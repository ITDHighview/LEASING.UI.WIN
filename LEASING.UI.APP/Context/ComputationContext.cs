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
    public class ComputationContext
    {
        public string SaveComputation(ComputationModel model)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_SaveComputation";
            _sqlpara = new SqlParameter("@ProjectId", model.ProjectId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@InquiringClient", model.InquiringClient);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ClientMobile", model.ClientMobile);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ClientID", model.ClientID);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@UnitId", model.UnitId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@UnitNo", model.UnitNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@StatDate", model.StatDate);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@FinishDate", model.FinishDate);
            _sqlcmd.Parameters.Add(_sqlpara);  
            _sqlpara = new SqlParameter("@Rental", model.Rental);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SecAndMaintenance", model.SecAndMaintenance);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@TotalRent", model.TotalRent);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SecDeposit", model.SecDeposit);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Total", model.Total);
            _sqlcmd.Parameters.Add(_sqlpara);   
            _sqlpara = new SqlParameter("@EncodedBy", model.EncodedBy);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@XML", model.XML);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@AdvancePaymentAmount", model.AdvancePaymentAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsFullPayment", model.IsFullPayment);
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
        public string SaveComputationParking(ComputationModel model)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_SaveComputationParking";
            _sqlpara = new SqlParameter("@ProjectId", model.ProjectId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@InquiringClient", model.InquiringClient);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ClientMobile", model.ClientMobile);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ClientID", model.ClientID);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@UnitId", model.UnitId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@UnitNo", model.UnitNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@StatDate", model.StatDate);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@FinishDate", model.FinishDate);
            _sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@Applicabledate1", model.Applicabledate1);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@Applicabledate2", model.Applicabledate2);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@TransactionDate", model.TransactionDate);
            //_sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Rental", model.Rental);
            _sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@SecAndMaintenance", model.SecAndMaintenance);
            //_sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@TotalRent", model.TotalRent);
            _sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@Advancemonths1", model.Advancemonths1);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@Advancemonths2", model.Advancemonths2);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@SecDeposit", model.SecDeposit);
            //_sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Total", model.Total);
            _sqlcmd.Parameters.Add(_sqlpara);

            _sqlpara = new SqlParameter("@EncodedBy", model.EncodedBy);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsFullPayment", model.IsFullPayment);
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
        public string DeleteComputation( int recid,int unitid)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_DeleteUnitReferenceById";
            _sqlpara = new SqlParameter("@RecId", recid);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@UnitId", unitid);
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
        public DataSet GetComputationList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetComputationList";

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
        public DataSet GetUnitComputationList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetUnitComputationList";

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
        public DataSet GetParkingComputationList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetParkingComputationList";

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
        public DataSet GetPostDatedCountMonth(string FromDate,string EndDate,string rental,string XML)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetPostDatedCountMonth";

                _SqlParameter = new SqlParameter("@FromDate", FromDate);
                _SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@EndDate", EndDate);
                _SqlCommand.Parameters.Add(_SqlParameter);
                //_SqlParameter = new SqlParameter("@ApplicableDate1", ApplicableDate1);
                //_SqlCommand.Parameters.Add(_SqlParameter);
                //_SqlParameter = new SqlParameter("@ApplicableDate2", ApplicableDate2);
                //_SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@Rental", rental);
                _SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@XML", XML);
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
        public DataSet GetPostDatedMonthList(string FromDate, string EndDate, string XML)
        {
            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetPostDatedMonthList";
                _SqlParameter = new SqlParameter("@FromDate", FromDate);
                _SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@EndDate", EndDate);
                _SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@XML", XML);
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
        public DataSet GetPostDatedCountMonthParking(string FromDate, string EndDate, string rental)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetPostDatedCountMonthParking";

                _SqlParameter = new SqlParameter("@FromDate", FromDate);
                _SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@EndDate", EndDate);
                _SqlCommand.Parameters.Add(_SqlParameter);
                //_SqlParameter = new SqlParameter("@ApplicableDate1", ApplicableDate1);
                //_SqlCommand.Parameters.Add(_SqlParameter);
                //_SqlParameter = new SqlParameter("@ApplicableDate2", ApplicableDate2);
                //_SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@Rental", rental);
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
        public DataSet GetComputationById(int recid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetComputationById";

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
        public DataSet GetMonthLedgerByRefIdAndClientId(int refid,string cliendId)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetMonthLedgerByRefIdAndClientId";

                _SqlParameter = new SqlParameter("@ReferenceID", refid);
                _SqlCommand.Parameters.Add(_SqlParameter);

                _SqlParameter = new SqlParameter("@ClientID", cliendId);
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
        public DataSet GetLedgerList(int recid,string ClientID)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetLedgerList";

                _SqlParameter = new SqlParameter("@ReferenceID", recid);
                _SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@ClientID", ClientID);
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
        public DataSet GetReferenceByClientID(string ClientID)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetReferenceByClientIDpaid";

                _SqlParameter = new SqlParameter("@ClientID", ClientID);
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
        public DataSet GetPaymentListByReferenceId(string referenceid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetPaymentListByReferenceId";

                _SqlParameter = new SqlParameter("@RefId", referenceid);
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
        public DataSet GetContractList()
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetContractList";

                //_SqlParameter = new SqlParameter("@RefId", referenceid);
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
                    _SqlParameter = null;
                    _SqlCommand = null;
                    _SqlConnection = null;
                }
                return dsRec;
            }
        }
        public DataSet GetReceiptByRefId(string referenceid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetReceiptByRefId";

                _SqlParameter = new SqlParameter("@RefId", referenceid);
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

    }
}
