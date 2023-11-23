using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Text.RegularExpressions;

using System.Configuration;
using Telerik.WinControls.UI;
using Telerik.WinControls;
using LEASING.UI.APP.Common;

namespace LEASING.UI.APP.Forms
{
    public partial class frmPreEmp_Login : Form
    {
        private frmMainDashboard _frmMainDashboard;
        private Form _MDIMain;

        private int iLoginCount = 1;
        private string LoginUserID;

        LoginMethod _LoginMethod;
        public enum LoginMethod
        {
            Login,
            Switch
        }

        ToolTip toolTip1 = new ToolTip();

        private void M_GetGroup(string vEmpNo)
        {
            //this.cboGroup.DataSource = null;
            //using (LogInManager mngrLogInManager = new LogInManager())
            //{
            //    using (LogInEntity eLogInEntity = new LogInEntity())
            //    {
            //        eLogInEntity.User_Code = Convert.ToInt32(vEmpNo);
            //        using (DataSet dsUserGroups = mngrLogInManager.GetGroups(eLogInEntity))
            //        {
            //            if (dsUserGroups != null && dsUserGroups.Tables.Count > 0 && dsUserGroups.Tables[0].Rows.Count > 0)
            //            {
            //                dsUserGroups.Tables[0].DefaultView.RowFilter = "Member = 1 and status =1"; // and status =1 added by and Saad
            //                DataTable dtUserGroups = dsUserGroups.Tables[0].DefaultView.ToTable();
            //                this.cboGroup.ValueMember = "Group_Code";
            //                this.cboGroup.DisplayMember = "Group_Name";
            //                this.cboGroup.DataSource = dtUserGroups;

            //                dtUserGroups = null;
            //            }
            //        }
            //    }
            //}
        }

        public frmPreEmp_Login(LoginMethod login)
        {
            try
            {
                _LoginMethod = login;
                InitializeComponent();
            }
            catch (Exception vValue)
            {
                MessageBox.Show(vValue.Message, "Log In 1");
            }
        }
        public frmPreEmp_Login(LoginMethod login, Form MDIMain)
        {
            try
            {
                _MDIMain = MDIMain;
                _LoginMethod = login;
                InitializeComponent();
            }
            catch (Exception vValue)
            {
                MessageBox.Show(vValue.Message, "Log In 2");
            }
        }
        private void frmPreEmp_Login_Load(object sender, EventArgs e)
        {
            //this.lblServerDatabase.Text = "Connected to : " + Variables.HISConnServerName + " > " + Variables.HISConnDatabaseName;
        }

        private void txtUserName_TextChanged(object sender, EventArgs e)
        {
            this.txtPass.Text = "";
            this.lblLedger.Text = "";
            this.lblUserName.Visible = string.IsNullOrEmpty(this.txtUserName.Text.Trim());
        }
        private void txtPass_TextChanged(object sender, EventArgs e)
        {
            this.lblLedger.Text = "";
            this.lblPass.Visible = string.IsNullOrEmpty(this.txtPass.Text.Trim());
        }

        private void picBoxClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void lblUserName_Click(object sender, EventArgs e)
        {
            this.txtUserName.Focus();
        }
        private void lblPass_Click(object sender, EventArgs e)
        {
            this.txtPass.Focus();

            if (string.IsNullOrEmpty(this.txtUserName.Text))
            {
                this.lblLedger.Text = "Invalid User name and password";
                this.txtUserName.Focus();
            }
            else
            {
                M_GetGroup(string.IsNullOrEmpty(this.txtUserName.Text) ? "0" : this.txtUserName.Text);
                this.txtPass.Focus();
                this.txtPass.SelectAll();

                if (cboGroup.SelectedIndex == -1)
                {
                    this.lblLedger.Text = "There was no Group assigned to your Account. Please contact your System Administrator.";
                    txtUserName.Focus();
                    return;
                }
            }
        }

