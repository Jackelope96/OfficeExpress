Imports System.Reflection

Namespace CustomControls

  Public Class PagedGrid(Of ObjectType, ChildControlObjectType)
    Inherits Table(Of ObjectType, ChildControlObjectType)

    Public Property PagingManager As System.Linq.Expressions.Expression(Of System.Func(Of ObjectType, Object))

    Private mPagingManagerProperty As PropertyInfo
    'Private mContainerDiv As HTMLDiv(Of ChildControlObjectType)
    Private mPagerDiv As HTMLDiv(Of ChildControlObjectType)
    Private mTextBox As HTMLTag(Of ChildControlObjectType)
    Private mLoadingBar As LoadingOverlay(Of ObjectType)

    Public Property ButtonClass As String = "TBButton"

    Public Property BtnFirst As HTMLTag(Of ChildControlObjectType)
    Public Property BtnPrev As HTMLTag(Of ChildControlObjectType)
    Public Property BtnNext As HTMLTag(Of ChildControlObjectType)
    Public Property BtnLast As HTMLTag(Of ChildControlObjectType)

    Protected Friend Overrides Sub Setup()
      MyBase.Setup()

      AllowClientSideSorting = False

      mPagingManagerProperty = Singular.Reflection.GetMember(PagingManager)

      mPagerDiv = Helpers.Div()
      mPagerDiv.AddClass("Pager")
      With mPagerDiv.Helpers

        'Left section
        With .Div
          .Style.FloatLeft()
          .AddClass("Buttons")

          'First / Prev
          '.Helpers.HTMLTag("button").AddClass("TBElement TBButton PagedGrid-First").Style.BackgroundImage = "url(" & VirtualPathUtility.ToAbsolute("~/Images/TBFirst.png") & ")"
          '.Helpers.HTMLTag("button").AddClass("TBElement TBButton PagedGrid-Prev").Style.BackgroundImage = "url(" & VirtualPathUtility.ToAbsolute("~/Images/TBPrev.png") & ")"
          '.Helpers.HTMLTag("span").AddClass("TBElement TBSeperator")
          BtnFirst = .Helpers.HTMLTag("button")
          With BtnFirst
            .AddClass("TBElement " & ButtonClass)
            .Style.BackgroundImage = "url(" & VirtualPathUtility.ToAbsolute("~/Images/TBFirst.png") & ")"
          End With
          BtnPrev = .Helpers.HTMLTag("button")
          With BtnPrev
            .AddClass("TBElement " & ButtonClass)
            .Style.BackgroundImage = "url(" & VirtualPathUtility.ToAbsolute("~/Images/TBPrev.png") & ")"
          End With
          .Helpers.HTMLTag("span").AddClass("TBElement TBSeperator")

          'Page x of x
          .Helpers.HTMLTag("span", "Page ").AddClass("TBElement")

          mTextBox = .Helpers.HTMLTag("input")
          With mTextBox
            .Style.Width = 30
            .Attributes("type") = "text"
            .AddBinding(KnockoutBindingString.NValue, mPagingManagerProperty.Name & "().PageNo")
          End With
          With .Helpers.HTMLTag("span")
            .AddClass("TBElement")
            .AddBinding(KnockoutBindingString.text, "' of ' + " & mPagingManagerProperty.Name & "().Pages()")
          End With


          'Next / Last
          .Helpers.HTMLTag("span").AddClass("TBElement TBSeperator")
          '.Helpers.HTMLTag("button").AddClass("TBElement TBButton PagedGrid-Next").Style.BackgroundImage = "url(" & VirtualPathUtility.ToAbsolute("~/Images/TBNext.png") & ")"
          '.Helpers.HTMLTag("button").AddClass("TBElement TBButton PagedGrid-Last").Style.BackgroundImage = "url(" & VirtualPathUtility.ToAbsolute("~/Images/TBLast.png") & ")"
          BtnNext = .Helpers.HTMLTag("button")
          With BtnNext
            .AddClass("TBElement " & ButtonClass)
            .Style.BackgroundImage = "url(" & VirtualPathUtility.ToAbsolute("~/Images/TBNext.png") & ")"
          End With
          BtnLast = .Helpers.HTMLTag("button")
          With BtnLast
            .AddClass("TBElement " & ButtonClass)
            .Style.BackgroundImage = "url(" & VirtualPathUtility.ToAbsolute("~/Images/TBLast.png") & ")"
          End With

        End With
        'Right section
        With .Div
          .Style.FloatRight()
          .AddClass("Status")

          .Helpers.HTMLTag("span").AddClass("TBElement TBSeperator")
          .Helpers.HTMLTag("span").AddBinding(KnockoutBindingString.text, mPagingManagerProperty.Name & "().PageDescription()")
        End With
        .Div.Style.ClearBoth()


      End With

      mLoadingBar = New LoadingOverlay(Of ObjectType)
      Helpers.Control(mLoadingBar)
      mLoadingBar.AddBinding(KnockoutBindingString.visible, mPagingManagerProperty.Name & "().IsLoading")

    End Sub

    Protected Friend Overrides Sub Render()

      If Me.Style("width") = "" Then
        Me.Style("width") = "100%"
      End If

      'Render the containing div
      Writer.Write("<div style=""width:" & Me.Style("width") & "; position: relative;"" data-bind=""PagedGrid: " & mPagingManagerProperty.Name & """>")

      'Reset the width to 100%, as the table will use the same style
      Me.Style("width") = "100%"
      'Render the table
      MyBase.Render()

      'Render the paging toolbar
      mPagerDiv.Render()
      mLoadingBar.Render()

      Writer.Write("</div>")

    End Sub

  End Class

  Public Class LoadingOverlay(Of ObjectType)
    Inherits HTMLDiv(Of ObjectType)

    Protected Friend Overrides Sub Setup()
      MyBase.Setup()

      AddClass("LoadingOverlay")
      Style.Position = Position.absolute

      With Helpers.Div
        .AddClass("Outer")

        With .Helpers.Div
          .AddClass("Inner")

          '.Helpers.Image("~/Images/LoadingSmall.gif")
          .Helpers.HTMLTag("span", "Loading...").AddClass("Loading")
        End With
      End With

    End Sub

    Protected Friend Overrides Sub Render()
      MyBase.Render()

    End Sub

  End Class

End Namespace
