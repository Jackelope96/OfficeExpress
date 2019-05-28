
Namespace Service

  Public Module ServiceModule

    Public Const ServiceUpdateQueueName As String = "ServiceUpdateQueue"

    ''' <summary>
    ''' True if changes to settings / service info must write a message to the service update queue.
    ''' </summary>
    Public Property ServiceUpdateEnabled As Boolean = False

    ''' <summary>
    ''' True if the current application is a service. Will be set by Servicebase.
    ''' </summary>
    Public Property IsService As Boolean = False

    Public Property GetDefaultInfoFunction As Func(Of Integer, String, IServerProgramInfo)

    Public Enum ServiceUpdateMessageType
      ServiceInfoUpdated = 1
      SystemSettingsUpdated = 2
      CommonDataType = 3
      CommonDataName = 4
      CommonDataAll = 5
      ServiceMessage = 6
    End Enum

#If SILVERLIGHT Then

#Else

    Public Sub NotifyService(MessageType As ServiceUpdateMessageType, Message As String, Optional IgnoreEnableSetting As Boolean = False)
      If (ServiceUpdateEnabled OrElse IgnoreEnableSetting) AndAlso Not IsService Then
        Singular.CommandProc.RunCommand("CmdProcs.cmdServerProgramMessage", {"@MessageType", "@Message"}, {MessageType, Message})
      End If
    End Sub

#End If

  End Module

End Namespace
