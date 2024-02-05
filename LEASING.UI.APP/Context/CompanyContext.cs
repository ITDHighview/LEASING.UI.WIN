using LEASING.UI.APP.Common;
using LEASING.UI.APP.Models;
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
    public class CompanyContext
    {
        public DataSet GetCompanyList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetCompanyList";

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
        public DataSet GetCompanyDetails(int recid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetCompanyDetails";

                _SqlParameter = new SqlParameter("@RecId", recid);
                _SqlCommand.Parameters.Add(_SqlParameter);

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
                    _SqlParameter = null;
                    _SqlCommand = null;
                    _SqlConnection = null;
                }
                return dsRec;
            }
        }

        public string SaveCompany(CompanyModel model)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_SaveCompany";
            _sqlpara = new SqlParameter("@CompanyName", model.CompanyName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyAddress", model.CompanyAddress);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyTIN", model.CompanyTIN);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyOwnerName", model.CompanyOwnerName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@EncodedBy", Variables.UserID);
            _sqlcmd.Parameters.Add(_sqlpara);
            try
            {
                _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
                _sqlcmd.Connection = _sqlcon;
                _sqlcmd.CommandType = CommandType.StoredProcedure;
                _sqlcmd.Connection.Open();
                _sqlreader = _sqlcmd.ExecuteReader();
                _sqlreader.Read();
                int index;
                if (_sqlreader.HasRows)
                {
                    index = _sqlreader.GetOrdinal("Message_Code");
                    if (!_sqlreader.IsDBNull(index))
                        return Convert.ToString(_sqlreader.GetString(index));
                }
            }
            catch (Exception expCommon)
            {
                return "FAILED|" + Convert.ToString(expCommon.Message);
            }
            finally
            {
                if (_sqlcon.State != ConnectionState.Closed)
                {
                    _sqlcon.Close();
                }
                _sqlpara = null;
                _sqlcmd = null;
                _sqlreader = null;
            }
            return "";
        }

        public string UpdateCompany(CompanyModel model)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_UpdateCompany";
            _sqlpara = new SqlParameter("RecId", model.RecId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyName", model.CompanyName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyAddress", model.CompanyAddress);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyTIN", model.CompanyTIN);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyOwnerName", model.CompanyOwnerName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@EncodedBy", Variables.UserID);
            _sqlcmd.Parameters.Add(_sqlpara);
            try
            {
                _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
                _sqlcmd.Connection = _sqlcon;
                _sqlcmd.CommandType = CommandType.StoredProcedure;
                _sqlcmd.Connection.Open();
                _sqlreader = _sqlcmd.ExecuteReader();
                _sqlreader.Read();
                int index;
                if (_sqlreader.HasRows)
                {
                    index = _sqlreader.GetOrdinal("Message_Code");
                    if (!_sqlreader.IsDBNull(index))
                        return Convert.ToString(_sqlreader.GetString(index));
                }
            }
            catch (Exception expCommon)
            {
                return "FAILED|" + Convert.ToString(expCommon.Message);
            }
            finally
            {
                if (_sqlcon.State != ConnectionState.Closed)
                {
                    _sqlcon.Close();
                }
                _sqlpara = null;
                _sqlcmd = null;
                _sqlreader = null;
            }
            return "";
        }
    }
}
