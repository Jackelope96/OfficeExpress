Imports System.ComponentModel
Imports System.ComponentModel.DataAnnotations
Imports Singular.DataAnnotations

Namespace Documents

  ''' <summary>
  ''' Allows temporary storage of documents in memory, for use with UI elements that use DocumentProviderBase.
  ''' </summary>
  <Serializable(), ProtectedKeySalt("TDocument")>
  Public Class TemporaryDocument
    Inherits DocumentProviderBase(Of TemporaryDocument)

    Public Sub New()

    End Sub

    Public Sub New(DocumentName As String, Document As Byte())
      SetDocument(Document, DocumentName)
    End Sub

    Public Shared Function NewTemporaryDocument(DocumentID As String, DocumentName As String) As TemporaryDocument
      Dim td As New TemporaryDocument
      td.SetDocument(DocumentID, DocumentName)
      Return td
    End Function

    <Key>
    Public Overrides Property DocumentID As Integer?
      Get
        Return MyBase.DocumentID
      End Get
      Set(value As Integer?)
        MyBase.DocumentID = value
      End Set
    End Property

    Public Shadows Property DocumentName As String
      Get
        Return MyBase.DocumentName
      End Get
      Set(value As String)
        MyBase.SetDocumentName(value)
      End Set
    End Property

    Public Function SaveToDatabase() As TemporaryDocument
      Document = Document.Save
      DocumentID = Document.DocumentID
      Return Me
    End Function

    Protected Overrides Sub CallSaveDocument()
      Throw New NotSupportedException("Save not allowed on TemporaryDocument")
    End Sub

    Public Overrides Sub DeleteSelf()
      Throw New NotSupportedException("Delete not allowed on TemporaryDocument")
    End Sub

    Public Overrides Sub Insert()
      Throw New NotSupportedException("Insert not allowed on TemporaryDocument")
    End Sub

    Public Overrides Sub Update()
      Throw New NotSupportedException("Update not allowed on TemporaryDocument")
    End Sub

  End Class

  ''' <summary>
  ''' Allows temporary storage of documents in memory, for use with UI elements that use DocumentProviderBase.
  ''' </summary>
  <Serializable()>
  Public Class TemporaryDocumentNotRequired
    Inherits TemporaryDocument

    Public Overloads Shared Function NewTemporaryDocument(DocumentID As String, DocumentName As String) As TemporaryDocumentNotRequired
      Dim td As New TemporaryDocumentNotRequired
      td.SetDocument(DocumentID, DocumentName)
      Return td
    End Function

    Protected Overrides ReadOnly Property DocumentRequired As Boolean
      Get
        Return False
      End Get
    End Property

  End Class

  <Serializable>
  Public Class TemporaryDocumentUnprotected
    Inherits TemporaryDocument

    <Key, Singular.DataAnnotations.UnProtectedKey>
    Public Overrides Property DocumentID As Integer?
      Get
        Return MyBase.DocumentID
      End Get
      Set(value As Integer?)
        MyBase.DocumentID = value
      End Set
    End Property
  End Class

End Namespace


