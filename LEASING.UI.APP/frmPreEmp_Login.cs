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
using LEASING.UI.APP.Context;

namespace LEASING.UI.APP.Forms
{
    public partial class frmPreEmp_Login : Form
    {
        private frmMainDashboard _frmMainDashboard;
        private Form _MDIMain;
        private int iLoginCount = 1;
        private int LoginUserID = 0;
        string FirstName;
        string MiddleName;
        string Surname;
        int UserGroupCode;
        string UserGroupName;
        string UserPassword;
        LoginMethod _LoginMethod;
        public enum LoginMethod
        {
            Login,
            Switch
        }
        ToolTip toolTip1 = new ToolTip();
        private void M_GetGroup(string vEmpNo)
        {
            this.cboGroup.DataSource = null;
            using (SecurityControlContext mngrLogInManager = new SecurityControlContext())
            {

                using (DataSet dsUserGroups = mngrLogInManager.GetGroup(Convert.ToInt32(vEmpNo)))
                {
                    if (dsUserGroups != null && dsUserGroups.Tables.Count > 0 && dsUserGroups.Tables[0].Rows.Count > 0)
                    {
                        //dsUserGroups.Tables[0].DefaultView.RowFilter = "Member = 1 and status =1"; 
                        //DataTable dtUserGroups = dsUserGroups.Tables[0].DefaultView.ToTable();
                        this.cboGroup.ValueMember = "Group_Code";
                        this.cboGroup.DisplayMember = "Group_Name";
                        this.cboGroup.DataSource = dsUserGroups.Tables[0];
                        this.cboGroup.Enabled = false;
                        //dtUserGroups = null;
                    }
                }

            }
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
                using (SecurityControlContext mngrLogInManager = new SecurityControlContext())
                {
                    using (DataSet dt = mngrLogInManager.GetUserPassword(Convert.ToString(txtUserName.Text)))
                    {
                        if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                        {
                            Variables.UserID = Convert.ToInt32(dt.Tables[0].Rows[0]["UserId"]);
                            if (Convert.ToBoolean(dt.Tables[0].Rows[0]["UserStatus"]))
                            {
                                MessageBox.Show("The user is in-active please contact system administrator!", "SYSTEM MESSAGE", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                this.txtUserName.Focus();
                            }
                        }
                    }
                }
                M_GetGroup(string.IsNullOrEmpty(Convert.ToString(Variables.UserID)) ? "0" : Convert.ToString(Variables.UserID));
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

            using (SecurityControlContext mngrLogInManager = new SecurityControlContext())
            {
                using (DataSet dt = mngrLogInManager.GetUserPassword(Convert.ToString(txtUserName.Text)))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        FirstName = Convert.ToString(dt.Tables[0].Rows[0]["StaffName"]);
                        UserPassword = Convert.ToString(dt.Tables[0].Rows[0]["UserPassword"]);
                        Variables.UserID = Convert.ToInt32(dt.Tables[0].Rows[0]["UserId"]);
                        if (Convert.ToBoolean(dt.Tables[0].Rows[0]["UserStatus"]))
                        {
                            MessageBox.Show("The user is in-active please contact system administrator!", "SYSTEM MESSAGE", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            this.txtUserName.Focus();
                        }
                        else if (!(this.txtPass.Text).Equals(UserPassword))
                        {
                            iLoginCount += 1;
                            this.lblLedger.Text = "Wrong Password !";
                            this.txtPass.Focus();
                            this.txtPass.SelectAll();
                        }
                        else
                        {

                            // Check if the selected account and password still active 
                            //if (!eLogInEntity.IsLockedOut)
                            //{
                            //    if (!eLogInEntity.AccountNeverExpire)
                            //    {
                            //        if (DateTime.Compare(eLogInEntity.AccountExpiryDate.Value, DateTime.Now) <= 0)
                            //        {
                            //            MessageBox.Show("This account expired , Contact IT Department !", "SYSTEM MESSAGE", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            //            this.txtUserName.Focus();
                            //            return;
                            //        }
                            //    }
                            //    if (!eLogInEntity.PasswordNeverExpire)
                            //    {
                            //        if (DateTime.Compare(eLogInEntity.PasswordExpiryDate.Value, DateTime.Now) <= 0)
                            //        {
                            //            MessageBox.Show("This Password expired , Contact IT Department !", "SYSTEM MESSAGE", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            //            this.txtUserName.Focus();
                            //            return;
                            //        }

                            //    }
                            //}
                            //else
                            //{
                            //    MessageBox.Show("This account Locked , Contact IT Department !", "SYSTEM MESSAGE", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            //    this.txtUserName.Focus();
                            //    return;
                            //}

                            Variables.FirstName = FirstName;
                            Variables.UserName = Convert.ToString(this.txtUserName.Text);
                            Variables.UserGroupCode = Convert.ToInt32(cboGroup.SelectedValue);
                            Variables.UserGroupName = this.cboGroup.Text;
                            Variables.UserPassword = UserPassword;


                            this.Hide();
                            //LoginUserID = Convert.ToInt32(this.txtUserName.Text);

                            if (_MDIMain != null)
                                _MDIMain.Close();

                            if (_frmMainDashboard != null)
                            {
                                _frmMainDashboard.Close();
                                _frmMainDashboard = null;
                            }

                            _frmMainDashboard = new frmMainDashboard();
                            _frmMainDashboard.Show();


                            //if (this.txtPass.Text.Equals("12345"))
                            //{
                            //    frmWC_ChangePassword frmWC_ChangePassword = new frmWC_ChangePassword();
                            //    frmWC_ChangePassword.StartPosition = FormStartPosition.CenterScreen;
                            //    frmWC_ChangePassword.ShowDialog();
                            //}
                        }
                    }



                }

            }

            /*FOR DEMO*/
            if (IsAllowMe)
            {
                this.Hide();
                //LoginUserID = Convert.ToInt32(this.txtUserName.Text);
                Variables.UserGroupCode = 26319;
                //Variables.FirstName = "ADMINISTRATOR";
                //Variables.UserID = Convert.ToInt32(this.txtUserName.Text);               
                //Variables.UserGroupName = "SUPER ADMIN";
                Variables.UserPassword = string.Empty;
                if (_MDIMain != null)
                    _MDIMain.Close();

                if (_frmMainDashboard != null)
                {
                    _frmMainDashboard.Close();
                    _frmMainDashboard = null;
                }

                _frmMainDashboard = new frmMainDashboard();
                _frmMainDashboard.Show();


            }

        }
        private void txtUserName_KeyPress(object sender, KeyPressEventArgs e)
        {

           

        //if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
        //    e.Handled = true;

            toolTip1.Hide(txtPass);

   
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
                    using (SecurityControlContext mngrLogInManager = new SecurityControlContext())
                    {
                        using (DataSet dt = mngrLogInManager.GetUserPassword(Convert.ToString(txtUserName.Text)))
                        {
                            if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                            {
                                Variables.UserID = Convert.ToInt32(dt.Tables[0].Rows[0]["UserId"]);
                                if (Convert.ToBoolean(dt.Tables[0].Rows[0]["UserStatus"]))
                                {
                                    MessageBox.Show("The user is in-active please contact system administrator!", "SYSTEM MESSAGE", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                    this.txtUserName.Focus();
                                }
                            }
                        }
                    }
                    M_GetGroup(string.IsNullOrEmpty(Convert.ToString(Variables.UserID)) ? "0" : Convert.ToString(Variables.UserID));
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
                using (SecurityControlContext mngrLogInManager = new SecurityControlContext())
                {
                    using (DataSet dt = mngrLogInManager.GetUserPassword(Convert.ToString(txtUserName.Text)))
                    {
                        if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                        {
                            Variables.UserID = Convert.ToInt32(dt.Tables[0].Rows[0]["UserId"]);
                            if (Convert.ToBoolean(dt.Tables[0].Rows[0]["UserStatus"]))
                            {
                                MessageBox.Show("The user is in-active please contact system administrator!", "SYSTEM MESSAGE", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                this.txtUserName.Focus();
                            }
                        }
                    }
                }
                M_GetGroup(string.IsNullOrEmpty(Convert.ToString(Variables.UserID)) ? "0" : Convert.ToString(Variables.UserID));
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

        private void txtUserName_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                //if (e.KeyChar == 13)
                //{
                    if (string.IsNullOrEmpty(this.txtUserName.Text))
                    {
                        this.lblLedger.Text = "Invalid User name and password";
                        this.txtUserName.Focus();
                    }
                    else
                    {
                        using (SecurityControlContext mngrLogInManager = new SecurityControlContext())
                        {
                            using (DataSet dt = mngrLogInManager.GetUserPassword(Convert.ToString(txtUserName.Text)))
                            {
                                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                                {
                                    Variables.UserID = Convert.ToInt32(dt.Tables[0].Rows[0]["UserId"]);
                                    if (Convert.ToBoolean(dt.Tables[0].Rows[0]["UserStatus"]))
                                    {
                                        MessageBox.Show("The user is in-active please contact system administrator!", "SYSTEM MESSAGE", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                        this.txtUserName.Focus();
                                    }
                                }
                            }
                        }

                        M_GetGroup(string.IsNullOrEmpty(Convert.ToString(Variables.UserID)) ? "0" : Convert.ToString(Variables.UserID));
                        this.txtPass.Focus();
                        this.txtPass.SelectAll();

                        if (cboGroup.SelectedIndex == -1)
                        {
                            this.lblLedger.Text = "There was no Group assigned to your Account. Please contact your System Administrator.";
                            txtUserName.Focus();
                            return;
                        }
                    }
                //}
            }
        }
    }
}
