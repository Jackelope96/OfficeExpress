using System;

namespace OETWeb
{
  /// <summary>
  /// The Default page class
  /// </summary>
  public partial class Default : OETPageBase<OETEmptyViewModel>
  {

		protected void Page_Load(object sender, EventArgs e)
		{
			//No default page for you
			this.Response.Redirect("~/Account/Home.aspx");
		}

		public class DefaultVM : OETStatelessViewModel<DefaultVM>
		{
			protected override void Setup()
			{
				base.Setup();
				

			}
		}

	}
}
