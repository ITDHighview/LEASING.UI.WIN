using LEASING.UI.APP.Common;
using LEASING.UI.APP.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Context
{
    public class ClientContext
    {
        const string SaveClientData = "sp_SaveClient";
        const string UpdateClientData = "sp_UpdateClient";

        public ClientModel SaveClient(ClientModel model)
        {
            ClientModel _model = new ClientModel();
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = SaveClientData;
            //_sqlpara = new SqlParameter("@ClientType", model.ClientType);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@ClientName", model.ClientName);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@Age", model.Age);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@PostalAddress", model.PostalAddress);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@DateOfBirth", model.DateOfBirth);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@TelNumber", model.TelNumber);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@Gender", model.Gender);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@Nationality", model.Nationality);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@Occupation", model.Occupation);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@AnnualIncome", model.AnnualIncome);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@EmployerName", model.EmployerName);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@EmployerAddress", model.EmployerAddress);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@SpouseName", model.SpouseName);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@ChildrenNames", model.ChildrenNames);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@TotalPersons", model.TotalPersons);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@MaidName", model.MaidName);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@DriverName", model.DriverName);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@VisitorsPerDay", model.TotalPersons);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@BuildingSecretary", 1);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@EncodedBy", Variables.UserID);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            //_sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@TIN_No", model.TIN_No);
            //_sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@XML", model.XMLData);
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
                int index2;
                if (_sqlreader.HasRows)
                {
                    index = _sqlreader.GetOrdinal("Message_Code");
                    if (!_sqlreader.IsDBNull(index))
                        _model.Message_Code = Convert.ToString(_sqlreader.GetString(index));
                    index2 = _sqlreader.GetOrdinal("ErrorMessage");
                    if (!_sqlreader.IsDBNull(index2))
                        _model.ErrorMessage = Convert.ToString(_sqlreader.GetString(index2));
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("SaveClient", "ClientContext", ex.ToString(), DateTime.Now, null);
                Functions.ErrorShow("SaveClient", ex.ToString());
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
            return _model;
        }
        public string UpdateClient(ClientModel model)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;

            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = UpdateClientData;

            _sqlpara = new SqlParameter("@ClientID", model.ClientID);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ClientType", model.ClientType);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ClientName", model.ClientName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Age", model.Age);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@PostalAddress", model.PostalAddress);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@DateOfBirth", model.DateOfBirth);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@TelNumber", model.TelNumber);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Gender", model.Gender);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Nationality", model.Nationality);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Occupation", model.Occupation);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@AnnualIncome", model.AnnualIncome);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@EmployerName", model.EmployerName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@EmployerAddress", model.EmployerAddress);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SpouseName", model.SpouseName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ChildrenNames", model.ChildrenNames);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@TotalPersons", model.TotalPersons);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@MaidName", model.MaidName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@DriverName", model.DriverName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@VisitorsPerDay", model.TotalPersons);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BuildingSecretary", model.BuildingSecretary);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@EncodedBy", model.EncodedBy);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@TIN_No", model.TIN_No);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsActive", model.IsActive);
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
        public DataSet GetClientList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetClientList";
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
        public DataSet GetClientTypeSelectList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetClientType";
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
        public DataSet GetClientByNumber(string ClientNumber)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetClientById";

                _SqlParameter = new SqlParameter("@ClientID", ClientNumber);
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
        public DataSet GetCheckContractProjectType(string refid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_CheckContractProjectType";

                _SqlParameter = new SqlParameter("@RefId", refid);
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
        public DataSet GetClientFileBrowseByNumber(string ClientNumber)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetFilesByClient";

                _SqlParameter = new SqlParameter("@ClientName", ClientNumber);
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
        public DataSet GetFilesByClientAndReference(string ClientId, string ReferenceID)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetFilesByClientAndReference";

                _SqlParameter = new SqlParameter("@ClientName", ClientId);
                _SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@ReferenceID", ReferenceID);
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
        public void GetViewFileById(string clientid, string baseFolderPath, int Id)
        {

            if (!string.IsNullOrWhiteSpace(clientid))
            {
                //if (clientFiles.ContainsKey(clientName))
                //{
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString()))
                {
                    try
                    {
                        connection.Open();
                        SqlCommand command = new SqlCommand("sp_GetClientFileByFileId", connection);
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@ClientName", clientid);
                        command.Parameters.AddWithValue("@Id", Id);
                        SqlDataReader reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            string filePath = reader.GetString(1);
                            byte[] fileData = (byte[])reader.GetValue(2);

                            //string folderName = Path.GetFileNameWithoutExtension(filePath);
                            string folderPath = Path.Combine(baseFolderPath, clientid);

                            if (!Directory.Exists(folderPath))
                                Directory.CreateDirectory(folderPath);

                            string destinationFilePath = Path.Combine(folderPath, Path.GetFileName(filePath));
                            File.WriteAllBytes(destinationFilePath, fileData);

                            // Open the file using the default program
                            Process.Start(destinationFilePath);
                        }


                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Error retrieving files: " + ex.Message);
                    }
                }
                //}
                //else
                //{
                //    MessageBox.Show("No files found for the specified client.");
                //}
            }
            else
            {
                MessageBox.Show("Please enter a client name.");
            }
        }
        public string SaveFileInDatabase(string clientName, string filePath, string FileNames, string files, string Notes, string ReferenceId, bool IsContractSinged)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;

            byte[] fileData = File.ReadAllBytes(filePath);
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_SaveFile";

            _sqlpara = new SqlParameter("@ClientName", clientName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@FilePath", filePath);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@FileData", fileData);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@FileNames", FileNames);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Files", files);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Notes", Notes);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ReferenceId", ReferenceId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsSignedContract", IsContractSinged);
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
        public string ConrtactSignedByPass(string ReferenceId)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_ConrtactSignedByPass";
            _sqlpara = new SqlParameter("@ReferenceId", ReferenceId);
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
        public void DeleteFileFromDatabase(string filePath)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString()))
            {
                try
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand("sp_DeleteFile", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@FilePath", filePath);
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error deleting file: " + ex.Message);
                }
            }
        }
        public DataSet GetSelecClient()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetSelecClient";

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
        public DataSet GetGetClientTypeAndID(string ClientId)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetClientTypeAndID";

                _SqlParameter = new SqlParameter("@ClientID", ClientId);
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
        public DataSet CheckClientNumberExist(string ClientID)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetClientID";

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
        public DataSet GetClientReferencePaid(string ClientID)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetClientReferencePaid";

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
                _SqlCommand.CommandText = "sp_GetReferenceByClientID";

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
        public DataSet GetClientBrowse()
        {

            SqlCommand _SqlCommand = null;
            //SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetClientBrowse";

                //_SqlParameter = new SqlParameter("@ClientID", ClientID);
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
        public DataSet GetContratBrowseByClientID(string clientId)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetContratBrowseByClientID";

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
                    _SqlParameter = null;
                    _SqlCommand = null;
                    _SqlConnection = null;
                }
                return dsRec;
            }
        }

        //       <connectionStrings>
        //	<add name = "TESTCONNECTION" connectionString="Data Source=DESKTOP-BTI8OA8;Initial Catalog=BiometrikDb;connect timeout=200;Integrated Security=false;Connection Timeout=60;User Id=histestuser;Password=histestuser"/>
        //</connectionStrings>
    }
}
