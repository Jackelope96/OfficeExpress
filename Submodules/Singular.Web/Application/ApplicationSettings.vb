Imports System.Web.Routing

Public MustInherit Class ApplicationSettings
  Inherits System.Web.HttpApplication

#Region " Settings "

  Private Shared mApplicationSettings As New SettingsApplication
  Public Shared ReadOnly Property Settings As SettingsApplication
    Get
      Return mApplicationSettings
    End Get
  End Property

  Private Shared mDisplaySettings As New SettingsDisplay
  Public Shared ReadOnly Property DisplaySettings As SettingsDisplay
    Get
      Return mDisplaySettings
    End Get
  End Property

  Public Class SettingsApplication
    ''' <summary>
    ''' Tells the Singular Library so store the View State on the server, instead of Sending it to the Browser.
    ''' </summary>
    ''' <value></value>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Property StoreViewStateInSession As Boolean = True

    ''' <summary>
    ''' Renames the Master Pages Content controls to A,B,C etc. As these are prefixed to child control names and make page sizes bigger.
    ''' </summary>
    ''' <value></value>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Property RenameMasterContentControls As Boolean = True

  End Class

  Public Class SettingsDisplay
    Public Property NumericEditorClassName As String = "NumericEditor"
    Public Property DatePickerClassName As String = "DatePicker"
    Public Property TimePickerClassName As String = "TimePicker"

    Public Property LibraryImagePath As String = "Singular/Images"
  End Class

