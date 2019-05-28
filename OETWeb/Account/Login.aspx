<%@ Page Title="Log In" Language="C#" MasterPageFile="~/SiteLoggedOut.Master" AutoEventWireup="false"
	CodeBehind="Login.aspx.cs" Inherits="OETWeb.Account.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

	<%
		using (var h = this.Helpers)
		{
			//var toolbar = h.Toolbar();
			//{
			//	toolbar.Helpers.HTML().Heading2("Log In");
			//	toolbar.Helpers.HTML("Please enter your user name and password");
			//}

			h.MessageHolder();
			var LoginDiv = h.Div();
			{
				var ImgDiv1 = LoginDiv.Helpers.DivC("row text-center");
				{
					var ImgDiv = ImgDiv1.Helpers.HTML("<img class='LoginImgSize' src='../Images/OFFICEEXPRESSLOGO.fw.png' />");

				}

				var fieldSet = LoginDiv.Helpers.FieldSetFor<Singular.Web.Security.LoginDetails>("Account Information", c => c.LoginDetails);
				{
					fieldSet.AddClass("StackedEditors SUI-RuleBorder");

					//var FieldDiv = LoginDiv.Helpers.DivC("TextCenter");
					//{
					//	fieldSet.Helpers.EditorRowFor(c => c.UserName);
					//	fieldSet.Helpers.EditorRowFor(c => c.Password);
					//}

					var row2 = fieldSet.Helpers.DivC("TextCenter");
					{
						row2.Helpers.LabelFor(c => c.UserName);
						row2.Helpers.EditorFor(c => c.UserName).AddClass("WidthInput");

					}

					var row = fieldSet.Helpers.DivC("TextCenter");
					{
						row.Helpers.LabelFor(c => c.Password);
						row.Helpers.EditorFor(c => c.Password).AddClass("WidthInput");
					}


					var RememberDiv = fieldSet.Helpers.DivC("TextCenter");
					{
						var row3 = RememberDiv.Helpers.DivC("row");
						{
							row3.Helpers.EditorFor(c => c.RememberMe);
							row3.Helpers.LabelFor(c => c.RememberMe).AddClass("MarginRight5");
						}
					}


				}

				var ButtonDiv = fieldSet.Helpers.DivC("TextCenter");
				{
					var button = ButtonDiv.Helpers.Button("Login", "Log In");
					{
						button.AddClass("");
						button.AddBinding(Singular.Web.KnockoutBindingString.click, "Login()");
						button.ClickOnEnterKey = true;
						button.Image.Glyph = Singular.Web.FontAwesomeIcon.@lock;
					}
				}

			}
		}


	%>

	<script type="text/javascript">

		function Login() {
			Singular.Validation.IfValid(ViewModel, function () {
				ViewModel.CallServerMethod('Login', { LoginDetails: ViewModel.LoginDetails.Serialise() }, function (result) {
					if (result.Success) {
						window.location = result.Data ? result.Data : ViewModel.RedirectLocation();
					} else {
						ViewModel.LoginDetails().Password('');
						Singular.AddMessage(1, 'Login', result.ErrorText).Fade(2000);
					}
				});
			});
		}

	</script>

</asp:Content>
