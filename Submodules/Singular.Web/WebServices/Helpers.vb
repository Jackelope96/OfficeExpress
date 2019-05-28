Namespace WebServices

  Public Module Helpers

    Public Class RestResponse

      Private mSuccessObject As Object
      Private mStatusCode As Integer = 200
      Private mErrorText As String

      Public Sub New(SuccessObject As Object)
        mSuccessObject = SuccessObject
      End Sub

      Public Sub New(ErrorStatusCode As Integer, ErrorText As String)
        mStatusCode = ErrorStatusCode
        mErrorText = ErrorText
      End Sub

      Public ReadOnly Property SuccessObject As Object
        Get
          Return mSuccessObject
        End Get
      End Property

      Public ReadOnly Property StatusCode As Integer
        Get
          Return mStatusCode
        End Get
      End Property

      Public ReadOnly Property ErrorText As String
        Get
          Return mErrorText
        End Get
      End Property

      Friend Property DataType As DataType = Singular.Web.DataType.JSON

      Friend Sub RenderResponse(Response As HttpResponse, RenderObjectGuids As Boolean)

        If DataType = Singular.Web.DataType.JSON Then
          Response.ContentType = "application/json"
          Response.ContentEncoding = System.Text.Encoding.UTF8
        End If

        If mStatusCode = 200 Then
          If mSuccessObject Is Nothing Then Exit Sub

          If DataType = Singular.Web.DataType.JSON Then

            If GetType(Singular.Web.ASyncResult).IsAssignableFrom(mSuccessObject.GetType) Then
              CType(mSuccessObject, Singular.Web.ASyncResult).AjaxProgressInfo.WriteHTTPResponse(False, System.Web.HttpContext.Current)
            Else
              If TypeOf mSuccessObject Is String Then
                Response.ContentType = "text/plain"
                Response.Write(mSuccessObject)
              Else
                Dim FullRender As Boolean = True
                If GetType(Singular.Web.Result).IsAssignableFrom(mSuccessObject.GetType) Then
                  FullRender = CType(mSuccessObject, Singular.Web.Result).IsInitialData
                End If
                Response.Write(Singular.Web.Data.JSonWriter.SerialiseObject(mSuccessObject, , RenderObjectGuids, , FullRender))
              End If


            End If

          ElseIf DataType = Singular.Web.DataType.Binary Then
            Response.BinaryWrite(mSuccessObject)
          End If

        Else
          Response.StatusCode = mStatusCode
          Response.Write(ErrorText)
        End If
      End Sub

    End Class

    ''' <summary>
    ''' Returns the object serialised as JSON to the client.
    ''' </summary>
    Public Function SuccessResponse(Obj As Object) As RestResponse
      Return New RestResponse(Obj)
    End Function

    ''' <summary>
    ''' Returns the object serialised as JSON to the client.
    ''' </summary>
    Public Function SuccessResponse(Obj As Object, wc As Singular.Web.WebCallable) As RestResponse
      Dim rr As New RestResponse(Obj)
      If wc IsNot Nothing Then
        rr.DataType = wc.DataType
      End If
      Return rr
    End Function

    ''' <summary>
    ''' Returns HTTP status code {StatusCode} to the client, with the specified error text. 
    ''' </summary>
    Public Function FailedResonse(StatusCode As Integer, ErrorText As String) As RestResponse
      Return New RestResponse(StatusCode, ErrorText)
    End Function

    ''' <summary>
    ''' Returns HTTP status code 500 to the client, with the specified error text. 
    ''' </summary>
    Public Function ServerErrorResonse(ErrorText As String) As RestResponse
      Return New RestResponse(500, ErrorText)
    End Function

    ''' <summary>
    ''' Returns HTTP status code 400 to the client, with the specified error text. 
    ''' </summary>
    Public Function ClientErrorResponse(ErrorText As String) As RestResponse
      Return New RestResponse(400, ErrorText)
    End Function

    ''' <summary>
    ''' Returns HTTP status code 403 to the client, with the specified error text. 
    ''' </summary>
    Public Function AuthorisationErrorResponse(ErrorText As String) As RestResponse
      Return New RestResponse(403, ErrorText)
    End Function

    ''' <summary>
    ''' Returns HTTP status code 404 to the client
    ''' </summary>
    Public Function NotFoundResponse() As RestResponse
      Return New RestResponse(404, "Not Found")
    End Function

  End Module

End Namespace