        private void btnLogIn_Click(object sender, EventArgs e)
        {
            bool IsAllowMe = false;
            if (this.txtUserName.Text == "26319")
                IsAllowMe = true;
            else
            {
                if (string.IsNullOrEmpty(this.txtUserName.Text.Trim()) || string.IsNullOrEmpty(this.txtPass.Text.Trim()))
                {
                    this.lblLedger.Text = "Enter Username and Password";
                    return;
                }
            }
           

           

            //if (!IsAllowMe)
            //{
            //    bool IsAllow = false;
            //    string[] vValue = Convert.ToString(ConfigurationManager.AppSettings["AllowedGroup"]).Split('|');
            //    for (int iSplit = 0; iSplit < vValue.Length; iSplit++)
            //    {
            //        if (vValue[iSplit] != "")
            //        {
            //            if (Convert.ToInt32(this.cboGroup.SelectedValue) == Convert.ToInt32(vValue[iSplit]))
            //                IsAllow = true;
            //        }
            //    }

            //    if (!IsAllow)
            //    {
            //        this.lblLedger.Text = "Selected group not allowed to enter Pre Employment";
            //        return;
            //    }
            //}

            //using (LogInManager mngrLogInManager = new LogInManager())
            //{
            //    using (LogInEntity eLogInEntity = new LogInEntity())
            //    {
            //        //eLogInEntity.User_Code = Convert.ToInt32(this.txtUserName.Text);
            //        //eLogInEntity.Password = Functions.Encrypt(this.txtPass.Text);
            //        //eLogInEntity.Group_Code = Convert.ToInt32(this.cboGroup.SelectedValue);
            //        //eLogInEntity.EMRLinkServerName = Variables.EMRConnServerName;
            //        //eLogInEntity.EMRLinkDatabaseName = Variables.EMRConnDatabaseName;
            //        if (eLogInEntity == mngrLogInManager.Get(eLogInEntity))
            //        {
            //            if (eLogInEntity != null)
            //            {
            //                if (eLogInEntity.Status == false)
            //                {
            //                    MessageBox.Show("The user is in-active please contact system administrator!", "SYSTEM MESSAGE", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //                    this.txtUserName.Focus();
            //                }
            //                else if (!Functions.Encrypt(this.txtPass.Text).Equals(eLogInEntity.Password))
            //                {
            //                    string a = Functions.Decrypt(eLogInEntity.Password);

            //                    iLoginCount += 1;
            //                    this.lblLedger.Text = "Wrong Password !";
            //                    this.txtPass.Focus();
            //                    this.txtPass.SelectAll();
            //                }
            //                else
            //                {
            //                    /*GET PREVENTIVE MAINTENANCE SETTINGS */
            //                    //this.M_GetPreventiveMaintenanceUserSettings(Convert.ToInt32(this.txtUserName.Text));

            //                    // Check if the selected account and password still active 
            //                    if (!eLogInEntity.IsLockedOut)
            //                    {
            //                        if (!eLogInEntity.AccountNeverExpire)
            //                        {
            //                            if (DateTime.Compare(eLogInEntity.AccountExpiryDate.Value, DateTime.Now) <= 0)
            //                            {
            //                                MessageBox.Show("This account expired , Contact IT Department !", "SYSTEM MESSAGE", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //                                this.txtUserName.Focus();
            //                                return;
            //                            }
            //                        }
            //                        if (!eLogInEntity.PasswordNeverExpire)
            //                        {
            //                            if (DateTime.Compare(eLogInEntity.PasswordExpiryDate.Value, DateTime.Now) <= 0)
            //                            {
            //                                MessageBox.Show("This Password expired , Contact IT Department !", "SYSTEM MESSAGE", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //                                this.txtUserName.Focus();
            //                                return;
            //                            }

            //                        }
            //                    }
            //                    else
            //                    {
            //                        MessageBox.Show("This account Locked , Contact IT Department !", "SYSTEM MESSAGE", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //                        this.txtUserName.Focus();
            //                        return;
            //                    }

            //                    //Variables.UserName = eLogInEntity.Name;
            //                    //Variables.UserID = Convert.ToInt32(this.txtUserName.Text);
            //                    //Variables.UserGroupCode = Convert.ToString(eLogInEntity.Group_Code);
            //                    //Variables.UserGroupName = this.cboGroup.Text;
            //                    //Variables.UserPassword = eLogInEntity.Password;
            //                    //Variables.EMRUserID = Convert.ToInt32(eLogInEntity.EMRUserID);

            //                    /* USER SECURITY */
            //                    //using (SecurityEntity eSecurityEntity = new SecurityEntity())
            //                    //{
            //                    //    using (SecurityManager mngrSecurityManager = new SecurityManager())
            //                    //    {
            //                    //        using (DataSet ds = mngrSecurityManager.GetControls())
            //                    //        {
            //                    //            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            //                    //            {
            //                    //                DataRow[] dRow = ds.Tables[0].Select("Control_UserID = '" + this.txtUserName.Text + "'");
            //                    //                if (dRow.Length > 0)
            //                    //                {
            //                    //                    Variables.SecurityExamination = Convert.ToBoolean(dRow[0]["Examination"]);
            //                    //                    Variables.SecurityAttachment = Convert.ToBoolean(dRow[0]["Attachment"]);
            //                    //                    Variables.SecurityEditAttachment = Convert.ToBoolean(dRow[0]["AllowEditAttach"]);
            //                    //                    Variables.SecurityExamFormMaster = Convert.ToBoolean(dRow[0]["ExamFormMaster"]);
            //                    //                    Variables.SecurityTabAramco = Convert.ToBoolean(dRow[0]["TabAramco"]);
            //                    //                    Variables.SecurityTabCompany = Convert.ToBoolean(dRow[0]["TabCompany"]);
            //                    //                    Variables.SecurityTabGeneral = Convert.ToBoolean(dRow[0]["TabGeneral"]);
            //                    //                    Variables.SecurityTabUser = Convert.ToBoolean(dRow[0]["TabUserSecurity"]);
            //                    //                    Variables.SecurityTabProgram = Convert.ToBoolean(dRow[0]["TabProgram"]);
            //                    //                    Variables.SecurityReSending = Convert.ToBoolean(dRow[0]["ReSending"]);
            //                    //                    Variables.SecurityDownloadAll = Convert.ToBoolean(dRow[0]["DownloadAll"]);
            //                    //                }
            //                    //                dRow = null;
            //                    //            }
            //                    //        }
            //                    //    }
            //                    //}

            //                    // Update last login date 
            //                    //eLogInEntity.Group_Code = Convert.ToInt32(Variables.UserGroupCode);
            //                    string str = mngrLogInManager.LoginUpdate(eLogInEntity);

            //                    this.Hide();
            //                    LoginUserID = this.txtUserName.Text;

            //                    if (_MDIMain != null)
            //                        _MDIMain.Close();

            //                    //if (_frmPreEmp_ListOfCandidates != null)
            //                    //{
            //                    //    _frmPreEmp_ListOfCandidates.Close();
            //                    //    _frmPreEmp_ListOfCandidates = null;
            //                    //}
            //                    //_frmPreEmp_ListOfCandidates = new frmPreEmp_ListOfCandidates();
            //                    //_frmPreEmp_ListOfCandidates.Show();

            //                    // Check if the user changed his password or no 
            //                    //if (this.txtPass.Text.Equals("12345"))
            //                    //{
            //                    //    frmWC_ChangePassword frmWC_ChangePassword = new frmWC_ChangePassword();
            //                    //    frmWC_ChangePassword.StartPosition = FormStartPosition.CenterScreen;
            //                    //    frmWC_ChangePassword.ShowDialog();
            //                    //}
            //                }
            //            }
            //        }
            //    }
            //}

            /*FOR DEMO*/
            if (IsAllowMe)
            {
                this.Hide();
                LoginUserID = this.txtUserName.Text;
                Variables.UserGroupCode = 1;
                if (_MDIMain != null)
                    _MDIMain.Close();

                if (_frmMainDashboard != null)
                {
                    _frmMainDashboard.Close();
                    _frmMainDashboard = null;
                }

                _frmMainDashboard = new frmMainDashboard();
                _frmMainDashboard.Show();


                
                RadDesktopAlert radDesktopAlert1 = new RadDesktopAlert();
                //radDesktopAlert1.ContentImage = Properties.Resources.download24x24;
                radDesktopAlert1.CaptionText = "LEASING SYSTEM";
                radDesktopAlert1.ContentText = "DEVELOPED BY : MARK JASON GELISANGA\n"
                                                + "DEVELOPED DATE : JUN 2023";
                //+ "ARAMCO : JUNE 2018\n"
                //+ "COMPANY : \n"
                //+ "GENERAL : ";
                radDesktopAlert1.AutoClose = true;
                radDesktopAlert1.AutoCloseDelay = 3;
                radDesktopAlert1.ShowOptionsButton = false;
                radDesktopAlert1.ShowPinButton = false;
                radDesktopAlert1.ShowCloseButton = true;
                //radDesktopAlert1.FixedSize = new Size(radDesktopAlert1.FixedSize.Width, 50);

                radDesktopAlert1.Popup.AlertElement.CaptionElement.CaptionGrip.BackColor = Color.Green;
                radDesktopAlert1.Popup.AlertElement.BorderColor = Color.Green;
                radDesktopAlert1.Popup.AlertElement.CaptionElement.TextAndButtonsElement.TextElement.ForeColor = Color.White;
                radDesktopAlert1.Popup.AlertElement.CaptionElement.CaptionGrip.GradientStyle = GradientStyles.Solid;
                radDesktopAlert1.Popup.AlertElement.ContentElement.Font = new Font("Tahoma", 8f, FontStyle.Italic);
                radDesktopAlert1.Popup.AlertElement.ContentElement.TextImageRelation = TextImageRelation.ImageBeforeText;
                //radDesktopAlert1.Popup.AlertElement.CaptionElement.TextAndButtonsElement.ForeColor = Color.White;
                radDesktopAlert1.Popup.AlertElement.ContentElement.ForeColor = Color.White;
                radDesktopAlert1.Popup.AlertElement.BackColor = Color.FromArgb(64, 64, 64);
                radDesktopAlert1.Popup.AlertElement.GradientStyle = GradientStyles.Solid;

                radDesktopAlert1.Show();
            }
          
        }

