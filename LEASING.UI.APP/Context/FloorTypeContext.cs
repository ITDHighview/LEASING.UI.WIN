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
    public class FloorTypeContext
    {
        public DataSet GetSelectFloortypes()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;


            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_SelectFloorTypes";

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
    }
}
