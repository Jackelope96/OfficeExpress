using System;
using Singular.Web;
using OETLib;
using OETLib.Security;

namespace OETWeb
{
  public class Global : ApplicationSettings<OETIdentity>
  {
    /// <summary>
    /// Setup the Application
    /// </summary>
    protected override void ApplicationSetup()
    {
      WebError.SupportsWebError = true;

      // Set the Common Data Reset Time
      CommonData.DefaultLifeTime = new TimeSpan(1, 0, 0);

      // Initialise Common Data Application Scope Lists
      CommonData.GetCachedLists();

      Singular.Web.Controls.Controls.DefaultButtonStyle = Singular.Web.ButtonStyle.Bootstrap;
      Singular.Web.Controls.Controls.DefaultButtonPostBackType = Singular.Web.PostBackType.Ajax;
      Singular.Web.Controls.Controls.DefaultDropDownType = Singular.DataAnnotations.DropDownWeb.SelectType.Combo;
      Singular.Web.Controls.Controls.UsesPagedGrid = true;

      Singular.Documents.Settings.PassUserIDToGetProc = true;
      Singular.Documents.Settings.DocumentHashesEnabled = true;

      Singular.Emails.EMailBuilder.RegardsText = "Regards<br/>OfficeExpressTuckShop";

      Singular.SystemSettings.General.RegisterSettingsClass<OETLib.CorrespondenceSettings>();

			Singular.Web.Scripts.Scripts.Settings.LibJQueryVersion = Singular.Web.Scripts.ScriptSettings.JQueryVersion.JQ_1_12_4;
			Singular.Web.Scripts.Scripts.Settings.LibJQueryUIVersion = Singular.Web.Scripts.ScriptSettings.JQueryUIVersion.JQ_UI_1_12_1;

		}

    /// <summary>
    /// Handles the start session event
    /// </summary>
    /// <param name="sender">The sender</param>
    /// <param name="e">The event arguments</param>
    public override void Session_Start(object sender, EventArgs e)
    {
      base.Session_Start(sender, e);

      // Initialise Common Data Session Scope Lists
      CommonData.InitialiseSessionLists();
    }
  }
}