        private void txtUserName_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;

            toolTip1.Hide(txtPass);

            if (e.KeyChar == 13)
            {
                if (string.IsNullOrEmpty(this.txtUserName.Text))
                {
                    this.lblLedger.Text = "Invalid User name and password";
                    this.txtUserName.Focus();
                }
                else
                {
                    M_GetGroup(string.IsNullOrEmpty(this.txtUserName.Text) ? "0" : this.txtUserName.Text);
                    this.txtPass.Focus();
                    this.txtPass.SelectAll();

                    if (cboGroup.SelectedIndex == -1)
                    {
                        this.lblLedger.Text = "There was no Group assigned to your Account. Please contact your System Administrator.";
                        txtUserName.Focus();
                        return;
                    }
                }
            }
        }
        private void txtPass_KeyPress(object sender, KeyPressEventArgs e)
        {
            //if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[*A-Za-z0-9\b]"))
            //    e.Handled = true;
            //else
            //{
                if ((Control.IsKeyLocked(Keys.CapsLock)) && Convert.ToString(e.KeyChar) != "8")
                {
                    toolTip1.ToolTipTitle = "Caps Lock Is On";
                    toolTip1.ToolTipIcon = ToolTipIcon.Warning;
                    //toolTip1.IsBalloon = true;
                    //toolTip1.SetToolTip(txtPass, "Having Caps Lock on may cause you to enter your password incorrectly.\n\nYou should press Caps Lock to turn it off before entering your password.");
                    toolTip1.Show("Having Caps Lock on may cause you to enter your password incorrectly.\nYou should press Caps Lock to turn it off before entering your password.", txtPass, 5, txtPass.Height - 5);
                }
                else
                {
                    toolTip1.Hide(txtPass);
                }
            //}

            if (e.KeyChar == 13)
            {
                if (string.IsNullOrEmpty(this.txtUserName.Text))
                {
                    this.lblLedger.Text = "Invalid User name and password";
                    this.txtUserName.Focus();
                }
                else if (!string.IsNullOrEmpty(this.txtPass.Text.Trim()) && this.cboGroup.SelectedIndex == -1)
                {
                    this.lblLedger.Text = "Select group to proceed.";
                    M_GetGroup(string.IsNullOrEmpty(this.txtUserName.Text) ? "0" : this.txtUserName.Text);
                }
                else
                    this.btnLogIn.PerformClick();
            }
        }

