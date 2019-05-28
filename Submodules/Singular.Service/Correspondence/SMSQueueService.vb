Public MustInherit Class SMSQueueService
  Inherits CorrespondenceQueueBase(Of Singular.Correspondence.ISmsSettings)

  Public Sub New(ServiceID As Integer, QueueName As String)
    MyBase.New(ServiceID, QueueName, "SMS Sender")
  End Sub

  Protected Overrides Sub SetupSender(Settings As Singular.Correspondence.ISmsSettings)
    Singular.SmsSending.SmsSender.SetSettings(Settings)
  End Sub

  Protected Overrides Function HasSettings(Settings As Correspondence.ISmsSettings) As Boolean
    Return Not String.IsNullOrEmpty(Settings.SmsUserName) AndAlso Not String.IsNullOrEmpty(Settings.SmsPassword)
  End Function

  Protected Overrides Sub SendCorrespondence()

    Try
      Dim SMSList = Singular.SmsSending.SmsList.GetUnsentSmsList

      Try
        SMSList.Send()

        Try
          SMSList.Save()
        Catch ex As Exception
          'If the sms list fails to save, it means there is no way of marking that the email is sent.
          'If the service is not stopped, the same smses will continue to be sent over and over.
          _QR.Stop()
          WriteProgress("Error saving sms list", ex)
        End Try

      Catch ex As Exception
        WriteProgress("Error sending smses", ex)
      End Try

    Catch ex As Exception
      WriteProgress("Error fetching sms list", ex)
    End Try

  End Sub

End Class