#End Region

  Overridable Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)

    'Set the connection string.
    SetConnectionString()

    'Backward Links to Singular.Server
    Singular.Web.Utilities.SingularWebInterface.GetCacheableJSonCallBack = AddressOf Singular.Web.Data.ClientDataProvider.GetCacheableJSon

    'Encryption Key
    Dim EncKey As String = System.Environment.MachineName
    Try
      Dim section = CType(System.Configuration.ConfigurationManager.GetSection("system.web/machineKey"), System.Web.Configuration.MachineKeySection)
      If Not section.DecryptionKey.Contains("AutoGenerate") AndAlso section.DecryptionKey.Length = 64 Then
        EncKey = section.DecryptionKey
      End If
    Catch ex As Exception
    End Try
    Singular.Encryption.Initialise(EncKey)


    'Max request size for uploads
    Dim Settings As System.Web.Configuration.HttpRuntimeSection = System.Web.HttpContext.Current.GetSection("system.web/httpRuntime")
    If Settings IsNot Nothing Then
      Singular.Web.WebServices.FileUploadHandler.MaxRequestSizeKB = Settings.MaxRequestLength
    End If

    RouteTable.Routes.Add(New Route(WebServices.StatelessHandler.StatelessHandlerPath, New Singular.Web.WebServices.StaticRouteHandler(Of Singular.Web.WebServices.StatelessHandler)))
    RouteTable.Routes.Add(New Route(Scripts.LibResourceHandler.HandlerURL & "/{*all}", New Singular.Web.WebServices.StaticRouteHandler(Of Singular.Web.Scripts.LibResourceHandler)))
    RouteTable.Routes.Add(New Route("Library/FileUpload", New Singular.Web.WebServices.StaticRouteHandler(Of Singular.Web.WebServices.SessionFileUploadHandler)))
    RouteTable.Routes.Add(New Route("Library/{Method}/{MainArg}", New Singular.Web.WebServices.LibraryRouteHandler))

    SetupSecurity()

    Try
      ApplicationSetup()
    Catch ex As Exception
      If Singular.Web.WebError.SupportsWebError Then
        Singular.Web.WebError.LogError(ex, "Global.asax - ApplicationSetup")
      End If
      Throw ex
    End Try

    'Setup script groups
    SetupScripts(Scripts.AppScriptManager)

    Try
      SetupLocalisation()
      GenerateVersionedScripts()
    Catch ex As Exception
      If Singular.Web.WebError.SupportsWebError Then
        Singular.Web.WebError.LogError(ex, "Global.asax - Localisation")
      End If
      Throw ex
    End Try

  End Sub

  Protected Overridable Sub SetConnectionString()
    Dim DebugConnection As Boolean = False
    Dim MachineName = System.Environment.MachineName
    If System.Configuration.ConfigurationManager.ConnectionStrings(MachineName) IsNot Nothing Then
      DebugConnection = True
      Singular.Settings.SetConnectionString(System.Configuration.ConfigurationManager.ConnectionStrings(MachineName).ConnectionString)
    End If

    If Not DebugConnection Then
      If System.Configuration.ConfigurationManager.ConnectionStrings("Main") IsNot Nothing Then
        Singular.Settings.SetConnectionString(System.Configuration.ConfigurationManager.ConnectionStrings("Main").ConnectionString)
      Else
        Singular.Settings.SetConnectionString(System.Configuration.ConfigurationManager.ConnectionStrings(System.Configuration.ConfigurationManager.ConnectionStrings.Count - 1).ConnectionString)
      End If
    End If
  End Sub

  Protected Overridable Sub SetupSecurity()

  End Sub

  Protected Overridable Sub ApplicationSetup()

  End Sub

  Protected Overridable Sub SetupScripts(SM As Scripts.ScriptManager)

    'JQuery
    With SM.AddScriptGroup(Scripts.ScriptGroupType.JQuery.ToString, Scripts.GetPath(Scripts.ScriptLocation.LibraryVirtualDir, Scripts.ScriptGroupType.JQuery.ToString))
      If Scripts.Settings.LibJQueryVersion = Scripts.ScriptSettings.JQueryVersion.JQ_1_7_2 Then
        .AddScript("jquery-1.7.2.js", "jquery-1.7.2.min.js", "//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js")
      Else
        .AddScript("jquery-1.12.4.js", "jquery-1.12.4.min.js", "//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js")
      End If
      If Scripts.Settings.LibJQueryUIVersion = Scripts.ScriptSettings.JQueryUIVersion.JQ_UI_1_9_0 Then
        .AddScript("jquery-ui-1.9.0.custom.js", "jquery-ui-1.9.0.custom.min.js", "//ajax.googleapis.com/ajax/libs/jqueryui/1.9.0/jquery-ui.min.js")
      Else
        .AddScript("jquery-ui-1.12.1.js", "jquery-ui-1.12.1.min.js", "//ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js")
      End If
    End With

    'Knockout
    With SM.AddScriptGroup(Scripts.ScriptGroupType.Knockout.ToString, Scripts.GetPath(Scripts.ScriptLocation.LibraryVirtualDir, Scripts.ScriptGroupType.Knockout.ToString))
      .AddScript("knockout-2.3.0.debug.js", "knockout-2.3.0.js", "//cdnjs.cloudflare.com/ajax/libs/knockout/2.3.0/knockout-min.js")
    End With

    'Singular
    With SM.AddScriptGroup(Scripts.ScriptGroupType.Singular.ToString, Scripts.GetPath(Scripts.ScriptLocation.LibraryEmbedded, Scripts.ScriptGroupType.Singular.ToString))

      Dim MinifiedName As String = "Singular"

      .AddScript("Utils.js")
      .AddScript("Singular.Core.js")
      Dim Main = .AddScript("Singular.ASPNet.js")
      .AddScript("Singular.Controls.js")
      .AddScript("Singular.Data.js")
      .AddScript("Singular.Validation2.js")
      .AddScript("KO.Bindings.js")
      .AddScript("KO.Plugins.js")

      If Controls.UsesPagedGrid Then
        MinifiedName &= "Pg"
        .AddScript("Singular.Paging.js")
      End If
      If Controls.UsesComboDropDown Then
        MinifiedName &= "Cd"
        .AddScript("SCombo.js")
      End If

      Main.ReleaseScriptName = MinifiedName & ".min.js"
      .EnableCombineAndMinify(Main)
    End With

    'Grid and Grid reporting
    With SM.AddScriptGroup(Scripts.ScriptGroupType.SGrid.ToString, Scripts.GetPath(Scripts.ScriptLocation.LibraryEmbedded, "SGrid"))
      .AddScript("Singular.Drawing.js")
      .EnableCombineAndMinify(.AddScript("Singular.Grid.js", "Singular.SGrid.min.js"))
    End With

    With SM.AddScriptGroup(Scripts.ScriptGroupType.GridReport.ToString, Scripts.GetPath(Scripts.ScriptLocation.LibraryEmbedded, "SGrid"))
      .AddScript("Singular.GridChart.js")
      .EnableCombineAndMinify(.AddScript("Singular.GridReport.js", "Singular.GridReport.min.js"))
    End With


    'If the project has ECMA6 support
    If Scripts.Settings.SupportECMA6 Then
      With SM.AddScriptGroup("ECMA6", Scripts.GetPath(Scripts.ScriptLocation.LibraryEmbedded, "Singular"))
        .AddScript("Singular.ecma6.js")
      End With
    End If

  End Sub

  Protected Overridable Sub SetupLocalisation()

  End Sub

  Overridable Sub Session_Start(sender As Object, e As EventArgs)
    Misc.WebSiteStats.AddSession(Session.SessionID)

    Session("LockObject") = New Object
  End Sub

  Overridable Sub Session_End(sender As Object, e As EventArgs)
    Misc.WebSiteStats.RemoveSession(Session.SessionID)
  End Sub

  Overridable Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
    ' Fires at the beginning of each request
  End Sub

  Overridable Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)

  End Sub

  Protected Overridable Sub GenerateVersionedScripts()
    Singular.Web.Scripts.AppScriptManager.GenerateVersionedFiles()
    Singular.Web.Scripts.JavascriptLocaliser.CreateFiles()
  End Sub

