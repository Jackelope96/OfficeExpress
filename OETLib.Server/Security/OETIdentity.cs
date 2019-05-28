using System;
using System.Data.SqlClient;
using Csla.Data;
using Singular.Security;
using Singular.Web.Security;

namespace OETLib.Security
{
  /// <summary>
  /// ResetState Enumeration
  /// </summary>
  public enum ResetState
  {
    /// <summary>
    /// Normal State (No reset needed)
    /// </summary>
    Normal = 0,

    /// <summary>
    /// Indicates that the password must be reset
    /// </summary>
    MustResetPassword = 1
  }

  /// <summary>
  /// The OETIdentity class
  /// </summary>
  [Serializable]
  public class OETIdentity: WebIdentity<OETIdentity>
  {
    #region Fields

    /// <summary>
    /// The First Name
    /// </summary>
    private string firstName;

    /// <summary>
    /// The Email Address
    /// </summary>
    private string emailAddress;

    /// <summary>
    /// Is this the identity's first time logging in?
    /// </summary>
    private bool firstTimeLogin;

    /// <summary>
    /// Password reset state
    /// </summary>
    private ResetState resetState;

    #endregion

    #region Properties

    /// <summary>
    /// Gets the Email Address
    /// </summary>
    public string EmailAddress
    {
      get
      {
        return this.emailAddress;
      }
    }

    /// <summary>
    /// Gets the First Name
    /// </summary>
    public string FirstName
    {
      get
      {
        return this.firstName;
      }
    }

    /// <summary>
    /// Gets the First Time Login indicator
    /// </summary>
    public Boolean FirstTimeLogin
    {
      get
      {
        return this.firstTimeLogin;
      }
    }

    /// <summary>
    /// Gets the password Reset State
    /// </summary>
    public ResetState ResetState
    {
      get
      {
        return this.resetState;
      }
    }

    #endregion

    #region Methods

    /// <summary>
    /// Marks the user as not first time login. This should be called after the user has gone to any page / or whatever process needs to run for first time users.
    /// </summary>
    public void MarkNonFirstTimeLogin()
    {
      this.firstTimeLogin = false;

      // Call a cmd proc to update this in the database.
    }

    /// <summary>
    /// After changing a user's password, call this to clear the Reset State
    /// </summary>
    public void ChangedPassword()
    {
      this.resetState = ResetState.Normal;
    }

    /// <summary>
    /// Setup a SQL Command to do a login check
    /// </summary>
    /// <param name="command">A SQL Command instance</param>
    /// <param name="criteria">The login criteria</param>
    protected override void SetupSqlCommand(SqlCommand command, IdentityCriterea criteria)
    {
      base.SetupSqlCommand(command, criteria);

      command.CommandText = "CmdProcs.WebLogin";
      command.Parameters["@Password"].Value = OETWebSecurity.GetPasswordHash(command.Parameters["@Password"].Value.ToString());
    }

    /// <summary>
    /// Reads the extra OETIdentity class properties from the data reader
    /// </summary>
    /// <param name="safeDataReader">Data reader containing the additional properties</param>
    /// <param name="startIndex">Index to start reading from</param>
    protected override void ReadExtraProperties(SafeDataReader safeDataReader, ref int startIndex)
    {
      base.ReadExtraProperties(safeDataReader, ref startIndex);

      this.emailAddress = safeDataReader.GetString(startIndex);
      this.firstTimeLogin = safeDataReader.GetBoolean(startIndex + 1);
      // Implement these columns in the Stored Procedure if you need them
      this.resetState = (ResetState)safeDataReader.GetInt32(startIndex + 2);
      // this.firstName = safeDataReader.GetString(startIndex + 3);
    }

    #endregion
  }
}
