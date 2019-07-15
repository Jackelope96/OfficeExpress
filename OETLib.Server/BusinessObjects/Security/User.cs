using System;
using System.Data.SqlClient;
using Singular;
using Singular.Emails;
using Singular.Rules;
using Singular.Security;

namespace OETLib.Security
{
  [Serializable]
  public class User : UserBase<User>
  {
    #region Properties

    /// <summary>
    /// Gets the parameter name for UserName
    /// </summary>
    protected override string UserNameParamName
    {
      get
      {
        return "@UserName";
      }
    }

    /// <summary>
    /// Gets the parameter name for Surname
    /// </summary>
    protected override string SurnameParamName
    {
      get
      {
        return "@LastName";
      }
    }

    /// <summary>
    /// Gets the Can Update UserName flag
    /// (NOTE: If you want to make the username updateable, you will need to update the updUser Stored Proc to accept a Username parameter (Same ordering as insUser)
    /// </summary>
    protected override bool CanUpdateUserName
    {
      get
      {





        return false;
      }
    }

    #endregion

    #region Members

    /// <summary>
    /// Adds rules to enforce Email Address entry and detect if a Username already exists
    /// </summary>
    protected override void AddCustomPasswordRule()
    {
      // Add custom password rule
      this.AddWebRule(EmailAddressProperty, u => u.EmailAddress == "", u => "Email address is required");

      JavascriptRule<User> rule = AddWebRule(User.LoginNameProperty, u => u.LoginName == "", u => "");
      rule.ASyncBusyText = "Checking rule...";
      rule.ServerRuleFunction = (user) =>
      {
        CommandProc commandProc = new CommandProc("CmdProcs.cmdCheckUserExists", new string[] { "@UserID", "@UserName" }, new object[] { user.UserID, user.LoginName }, CommandProc.FetchTypes.DataRow);
        if (commandProc.Execute().DataRowValue != null)
        {
          return "A user with this name already exists.";
        }
        else
        {
          return "";
        }
      };
    }

    // Instructions to allow passwords to be changed in Edit User dialog.
    // 1. Remove the InsertUpdate method which generates a random password
    // 2. Uncomment the first part of UpdProcs.updUser

    /// <summary>
    /// Inserts or updates a user
    /// </summary>
    /// <param name="command">A SQL Command instance</param>
    protected override void InsertUpdate(SqlCommand command)
    {
      Boolean sendEmail = false;
      String tempPassword = Singular.Misc.Password.CreateRandomEasyPassword(8);

      if (this.IsNew)
      {
        sendEmail = true;
        this.Password = tempPassword;
      }

      base.InsertUpdate(command);

      if (sendEmail)
      {
        EMailBuilder.Create(this.EmailAddress, "OfficeExpressTuckShop User Created")
  .AddHeading("OfficeExpressTuckShop User Created")
  .AddParagraph("Please note, your user for OfficeExpressTuckShop has been created.")
  .AddParagraph("User Name: " + this.LoginName + "<br/>Password: " + tempPassword)
  .AddParagraph("Please log in as soon as possible with the above temporary password. You will be required to change your password the first time you log in.")
  .AddRegards()
  .Save();
      }
    }

    /// <summary>
    /// Adds the hashed password to the given SQL parameters list
    /// </summary>
    /// <param name="parameters">SQL Parameters list</param>
    protected override void AddExtraParameters(ref SqlParameterCollection parameters)
    {
      base.AddExtraParameters(ref parameters);

      var password = parameters["@Password"].Value;
      if (password != DBNull.Value)
      {
        parameters["@Password"].Value = OETWebSecurity.GetPasswordHash(password.ToString());
      }
    }

    /// <summary>
    /// Reset a user's password
    /// </summary>
    /// <param name="userName">The user's username</param>
    public static void ResetPassword(string userName)
    {
      //string newPassword = Singular.Misc.Password.CreateRandomEasyPassword(8);
      string newPassword = "Singular";

      CommandProc commandProc = new CommandProc(
        "CmdProcs.cmdResetPassword",
        new string[] { "@UserName", "@RandomPassword" },
        new object[] { userName, OETLib.Security.OETWebSecurity.GetPasswordHash(newPassword) },
        Singular.CommandProc.FetchTypes.DataRow);

      commandProc = commandProc.Execute();

      if ((bool)commandProc.DataRow[0])
      {
        EMailBuilder.Create(commandProc.DataRow["EmailAddress"].ToString(), "Password Reset")
          .AddHeading("Password Reset")
          .AddParagraph("Please note, your password for OfficeExpressTuckShop has been reset to " + newPassword)
          .AddParagraph("Please log in as soon as possible, and change your password.")
          .AddRegards()
          .Save();
      }
    }

    #endregion
  }
}