End Class

Public MustInherit Class ApplicationSettings(Of Identity As Singular.Web.Security.WebIdentity(Of Identity))
  Inherits ApplicationSettings

  Public Sub New()
    Singular.Web.Security.WebLoginMethod = AddressOf AuthenticateUser
  End Sub

  Friend Sub AuthenticateUser(UserName As String, Password As String, AuthType As Security.AuthType)
    Singular.Web.Security.WebPrinciple(Of Identity).Login(UserName, Password, AuthType)
  End Sub

  Protected Overrides Sub SetupSecurity()
    Singular.Security.SetGetIdentityDelegate(AddressOf Security.GetPrinciple)
  End Sub

  Public Overrides Sub Session_Start(sender As Object, e As System.EventArgs)
    MyBase.Session_Start(sender, e)

  End Sub

  Public Overrides Sub Application_AuthenticateRequest(sender As Object, e As EventArgs)
    MyBase.Application_AuthenticateRequest(sender, e)

    Singular.Web.Security.WebPrinciple(Of Identity).InitialiseRequest(Context)

  End Sub

  Public Overridable Sub Application_AcquireRequestState(sender As Object, e As EventArgs)

    'To guard against session fixation, check if the user name in the session matches the user name in the auth token
    If System.Web.HttpContext.Current.Session IsNot Nothing Then
      Dim SessionUserName As String = Session("Session_UserName")
      If SessionUserName Is Nothing AndAlso Request.IsAuthenticated Then
        'First user to use this session
        SessionUserName = Context.User.Identity.Name
        Session("Session_UserName") = SessionUserName
      ElseIf SessionUserName IsNot Nothing AndAlso SessionUserName <> Context.User.Identity.Name Then
        'Session name has been set, but the user is not logged in, or the user is a different person

        'Throw New Exception("this session is already being used by someone else.") - this is causing too many issues.
        Session.Clear()
      End If

    End If

  End Sub

End Class
