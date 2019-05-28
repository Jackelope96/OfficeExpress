// Generated 31 Mar 2015 14:42 - Singular Systems Object Generator Version 2.1.661
// ToDo: Was manually converted. Generate new base with updated object generator.
using System;
using System.Data;
using System.ComponentModel.DataAnnotations;
using Csla;
using Csla.Data;
using Singular.Paging;
using Singular.Web;
#if SILVERLIGHT == false
using System.Data.SqlClient;
#endif

namespace OETLib.Security
{
  /// <summary>
  /// The ROUserPagedList class
  /// </summary>
  [Serializable]
  public class ROUserPagedList: OETReadOnlyListBase<ROUserPagedList, ROUserPaged>, IPagedList
  {
    private int totalRecords = 0;

    public int TotalRecords
    {
      get
      {
        return this.totalRecords;
      }
    }

    #region "Data Access"

    [Serializable, WebFetchable]
    public class Criteria : PageCriteria<Criteria>
    {
      public static PropertyInfo<string> UserNameProperty = PageCriteria<Criteria>.RegisterSProperty<string>((c) => c.UserName, string.Empty);

      [Singular.DataAnnotations.TextField, Display(Name="Filter User Name")]
      public string UserName { get; set; }

      public Criteria()
      {
        UserName = string.Empty;
      }
    }

    public void New()
    {
    }

    public void Fetch(SafeDataReader safeDataReader)
    {
      safeDataReader.Read();
      this.totalRecords = safeDataReader.GetInt32(0);
      safeDataReader.NextResult();

      this.RaiseListChangedEvents = false;
      this.IsReadOnly = false;
      while (safeDataReader.Read())
      {
        this.Add(ROUserPaged.GetROUserPaged(safeDataReader));
      }
      this.IsReadOnly = true;
      this.RaiseListChangedEvents = true;
    }

    protected override void DataPortal_Fetch(object criteriaObject)
    {
      Criteria criteria = (Criteria)criteriaObject;
      using (SqlConnection connection = new SqlConnection(Singular.Settings.ConnectionString))
      {
        connection.Open();
        try
        {
          using (SqlCommand command = connection.CreateCommand())
          {
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "GetProcs.getROUserPagedList";
            criteria.AddParameters(command);
            command.Parameters.AddWithValue("@UserName", criteria.UserName);

            using (SafeDataReader safeDataReader = new SafeDataReader(command.ExecuteReader()))
            {
              this.Fetch(safeDataReader);
            }
          }
        }
        finally
        {
          connection.Close();
        }
      }
    }

    #endregion
  }
}
