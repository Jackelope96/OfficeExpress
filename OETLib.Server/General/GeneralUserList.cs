﻿// Generated 26 Jun 2019 23:30 - Singular Systems Object Generator Version 2.2.699
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


namespace OETLib.Server.General
{
  [Serializable]
  public class GeneralUserList
   : SingularBusinessListBase<GeneralUserList, GeneralUser>
  {
    #region " Business Methods "

    public GeneralUser GetItem(int UserID)
    {
      foreach (GeneralUser child in this)
      {
        if (child.UserID == UserID)
        {
          return child;
        }
      }
      return null;
    }

    public override string ToString()
    {
      return "S";
    }

    #endregion

    #region " Data Access "

    [Serializable]
    public class Criteria
      : CriteriaBase<Criteria>
    {
      public Criteria()
      {
      }
      public int? _userid { get; set; }

    }

    public static GeneralUserList NewGeneralUserList()
    {
      return new GeneralUserList();
    }

    public GeneralUserList()
    {
      // must have parameter-less constructor
    }

    public static GeneralUserList GetGeneralUserList(int userid)
    {
      return DataPortal.Fetch<GeneralUserList>(new Criteria{ _userid = userid});
    }

    protected void Fetch(SafeDataReader sdr)
    {
      this.RaiseListChangedEvents = false;
      while (sdr.Read())
      {
        this.Add(GeneralUser.GetGeneralUser(sdr));
      }
      this.RaiseListChangedEvents = true;
    }

    protected override void DataPortal_Fetch(Object criteria)
    {
      Criteria crit = (Criteria)criteria;
      using (SqlConnection cn = new SqlConnection(Singular.Settings.ConnectionString))
      {
        cn.Open();
        try
        {
          using (SqlCommand cm = cn.CreateCommand())
          {
            cm.CommandType = CommandType.StoredProcedure;
            //custom stored proc code
            if (crit._userid.HasValue)
              cm.Parameters.AddWithValue("@userid", crit._userid);
            cm.CommandText = "GetProcs.getGeneralUserList";
            using (SafeDataReader sdr = new SafeDataReader(cm.ExecuteReader()))
            {
              Fetch(sdr);
            }
          }
        }
        finally
        {
          cn.Close();
        }
      }
    }

    #endregion

  }

}