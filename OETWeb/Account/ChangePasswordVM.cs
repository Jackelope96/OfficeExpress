using System;
using System.Data;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using Csla;
using Singular;
using Singular.Web;
using OETLib;
using OETLib.Security;

namespace OETWeb
{
  /// <summary>
  /// The ChangePasswordVM class
  /// </summary>
  public class ChangePasswordVM: OETStatelessViewModel<ChangePasswordVM>
  {
    #region Properties

    /// <summary>
    /// The Password Change Details
    /// </summary>
    public ChangeDetails Details { get; set; }

    #endregion

    #region Methods

    /// <summary>
    /// Setup the ChangePasswordVM View Model
    /// </summary>
    protected override void Setup()
    {
      base.Setup();

      this.Details = new ChangeDetails();

      if (Page.Request.QueryString["WasReset"] != null)
      {
        AddMessage(Singular.Web.MessageType.Information, "Reset Password", "You have logged in with a temporary password. Please choose a new password now.");
      }
    }

    /// <summary>
    /// Changes a user's password
    /// </summary>
    /// <param name="details">The password change details</param>
    /// <returns>The password change result</returns>
    [WebCallable]
    public static Tuple<Singular.Web.MessageType, String> ChangePassword(ChangeDetails details)
    {
      // Check for any business rule failures
      if (!details.CheckAllRules())
      {
        return Tuple.Create(Singular.Web.MessageType.Validation, "Validation failed");
      }

      // Check if the password meets complexity requirements
      Singular.Misc.Password.PasswordChecker passwordChecker = new Singular.Misc.Password.PasswordChecker(8, true, true, true, false, 1);
      if (!passwordChecker.CheckPassword(details.NewPassword))
      {
        return Tuple.Create(Singular.Web.MessageType.Warning, passwordChecker.ErrorMessage);
      }

      // Attempt to change the user's password
      DataRow result = CommandProc.GetDataRow(
        "CmdProcs.cmdChangePassword",
        new string[] { "@UserID", "@OldPassword", "@NewPassword" },
        new object[] { 
            Singular.Settings.CurrentUserID,
            OETWebSecurity.GetPasswordHash(details.OldPassword),
            OETWebSecurity.GetPasswordHash(details.NewPassword)
          });

      if (!(bool)result[0])
      {
        return Tuple.Create(Singular.Web.MessageType.Warning, "The password you entered doesn't match your current password.");
      }
      else
      {
        return Tuple.Create(Singular.Web.MessageType.Success, "Change Password Success.");
      }
    }

    #endregion

    #region Classes

    /// <summary>
    /// The ChangeDetails class
    /// </summary>
    public class ChangeDetails : OETBusinessBase<ChangeDetails>
    {
      #region Properties

      /// <summary>
      /// Old Password PropertyInfo
      /// </summary>
      public static PropertyInfo<string> OldPasswordProperty = RegisterProperty<string>((c) => c.OldPassword);

      /// <summary>
      /// New Password PropertyInfo
      /// </summary>
      public static PropertyInfo<string> NewPasswordProperty = RegisterProperty<string>((c) => c.NewPassword);

      /// <summary>
      /// Confirm Password PropertyInfo
      /// </summary>
      public static PropertyInfo<string> ConfirmPasswordProperty = RegisterProperty<string>((c) => c.ConfirmPassword);

      /// <summary>
      /// ToString PropertyInfo
      /// </summary>
      public static PropertyInfo<string> ToStringProperty = RegisterReadOnlyProperty<string>((c) => c.ToString(), (f) => "Change Password");

      /// <summary>
      /// Gets the Old Password
      /// </summary>
      [Required(ErrorMessage = "Old Password Required"), PasswordPropertyText]
      public string OldPassword
      {
        get
        {
          return this.GetProperty(OldPasswordProperty);
        }
        set
        {
          this.SetProperty(OldPasswordProperty, value);
        }
      }

      /// <summary>
      /// Gets the New Password
      /// </summary>
      [PasswordPropertyText, StringLength(100, MinimumLength = 8, ErrorMessage = "New Password must be between 8 and 100 characters.")]
      public string NewPassword
      {
        get
        {
          return this.GetProperty(NewPasswordProperty);
        }
        set
        {
          this.SetProperty(NewPasswordProperty, value);
        }
      }

      /// <summary>
      /// Gets the Confirm Password
      /// </summary>
      [Required(ErrorMessage = "Confirm Password Required"), PasswordPropertyText]
      public string ConfirmPassword
      {
        get
        {
          return this.GetProperty(ConfirmPasswordProperty);
        }
        set
        {
          this.SetProperty(ConfirmPasswordProperty, value);
        }
      }

      /// <summary>
      /// Convert to a string
      /// </summary>
      /// <returns>String describing the change details</returns>
      public override string ToString()
      {
        return this.GetProperty<string>(ToStringProperty);
      }

      #endregion

      #region Methods

      /// <summary>
      /// Add property business rules
      /// </summary>
      protected override void AddBusinessRules()
      {
        base.AddBusinessRules();

        this.AddWebRule(ConfirmPasswordProperty,
          (c) => c.NewPassword != c.ConfirmPassword,
          (c) => "Confirmed Password does not match new Password");

        this.AddWebRule(NewPasswordProperty,
          (c) => c.NewPassword != string.Empty && c.NewPassword == c.OldPassword,
          (c) => "New Password cannot be same as Old Password");
      }

      #endregion
    }

    #endregion
  }
}
