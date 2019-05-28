Namespace Scripts

  Public Enum ScriptLocation
    Project = 1
    LibraryVirtualDir = 2 'Jquery, knockout etc
    LibraryEmbedded = 3
  End Enum

  Public Enum ScriptGroupType
    Knockout = 0
    JQuery = 1
    Singular = 2
    SGrid = 3
    GridReport = 4
  End Enum

  Public Module Scripts
    Public Property Settings As New ScriptSettings

    Private mAppScriptManager As ScriptManager
    Friend ReadOnly Property AppScriptManager As ScriptManager
      Get
        If mAppScriptManager Is Nothing Then
          mAppScriptManager = New ScriptManager
        End If
        Return mAppScriptManager
      End Get
    End Property

    Public ReadOnly Property UseDebugScripts As Boolean
      Get
        Return Singular.Debug.InDebugMode OrElse Settings.AlwaysUseDebugScripts
      End Get
    End Property

    Public Function GetPath(Location As ScriptLocation, Optional SubPath As String = "") As String

      If Location = ScriptLocation.LibraryVirtualDir Then
        Return Settings.LibraryScriptsOldPath & If(SubPath = "", "", "/" & SubPath)
      ElseIf Location = ScriptLocation.LibraryEmbedded Then
        Return Settings.LibraryScriptsResPath & If(SubPath = "", "", "/" & SubPath)
      Else

        Return Settings.ScriptsPath & If(SubPath = "", "", "/" & SubPath)
      End If
    End Function


    Private mLibraryScript As String = ""
    ''' <summary>
    ''' Renders the script tags to include all the .js files required by the singular library.
    ''' </summary>
    Public Function RenderLibraryScripts() As String
      SyncLock mAppScriptManager
        If mLibraryScript = "" Then
          mLibraryScript = AppScriptManager.RenderLibraryScripts()
        End If

        'Localised resources:
        If Singular.Localisation.LocalisationEnabled AndAlso Singular.Localisation.CurrentLanguageID <> 1 Then
          Return mLibraryScript & ScriptFile.GetScriptTag(JavascriptLocaliser.LocalisedScriptURL(Singular.Localisation.CurrentCulture.TwoLetterISOLanguageName))
        Else
          Return mLibraryScript
        End If
      End SyncLock
    End Function

    Public Function RenderScriptGroup(GroupName As String) As String

      Return AppScriptManager.GetGroup(GroupName).RenderScriptTags

    End Function

    Public Function RenderScriptFile(DebugName As String) As String

      Return ScriptFile.GetScriptTag(Settings.ScriptAbsolutePath & "/" & DebugName)

    End Function

    Public Function RenderScriptFile(DebugName As String, ReleaseName As String) As String

      If UseDebugScripts Then
        Return RenderScriptFile(DebugName)
      Else
        Return ScriptFile.GetScriptTag(Settings.ScriptAbsolutePath & "/" & ReleaseName)
      End If

    End Function

    Public Function RenderGoogleAnalyticsSetup(TrackingCode As String, URL As String) As String

      If TrackingCode <> "" Then
        Return vbCrLf & String.Format(My.Resources.GoogleAnalyticsInclude, TrackingCode, URL)
      Else
        Return ""
      End If

    End Function

  End Module

  Public Class ScriptSettings
    Public Property ScriptsPath As String = "~/Scripts"
    Public Property LibraryScriptsOldPath As String = "~/Singular/Javascript"
    Public Property LibraryScriptsResPath As String = "~/" & LibResourceHandler.HandlerURL & "/Javascript"

    Private mScriptAbsolutePath As String = ""
    Friend ReadOnly Property ScriptAbsolutePath As String
      Get
        If mScriptAbsolutePath = "" Then
          mScriptAbsolutePath = VirtualPathUtility.ToAbsolute(ScriptsPath)
        End If
        Return mScriptAbsolutePath
      End Get
    End Property

    ''' <summary>
    ''' Tells the script manager to always make the browser load debug javascript files., even when the web site is not running in debug mode.
    ''' </summary>
    Public Property AlwaysUseDebugScripts As Boolean = False

    ''' <summary>
    ''' Tells the script manager to make the browser load javascript files from a content delivery network. Debug files will still be loaded locally when in debug mode.
    ''' </summary>
    Public Property UseCDN As Boolean = True

    Public Enum JQueryVersion
      JQ_1_7_2 = 1
      JQ_1_12_4 = 2
    End Enum

    Public Enum JQueryUIVersion
      JQ_UI_1_9_0 = 1
      JQ_UI_1_12_1 = 2
    End Enum

    Public Property LibJQueryVersion As JQueryVersion = JQueryVersion.JQ_1_7_2

    Public Property LibJQueryUIVersion As JQueryUIVersion = JQueryUIVersion.JQ_UI_1_9_0

    'Public Property ScriptsInProjectFolder As Boolean = False

    Public Property SupportECMA6 As Boolean = False

  End Class

  Public Class LibraryIncludes
    Private Shared Property LibIncludeBasePath = GetPath(ScriptLocation.LibraryEmbedded, "Include")

    Public Shared Property AuditTrailsScript As New ScriptFile(LibIncludeBasePath, "AuditTrails.js") With {.VersionNo = ScriptsVersion}
    Public Shared Property CheckQueriesScript As New ScriptFile(LibIncludeBasePath, "CheckQueries.js") With {.VersionNo = ScriptsVersion}
    Public Shared Property ImageResizerScript As New ScriptFile(LibIncludeBasePath, "ImageResizer.js") With {.VersionNo = ScriptsVersion}
    Public Shared Property MaintenanceScript As New ScriptFile(LibIncludeBasePath, "Maintenance.js") With {.VersionNo = ScriptsVersion}
    Public Shared Property ScheduleScript As New ScriptFile(LibIncludeBasePath, "Schedule.js") With {.VersionNo = ScriptsVersion}
    Public Shared Property SecurityScript As New ScriptFile(LibIncludeBasePath, "Security.js") With {.VersionNo = ScriptsVersion}
  End Class

  Public Class ScriptManager

    Private mScriptGroupList As New Dictionary(Of String, ScriptGroup)

    ''' <summary>
    ''' Adds a container for a collection of files.
    ''' </summary>
    ''' <param name="GroupName">The unique name of the group.</param>
    ''' <param name="Path">The URL where all of the files in this group are stored. (Use ~ for the web site root)</param>
    Public Function AddScriptGroup(GroupName As String, Path As String) As ScriptGroup

      Dim sg As New ScriptGroup With {.GroupName = GroupName, .Path = Path}
      mScriptGroupList.Add(GroupName, sg)
      Return sg

    End Function

    Public Function AddVersionedScript(GroupName As String, DebugPath As String) As ScriptGroup
      Dim Path As String = IO.Path.GetDirectoryName(DebugPath)
      Dim FileName As String = IO.Path.GetFileName(DebugPath)
      If FileName.EndsWith(".js") Then
        FileName = FileName.Substring(0, FileName.Length - 3)
      End If

      Dim sg = AddScriptGroup(GroupName, Path)
      sg.EnableCombineAndMinify(sg.AddScript(FileName & ".js"))
      Return sg
    End Function

    Friend Function GetGroup(GroupName As String) As ScriptGroup
      Return mScriptGroupList(GroupName)
    End Function

    Friend Function RenderLibraryScripts() As String
      Dim sb As New Text.StringBuilder
      For Each key As String In mScriptGroupList.Keys
        If Singular.Misc.In(key, ScriptGroupType.Knockout.ToString, ScriptGroupType.JQuery.ToString, ScriptGroupType.Singular.ToString) Then
          mScriptGroupList(key).RenderScriptTags(sb)
        End If
      Next
      If Settings.SupportECMA6 Then
        mScriptGroupList("ECMA6").RenderScriptTags(sb)
      End If
      Return sb.ToString
    End Function

    Friend Sub GenerateVersionedFiles()
      For Each key As String In mScriptGroupList.Keys
        mScriptGroupList(key).GenerateCombinedScript()
      Next
    End Sub

  End Class



End Namespace

