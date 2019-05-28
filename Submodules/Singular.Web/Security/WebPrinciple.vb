Imports Singular.Security
Imports Csla
Imports Csla.Serialization
Imports System.Web.Security
Imports System.ComponentModel.DataAnnotations
Imports Singular.DataAnnotations

Namespace Security

  Public Enum AuthType
    FormsCookie = 1
    WindowsAuth = 2
    HTTPHeader = 3
  End Enum

  Public Class LoginDetails

    <Required, LocalisedDisplay("Username"),
    Singular.DataAnnotations.TextField(, , False)>
    Public Property UserName As String

    <Required, LocalisedDisplay("Password"), System.ComponentModel.PasswordPropertyText(),
    Singular.DataAnnotations.TextField(, , False)>
    Public Property Password As String

    <Display(Name:="Stay logged in"), LocalisedDisplay("RememberMe")>
    Public Property RememberMe As Boolean = False
  End Class

  <Serializable()>
  Public Class WebPrinciple(Of i As WebIdentity(Of i))
    Inherits Singular.Security.PrincipalBase(Of i)

    Public Sub New(ByVal identity As i)
      MyBase.New(identity)
    End Sub

    ''' <summary>
    ''' Refetches the User From the Database. This is called when the User Session has expired, but the Authentication Cookie is still active.
    ''' </summary>
    ''' <remarks></remarks>
    Public Shared Function Refetch(UserName As String, AuthType As AuthType) As Singular.Security.IPrincipal

      Dim identity = DataPortal.Fetch(Of i)(New IdentityCriterea(UserName, "", True))

      If identity.IsAuthenticated OrElse AuthType = Singular.Web.Security.AuthType.WindowsAuth Then
        'Windows authentication will have authenticated this user on the domain,
        'but the user is not in the app database. Return a user that is not authenticated.
        Dim principal As New Singular.Web.Security.WebPrinciple(Of i)(identity)
        Csla.ApplicationContext.User = principal
        ResetUser(UserName.ToLower)
        StoreUser(UserName.ToLower, principal)
        identity.AuthType = AuthType
        Return principal

      End If
      Return Nothing
    End Function

    Public Shared Shadows Function Login(ByVal UserName As String, ByVal Password As String, AuthType As AuthType) As Boolean

      Return Login(New IdentityCriterea(UserName, Password, False), AuthType)

    End Function

    Public Shared Shadows Function Login(Criteria As IdentityCriterea, AuthType As AuthType) As Boolean

      Dim ident = DoLogin(Criteria, AuthType)

      Return If(ident Is Nothing, False, ident.IsAuthenticated)

    End Function

    Public Shared Function DoLogin(Criteria As IdentityCriterea, AuthType As AuthType) As i

      Try

        Dim identity = DataPortal.Fetch(Of i)(Criteria)

        If identity.IsAuthenticated Then
          identity.AuthType = AuthType
          Dim principal As New Singular.Web.Security.WebPrinciple(Of i)(identity)
          Csla.ApplicationContext.User = principal
          System.Web.HttpContext.Current.User = principal
          ResetUser(Criteria.Username.ToLower)
          StoreUser(Criteria.Username.ToLower, principal)
        End If

        Return identity

      Catch ex As Exception
        If Singular.Debug.IsCustomError(ex) Then
          System.Web.HttpContext.Current.Items("LoginError") = Singular.Debug.RecurseExceptionMessage(ex)
          Return Nothing
        Else
          Throw ex
        End If

      End Try

    End Function

    Public Shared Sub InitialiseRequest(Context As System.Web.HttpContext)

      Dim UserName As String = Nothing
      Dim Ticket As FormsAuthenticationTicket = Nothing
      Dim AuthType As AuthType

      Dim MobileAuthToken As String = Nothing
      If Context.Request.Headers("AuthToken") IsNot Nothing Then
        MobileAuthToken = Context.Request.Headers("AuthToken")
      End If

      If String.IsNullOrEmpty(MobileAuthToken) Then
        'Forms Authentication / Windows Authentication

        If Singular.Web.IsServerFarm Then
          'decrypt the cookie to get the version
          Ticket = GetFormsAuthTicket()
        End If

        If Context.Request.IsAuthenticated Then
          UserName = Context.User.Identity.Name.ToLower()
        End If

        'Check if this is a windows auth principle
        If Context.User IsNot Nothing AndAlso TypeOf Context.User Is System.Security.Principal.WindowsPrincipal Then
          AuthType = Singular.Web.Security.AuthType.WindowsAuth
        Else
          AuthType = Singular.Web.Security.AuthType.FormsCookie
        End If

      Else
        'Mobile
        Dim ti As Security.TokenInfo = Singular.Web.Security.GetTokenInfo(MobileAuthToken)
        If ti.ExpiryDate > Now Then
          UserName = ti.UserName
          AuthType = Singular.Web.Security.AuthType.HTTPHeader
          Context.Items("HttpHeaderAuth") = True
        End If

      End If

      If Not String.IsNullOrEmpty(UserName) Then
        'Get the cached user.
        Dim SUser As Singular.Security.IPrincipal = Singular.Web.Security.GetUser(UserName)

        'If the cached users version is different to the cookie, reset it.
        If SUser IsNot Nothing AndAlso SUser.GetIdentity(Of i).SetData(Ticket) Then
          SUser = Nothing
        End If

        If SUser Is Nothing Then
          'Set the cached user.
          Try
            SUser = Singular.Web.Security.WebPrinciple(Of i).Refetch(UserName, AuthType)
            SUser.GetIdentity(Of i).SetData(Ticket)
          Catch ex As Exception
            Singular.Web.Security.Logout()
          End Try

        End If
        'Set the thread and HTTPContext user to the projects specific principle type.
        Context.User = SUser
        System.Threading.Thread.CurrentPrincipal = SUser
      End If

    End Sub

  End Class

  Public Class LoginResult
    Inherits Singular.Web.Result

    Public Property RedirectLocation As String

  End Class

  <Serializable()>
  Public Class WebIdentity(Of i As WebIdentity(Of i))
    Inherits Singular.Security.IdentityBase(Of i)
    Implements IWebIdentity

    ''' <summary>
    ''' The HTML to be used by the LoggedInName control.
    ''' </summary>
    ''' <value></value>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Overridable ReadOnly Property LoginLabelHTML As String Implements IWebIdentity.LoginLabelHTML
      Get
        Return "<strong>" & System.Web.HttpUtility.HtmlEncode(UserNameReadable) & "</strong>"
      End Get
    End Property

    Friend Property AuthType As AuthType Implements IWebIdentity.AuthType

    Protected Overrides Sub SetupSqlCommand(cmd As System.Data.SqlClient.SqlCommand, Criteria As IdentityCriterea)
      cmd.CommandText = "GetProcs.WebLogin"
      If cmd.Parameters("@RefreshingRoles") Is Nothing Then
        cmd.Parameters.AddWithValue("@RefreshingRoles", CType(Criteria, IdentityCriterea).RefreshingRoles)
      Else
        cmd.Parameters("@RefreshingRoles").Value = CType(Criteria, IdentityCriterea).RefreshingRoles
      End If
    End Sub

    Public Function GetAuthToken(ExpiryDate As Date) As String Implements IWebIdentity.GetAuthToken
      Return Singular.Web.Security.GetMessageFromToken(New Singular.Web.Security.TokenInfo() With {.ExpiryDate = ExpiryDate, .UserName = GetAuthTokenUsername()})
    End Function

    Protected Overridable Function GetAuthTokenUsername() As String
      Return Me.Name
    End Function

    ''' <summary>
    ''' Additional check to determine if the user is authenticated or not.
    ''' </summary>
    Public Overridable ReadOnly Property CustomAuthCriteria As Boolean
      Get
        Return True
      End Get
    End Property

#Region " Cookie "

    Private mPersistCookie As Boolean
    Private mVersion As Integer = 0
    Private mVersionChanged As Boolean = False

    Friend Function SetData(Ticket As FormsAuthenticationTicket) As Boolean
      mVersionChanged = False
      If Ticket IsNot Nothing AndAlso mVersion <> Ticket.Version Then
        mVersion = Ticket.Version
        Return True
      End If
      Return False
    End Function

    ''' <summary>
    ''' Marks this identity object as old, so other webservers will refetch it.
    ''' </summary>
    Protected Sub Invalidate()
      If Not mVersionChanged Then
        Dim Ticket = GetFormsAuthTicket()
        SetData(Ticket)
        mVersion += 1
        If Ticket IsNot Nothing Then
          System.Web.HttpContext.Current.Response.Cookies.Remove(FormsAuthentication.FormsCookieName)
          System.Web.HttpContext.Current.Response.Cookies.Add(GetCookie(Ticket.IsPersistent))
        End If
        mVersionChanged = True
      End If
    End Sub

    Private Function GetCookie(Remember As Boolean) As System.Web.HttpCookie

      Return GetAuthCookie(Name, Remember, mVersion, UserID)

    End Function

    Public Shared Function GetAuthCookie(UserName As String, Remember As Boolean, Optional Version As Integer = 0, Optional UserID As Integer = 0) As System.Web.HttpCookie

      Dim Ticket As New FormsAuthenticationTicket(Version, UserName, Now, Now.Add(FormsAuthentication.Timeout), Remember, UserID)
      Dim AuthCookie As New System.Web.HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(Ticket))
      AuthCookie.HttpOnly = True
      If Remember Then AuthCookie.Expires = Ticket.Expiration
      Return AuthCookie

    End Function

    ''' <summary>
    ''' Sets a new user name, and re-generates the auth cookie.
    ''' </summary>
    Public Sub Rename(NewUserName As String)
      LoadProperty(NameProperty, NewUserName)
      Invalidate()
    End Sub

#End Region

    Protected Overridable Sub OnLogin(Result As LoginResult)

    End Sub

    ''' <summary>
    ''' Checks the user credentials, and creates the authentication cookie
    ''' </summary>
    ''' <param name="LoginInfo">Login Information</param>
    ''' <param name="OnError">An optional function to provide custom error text</param>
    Public Shared Function Login(LoginInfo As LoginDetails, Optional OnError As Action(Of Singular.Web.Result) = Nothing) As LoginResult

      Dim Result As LoginResult
      Dim Context = System.Web.HttpContext.Current

      If Membership.ValidateUser(LoginInfo.UserName, LoginInfo.Password) Then

        Dim ident As i = Singular.Security.CurrentIdentity

        'Set the auth cookie
        Dim cookie = ident.GetCookie(LoginInfo.RememberMe)

        Context.Response.Cookies.Add(cookie)

        Result = New LoginResult With {.Success = True}

        'Custom Login Code
        ident.OnLogin(Result)

      Else
        If Context.Items("LoginError") IsNot Nothing Then
          Result = New LoginResult With {.Success = False, .ErrorText = System.Web.HttpContext.Current.Items("LoginError")}
        Else
          Result = New LoginResult With {.Success = False, .ErrorText = "Incorrect User Name or Password"}
        End If

        'Custom Error Code
        If OnError IsNot Nothing Then
          OnError(Result)
        End If

      End If

      Return Result

    End Function

  End Class

  <Serializable()>
  Public Class WebIdentityGeneric
    Inherits WebIdentity(Of WebIdentityGeneric)
  End Class


End Namespace
