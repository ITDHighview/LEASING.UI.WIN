using LEASING.UI.APP.Common;
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
    public class OtherContext
    {      
        public DataSet GetTotalCountLabel()
        {
            SqlCommand _SqlCommand = null;
            //SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetTotalCountLabel";
                //_SqlParameter = new SqlParameter("", "");
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
                    Functions.LogError("GetTotalCountLabel", "OtherContext", expCommon.ToString(), DateTime.Now, null);
                    Functions.ErrorShow("GetTotalCountLabel", expCommon.ToString());
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
        public DataSet GetNotificationList()
        {
            SqlCommand _SqlCommand = null;
            //SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetNotificationList";
                //_SqlParameter = new SqlParameter("", "");
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
                    Functions.LogError("GetNotificationList", "OtherContext", expCommon.ToString(), DateTime.Now, null);
                    Functions.ErrorShow("GetNotificationList", expCommon.ToString());
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
        public DataSet GetUnitListByProjectAndStatus(int ProjectId,string UnitStatus)
        {
            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetUnitListByProjectAndStatus";
                _SqlParameter = new SqlParameter("@ProjectId", ProjectId);
                _SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@UnitStatus", UnitStatus);
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
                    Functions.LogError("GetUnitListByProjectAndStatus", "OtherContext", expCommon.ToString(), DateTime.Now, null);
                    Functions.ErrorShow("GetUnitListByProjectAndStatus", expCommon.ToString());
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
        public DataSet GetProjectStatusCount(int projectid)
        {
            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetProjectStatusCount";
                _SqlParameter = new SqlParameter("@ProjectId", projectid);
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
                    Functions.LogError("GetProjectStatusCount", "OtherContext", expCommon.ToString(), DateTime.Now, null);
                    Functions.ErrorShow("GetProjectStatusCount", expCommon.ToString());
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
    }
}