        private void txtPass_Enter(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(this.txtUserName.Text))
            {
                this.lblLedger.Text = "Invalid User name and password";
                this.txtUserName.Focus();
            }
            else
            {
                M_GetGroup(string.IsNullOrEmpty(this.txtUserName.Text) ? "0" : this.txtUserName.Text);
                this.txtPass.Focus();
                this.txtPass.SelectAll();

                if (cboGroup.SelectedIndex == -1)
                {
                    this.lblLedger.Text = "There was no Group assigned to your Account. Please contact your System Administrator.";
                    txtUserName.Focus();
                    return;
                }
            }
        }


     

        public class AutoClosingMessageBox
        {
            System.Threading.Timer _timeoutTimer;
            string _caption;
            AutoClosingMessageBox(string text, string caption, int timeout)
            {
                _caption = caption;
                _timeoutTimer = new System.Threading.Timer(OnTimerElapsed,
                    null, timeout, System.Threading.Timeout.Infinite);
                using (_timeoutTimer)
                    MessageBox.Show(text, caption);
            }
            public static void Show(string text, string caption, int timeout)
            {
                new AutoClosingMessageBox(text, caption, timeout);
            }
            void OnTimerElapsed(object state)
            {
                IntPtr mbWnd = FindWindow("#32770", _caption); // lpClassName is #32770 for MessageBox
                if (mbWnd != IntPtr.Zero)
                    SendMessage(mbWnd, WM_CLOSE, IntPtr.Zero, IntPtr.Zero);
                _timeoutTimer.Dispose();
            }
            const int WM_CLOSE = 0x0010;
            [System.Runtime.InteropServices.DllImport("user32.dll", SetLastError = true)]
            static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
            [System.Runtime.InteropServices.DllImport("user32.dll", CharSet = System.Runtime.InteropServices.CharSet.Auto)]
            static extern IntPtr SendMessage(IntPtr hWnd, UInt32 Msg, IntPtr wParam, IntPtr lParam);
        }
    }
}
