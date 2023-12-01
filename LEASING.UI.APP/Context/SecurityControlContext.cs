using LEASING.UI.APP.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Context
{
    public class SecurityControlContext : IDisposable
    {
        public string SaveFormControls(int FormId, int MenuId, string ControlName, string ControlDescription, bool IsBackRoundControl, bool IsHeaderControl)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;

            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_SaveFormControls";
            _sqlpara = new SqlParameter("@FormId", FormId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@MenuId", MenuId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ControlName", ControlName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ControlDescription", ControlDescription);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsBackRoundControl", IsBackRoundControl);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsHeaderControl", IsHeaderControl);
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
        public DataSet GetControls(int groupid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_getControlPermission";

                _SqlParameter = new SqlParameter("@GroupId", groupid);
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
        public DataSet GetFormList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetFormList";

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
        public DataSet GetMenuList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetMenuList";

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
        public DataSet GetControlList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetControlList";

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
        public DataSet GetGroupList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetGroupList";

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
        public DataSet GetFormListByGroupId(int groupid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetFormListByGroupId";

                _SqlParameter = new SqlParameter("@GroupId", groupid);
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
        public DataSet GetGetMenuListByFormId(int FormId)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetMenuListByFormId";

                _SqlParameter = new SqlParameter("@FormId", FormId);
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
        public DataSet GetControlListByGroupIdAndMenuId(int groupid, int menuid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetControlListByGroupIdAndMenuId";

                _SqlParameter = new SqlParameter("@GroupId", groupid);
                _SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@MenuId", menuid);
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
        public DataSet GetGroupControlInfo(int ControlId, int GroupId, int FormId)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetGroupControlInfo";

                _SqlParameter = new SqlParameter("@ControlId", ControlId);
                _SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@GroupId", GroupId);
                _SqlCommand.Parameters.Add(_SqlParameter);
                _SqlParameter = new SqlParameter("@FormId", FormId);
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
        public string UpdateGroupFormControls(int FormId, int ControlId, int GroupId, bool IsVisible)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;

            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_UpdateGroupFormControls";
            _sqlpara = new SqlParameter("@FormId", FormId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ControlId", ControlId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@GroupId", GroupId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@IsVisible", IsVisible);
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
        public string SaveUser(int groupid,int? UserId, string UserPassword, string StaffName, string Middlename, string Lastname, string EmailAddress, string Phone,string Mode)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;

            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_SaveUser";
            _sqlpara = new SqlParameter("@GroupId", groupid);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@UserId", UserId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@UserPassword", UserPassword);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@StaffName", StaffName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Middlename", Middlename);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Lastname", Lastname);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@EmailAddress", EmailAddress);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Phone", Phone);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Mode", Mode);
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
        public DataSet GetUserList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetUserList";

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
        public DataSet GetUserInfo()
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetUserInfo";

                _SqlParameter = new SqlParameter("@UserId", Variables.UserID);
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
        public DataSet GetGroup(int userid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetGroup";

                _SqlParameter = new SqlParameter("@UserId", userid);
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
        public DataSet GetUserPassword(int userid)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetUserPassword";

                _SqlParameter = new SqlParameter("@UserId", userid);
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

        #region Disposable Implementation
        private bool disposed = false;
        private Component component = new Component();
        private IntPtr handle;
        // Other managed resource this class uses.

        public void Dispose()
        {
            Dispose(true);
            // This object will be cleaned up by the Dispose method.
            // Therefore, you should call GC.SupressFinalize to
            // take this object off the finalization queue
            // and prevent finalization code for this object
            // from executing a second time.
            GC.SuppressFinalize(this);
        }

        private void Dispose(bool disposing)
        {
            // Check to see if Dispose has already been called.
            if (!this.disposed)
            {
                // If disposing equals true, dispose all managed
                // and unmanaged resources.
                if (disposing)
                {
                    // Dispose managed resources.
                    component.Dispose();
                }
                // Call the appropriate methods to clean up
                // unmanaged resources here.
                // If disposing is false,
                // only the following code is executed.
                CloseHandle(handle);
                handle = IntPtr.Zero;
                // Note disposing has been done.
                disposed = true;
            }
        }

        // Use interop to call the method necessary
        // to clean up the unmanaged resource.
        [System.Runtime.InteropServices.DllImport("Kernel32")]
        private extern static Boolean CloseHandle(IntPtr handle);

        // Use C# destructor syntax for finalization code.
        // This destructor will run only if the Dispose method
        // does not get called.
        // It gives your base class the opportunity to finalize.
        // Do not provide destructors in types derived from this class.

        //---CLASS NAME
        ~SecurityControlContext()
        {
            // Do not re-create Dispose clean-up code here.
            // Calling Dispose(false) is optimal in terms of
            // readability and maintainability.
            Dispose(false);
        }
        #endregion
    }
}
