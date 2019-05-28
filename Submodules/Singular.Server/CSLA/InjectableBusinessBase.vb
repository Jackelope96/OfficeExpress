<Serializable()> _
Public Class InjectableBusinessBase(Of C As InjectableBusinessBase(Of C))
  Inherits SingularBusinessBase(Of C)

  Protected Sub New()

  End Sub

  Protected Overrides Sub DataPortal_OnDataPortalInvoke(e As Csla.DataPortalEventArgs)
    Inject()
    MyBase.DataPortal_OnDataPortalInvoke(e)
  End Sub

  Protected Overrides Sub Child_OnDataPortalInvoke(e As Csla.DataPortalEventArgs)
    Inject()
    MyBase.Child_OnDataPortalInvoke(e)
  End Sub

  Protected Overrides Sub OnDeserialized(context As Runtime.Serialization.StreamingContext)
    Inject()
    MyBase.OnDeserialized(context)
  End Sub

  Private Sub Inject()

    Dim t = Me.GetType()


  End Sub

End Class
