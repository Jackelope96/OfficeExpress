using System.Web;
using System.Web.UI;
using Singular.Web;
using Singular.Web.Security;
using OETLib.Security;

namespace OETWeb.Account
{
  public partial class Login: OETPageBase<LoginVM>
  {
  }

  public class LoginVM: OETStatelessViewModel<LoginVM>
  {
    /// <summary>
    /// The login details
    /// </summary>
    public LoginDetails LoginDetails { get; set; }

    /// <summary>
    /// The location to redirect to after login
    /// </summary>
    public string RedirectLocation { get; set; }

    /// <summary>
    /// Setup the Login ViewModel
    /// </summary>
    protected override void Setup()
    {
      base.Setup();

      this.LoginDetails = new LoginDetails();

      this.ValidationMode = ValidationMode.OnSubmit;
      this.ValidationDisplayMode = ValidationDisplayMode.Controls;

			if(Page.Request.QueryString["ReturnUrl"] == "/OETWeb/default.aspx")
			{
				this.RedirectLocation = VirtualPathUtility.ToAbsolute(Security.GetSafeRedirectUrl("~/Account/Home.aspx", "~/Account/Home.aspx"));
			}
			else
			{
				this.RedirectLocation = VirtualPathUtility.ToAbsolute(Security.GetSafeRedirectUrl(Page.Request.QueryString["ReturnUrl"], "~/Account/Home.aspx"));
			}						
		}

    /// <summary>
    /// Check the login details
    /// </summary>
    /// <param name="loginDetails">Login details</param>
    /// <returns>True if the login details are valid</returns>
    [WebCallable(LoggedInOnly = false)]
    public Result Login(LoginDetails loginDetails)
    {
      return OETIdentity.Login(loginDetails);
    }
  }
}
