''' <summary>
''' Listens for updates to the services / system settings tables.
''' </summary>
Public Class ServiceUpdater

  Private _ServiceBase As ServiceBase
  Private _ServiceUpdateQueue As Singular.Data.SQLQueueReader

  Public Sub New(ServiceBase As ServiceBase)
    _ServiceBase = ServiceBase

  End Sub

  Friend Sub Initialise()

    If Singular.Service.ServiceUpdateEnabled Then

      _ServiceBase.WriteProgress("Starting service updater")

      _ServiceUpdateQueue = New Singular.Data.SQLQueueReader(Singular.Service.ServiceUpdateQueueName)
      _ServiceUpdateQueue.Timeout = 3600
      _ServiceUpdateQueue.BeginWaitForMessage(AddressOf ServiceMessageReceived, AddressOf ServiceQueueError)

    End If

  End Sub

  Private Sub ServiceMessageReceived(Message As String)

    Dim SeperatorIndex = Message.IndexOf(",")
    Dim MessageType As Singular.Service.ServiceUpdateMessageType = Message.Substring(0, SeperatorIndex)
    Message = Message.Substring(SeperatorIndex + 1)

    If MessageType = ServiceUpdateMessageType.ServiceInfoUpdated Then
      ServiceInfoChanged(Message)
    ElseIf MessageType = ServiceUpdateMessageType.SystemSettingsUpdated Then
      SystemSettingsChanged(Message)
    ElseIf MessageType >= ServiceUpdateMessageType.CommonDataType AndAlso MessageType <= ServiceUpdateMessageType.CommonDataAll Then
      CommonDataReset(MessageType, Message)
    ElseIf MessageType = ServiceUpdateMessageType.ServiceMessage Then
      ServiceMessage(Message)
    End If

  End Sub

  Private Sub ServiceQueueError(Ex As Exception)
    _ServiceBase.WriteProgress("Error in service info updater: " & Singular.Debug.RecurseExceptionMessage(Ex))
  End Sub

#Region " Service Info Update "

  Private Sub ServiceInfoChanged(Message As String)

    Dim ServerProgramIDs As String() = Message.Split(",")

    For Each Program In _ServiceBase.ServerPrograms
      If ServerProgramIDs.Contains(Program.ServerProgramTypeID) Then
        Program.ServiceInfoChanged(Singular.Service.ServerProgramTypeList.GetServerProgramType(Program.ServerProgramTypeID))
      End If
    Next

  End Sub

#End Region

#Region " System Settings Updates "

  ''' <summary>
  ''' Called when a system settings object is saved. The cached setting will be removed, and each program will be notified.
  ''' </summary>
  ''' <param name="Message">Full Type name</param>
  Private Sub SystemSettingsChanged(Message As String)

    Dim SettingsType = Type.GetType(Message)

    Dim SettingsInstance = Singular.SystemSettings.GetSystemSetting(SettingsType, True)

    _ServiceBase.WriteProgress("Reset settings for type: " & SettingsType.Name)

    'Email Settings
    If GetType(Singular.Correspondence.IEmailSettings).IsAssignableFrom(SettingsType) Then
      Singular.Emails.MailSettings.DefaultCredential.FromProjectSettings(SettingsInstance)
    End If

    'Sms Settings
    If GetType(Singular.Correspondence.ISmsSettings).IsAssignableFrom(SettingsType) Then
      Singular.SmsSending.SmsSender.SetSettings(SettingsInstance)
    End If

    For Each Program In _ServiceBase.ServerPrograms
      Program.SystemSettingsChanged(SettingsType, SettingsInstance)
    Next

  End Sub

#End Region

#Region " Commondata Refresh "

  Private Sub CommonDataReset(MessageType As Singular.Service.ServiceUpdateMessageType, Message As String)

    If MessageType = ServiceUpdateMessageType.CommonDataType Then

      Dim ListType = Type.GetType(Message)
      Singular.CommonData.Lists.Refresh(ListType)

      _ServiceBase.WriteProgress("Reset cached data for type: " & Message)

    ElseIf MessageType = ServiceUpdateMessageType.CommonDataName Then

      Singular.CommonData.Lists.Refresh(Message)
      _ServiceBase.WriteProgress("Reset cached data for name: " & Message)

    ElseIf MessageType = ServiceUpdateMessageType.CommonDataAll Then

      Singular.CommonData.Lists.RefreshAll()
      _ServiceBase.WriteProgress("Reset all cached data")

    End If

  End Sub

#End Region

#Region " Service Message "

  Private Sub ServiceMessage(Message As String)

    Dim Params = Message.Split("|")

    Dim ServerProgram = _ServiceBase.ServerPrograms.FirstOrDefault(Function(c) c.ServerProgramTypeID = Params(0))
    If ServerProgram IsNot Nothing Then

      Dim Method = ServerProgram.GetType.GetMethod(Params(1))
      Dim MethodArgInfo = Method.GetParameters(0)
      Dim MethodArg = Singular.Web.Data.JS.StatelessJSSerialiser.DeserialiseObject(MethodArgInfo.ParameterType, Params(2))

      Method.Invoke(ServerProgram, {MethodArg})

    End If

  End Sub

#End Region

  Friend Sub [Stop]()
    If _ServiceUpdateQueue IsNot Nothing Then _ServiceUpdateQueue.Stop()
  End Sub


End Class
