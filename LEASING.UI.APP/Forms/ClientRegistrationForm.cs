using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using LEASING.UI.APP.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class ClientRegistrationForm : Form
    {
        private ClientContext _client;
        #region XML
        private static string SetXMLTable(ref ArrayList xml)
        {
            StringBuilder strXML = new StringBuilder();
            try
            {
                if (xml.Count > 0)
                {
                    strXML.Append("<Table1>");
                    for (int iIndex = 0; iIndex < xml.Count; iIndex++)
                    {
                        strXML.Append("<c" + (iIndex + 1).ToString() + ">");
                        strXML.Append(parseXML(xml[iIndex]));
                        strXML.Append("</c" + (iIndex + 1).ToString() + ">");
                    }
                    strXML.Append("</Table1>");
                    xml = new ArrayList();
                }
            }
            catch (Exception)
            {

            }
            return strXML.ToString();
        }
        private static string parseXML(object strValue)
        {
            string retValue = string.Empty;
            retValue = strValue.ToString();
            try
            {
                if (retValue.Trim().Length > 0)
                {
                    retValue = retValue.Replace("&", "&amp;");
                    retValue = retValue.Replace("<", "&lt;");
                    retValue = retValue.Replace(">", "&gt;");
                    retValue = retValue.Replace("\"", "&quot;");
                    retValue = retValue.Replace("'", "&apos;");

                    retValue = retValue.Trim();
                }
            }
            catch (Exception)
            {

            }
            return retValue;
        }
        private string XMLData(ClientModel model)
        {
            StringBuilder sbClient = new StringBuilder();
            ArrayList alClient = new ArrayList();
            //this.dgvAdvancePayment.BeginEdit();      
            alClient.Add(model.ClientType);
            alClient.Add(model.ClientName);
            alClient.Add(model.Age);
            alClient.Add(model.PostalAddress);
            alClient.Add(model.DateOfBirth);
            alClient.Add(model.TelNumber);
            alClient.Add(model.Gender);
            alClient.Add(model.Nationality);
            alClient.Add(model.Occupation);
            alClient.Add(model.AnnualIncome);
            alClient.Add(model.EmployerName);
            alClient.Add(model.EmployerAddress);
            alClient.Add(model.SpouseName);
            alClient.Add(model.ChildrenNames);
            alClient.Add(model.TotalPersons);
            alClient.Add(model.MaidName);
            alClient.Add(model.DriverName);
            alClient.Add(model.NoVisitorsPerDay);
            alClient.Add(1);
            alClient.Add(Variables.UserID);
            alClient.Add(Environment.MachineName);
            alClient.Add(model.TIN_No);
            sbClient.Append(SetXMLTable(ref alClient));
            return sbClient.ToString();
        }
        #endregion
        enum ModeStatus
        {
            NEW,
            READ
        }
        private string _FormMode;
        public string FormMode
        {
            get
            {
                return _FormMode;
            }
            set
            {
                _FormMode = value;
                switch (_FormMode)
                {
                    case "NEW":
                        btnUndo.Enabled = true;
                        btnSave.Enabled = true;
                        btnNewProject.Enabled = false;
                        EnabledFields();
                        EmptyFields();
                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        btnNewProject.Enabled = true;
                        DisabledFields();
                        EmptyFields();
                        break;

                    default:
                        break;
                }
            }
        }
        private void EmptyFields()
        {
            ddlClientType.Text = string.Empty;
            txtname.Text = string.Empty;
            txtage.Text = string.Empty;
            txtpostaladdress.Text = string.Empty;
            txttelno.Text = string.Empty;
            txtnationality.Text = string.Empty;
            txtoccupation.Text = string.Empty;
            txtannualincome.Text = string.Empty;
            txtnameofemployer.Text = string.Empty;
            txtaddresstelephoneno.Text = string.Empty;
            txtspousename.Text = string.Empty;
            txtnameofchildren.Text = string.Empty;
            txttotalnoofperson.Text = string.Empty;
            txtnameofmaid.Text = string.Empty;
            txtnameofdriver.Text = string.Empty;
            txtnoofvisitorperday.Text = string.Empty;
            txtTinNo.Text = string.Empty;
        }
        private void EnabledFields()
        {
            ddlClientType.Enabled = true;
            txtname.Enabled = true;
            txtage.Enabled = true;
            txtpostaladdress.Enabled = true;
            dtpdob.Enabled = true;
            ddlgender.Enabled = true;
            txttelno.Enabled = true;
            txtnationality.Enabled = true;
            txtoccupation.Enabled = true;
            txtannualincome.Enabled = true;
            txtnameofemployer.Enabled = true;
            txtaddresstelephoneno.Enabled = true;
            txtspousename.Enabled = true;
            txtnameofchildren.Enabled = true;
            txttotalnoofperson.Enabled = true;
            txtnameofmaid.Enabled = true;
            txtnameofdriver.Enabled = true;
            txtnoofvisitorperday.Enabled = true;
            txtTinNo.Enabled = true;
        }
        private void IsCorporate()
        {
            txtname.Enabled = true;
            txtpostaladdress.Enabled = true;
            txtaddresstelephoneno.Enabled = true;
            txttelno.Enabled = true;
            txtTinNo.Enabled = true;

            txtage.Enabled = false;
            dtpdob.Enabled = false;
            ddlgender.Enabled = false;
            txttelno.Enabled = false;
            txtnationality.Enabled = false;
            txtoccupation.Enabled = false;
            txtannualincome.Enabled = false;
            txtnameofemployer.Enabled = false;
            txtspousename.Enabled = false;
            txtnameofchildren.Enabled = false;
            txttotalnoofperson.Enabled = false;
            txtnameofmaid.Enabled = false;
            txtnameofdriver.Enabled = false;
            txtnoofvisitorperday.Enabled = false;



            txtname.Text = string.Empty;
            txtage.Text = string.Empty;
            txtpostaladdress.Text = string.Empty;
            txttelno.Text = string.Empty;
            txtnationality.Text = string.Empty;
            txtoccupation.Text = string.Empty;
            txtannualincome.Text = string.Empty;
            txtnameofemployer.Text = string.Empty;
            txtaddresstelephoneno.Text = string.Empty;
            txtspousename.Text = string.Empty;
            txtnameofchildren.Text = string.Empty;
            txttotalnoofperson.Text = string.Empty;
            txtnameofmaid.Text = string.Empty;
            txtnameofdriver.Text = string.Empty;
            txtnoofvisitorperday.Text = string.Empty;
            txtTinNo.Text = string.Empty;

        }
        private void DisabledFields()
        {
            ddlClientType.Enabled = false;
            txtname.Enabled = false;
            txtage.Enabled = false;
            txtpostaladdress.Enabled = false;
            dtpdob.Enabled = false;
            ddlgender.Enabled = false;
            txttelno.Enabled = false;
            txtnationality.Enabled = false;
            txtoccupation.Enabled = false;
            txtannualincome.Enabled = false;
            txtnameofemployer.Enabled = false;
            txtaddresstelephoneno.Enabled = false;
            txtspousename.Enabled = false;
            txtnameofchildren.Enabled = false;
            txttotalnoofperson.Enabled = false;
            txtnameofmaid.Enabled = false;
            txtnameofdriver.Enabled = false;
            txtnoofvisitorperday.Enabled = false;
            txtTinNo.Enabled = false;
        }
        private bool IsValid()
        {
            if (string.IsNullOrEmpty(this.ddlClientType.Text))
            {
                MessageBox.Show("Client Type cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(this.txtname.Text))
            {
                MessageBox.Show("Name cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            return true;
        }
        //private string ClientTypeCode()
        //{
        //    string Code = string.Empty;
        //    switch (this.ddlClientType.Text)
        //    {
        //        case "INDIVIDUAL":
        //            Code = "INDV";
        //            break;
        //        case "CORPORATE":
        //            Code = "CORP";
        //            break;
        //        case "PARTNERSHIP":
        //            Code = "PART";
        //            break;
        //    }
        //    return Code;
        //}
        private void SaveClient()
        {
            try
            {
                ClientModel dto = new ClientModel();
                ClientModel results = new ClientModel();
                dto.ClientType = this.ddlClientType.Text;
                dto.ClientName = this.txtname.Text;
                dto.Age = Functions.ConvertStringToInt(this.txtage.Text);
                dto.PostalAddress = this.txtpostaladdress.Text;
                dto.DateOfBirth = this.dtpdob.Text;
                dto.Gender = this.ddlgender.Text == "MALE" ? true : false;
                dto.TelNumber = this.txttelno.Text;
                dto.Nationality = this.txtnationality.Text;
                dto.Occupation = this.txtoccupation.Text;
                dto.AnnualIncome = Functions.ConvertStringToInt(this.txtannualincome.Text);
                dto.EmployerName = this.txtnameofemployer.Text;
                dto.EmployerAddress = this.txtaddresstelephoneno.Text;
                dto.SpouseName = this.txtspousename.Text;
                dto.ChildrenNames = this.txtnameofchildren.Text;
                dto.TotalPersons = Functions.ConvertStringToInt(this.txttotalnoofperson.Text);
                dto.MaidName = this.txtnameofmaid.Text;
                dto.DriverName = this.txtnameofdriver.Text;
                dto.NoVisitorsPerDay = Functions.ConvertStringToInt(this.txtnoofvisitorperday.Text);
                dto.TIN_No = this.txtTinNo.Text;
                dto.XMLData = this.XMLData(dto);

                results = _client.SaveClient(dto);
                if (results.Message_Code.Equals("SUCCESS"))
                {
                    Functions.MessageShow("New Client  has been added successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    this.ClientBrowse();             
                }
                else
                {
                    Functions.MessageShow(results.Message_Code);
                    this.FormMode = ModeStatus.READ.ToString();
                }
                if (results.ErrorMessage != null)
                {
                    Functions.ErrorShow("SaveClient()", results.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("SaveClient()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("SaveClient()", ex.ToString());
            }
        }
        public ClientRegistrationForm()
        {
            _client = new ClientContext();
            InitializeComponent();
        }
        private void ClientBrowse()
        {
            try
            {
                this.dgvClientList.DataSource = null;
                using (DataSet dt = _client.GetClientList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        this.dgvClientList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("ClientBrowse()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("ClientBrowse()", ex.ToString());
            }
        }
        private void getClientTypeSelectList()
        {
            try
            {
                this.ddlClientType.DataSource = null;
                using (DataSet dt = _client.GetClientTypeSelectList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        this.ddlClientType.ValueMember = "ClientType";
                        this.ddlClientType.DisplayMember = "ClientType";
                        this.ddlClientType.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("getClientTypeSelectList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("getClientTypeSelectList()", ex.ToString());
            }
        }
        private void txtage_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void txtannualincome_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void txttelno_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void radLabel16_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void btnNewProject_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.NEW.ToString();
        }
        private void frmAddNewClient_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            this.FormMode = ModeStatus.READ.ToString();
            this.getClientTypeSelectList();
            this.ClientBrowse();
        }
        private void btnUndo_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.READ.ToString();
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (this.IsValid())
            {
                if (Functions.MessageConfirm("Are you sure you want to add this client ?") == DialogResult.Yes)
                {
                    this.SaveClient();
                }
            }
        }
        private void txttotalnoofperson_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void txtnameofvisitorperday_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void dgvClientList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvClientList.Columns[e.ColumnIndex].Name == "ColEdit")
                {
                    EditClientForm forms = new EditClientForm();
                    forms.ClientID = Convert.ToString(dgvClientList.CurrentRow.Cells["ClientID"].Value);
                    forms.ShowDialog();
                    this.ClientBrowse();
                }
            }
        }
        private void ddlClientType_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (this.ddlClientType.SelectedIndex >= 0)
            {
                if (this.ddlClientType.SelectedIndex == 1 || this.ddlClientType.SelectedIndex == 2)
                {
                    this.IsCorporate();
                }
                else
                {
                    this.EnabledFields();
                }
            }
        }
        private int CalculateAge(DateTime birthDate)
        {           
            DateTime currentDate = DateTime.Now;          
            int age = currentDate.Year - birthDate.Year;        
            if (currentDate.Month < birthDate.Month || (currentDate.Month == birthDate.Month && currentDate.Day < birthDate.Day))
            {
                age--;
            }
            return age;
        }
        private void dtpdob_ValueChanged(object sender, EventArgs e)
        {
            DateTime dtt = dtpdob.Value;           
            int age = CalculateAge(dtt);           
            txtage.Text = string.Empty;
            txtage.Text = age.ToString();
            //txtage.Focus();
        }
    }
}
