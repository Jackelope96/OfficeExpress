using Singular.Web.Security;

namespace OETWeb.Maintenance
{
  /// <summary>
  /// The Security page class
  /// </summary>
  public partial class Security : OETPageBase<SecurityVM>
  {
  }

  /// <summary>
  /// The SecurityVM ViewModel class
  /// </summary>
  public class SecurityVM: StatelessSecurityVM
  {
  }
}
