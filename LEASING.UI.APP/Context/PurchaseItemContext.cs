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
    public class PurchaseItemContext
    {
        public DataSet GetGetPurchaseItemById(int recid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetPurchaseItemById";

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
                    //_SqlParameter = null;
                    _SqlCommand = null;
                    _SqlConnection = null;
                }
                return dsRec;
            }
        }
        public DataSet GetGetPurchaseItemInfoById(int recid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetPurchaseItemInfoById";

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
                    //_SqlParameter = null;
                    _SqlCommand = null;
                    _SqlConnection = null;
                }
                return dsRec;
            }
        }
        public DataSet GetGetPurchaseItemList()
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetPurchaseItemList";

                //_SqlParameter = new SqlParameter("@RecId", recid);
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

        public DataSet GetInActivePurchaseItemList()
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetInActivePurchaseItemList";

                //_SqlParameter = new SqlParameter("@RecId", recid);
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
        public string SavePurchaseItem(PurchaseItemModel model)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;

            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_SavePurchaseItem";

            //_sqlpara = new SqlParameter("@RecId", model.ProjectId);
            //_sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ProjectId", model.ProjectId);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@Descriptions", model.Descriptions);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@DatePurchase", model.DatePurchase);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@UnitAmount", model.UnitAmount);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@Amount", model.Amount);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@TotalAmount", model.TotalAmount);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@Remarks", model.Remarks);
            _sqlcmd.Parameters.Add(_sqlpara);


            _sqlpara = new SqlParameter("@UnitNumber", model.UnitNumber);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@UnitID", model.UnitID);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@EncodedBy", Variables.UserID);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            _sqlcmd.Parameters.Add(_sqlpara);


            try
            {
                _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
                _sqlcmd.Connection = _sqlcon;
                _sqlcmd.CommandType = CommandType.StoredProcedure;

                //_sqlreader = SqlDataReader(_sqlcmd, false);

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
                //vErrorMessage = Convert.ToString(expCommon.Message);
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
        public string EditPurchaseItem(PurchaseItemModel model)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;

            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_UpdatePurchaseItemById";

            //_sqlpara = new SqlParameter("@RecId", model.ProjectId);
            //_sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@RecId", model.RecId);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@ProjectId", model.ProjectId);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@Descriptions", model.Descriptions);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@DatePurchase", model.DatePurchase);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@UnitAmount", model.UnitAmount);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@Amount", model.Amount);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@TotalAmount", model.TotalAmount);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@Remarks", model.Remarks);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@UnitNumber", model.UnitNumber);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@UnitID", model.UnitID);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@LastChangedBy", Variables.UserID);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            _sqlcmd.Parameters.Add(_sqlpara);


            try
            {
                _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
                _sqlcmd.Connection = _sqlcon;
                _sqlcmd.CommandType = CommandType.StoredProcedure;

                //_sqlreader = SqlDataReader(_sqlcmd, false);

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
                //vErrorMessage = Convert.ToString(expCommon.Message);
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
        public string DeletePurchaseItem(int recid)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;

            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_DeletePurchaseItemById";

            _sqlpara = new SqlParameter("@RecId", recid);
            _sqlcmd.Parameters.Add(_sqlpara);

            try
            {
                _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
                _sqlcmd.Connection = _sqlcon;
                _sqlcmd.CommandType = CommandType.StoredProcedure;

                //_sqlreader = SqlDataReader(_sqlcmd, false);

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
                //vErrorMessage = Convert.ToString(expCommon.Message);
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
        public string DeactivatePurchaseItem(int recid)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;

            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_DeactivatePurchaseItemById";

            _sqlpara = new SqlParameter("@RecId", recid);
            _sqlcmd.Parameters.Add(_sqlpara);

            try
            {
                _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
                _sqlcmd.Connection = _sqlcon;
                _sqlcmd.CommandType = CommandType.StoredProcedure;

                //_sqlreader = SqlDataReader(_sqlcmd, false);

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
                //vErrorMessage = Convert.ToString(expCommon.Message);
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

        public string ActivatePurchaseItem(int recid)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;

            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_activatePurchaseItemById";

            _sqlpara = new SqlParameter("@RecId", recid);
            _sqlcmd.Parameters.Add(_sqlpara);

            try
            {
                _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
                _sqlcmd.Connection = _sqlcon;
                _sqlcmd.CommandType = CommandType.StoredProcedure;

                //_sqlreader = SqlDataReader(_sqlcmd, false);

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
                //vErrorMessage = Convert.ToString(expCommon.Message);
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
