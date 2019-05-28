using System.ComponentModel;
using System.Linq;
using Singular.Security;
using Singular.Web;
using Singular.Web.Data;
using OETLib.Security;

namespace OETWeb.Maintenance
{
  /// <summary>
  /// The Users page class
  /// </summary>
  public partial class Users : OETPageBase<UsersVM>
  {
  }

  /// <summary>
  /// The UsersVM ViewModel class
  /// </summary>
  public class UsersVM : OETStatelessViewModel<UsersVM>
  {
    /// <summary>
    /// User List Page Manager 
    /// </summary>
    public PagedDataManager<UsersVM> UserListPageManager { get; set; }

    /// <summary>
    /// User Criteria 
    /// </summary>
    public ROUserPagedList.Criteria UserCriteria { get; set; }

    /// <summary>
    /// User List
    /// </summary>
    public ROUserPagedList UserList { get; set; }

    /// <summary>
    /// The Editing User
    /// </summary>
    public OETLib.Security.User EditingUser { get; set; }

    /// <summary>
    /// UsersVM constructor
    /// </summary>
    public UsersVM()
    {
      this.UserListPageManager = new PagedDataManager<UsersVM>((c) => c.UserList, (c) => c.UserCriteria, "UserName", 20);
      this.UserCriteria = new ROUserPagedList.Criteria();
      this.UserList = new ROUserPagedList();
    }

    /// <summary>
    /// Setup the Users ViewModel
    /// </summary>
    protected override void Setup()
    {
      base.Setup();

      this.ValidationDisplayMode = ValidationDisplayMode.Controls | ValidationDisplayMode.SubmitMessage;

      this.UserList = (ROUserPagedList)UserListPageManager.GetInitialData();
    }

    /// <summary>
    /// Gets the Security Group List (For drop down)
    /// </summary>
    [Browsable(false)]
    public SecurityGroupList SecurityGroupList
    {
      get
      {
        return SecurityGroupList.GetSecurityGroupList();
      }
    }

    /// <summary>
    /// Get the user with the given Id
    /// </summary>
    /// <param name="userId">The User Id</param>
    /// <returns>A User instance</returns>
    [WebCallable]
    public static OETLib.Security.User GetUser(int userId)
    {
      return OETLib.Security.UserList.GetUserList(userId).First();
    }

    /// <summary>
    /// Save changes to a user
    /// </summary>
    /// <param name="user">A user instance</param>
    /// <returns>The save result</returns>
    [WebCallable(Roles = new string[] { "Security.Manage Users" })]
    public static SaveResult SaveUser(OETLib.Security.User user)
    {
      return new SaveResult(user.TrySave(typeof(OETLib.Security.UserList)));
    }

    /// <summary>
    /// Delete the user with the given Id
    /// </summary>
    /// <param name="userId">The User Id</param>
    /// <returns>The delete result</returns>
    [WebCallable(Roles = new string[] { "Security.Manage Users" })]
    public static Result DeleteUser(int userId)
    {
      OETLib.Security.UserList userList = OETLib.Security.UserList.GetUserList(userId);
      if (userList.Count != 1)
      {
        return new Result(false, "You don't have access to edit this user");
      }
      else
      {
        userList.RemoveAt(0);
        userList.Save();
        return new Result(true);
      }
    }

    /// <summary>
    /// Reset a user's password
    /// </summary>
    /// <param name="userName">The user's username</param>
    [WebCallable(Roles = new string[] { "Security.Reset Passwords" })]
    public static void ResetPassword(string userName)
    {
      OETLib.Security.User.ResetPassword(userName);
    }
  }
}
