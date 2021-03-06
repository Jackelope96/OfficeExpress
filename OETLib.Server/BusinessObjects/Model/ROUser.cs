﻿// Generated 28 May 2019 20:16 - Singular Systems Object Generator Version 2.2.699
//<auto-generated/>
using System;
using Csla;
using Csla.Serialization;
using Csla.Data;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using Singular;
using Singular.DataAnnotations;
using System.Data;
using System.Data.SqlClient;


namespace OETLib.BusinessObjects.Model
{
  [Serializable]
  public class ROUser
   : SingularReadOnlyBase<ROUser>
  {
    #region " Properties and Methods "

    #region " Properties "

    public static PropertyInfo<int> UserIDProperty = RegisterProperty<int>(c => c.UserID, "ID", 0);
    /// <summary>
    /// Gets the ID value
    /// </summary>
    [Display(AutoGenerateField = false), Key]
    public int UserID
    {
      get { return GetProperty(UserIDProperty); }
    }

    public static PropertyInfo<string> FirstNameProperty = RegisterProperty<string>(c => c.FirstName, "First Name", "");
    /// <summary>
    /// Gets the First Name value
    /// </summary>
    [Display(Name = "First Name", Description = "")]
    public string FirstName
    {
      get { return GetProperty(FirstNameProperty); }
    }

    public static PropertyInfo<string> LastNameProperty = RegisterProperty<string>(c => c.LastName, "Last Name", "");
    /// <summary>
    /// Gets the Last Name value
    /// </summary>
    [Display(Name = "Last Name", Description = "")]
    public string LastName
    {
      get { return GetProperty(LastNameProperty); }
    }

    public static PropertyInfo<string> UserNameProperty = RegisterProperty<string>(c => c.UserName, "User Name", "");
    /// <summary>
    /// Gets the User Name value
    /// </summary>
    [Display(Name = "User Name", Description = "")]
    public string UserName
    {
      get { return GetProperty(UserNameProperty); }
    }

    public static PropertyInfo<byte[]> PasswordProperty = RegisterProperty<byte[]>(c => c.Password, "Password", null);
    /// <summary>
    /// Gets the Password value
    /// </summary>
    [Display(Name = "Password", Description = "SHA2_256 hashed password.")]
    public byte[] Password
    {
      get { return GetProperty(PasswordProperty); }
    }

    public static PropertyInfo<byte[]> SaltProperty = RegisterProperty<byte[]>(c => c.Salt, "Salt");
    /// <summary>
    /// Gets the Salt value
    /// </summary>
    [Display(Name = "Salt", Description = "Salt to be combined with plain text password. This is a guid that is changed whenever the user changes their password.")]
    public byte[] Salt
    {
      get { return GetProperty(SaltProperty); }
    }

    public static PropertyInfo<string> RFIDProperty = RegisterProperty<string>(c => c.RFID, "RF", (string)"");
    /// <summary>
    /// Gets the RF value
    /// </summary>
    [Display(Name = "RF", Description = "")]
    public string RFID
    {
      get { return GetProperty(RFIDProperty); }
    }

    public static PropertyInfo<DateTime> PasswordChangeDateProperty = RegisterProperty<DateTime>(c => c.PasswordChangeDate, "Password Change Date");
    /// <summary>
    /// Gets the Password Change Date value
    /// </summary>
    [Display(Name = "Password Change Date", Description = "Last time the password was changed / when the user was created.")]
    public DateTime PasswordChangeDate
    {
      get
      {
        return GetProperty(PasswordChangeDateProperty);
      }
    }

    public static PropertyInfo<SmartDate> CreatedDateProperty = RegisterProperty<SmartDate>(c => c.CreatedDate, "Created Date");
    /// <summary>
    /// Gets the Created Date value
    /// </summary>
    [Display(AutoGenerateField = false)]
    public SmartDate CreatedDate
    {
      get { return GetProperty(CreatedDateProperty); }
    }

    public static PropertyInfo<int> CreatedByProperty = RegisterProperty<int>(c => c.CreatedBy, "Created By");
    /// <summary>
    /// Gets the Created By value
    /// </summary>
    [Display(AutoGenerateField = false)]
    public int? CreatedBy
    {
      get { return GetProperty(CreatedByProperty); }
    }

    public static PropertyInfo<bool> FirstTimeLoginProperty = RegisterProperty<bool>(c => c.FirstTimeLogin, "First Time Login", true);
    /// <summary>
    /// Gets the First Time Login value
    /// </summary>
    [Display(Name = "First Time Login", Description = "True when the user is created, set to false the first time they log in.")]
    public bool FirstTimeLogin
    {
      get { return GetProperty(FirstTimeLoginProperty); }
    }

    public static PropertyInfo<string> EmailAddressProperty = RegisterProperty<string>(c => c.EmailAddress, "Email Address", "");
    /// <summary>
    /// Gets the Email Address value
    /// </summary>
    [Display(Name = "Email Address", Description = "")]
    public string EmailAddress
    {
      get { return GetProperty(EmailAddressProperty); }
    }

    public static PropertyInfo<int> ResetStateProperty = RegisterProperty<int>(c => c.ResetState, "Reset State", 1);
    /// <summary>
    /// Gets the Reset State value
    /// </summary>
    [Display(Name = "Reset State", Description = "Password reset state. 0 = Normal, 1=Must change password on login, 2=Locked out until password reset again.")]
    public int ResetState
    {
      get { return GetProperty(ResetStateProperty); }
    }

    public static PropertyInfo<int> DeductIDProperty = RegisterProperty<int>(c => c.DeductID, "Reset State", 1);
    /// <summary>
    /// Gets the Reset State value
    /// </summary>
    [Display(Name = "Deduct from salary")]
    public int DeductID
    {
      get { return GetProperty(DeductIDProperty); }
    }

    #endregion

    #region " Methods "

    protected override object GetIdValue()
    {
      return GetProperty(UserIDProperty);
    }

    public override string ToString()
    {
      return this.FirstName;
    }

    #endregion

    #endregion

    #region " Data Access & Factory Methods "

    internal static ROUser GetROUser(SafeDataReader dr)
    {
      var r = new ROUser();
      r.Fetch(dr);
      return r;
    }

    protected void Fetch(SafeDataReader sdr)
    {
      int i = 0;
      LoadProperty(UserIDProperty, sdr.GetInt32(i++));
      LoadProperty(FirstNameProperty, sdr.GetString(i++));
      LoadProperty(LastNameProperty, sdr.GetString(i++));
      LoadProperty(UserNameProperty, sdr.GetString(i++));
      LoadProperty(PasswordProperty, sdr.GetValue(i++));
      LoadProperty(SaltProperty, sdr.GetValue(i++));
      LoadProperty(RFIDProperty, sdr.GetValue(i++));
      LoadProperty(PasswordChangeDateProperty, sdr.GetValue(i++));
      LoadProperty(CreatedDateProperty, sdr.GetSmartDate(i++));
      LoadProperty(CreatedByProperty, sdr.GetInt32(i++));
      LoadProperty(FirstTimeLoginProperty, sdr.GetBoolean(i++));
      LoadProperty(EmailAddressProperty, sdr.GetString(i++));
      LoadProperty(ResetStateProperty, sdr.GetInt32(i++));
      LoadProperty(DeductIDProperty, sdr.GetInt32(i++));
    }

    #endregion

  }

}