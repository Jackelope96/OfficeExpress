using Singular.Web.MaintenanceHelpers;

namespace OETWeb.Maintenance
{
  /// <summary>
  /// The Maintenance custom page class
  /// </summary>
  public partial class Maintenance : OETPageBase<MaintenanceVM>
  {
  }

  /// <summary>
  /// The MaintenanceVM ViewModel class
  /// </summary>
  public class MaintenanceVM: StatelessMaintenanceVM
  {
    /// <summary>
    /// Setup the ViewModel
    /// </summary>
    protected override void Setup()
    {
      base.Setup();

      // TODO: Add Maintenance pages here.
      // Please don't leave any commented out text here!

      MainSection mainSection = AddMainSection("General");
      mainSection.AddMaintenancePage<OETWeb.Maintenance.Products>("Products");
    }
  }
}
