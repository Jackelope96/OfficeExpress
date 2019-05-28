Public MustInherit Class EmailQueueService
  Inherits CorrespondenceQueueBase(Of Singular.Correspondence.IEmailSettings)

  Public Sub New(ServiceID As Integer, QueueName As String)
    MyBase.New(ServiceID, QueueName, "Email Sender")
  End Sub

  Protected Overrides Sub SetupSender(Settings As Singular.Correspondence.IEmailSettings)
    Singular.Emails.MailSettings.DefaultCredential.FromProjectSettings(Settings)
  End Sub

  Protected Overrides Function HasSettings(Settings As Correspondence.IEmailSettings) As Boolean
    Return Not String.IsNullOrEmpty(Settings.EMailServer) AndAlso Not String.IsNullOrEmpty(Settings.FromEMailAddress)
  End Function

  Protected Overrides Sub SendCorrespondence()

    Try
      Dim EmailList = Singular.Emails.EmailList.GetEmailList(False)

      Try
        EmailList.SendEmails()

        Try
          EmailList.Save()
        Catch ex As Exception
          'If the email list fails to save, it means there is no way of marking that the email is sent.
          'If the service is not stopped, the same emails will continue to be sent over and over.
          _QR.Stop()
          WriteProgress("Error saving email list", ex)
        End Try

      Catch ex As Exception
        WriteProgress("Error sending emails", ex)
      End Try

    Catch ex As Exception
      WriteProgress("Error fetching email list", ex)
    End Try

  End Sub

End Class
