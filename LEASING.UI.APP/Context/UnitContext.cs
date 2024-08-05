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
    public class UnitContext
    {

        public string SaveUnit(UnitModel model)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_SaveNewtUnit";
            _sqlpara = new SqlParameter("@ProjectId", model.ProjectId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsParking", model.IsParking);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@FloorNo", model.FloorNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@AreaSqm", model.AreaSqm);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@AreaRateSqm", model.AreaRateSqm);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@AreaTotalAmount", model.AreaTotalAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@FloorType", model.FloorType);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BaseRental", model.BaseRental);
            _sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@UnitStatus", model.UnitStatus);
            //_sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@DetailsofProperty", model.DetailsofProperty);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@UnitNo", model.UnitNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@UnitSequence", model.UnitSequence);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@EndodedBy", Variables.UserID);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BaseRentalVatAmount", model.BaseRentalVatAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BaseRentalWithVatAmount", model.BaseRentalWithVatAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BaseRentalTax", model.BaseRentalTax);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsNonVat", model.IsNonVat);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsNonTax", model.IsNonTax);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsNonCusa", model.IsNonCusa);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@TotalRental", model.TotalRental);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SecAndMainAmount", model.SecAndMainAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SecAndMainVatAmount ", model.SecAndMainVatAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SecAndMainWithVatAmount", model.SecAndMainWithVatAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Vat", model.Vat);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Tax", model.Tax);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@TaxAmount", model.TaxAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsNotRoundOff", model.IsNotRoundOff);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsOverrideSecAndMain", model.IsOverrideSecAndMain);
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

        public string EditUnit(UnitModel model)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_UpdateUnitById";
            _sqlpara = new SqlParameter("@RecId", model.UnitId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ProjectId", model.ProjectId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsParking", model.IsParking);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@FloorNo", model.FloorNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@AreaSqm", model.AreaSqm);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@AreaRateSqm", model.AreaRateSqm);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@AreaTotalAmount", model.AreaTotalAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@FloorType", model.FloorType);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BaseRental", model.BaseRental);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@DetailsofProperty", model.DetailsofProperty);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@UnitNo", model.UnitNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@UnitSequence", model.UnitSequence);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BaseRentalVatAmount", model.BaseRentalVatAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BaseRentalWithVatAmount", model.BaseRentalWithVatAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BaseRentalTax", model.BaseRentalTax);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsNonVat", model.IsNonVat);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsNonTax", model.IsNonTax);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsNonCusa", model.IsNonCusa);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@TotalRental", model.TotalRental);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SecAndMainAmount", model.SecAndMainAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SecAndMainVatAmount ", model.SecAndMainVatAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SecAndMainWithVatAmount", model.SecAndMainWithVatAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Vat", model.Vat);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Tax", model.Tax);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@TaxAmount", model.TaxAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@LastChangedBy", Variables.UserID);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@UnitStatus", model.UnitStatus);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsNotRoundOff", model.IsNotRoundOff);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsOverrideSecAndMain", model.IsOverrideSecAndMain);
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

        public string MovedIn(string ReferenceID)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_MovedIn";
            _sqlpara = new SqlParameter("@ReferenceID", ReferenceID);
            _sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@LastChangedBy", model.LastchangedBy);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            //_sqlcmd.Parameters.Add(_sqlpara);
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
        public string MovedOut(string ReferenceID)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_MovedOut";
            _sqlpara = new SqlParameter("@ReferenceID", ReferenceID);
            _sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@LastChangedBy", model.LastchangedBy);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            //_sqlcmd.Parameters.Add(_sqlpara);
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
        public DataSet GetUnitList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetUnitList";

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

        public DataSet GetUnitByProjectId(int projectid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetUnitByProjectId";

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
        public DataSet GetUnitAvailableByProjectId(int projectid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetUnitAvailableByProjectId";

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
        public DataSet GetParkingAvailableByProjectId(int projectid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetParkingAvailableByProjectId";

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
        public DataSet GetUnitAvailableById(int recid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetUnitAvailableById";

                _SqlParameter = new SqlParameter("@UnitNo", recid);
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
        public DataSet GetUnitAvailableByIdParking(int recid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetUnitAvailableByIdParking";

                _SqlParameter = new SqlParameter("@UnitNo", recid);
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
        public DataSet GetUnitById(int id)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetUnitById";

                _SqlParameter = new SqlParameter("@RecId", id);
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
        public DataSet GetClientUnitList(string clientId)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetClientUnitList";

                _SqlParameter = new SqlParameter("@ClientID", clientId);
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
        public string SaveFloorTypeInfo(string TypeName)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_SaveFloorType";
            _sqlpara = new SqlParameter("@TypeName", TypeName);
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
        public string UpdateFloorTypeInfo(int Recid,string TypeName)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_UpdateFloorType";
            _sqlpara = new SqlParameter("@RecId", Recid);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@TypeName", TypeName);
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
        public DataSet GetFloorTypeBrowse()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetFloorTypeBrowse";
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
        public string DeleteFloorType(string FloorTypeDescription)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_DeleteFloorType";
            _sqlpara = new SqlParameter("@FloorTypeDescription", FloorTypeDescription);
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
