// Generated 31 Mar 2015 14:42 - Singular Systems Object Generator Version 2.1.661
// ToDo: Was manually converted. Generate new base with updated object generator.
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using Csla;
using Csla.Data;
#if SILVERLIGHT == false 
using System.Data.SqlClient;
#endif

namespace OETLib.Security
{
  /// <summary>
  /// The ROUserPaged class
  /// </summary>
  [Serializable]
  public class ROUserPaged: OETReadOnlyBase<ROUserPaged>
  {
    #region Properties

    /// <summary>
    /// User ID PropertyInfo
    /// </summary>
    public static PropertyInfo<int> UserIDProperty = RegisterProperty<int>((c) => c.UserID, "ID");

    /// <summary>
    /// Gets the ID value
    /// </summary>
    [Display(AutoGenerateField = false), Key]
    public int? UserID
    {
      get
      {
        return GetProperty(UserIDProperty);
      }
    }

    /// <summary>
    /// User Name PropertyInfo
    /// </summary>
    public static PropertyInfo<string> UserNameProperty = RegisterProperty<string>((c) => c.UserName, "User Name");

    /// <summary>
    /// Gets the User Name value
    /// </summary>
    [Display(Name = "User Name", Description = "")]
    public string UserName
    {
      get
      {
        return GetProperty(UserNameProperty);
      }
    }

    /// <summary>
    /// First Name PropertyInfo
    /// </summary>
    public static PropertyInfo<string> FirstNameProperty = RegisterProperty<string>((c) => c.FirstName, "First Name");

    /// <summary>
    /// Gets the First Name value
    /// </summary>
    [Display(Name = "First Name", Description = "")]
    public string FirstName
    {
      get
      {
        return GetProperty(FirstNameProperty);
      }
    }

    /// <summary>
    /// Last Name PropertyInfo
    /// </summary>
    public static PropertyInfo<string> LastNameProperty = RegisterProperty<string>((c) => c.LastName, "Last Name");

    /// <summary>
    /// Gets the Last Name value
    /// </summary>
    [Display(Name = "Last Name", Description = "")]
    public string LastName
    {
      get
      {
        return GetProperty(LastNameProperty);
      }
    }

    #endregion

    #region Methods

    /// <summary>
    /// Get the User's ID
    /// </summary>
    /// <returns></returns>
    protected override object GetIdValue()
    {
      return GetProperty(UserIDProperty);
    }

    /// <summary>
    /// Convert to a string
    /// </summary>
    /// <returns>The user's Username</returns>
    public override string ToString()
    {
      return this.UserName;
    }
    
    #endregion

    #region Data Access & Factory Methods

    internal static ROUserPaged GetROUserPaged(SafeDataReader safeDataReader)
    {
      ROUserPaged roUserPaged = new ROUserPaged();
      roUserPaged.Fetch(safeDataReader);
      return roUserPaged;
    }

    protected void Fetch(SafeDataReader safeDataReader)
    {
      this.LoadProperty(UserIDProperty, safeDataReader.GetInt32(0));
      this.LoadProperty(UserNameProperty, safeDataReader.GetString(1));
      this.LoadProperty(FirstNameProperty, safeDataReader.GetString(2));
      this.LoadProperty(LastNameProperty, safeDataReader.GetString(3));
    }

    #endregion
  }
}
