using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Context
{
   public class Class1
    {
        public DataSet GEtLIST()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "proc_AAA_MIGRATION_GET";

                //_SqlParameter = new SqlParameter("@ApproverEmpNno", _AssignTo);
                //_SqlCommand.Parameters.Add(_SqlParameter);

                try
                {
                    _SqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
                    _SqlCommand.Connection = _SqlConnection;
                    _SqlCommand.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter dataAdaptor = new SqlDataAdapter(_SqlCommand))
                    {
                        dataAdaptor.Fill(dsRec);
                    }
                }
                catch (Exception expCommon)
                {
                    return null;
                }
                finally
                {
                    if (_SqlConnection.State != ConnectionState.Closed)
                    {
                        _SqlConnection.Close();
                    }
                    //_SqlParameter = null;
                    _SqlCommand = null;
                    _SqlConnection = null;
                }
                return dsRec;
            }
        }



        //public string testMigration(string _Service_Code, Decimal _Normal_Charges)
        //{
        //    SqlCommand _sqlcmd = null;
        //    SqlParameter _sqlpara;
        //    SqlConnection _sqlcon = null;
        //    SqlDataReader _sqlreader = null;

        //    _sqlcmd = new SqlCommand();
        //    _sqlcmd.CommandText = "proc_MIGRATION_INSERT";

        //    _sqlpara = new SqlParameter("@XML", M_XMLNeedl_nEWe());
        //    _sqlcmd.Parameters.Add(_sqlpara);



        //    try
        //    {
        //        _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
        //        _sqlcmd.Connection = _sqlcon;
        //        _sqlcmd.CommandType = CommandType.StoredProcedure;

        //        //_sqlreader = SqlDataReader(_sqlcmd, false);

        //        _sqlcmd.Connection.Open();
        //        _sqlreader = _sqlcmd.ExecuteReader();
        //        _sqlreader.Read();

        //        int index;
        //        if (_sqlreader.HasRows)
        //        {
        //            index = _sqlreader.GetOrdinal("Message_Code");
        //            if (!_sqlreader.IsDBNull(index))
        //                return Convert.ToString(_sqlreader.GetString(index));
        //        }
        //    }
        //    catch (Exception expCommon)
        //    {
        //        //vErrorMessage = Convert.ToString(expCommon.Message);
        //        return "FAILED|" + Convert.ToString(expCommon.Message);
        //    }
        //    finally
        //    {
        //        if (_sqlcon.State != ConnectionState.Closed)
        //        {
        //            _sqlcon.Close();
        //        }
        //        _sqlpara = null;
        //        _sqlcmd = null;
        //        _sqlreader = null;
        //    }
        //    return "";
        //}

        //       <connectionStrings>
        //	<add name = "TESTCONNECTION" connectionString="Data Source=DESKTOP-BTI8OA8;Initial Catalog=BiometrikDb;connect timeout=200;Integrated Security=false;Connection Timeout=60;User Id=histestuser;Password=histestuser"/>
        //</connectionStrings>
    }
}
