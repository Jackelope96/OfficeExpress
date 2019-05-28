Namespace SystemSettings

  Public Class SystemSettingsVM
    Inherits Singular.Web.StatelessViewModel(Of SystemSettingsVM)

    <System.ComponentModel.Browsable(False)>
    Public Property SystemSettingList As Singular.SystemSettings.Objects.SystemSettingList
    Public Property SystemSetting As Singular.SystemSettings.ISettingsSection

    Protected Overrides Sub Setup()

      If Page.Request.QueryString("Name") IsNot Nothing Then
        'Editing Setting

        SystemSetting = GetSystemSettingList(Page.Request.QueryString("Name")).First.Settings
        If Not String.IsNullOrEmpty(SystemSetting.SecurityRole) AndAlso Not Singular.Security.HasAccess(SystemSetting.SecurityRole) Then
          Me.SystemSetting = Nothing
        End If
      End If
      If Me.SystemSetting Is Nothing Then
        'Showing all Settings
        SystemSettingList = GetSystemSettingList(Nothing)

        If SystemSettingList.Count = 1 Then
          SystemSetting = SystemSettingList(0).Settings
        End If

      End If

    End Sub

    Protected Overridable Function GetSystemSettingList(SettingName As String) As Singular.SystemSettings.Objects.SystemSettingList
      Return Singular.SystemSettings.Objects.SystemSettingList.GetSystemSettingList(SettingName)
    End Function

    Public Function SaveSetting(Setting As Object, SettingsType As String) As Singular.Web.SaveResult

      If String.IsNullOrEmpty(SecurityRole) OrElse Singular.Security.HasAccess(SecurityRole) Then
        Dim CustomSettingType As Type = Type.GetType(SettingsType)
        Dim ssl = Singular.SystemSettings.Objects.SystemSettingList.GetSystemSettingList(CustomSettingType)
        ssl(0).Settings.ReturnUnMaskedPassword = False
        Dim serialiser As New Singular.Web.Data.JS.StatelessJSSerialiser(ssl(0).Settings)
        ssl(0).Settings.ReturnUnMaskedPassword = True
        Setting.ReturnUnMaskedPassword = True
        serialiser.Deserialise(Setting)
        ssl.PrepareToSave()

        Dim sh = TrySave(ssl)
        If sh.Success Then
          Singular.SystemSettings.ResetSettings(CustomSettingType)
          AfterSave()
        End If

        ssl(0).Settings.ReturnUnMaskedPassword = False

        Return New Singular.Web.SaveResult(sh) With {.Data = ssl(0).Settings}
      Else
        Throw New UnauthorizedAccessException("Access denied")
      End If

    End Function

    Protected Overridable Sub AfterSave()

    End Sub

  End Class

End Namespace

