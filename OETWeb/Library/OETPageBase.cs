using Singular.Web;

namespace OETWeb
{
  /// <summary>
  /// The OETPageBase class
  /// </summary>
  /// <typeparam name="VM"></typeparam>
  public class OETPageBase<VM>: PageBase<VM> where VM: IViewModel
  {
    protected override void OnInit(System.EventArgs e)
    {
      base.OnInit(e);

      if (OETLib.Security.OETWebSecurity.HasAuthenticatedUser())
      {
        if (OETLib.Security.OETWebSecurity.CurrentIdentity().ResetState == OETLib.Security.ResetState.MustResetPassword)
        {
          Singular.Web.Misc.NavigationHelper.RedirectAndRemember("~/Account/ChangePassword.aspx?WasReset=true");
        }
      }
    }
  }
}
