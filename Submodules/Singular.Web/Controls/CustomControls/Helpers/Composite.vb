Imports Singular.Web.Controls.HelperControls
Imports System.Reflection
Imports Singular.Web.Controls

Namespace CustomControls

  ''' <summary>
  ''' Combines a label and an editor for a given property.
  ''' </summary>
  Public Class EditorRow(Of ObjectType)
    Inherits HelperBase(Of ObjectType)

    Protected mSwapLabel As Boolean
    Protected mLabel As FieldLabel(Of ObjectType)
    Protected mEditor As EditorBase(Of ObjectType)

    Public Sub New(Optional SwapLabel As Boolean = False)
      mSwapLabel = SwapLabel
    End Sub

    Public Sub New(Editor As EditorBase(Of ObjectType), Optional Label As FieldLabel(Of ObjectType) = Nothing, Optional SwapLabel As Boolean = False)
      mEditor = Editor
      mLabel = Label
      mSwapLabel = SwapLabel
    End Sub

    Protected Friend Overrides Function IsBindingAllowed(BindingType As KnockoutBindingString) As Boolean
      If Singular.Misc.In(BindingType, KnockoutBindingString.enable, "false") Then
        Throw New Exception("enabled and disabled binding must be specified on the editor, otherwise it won't work in firefox or chrome.")
      Else
        Return True
      End If
    End Function

    Protected Friend Overrides Sub Setup()
      MyBase.Setup()

      If mLabel Is Nothing Then
        mLabel = New FieldLabel(Of ObjectType)
        If mLinqExpression Is Nothing Then
          mLabel.For(PropertyInfo)
        Else
          mLabel.For(mLinqExpression)
        End If
      End If

      If mEditor Is Nothing Then
        If mLinqExpression Is Nothing Then
          mEditor = EditorBase(Of ObjectType).GetEditor(PropertyInfo)
        Else
          mEditor = EditorBase(Of ObjectType).GetEditor(mLinqExpression)
        End If
        If mEditor.KeepInline Then
          AddClass("InlineRow")
        End If
      End If

      If Not mSwapLabel Then AddControl(mLabel)

      If TypeOf mEditor Is RadioButtonEditor(Of ObjectType) Then
        With Helpers.Div()
          .Style.Display = Display.inlineblock
          .AddClass("RadioButtons")
          .Helpers.Control(mEditor)
        End With

      Else
        AddControl(mEditor)
      End If

      If mSwapLabel Then AddControl(mLabel)

      If TypeOf mEditor Is TextEditor(Of ObjectType) AndAlso DirectCast(mEditor, TextEditor(Of ObjectType)).MultiLine Then
        AddClass("row-ta")
      End If

    End Sub

    Public ReadOnly Property Label() As FieldLabel(Of ObjectType)
      Get
        Return mLabel
      End Get
    End Property

    Public ReadOnly Property Editor() As EditorBase(Of ObjectType)
      Get
        Return mEditor
      End Get
    End Property

    Protected Friend Overrides Sub Render()
      MyBase.Render()

      With Writer

        AddClass(EditorRowRowClass)

        WriteFullStartTag("div", TagType.IndentChildren)

        ' mLabel.Render()
        'mEditor.Render()

        RenderChildren()

        .WriteEndTag("div", True)

      End With

    End Sub

  End Class

  Public Class ReadOnlyRow(Of ObjectType)
    Inherits HelperBase(Of ObjectType)

    Protected mLabel As FieldLabel(Of ObjectType)
    Protected mReadOnly As FieldDisplay(Of ObjectType)

    Protected Friend Overrides Function IsBindingAllowed(BindingType As KnockoutBindingString) As Boolean
      If Singular.Misc.In(BindingType, KnockoutBindingString.enable, KnockoutBindingString.disable) Then
        Throw New Exception("enabled and disabled binding must be specified on the editor, otherwise it won't work in firefox or chrome.")
      Else
        Return True
      End If
    End Function

    Protected Friend Overrides Sub Setup()
      MyBase.Setup()

      If mLabel Is Nothing Then
        mLabel = New FieldLabel(Of ObjectType)
        If mLinqExpression Is Nothing Then
          mLabel.For(PropertyInfo)
        Else
          mLabel.For(mLinqExpression)
        End If

        AddControl(mLabel)
      End If

      If mReadOnly Is Nothing Then
        If mLinqExpression Is Nothing Then
          mReadOnly = Helpers.ReadOnlyFor(PropertyInfo, FieldTagType.span)
        Else
          mReadOnly = Helpers.ReadOnlyFor(mLinqExpression, FieldTagType.span)
        End If
      End If

      mReadOnly.AddClass("display")

    End Sub

    Public ReadOnly Property Label() As FieldLabel(Of ObjectType)
      Get
        Return mLabel
      End Get
    End Property

    Public ReadOnly Property Display() As FieldDisplay(Of ObjectType)
      Get
        Return mReadOnly
      End Get
    End Property

    Protected Friend Overrides Sub Render()
      MyBase.Render()

      With Writer
        AddClass(EditorRowRowClass)
        WriteFullStartTag("div", TagType.IndentChildren)
        'mLabel.Render()
        'mReadOnly.Render()
        RenderChildren()
        .WriteEndTag("div", True)
      End With
    End Sub

  End Class

  ''' <summary>
  ''' Creates a Fieldset group where all the child controls are bound under the given context.
  ''' </summary>
  Public Class FieldSet(Of ObjectType, ChildControlObjectType)
    Inherits HelperBase(Of ObjectType, ChildControlObjectType)

    Private mLegend As HTMLTag(Of ChildControlObjectType) = Nothing

    ''' <summary>
    ''' The Title / Legend / Header
    ''' </summary>
    Public ReadOnly Property Legend As HTMLTag(Of ChildControlObjectType)
      Get
        If mLegend Is Nothing Then
          mLegend = Helpers.HTMLTag("legend")
        End If
        Return mLegend
      End Get
    End Property

    Protected Friend Overrides Sub Setup()
      MyBase.Setup()

      mRequiresProperty = False

      If mLinqExpression IsNot Nothing Then
        AddBinding(KnockoutBindingString.with, GetForJS)
      End If

    End Sub

    Protected Friend Overrides Sub Render()
      MyBase.Render()

      With Writer

        WriteFullStartTag("fieldset", TagType.IndentChildren)

        For Each child As Singular.Web.Controls.CustomWebControl In Controls
          child.Render()
        Next

        Writer.WriteEndTag("fieldset", True)

      End With

    End Sub

  End Class

  ''' <summary>
  ''' Repeats the child controls for each item in the provided list.
  ''' </summary>
  Public Class ForEach(Of ObjectType, ChildControlObjectType)
    Inherits HelperBase(Of ObjectType, ChildControlObjectType)

    Friend Property JSExpression As String = ""

    Protected Friend Overrides Sub Setup()
      MyBase.Setup()

      If JSExpression <> "" Then
        AddBinding(KnockoutBindingString.foreach, JSExpression)
      Else
        AddBinding(KnockoutBindingString.foreach, GetForJS)
      End If

    End Sub

    Protected Friend Overrides Sub Render()
      MyBase.Render()

      With Writer

        WriteFullStartTag("div", TagType.IndentChildren)

        RenderChildren()

        .WriteEndTag("div", True)

      End With


    End Sub

  End Class

  ''' <summary>
  ''' Creates a document upload control that binds to a Singular.Documents.IDocumentProvider
  ''' </summary>
  ''' <remarks></remarks>
  Public Class DocumentManager(Of ObjectType)
    Inherits HelperBase(Of Singular.Documents.IDocumentProviderBasic)

    ''' <summary>
    ''' True if the user can overwrite the file once it has been uploaded.
    ''' Make sure you call mark old when fetching documents
    ''' </summary>
    Public Property AllowOverwrite As Boolean = False


    Private mFileEditor As FileEditor(Of Singular.Documents.IDocumentProviderBasic)
    Public ReadOnly Property FileEditor As FileEditor(Of Singular.Documents.IDocumentProviderBasic)
      Get
        Return mFileEditor
      End Get
    End Property

    Private mDownloader As DocumentDownloader(Of Singular.Documents.IDocumentProviderBasic)
    Public ReadOnly Property Downloader As DocumentDownloader(Of Singular.Documents.IDocumentProviderBasic)
      Get
        Return mDownloader
      End Get
    End Property

    Private mUploadStatusField As FieldDisplay(Of Singular.Documents.IDocumentProviderBasic)

    Public Sub SetUploadStatusText(Optional UploadingText As String = "", Optional FinishedUploadingText As String = "File ready to be saved.")
      If UploadingText <> "" Then
        UploadingText = "'" & UploadingText & "'"
      Else
        UploadingText = "Singular.FileProgress($data)"
      End If
      mUploadStatusField.AddBinding(Singular.Web.KnockoutBindingString.text, "ExistsOnServer() == 2 ? " & UploadingText & ": '" & FinishedUploadingText & "'")
    End Sub

    Private mClearButton As Button(Of Singular.Documents.IDocumentProviderBasic)

    Public ReadOnly Property ClearButton As Button(Of Singular.Documents.IDocumentProviderBasic)
      Get
        Return mClearButton
      End Get
    End Property

    Protected Friend Overrides Sub Setup()
      MyBase.Setup()

      If GetType(ObjectType) IsNot GetType(Singular.Documents.IDocumentProviderBasic) AndAlso Not Singular.Reflection.TypeImplementsInterface(GetType(ObjectType), GetType(Singular.Documents.IDocumentProviderBasic)) Then
        Throw New Exception("DocumentManager can only be used on types that implement Singular.Documents.IDocumentProviderBasic")
      End If

      'File Transfering image and label.
      With Helpers.If(Function(c) c.ExistsOnServer >= 2)

        With .Helpers.Image()
          .Style.Padding(, , "5px")
          .AddBinding(KnockoutBindingString.src, "DocumentName() ? '" & VirtualPathUtility.ToAbsolute("~/Singular/Images/IconApply.png") & "' : '" & VirtualPathUtility.ToAbsolute("~/Singular/Images/LoadingSmall.gif") & "'")
          .AddClass("StatusImage")
        End With

        mUploadStatusField = .Helpers.ReadOnlyFor()
        mUploadStatusField.Style.MarginLeft("5px")
        mUploadStatusField.AddClass("UploadStatus")
        SetUploadStatusText()

        .Helpers.HTML.NewLine()

      End With

      'Choose another.
      'If you can still see this button with AllowOverwrite = false, make sure you call mark old when fetching documents
      mClearButton = Helpers.Button("")
      With mClearButton
        .Tooltip = "Choose a different file."
        .ButtonSize = ButtonSize.Small
        .ButtonStyle = ButtonMainStyle.Warning

        .Image.SrcDefined = DefinedImageType.Clear
        .Image.Glyph = FontAwesomeIcon.eraser

        .AddBinding(KnockoutBindingString.click, "DocumentName(''); ExistsOnServer(0); ")
        .AddBinding(KnockoutBindingString.visible, "DocumentName() && IsNew")
      End With

      'Downloader
      mDownloader = Helpers.DocumentDownloader()

      'Upload editor holder.
      With Helpers.Div
        .AddBinding(KnockoutBindingString.if, Function(c) Not c.DocumentName)

        'Upload editor.
        mFileEditor = .Helpers.EditorFor(Function(c) c.DocumentName)
        With mFileEditor
          '.TableCellMode()
          '.MakeRequired()
          .Style.Width = "100%"
          .AddClass("SUI-RuleBorder")
          .AddBinding(KnockoutBindingString.Rule, Function(c) c.DocumentName)
        End With

      End With


    End Sub

    Protected Friend Overrides Sub Render()
      MyBase.Render()

      If AllowOverwrite Then
        'Overwrite the visible binding if overwrites are allowed.
        mClearButton.AddBinding(KnockoutBindingString.visible, Function(c) c.DocumentName)
      End If

      RenderChildren()

    End Sub

  End Class

  Public Class DocumentDownloader(Of ObjectType)
    Inherits HelperBase(Of Singular.Documents.IDocumentProviderBasic)

    Private mLink As Link(Of Singular.Documents.IDocumentProviderBasic)
    Public ReadOnly Property Link As Link(Of Singular.Documents.IDocumentProviderBasic)
      Get
        Return mLink
      End Get
    End Property

    Private mButton As Button(Of Singular.Documents.IDocumentProviderBasic)

    Public Property ShowButton As Boolean
      Get
        Return mButton.Visible
      End Get
      Set(value As Boolean)
        mButton.Visible = value
      End Set
    End Property

    ''' <summary>
    ''' Extra query string appended when calling FileDownloader.ashx
    ''' </summary>
    Public Property ExtraQueryString As String

    Protected Friend Overrides Sub Setup()
      MyBase.Setup()

      'Download Button
      mButton = Helpers.Button("", "")
      With mButton
        .Attributes("title") = "View this file."
        .Image.SrcDefined = DefinedImageType.OpenFile
        .Image.Glyph = FontAwesomeIcon.download
        .ButtonSize = ButtonSize.Small
        .ButtonStyle = ButtonMainStyle.Default

        .AddBinding(KnockoutBindingString.visible, Function(c) c.DocumentName)

      End With

      'File Name Label
      mLink = Helpers.LinkFor(, Function(c) c.DocumentName)
      mLink.AddBinding(KnockoutBindingString.visible, Function(c) c.DocumentName)

    End Sub

    Protected Friend Overrides Sub Render()
      MyBase.Render()

      If String.IsNullOrEmpty(ExtraQueryString) Then
        mButton.AddBinding(KnockoutBindingString.click, "Singular.DownloadFile($data, '', '" & ExtraQueryString & "')")
      Else
        mButton.AddBinding(KnockoutBindingString.click, "Singular.DownloadFile($data)")
      End If

      If String.IsNullOrEmpty(ExtraQueryString) Then
        mLink.AddBinding(KnockoutBindingString.href, "Singular.DownloadPath($data)")
      Else
        mLink.AddBinding(KnockoutBindingString.href, "Singular.DownloadPath($data) + '&" & ExtraQueryString & "'")
      End If

      If mButton.Visible Then
        mButton.Render()
      End If

      mLink.Render()

    End Sub

  End Class

  ''' <summary>
  ''' Creates a random image to make sure the user is human.
  ''' </summary>
  ''' <typeparam name="ObjectType"></typeparam>
  ''' <remarks></remarks>
  Public Class CaptchaEntry(Of ObjectType)
    Inherits HelperBase(Of ObjectType)

    Private mContainerDiv As HTMLDiv(Of ObjectType)
    Private mCaptchaImage As Image(Of ObjectType)
    Private mRefreshButton As Button(Of ObjectType)
    Private mLabel As FieldLabel(Of ICaptcha)
    Private mEditor As EditorBase(Of ICaptcha)

    Public ReadOnly Property Editor As EditorBase(Of ICaptcha)
      Get
        Return mEditor
      End Get
    End Property

    Protected Friend Overrides Sub Setup()
      MyBase.Setup()

      HelperAccessorsParent.ContextList.AddContext("HasCaptchaControl")

      mContainerDiv = Helpers.Div

      With mContainerDiv
        .AddClass("row")

        mLabel = New FieldLabel(Of ICaptcha)
        mLabel.For(Function(c) c.CaptchaText)
        mLabel.Style("height") = "50px"
        mLabel.Style("vertical-align") = "top"
        .Helpers.Control(mLabel)

        With .Helpers.Div
          .Style.Width = 350
          .Style.Display = Display.inlineblock
          .Attributes("class") = "CaptchaContainer"
          .AddBinding(KnockoutBindingString.Captcha, "{}")
          '.Attributes("data-captcha") = "imgCaptcha"

          mCaptchaImage = .Helpers.Image("")
          With mCaptchaImage
            .Alt = "Captcha"
            .Style("vertical-align") = "middle"
            .Style("padding") = "0 5px 5px 0"
            '.Attributes("id") = "imgCaptcha"
          End With

          mRefreshButton = .Helpers.Button("")
          mRefreshButton.ButtonStyle = ButtonMainStyle.Default
          With mRefreshButton
            If Singular.Web.Controls.DefaultButtonStyle = ButtonStyle.Bootstrap Then
              .ButtonSize = ButtonSize.Small
              .RenderMode = ButtonStyle.Bootstrap
              .Image.Glyph = FontAwesomeIcon.refresh
            Else
              .Image.SrcDefined = Singular.Web.DefinedImageType.Refresh
            End If

            .Attributes("title") = "New Image"
            .PostBackType = PostBackType.None

            .AddClass("CaptchaRefresh")

          End With
          .Helpers.HTML.NewLine()

          mEditor = EditorBase(Of ICaptcha).GetEditor(Function(c) c.CaptchaText)
          mEditor.Style("text-transform") = "uppercase"
          .Helpers.Control(mEditor)
        End With

      End With

    End Sub

    Protected Friend Overrides Sub Render()
      MyBase.Render()

      TransferPropertiesTo(mContainerDiv)

      mContainerDiv.Render()

    End Sub


  End Class

End Namespace

