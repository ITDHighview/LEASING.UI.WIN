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


    public class PaymentContext
    {
        /*Active SP-COMMAND*/
        const string generateFirstPayment = "sp_GenerateFirstPayment";
        const string generateFirstPaymentParking = "sp_GenerateFirstPaymentParking";
        const string generateBulkPayment = "sp_GenerateBulkPayment";

        /*Active SP-QUERY*/

        /*In-Active SP-COMMAND*/
        //const string generateSecondPaymentUnit = "sp_GenerateSecondPaymentUnit";
        //const string generateSecondPaymentParking = "sp_GenerateSecondPaymentParking";
        public string GenerateFirstPayment(string RefId,
            decimal PaidAmount,
            decimal ReceiveAmount,
            decimal ChangeAmount,
            decimal SecAmount,
            string CompanyORNo,
            string CompanyPRNo,
            string BankAccountName,
            string BankAccountNumber,
            string BankName,
            string SerialNo,
            string PaymentRemarks,
            string REF,
            string ModeType,
            string BankBranch,
            string ReceiptDate,
             string CheckDate,
            out string TransID)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = generateFirstPayment;
            _sqlpara = new SqlParameter("@RefId", RefId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@PaidAmount", PaidAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ReceiveAmount", ReceiveAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ChangeAmount", ChangeAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SecAmountADV", SecAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyORNo", CompanyORNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyPRNo", CompanyPRNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankAccountName", BankAccountName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankAccountNumber", BankAccountNumber);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankName", BankName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SerialNo", SerialNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@PaymentRemarks", PaymentRemarks);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@REF", REF);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ModeType", ModeType);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@EncodedBy", Variables.UserID);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankBranch", BankBranch);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ReceiptDate", ReceiptDate);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CheckDate", CheckDate);
            _sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@XML", XML);
            //_sqlcmd.Parameters.Add(_sqlpara);
            TransID = string.Empty;
            try
            {
                _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
                _sqlcmd.Connection = _sqlcon;
                _sqlcmd.CommandType = CommandType.StoredProcedure;
                _sqlcmd.Connection.Open();
                _sqlreader = _sqlcmd.ExecuteReader();
                _sqlreader.Read();
                if (_sqlreader.HasRows)
                {
                    int sindex = _sqlreader.GetOrdinal("TranID");
                    if (!_sqlreader.IsDBNull(sindex))
                        TransID = Convert.ToString(_sqlreader.GetString(sindex));
                }
                if (_sqlreader.HasRows)
                {
                    int index = _sqlreader.GetOrdinal("Message_Code");
                    if (!_sqlreader.IsDBNull(index))
                        return Convert.ToString(_sqlreader.GetString(index));
                }
            }
            catch (Exception expCommon)
            {
                return "FAILED|" + Convert.ToString(expCommon.ToString());
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
        public string GenerateFirstPaymentParking(string RefId,
           decimal PaidAmount,
           decimal ReceiveAmount,
           decimal ChangeAmount,
           decimal SecAmount,
           string CompanyORNo,
           string CompanyPRNo,
           string BankAccountName,
           string BankAccountNumber,
           string BankName,
           string SerialNo,
           string PaymentRemarks,
           string REF,
           string ModeType,
           string BankBranch,
           string ReceiptDate,
           string CheckDate,
           out string TransID)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = generateFirstPaymentParking;
            _sqlpara = new SqlParameter("@RefId", RefId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@PaidAmount", PaidAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ReceiveAmount", ReceiveAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ChangeAmount", ChangeAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SecAmountADV", SecAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyORNo", CompanyORNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyPRNo", CompanyPRNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankAccountName", BankAccountName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankAccountNumber", BankAccountNumber);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankName", BankName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SerialNo", SerialNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@PaymentRemarks", PaymentRemarks);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@REF", REF);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ModeType", ModeType);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@EncodedBy", Variables.UserID);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankBranch", BankBranch);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ReceiptDate", ReceiptDate);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CheckDate", CheckDate);
            _sqlcmd.Parameters.Add(_sqlpara);
            //_sqlpara = new SqlParameter("@XML", XML);
            //_sqlcmd.Parameters.Add(_sqlpara);
            TransID = string.Empty;
            try
            {
                _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
                _sqlcmd.Connection = _sqlcon;
                _sqlcmd.CommandType = CommandType.StoredProcedure;
                _sqlcmd.Connection.Open();
                _sqlreader = _sqlcmd.ExecuteReader();
                _sqlreader.Read();
                if (_sqlreader.HasRows)
                {
                    int sindex = _sqlreader.GetOrdinal("TranID");
                    if (!_sqlreader.IsDBNull(sindex))
                        TransID = Convert.ToString(_sqlreader.GetString(sindex));
                }
                if (_sqlreader.HasRows)
                {
                    int index = _sqlreader.GetOrdinal("Message_Code");
                    if (!_sqlreader.IsDBNull(index))
                        return Convert.ToString(_sqlreader.GetString(index));
                }
            }
            catch (Exception expCommon)
            {
                return "FAILED|" + Convert.ToString(expCommon.ToString());
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
        //public string GenerateSecondPayment(string RefId,
        //   decimal PaidAmount,
        //   decimal ReceiveAmount,
        //   decimal ChangeAmount,
        //   string CompanyORNo,
        //   string CompanyPRNo,
        //   string BankAccountName,
        //   string BankAccountNumber,
        //   string BankName,
        //   string SerialNo,
        //   string PaymentRemarks,
        //   string REF,
        //   string ModeType,
        //   int ledgerRecId,
        //   out string TransID
        //   )
        //{
        //    SqlCommand _sqlcmd = null;
        //    SqlParameter _sqlpara;
        //    SqlConnection _sqlcon = null;
        //    SqlDataReader _sqlreader = null;
        //    _sqlcmd = new SqlCommand();
        //    _sqlcmd.CommandText = generateSecondPaymentUnit;
        //    _sqlpara = new SqlParameter("@RefId", RefId);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@PaidAmount", PaidAmount);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@ReceiveAmount", ReceiveAmount);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@ChangeAmount", ChangeAmount);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@CompanyORNo", CompanyORNo);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@CompanyPRNo", CompanyPRNo);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@BankAccountName", BankAccountName);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@BankAccountNumber", BankAccountNumber);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@BankName", BankName);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@SerialNo", SerialNo);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@PaymentRemarks", PaymentRemarks);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@REF", REF);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@ModeType", ModeType);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@ledgerRecId", ledgerRecId);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@EncodedBy", Variables.UserID);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
        //    _sqlcmd.Parameters.Add(_sqlpara);
        //    TransID = string.Empty;
        //    try
        //    {
        //        _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
        //        _sqlcmd.Connection = _sqlcon;
        //        _sqlcmd.CommandType = CommandType.StoredProcedure;
        //        _sqlcmd.Connection.Open();
        //        _sqlreader = _sqlcmd.ExecuteReader();
        //        _sqlreader.Read();

        //        if (_sqlreader.HasRows)
        //        {
        //            int indexs = _sqlreader.GetOrdinal("TranID");
        //            if (!_sqlreader.IsDBNull(indexs))
        //                TransID = Convert.ToString(_sqlreader.GetString(indexs));
        //        }
        //        if (_sqlreader.HasRows)
        //        {
        //            int index = _sqlreader.GetOrdinal("Message_Code");
        //            if (!_sqlreader.IsDBNull(index))
        //                return Convert.ToString(_sqlreader.GetString(index));
        //        }
        //    }
        //    catch (Exception expCommon)
        //    {
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


        public string GenerateBulkPayment(string RefId,
           decimal PaidAmount,
           decimal ReceiveAmount,
           decimal ChangeAmount,
           string CompanyORNo,
           string CompanyPRNo,
           string BankAccountName,
           string BankAccountNumber,
           string BankName,
           string SerialNo,
           string PaymentRemarks,
           string REF,
           string ModeType,
           int ledgerRecId,
          string XML,
          string BankBranch,
          string ReceiptDate,
          string CheckDate,
          out string TransID,
          out string RecieptID
          )
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = generateBulkPayment;
            _sqlpara = new SqlParameter("@RefId", RefId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@PaidAmount", PaidAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ReceiveAmount", ReceiveAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ChangeAmount", ChangeAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyORNo", CompanyORNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyPRNo", CompanyPRNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankAccountName", BankAccountName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankAccountNumber", BankAccountNumber);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankName", BankName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SerialNo", SerialNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@PaymentRemarks", PaymentRemarks);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@REF", REF);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ModeType", ModeType);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@EncodedBy", Variables.UserID);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@XML", XML);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankBranch", BankBranch);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ReceiptDate", ReceiptDate);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CheckDate", CheckDate);
            _sqlcmd.Parameters.Add(_sqlpara);

            TransID = string.Empty;
            RecieptID = string.Empty;
            try
            {
                _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
                _sqlcmd.Connection = _sqlcon;
                _sqlcmd.CommandType = CommandType.StoredProcedure;
                _sqlcmd.Connection.Open();
                _sqlreader = _sqlcmd.ExecuteReader();
                _sqlreader.Read();
                if (_sqlreader.HasRows)
                {
                    int indexs = _sqlreader.GetOrdinal("TranID");
                    if (!_sqlreader.IsDBNull(indexs))
                        TransID = Convert.ToString(_sqlreader.GetString(indexs));
                }
                if (_sqlreader.HasRows)
                {
                    int indexs = _sqlreader.GetOrdinal("ReceiptID");
                    if (!_sqlreader.IsDBNull(indexs))
                        RecieptID = Convert.ToString(_sqlreader.GetString(indexs));
                }
                if (_sqlreader.HasRows)
                {
                    int index = _sqlreader.GetOrdinal("Message_Code");
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
        //   public string GeneratePaymentParking(string RefId,
        //decimal PaidAmount,
        //decimal ReceiveAmount,
        //decimal ChangeAmount,
        //string CompanyORNo,
        //string CompanyPRNo,
        //string BankAccountName,
        //string BankAccountNumber,
        //string BankName,
        //string SerialNo,
        //string PaymentRemarks,
        //string REF,
        //string ModeType,
        //int ledgerRecId
        //)
        //   {
        //       SqlCommand _sqlcmd = null;
        //       SqlParameter _sqlpara;
        //       SqlConnection _sqlcon = null;
        //       SqlDataReader _sqlreader = null;
        //       _sqlcmd = new SqlCommand();
        //       _sqlcmd.CommandText = generateSecondPaymentParking;
        //       _sqlpara = new SqlParameter("@RefId", RefId);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@PaidAmount", PaidAmount);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@ReceiveAmount", ReceiveAmount);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@ChangeAmount", ChangeAmount);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@CompanyORNo", CompanyORNo);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@CompanyPRNo", CompanyPRNo);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@BankAccountName", BankAccountName);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@BankAccountNumber", BankAccountNumber);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@BankName", BankName);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@SerialNo", SerialNo);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@PaymentRemarks", PaymentRemarks);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@REF", REF);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@ModeType", ModeType);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@ledgerRecId", ledgerRecId);
        //       _sqlcmd.Parameters.Add(_sqlpara);

        //       _sqlpara = new SqlParameter("@EncodedBy", Variables.UserID);
        //       _sqlcmd.Parameters.Add(_sqlpara);
        //       _sqlpara = new SqlParameter("@ComputerName", Environment.MachineName);
        //       _sqlcmd.Parameters.Add(_sqlpara);

        //       try
        //       {
        //           _sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString());
        //           _sqlcmd.Connection = _sqlcon;
        //           _sqlcmd.CommandType = CommandType.StoredProcedure;

        //           //_sqlreader = SqlDataReader(_sqlcmd, false);

        //           _sqlcmd.Connection.Open();
        //           _sqlreader = _sqlcmd.ExecuteReader();
        //           _sqlreader.Read();

        //           int index;
        //           if (_sqlreader.HasRows)
        //           {
        //               index = _sqlreader.GetOrdinal("Message_Code");
        //               if (!_sqlreader.IsDBNull(index))
        //                   return Convert.ToString(_sqlreader.GetString(index));
        //           }
        //       }
        //       catch (Exception expCommon)
        //       {
        //           //vErrorMessage = Convert.ToString(expCommon.Message);
        //           return "FAILED|" + Convert.ToString(expCommon.Message);
        //       }
        //       finally
        //       {
        //           if (_sqlcon.State != ConnectionState.Closed)
        //           {
        //               _sqlcon.Close();
        //           }
        //           _sqlpara = null;
        //           _sqlcmd = null;
        //           _sqlreader = null;
        //       }
        //       return "";
        //   }
        public string CloseContract(string RefId)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_CloseContract";
            _sqlpara = new SqlParameter("@ReferenceID", RefId);
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
        public string TerminateContract(string RefId)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_TerminateContract";
            _sqlpara = new SqlParameter("@ReferenceID", RefId);
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
        public string HoldPayment(string RefId, int ledgerRecId)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_HoldPayment";
            _sqlpara = new SqlParameter("@ReferenceID", RefId);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@Recid", ledgerRecId);
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
        public string HoldPDCPayment(string xml, string CompanyORNo, string CompanyPRNo, string BankAccountName, string BankAccountNumber, string BankName, string SerialNo, string BankBranch, string REF, string ModeType)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_HoldPDCPayment";

            _sqlpara = new SqlParameter("@XML", xml);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyORNo", CompanyORNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyPRNo", CompanyPRNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankAccountName", BankAccountName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankAccountNumber", BankAccountNumber);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankName", BankName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@SerialNo", SerialNo);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@BankBranch", BankBranch);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@REF", REF);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@ModeType", ModeType);
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
        public string SaveBankNameInfo(string bankName)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_SaveBankName";
            _sqlpara = new SqlParameter("@BankName", bankName);
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
        public string DeleteBankName(string bankName)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_DeleteBankName";
            _sqlpara = new SqlParameter("@BankName", bankName);
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
        public string UpdateORNumber(string RcptID, string CompanyORNo)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_UpdateORNumber";
            _sqlpara = new SqlParameter("@RcptID", RcptID);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@CompanyORNo", CompanyORNo);
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
        public DataSet GetSelectPaymentMode()
        {
            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_SelectPaymentMode";
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
        public DataSet GetBankNameBrowse()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_SelectBankName";
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
        public DataSet GetCheckPaymentStatus(string ReferenceID)
        {
            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetCheckPaymentStatus";
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
                    _SqlParameter = null;
                    _SqlCommand = null;
                    _SqlConnection = null;
                }
                return dsRec;
            }
        }
        public DataSet GetForContractSignedUnitList()
        {
            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetForContractSignedUnitList";
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
        public DataSet GetForContractSignedParkingList()
        {
            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetForContractSignedParkingList";
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
        public DataSet GetForMoveInUnitList()
        {
            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetForMoveInUnitList";
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
        public DataSet GetForMoveInParkingList()
        {
            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetForMoveInParkingList";
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
        public DataSet GetForMoveOutUnitList()
        {
            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetForMoveOutUnitList";
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
        public DataSet GetForMoveOutParkingList()
        {
            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetForMoveOutParkingList";
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
        public DataSet GetClosedContracts()
        {
            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetClosedContracts";
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
        public DataSet GetCheckOrNumber(string CompanyORNo)
        {
            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_CheckOrNumber";
                _SqlParameter = new SqlParameter("@CompanyORNo", CompanyORNo);
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
        public DataSet GetCheckPRNumber(string CompanyPRNo)
        {
            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_CheckPRNumber";
                _SqlParameter = new SqlParameter("@CompanyORNo", CompanyPRNo);
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
        public DataSet CheckIfOrIsEmpty(string TranId)
        {
            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_CheckIfOrIsEmpty";
                _SqlParameter = new SqlParameter("@TranId", TranId);
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
        public DataSet GetPenaltyResult(int LedgerId)
        {
            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetPenaltyResult";
                _SqlParameter = new SqlParameter("@LedgerId", LedgerId);
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
        public DataSet GetLedgerListOnQue(string xml)
        {
            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetLedgerListOnQue";
                _SqlParameter = new SqlParameter("@XML", xml);
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
        public DataSet GetLedgerListOnQueTotalAMount(string xml)
        {
            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetLedgerListOnQueTotalAMount";
                _SqlParameter = new SqlParameter("@XML", xml);
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


        public string SaveOtherPaymentType(OtherPaymentTypeModel model)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_SaveOtherPaymentType";
            _sqlpara = new SqlParameter("@OtherPaymentTypeName", model.OtherPaymentTypeName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@OtherPaymentVatPCT", model.OtherPaymentVatPCT);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@OtherPaymentTaxPCT", model.OtherPaymentTaxPCT);
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
        public DataSet GetOtherPaymentTypeBrowse()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetOtherPaymentTypeBrowse";
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
        public DataSet GetOtherPaymentTypeList()
        {

            SqlCommand _SqlCommand = null;
            // SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetOtherPaymentTypeList";
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
        public string SaveOtherPayment(PaymentModel model)
        {
            SqlCommand _sqlcmd = null;
            SqlParameter _sqlpara;
            SqlConnection _sqlcon = null;
            SqlDataReader _sqlreader = null;
            _sqlcmd = new SqlCommand();
            _sqlcmd.CommandText = "sp_SaveOtherPayment";
            _sqlpara = new SqlParameter("@ClientID", model.ClientID);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@OtherPaymentTypeName", model.OtherPaymentTypeName);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@OtherPaymentAmount", model.OtherPaymentAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@OtherPaymentVatPCT", model.OtherPaymentVatPCT);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@OtherPaymentVatAmount", model.OtherPaymentVatAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@OtherPaymentIsVatApplied", model.OtherPaymentIsVatApplied);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@OtherPaymentTaxPCT", model.OtherPaymentTaxPCT);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@OtherPaymentTaxAmount", model.OtherPaymentTaxAmount);
            _sqlcmd.Parameters.Add(_sqlpara);
            _sqlpara = new SqlParameter("@OtherPaymentTaxIsApplied", model.OtherPaymentTaxIsApplied);
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
        public DataSet GetOtherPaymentTypeRateByName(string OtherPaymentTypeName)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetOtherPaymentTypeRateByName";
                _SqlParameter = new SqlParameter("@OtherPaymentTypeName", OtherPaymentTypeName);
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
        public DataSet GetOtherPaymentBrowse()
        {

            SqlCommand _SqlCommand = null;
            //SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetOtherPaymentBrowse";
                //_SqlParameter = new SqlParameter("@OtherPaymentTypeName", OtherPaymentTypeName);
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
        public DataSet GetOtherPaymentBrowseByClientID(string ClientID)
        {

            SqlCommand _SqlCommand = null;
            SqlParameter _SqlParameter;
            SqlConnection _SqlConnection = null;
            using (DataSet dsRec = new DataSet())
            {
                _SqlCommand = new SqlCommand();
                _SqlCommand.CommandText = "sp_GetOtherPaymentBrowseByClientID";
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
    }
}
