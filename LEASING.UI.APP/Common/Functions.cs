using LEASING.UI.APP.Context;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Telerik.WinControls;
using Telerik.WinControls.UI;

namespace LEASING.UI.APP.Common
{
    public class Functions
    {
        public static void SecurityControls(Control _ctrl)
        {
            DataTable dtTable = new DataTable();
            DataView dvView;
            using (SecurityControlContext mngrSecurityManager = new SecurityControlContext())
            {
                using (DataSet ds = mngrSecurityManager.GetControls())
                {
                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        dtTable = ds.Tables[0];
                }
            }

            int len = _ctrl.GetType().ToString().Length - _ctrl.GetType().ToString().LastIndexOf('.');
            string vName = _ctrl.GetType().ToString().Substring(_ctrl.GetType().ToString().LastIndexOf('.') + 1, len - 1);

            if (vName == "frmMainDashboard")
            {
                #region MAIN DASHBOARD
                dvView = new DataView(dtTable);
                dvView.RowFilter = "FormName = '" + vName + "'";

                if (dvView.Count > 0)
                {
                    foreach (Control ctrl in _ctrl.Controls)
                    {
                        string ControlNames = ctrl.Name;
                        string controlTypes = ctrl.GetType().ToString();

                        switch (ctrl.Name)
                        {
                            case "tableLayoutPanel1":
                                System.Windows.Forms.TableLayoutPanel tableLayoutPanel1 = (System.Windows.Forms.TableLayoutPanel)ctrl;
                                for (int iAllPages = 0; iAllPages < dvView.Count; iAllPages++)
                                {
                                    foreach (Control control in tableLayoutPanel1.Controls)
                                    {
                                        if (control is RadLabel)
                                        {
                                            RadLabel RadLabel = (RadLabel)control;
                                            switch (RadLabel.Name)
                                            {
                                                case "lblMenus":
                                                    foreach (Control controls in RadLabel.Controls)
                                                    {
                                                        if (controls is RadPanel)
                                                        {
                                                            RadPanel RadPanel = (RadPanel)controls;
                                                            switch (RadPanel.Name)
                                                            {
                                                                case "radPanel2":
                                                                    if (Convert.ToString(dvView[iAllPages]["ControlName"]) == RadPanel.Name)
                                                                    {
                                                                        RadPanel.Visible = Convert.ToBoolean(dvView[iAllPages]["Permission"]);
                                                                    }
                                                                    foreach (Control controlss in RadPanel.Controls)
                                                                    {
                                                                        if (controlss is RadMenu)
                                                                        {
                                                                            RadMenu RadMenu = (RadMenu)controlss;
                                                                            switch (RadMenu.Name)
                                                                            {
                                                                                case "radMenu2":
                                                                                    for (int iControls = 0; iControls < RadMenu.Items.Count; iControls++)
                                                                                    {
                                                                                        if (Convert.ToString(dvView[iAllPages]["ControlName"]) == RadMenu.Items[iControls].Name)
                                                                                        {
                                                                                            if (Convert.ToBoolean(dvView[iAllPages]["Permission"]))
                                                                                            {
                                                                                                RadMenu.Items[iControls].Visibility = ElementVisibility.Visible;
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                RadMenu.Items[iControls].Visibility = ElementVisibility.Collapsed;
                                                                                            }
                                                                                        }
                                                                                        RadMenuItem targetMenuItem = RadMenu.Items["radMenuItemClient"] as RadMenuItem;

                                                                                        for (int targetMenuItems = 0; targetMenuItems < targetMenuItem.Items.Count; targetMenuItems++)
                                                                                        {
                                                                                            string sadas = Convert.ToString(dvView[iAllPages]["ControlName"]);                                                                                   
                                                                                            if (Convert.ToString(dvView[iAllPages]["ControlName"]) == targetMenuItem.Items[targetMenuItems].Name)
                                                                                            {
                                                                                                if (Convert.ToBoolean(dvView[iAllPages]["Permission"]))
                                                                                                {
                                                                                                    targetMenuItem.Items[targetMenuItems].Visibility = ElementVisibility.Visible;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    targetMenuItem.Items[targetMenuItems].Visibility = ElementVisibility.Collapsed;
                                                                                                }
                                                                                            }
                                                                                        }                                                                                   
                                                                                    }
                                                                                    break;
                                                                            }
                                                                        }
                                                                    }
                                                                    break;

                                                                    /*ADD here the rest of the menu*/
                                                            }
                                                        }
                                                    }
                                                    break;
                                            }
                                        }
                                    }
                                    //for (int iPages = 0; iPages < pvw.Pages.Count; iPages++)
                                    //{
                                    //    if (Convert.ToString(dvView[iAllPages]["ControlName"]) == Convert.ToString(pvw.Pages[iPages].Name))
                                    //    {
                                    //        if (Convert.ToBoolean(dvView[iAllPages]["Permission"]))
                                    //            pvw.Pages[iPages].Item.Visibility = ElementVisibility.Visible;
                                    //        else
                                    //            pvw.Pages[iPages].Item.Visibility = ElementVisibility.Collapsed;
                                    //    }
                                    //}
                                }
                                break;
                        }
                        //switch (ctrl.Name)
                        //{
                        //    case "radPageView1":
                        //        Telerik.WinControls.UI.RadPageView pvw = (Telerik.WinControls.UI.RadPageView)ctrl;
                        //        for (int iAllPages = 0; iAllPages < dvView.Count; iAllPages++)
                        //        {
                        //            for (int iPages = 0; iPages < pvw.Pages.Count; iPages++)
                        //            {
                        //                if (Convert.ToString(dvView[iAllPages]["ControlName"]) == Convert.ToString(pvw.Pages[iPages].Name))
                        //                {
                        //                    if (Convert.ToBoolean(dvView[iAllPages]["Permission"]))
                        //                        pvw.Pages[iPages].Item.Visibility = ElementVisibility.Visible;
                        //                    else
                        //                        pvw.Pages[iPages].Item.Visibility = ElementVisibility.Collapsed;
                        //                }
                        //            }
                        //        }
                        //        break;
                        //}
                    }
                }
                #endregion
            }
            else if (vName == "frmClientInformation")
            {
                #region CLIENT
                dvView = new DataView(dtTable);
                dvView.RowFilter = "FormName = '" + vName + "'";

                if (dvView.Count > 0)
                {
                    foreach (Control ctrl in _ctrl.Controls)
                    {
                        string ControlNames = ctrl.Name;
                        string controlTypes = ctrl.GetType().ToString();

                        switch (ctrl.Name)
                        {
                            //case "toolStripDownload":
                            //    ctrl.Visible = Convert.ToBoolean(dvView[0]["Permission"]);
                            //    break;
                            //case "toolStrip1":
                            //    System.Windows.Forms.ToolStrip toolstrip = (System.Windows.Forms.ToolStrip)ctrl;

                            //    for (int iAllPages = 0; iAllPages < dvView.Count; iAllPages++)
                            //    {
                            //        for (int iControls = 0; iControls < toolstrip.Items.Count; iControls++)
                            //        {
                            //            if (Convert.ToString(dvView[iAllPages]["ControlName"]) == toolstrip.Items[iControls].Name)
                            //            {
                            //                toolstrip.Items[iControls].Visible = Convert.ToBoolean(dvView[iAllPages]["Permission"]);
                            //            }
                            //        }
                            //    }
                            //    break;



                            case "tableLayoutPanel2":
                                System.Windows.Forms.TableLayoutPanel TableLayoutPanel = (System.Windows.Forms.TableLayoutPanel)ctrl;

                                for (int iAllPages = 0; iAllPages < dvView.Count; iAllPages++)
                                {

                                    foreach (Control control in TableLayoutPanel.Controls)
                                    {
                                        if (control is ToolStrip)
                                        {
                                            ToolStrip ToolStrip = (ToolStrip)control;
                                            switch (ToolStrip.Name)
                                            {
                                                case "toolStrip2":
                                                    for (int iControls = 0; iControls < ToolStrip.Items.Count; iControls++)
                                                    {
                                                        if (Convert.ToString(dvView[iAllPages]["ControlName"]) == ToolStrip.Items[iControls].Name)
                                                        {
                                                            ToolStrip.Items[iControls].Visible = Convert.ToBoolean(dvView[iAllPages]["Permission"]);
                                                        }
                                                    }
                                                    break;
                                            }
                                        }
                                        else if (control is RadGroupBox)
                                        {
                                            RadGroupBox RadGroupBox = (RadGroupBox)control;

                                            switch (RadGroupBox.Name)
                                            {
                                                case "radGroupBox3":
                                                    foreach (Control RadGroupBoxcontrols in RadGroupBox.Controls)
                                                    {
                                                        if (RadGroupBoxcontrols is TableLayoutPanel)
                                                        {
                                                            TableLayoutPanel TableLayoutPanels = (TableLayoutPanel)RadGroupBoxcontrols;
                                                            switch (TableLayoutPanels.Name)
                                                            {
                                                                case "tableLayoutPanel6":

                                                                    foreach (Control controls in TableLayoutPanels.Controls)
                                                                    {
                                                                        if (controls is RadButton)
                                                                        {
                                                                            RadButton RadButton = (RadButton)controls;
                                                                            switch (RadButton.Name)
                                                                            {
                                                                                case "btnSelectClient":
                                                                                    if (Convert.ToString(dvView[iAllPages]["ControlName"]) == RadButton.Name)
                                                                                    {
                                                                                        RadButton.Visible = Convert.ToBoolean(dvView[iAllPages]["Permission"]);
                                                                                    }
                                                                                    break;
                                                                            }
                                                                        }
                                                                    }
                                                                    break;
                                                            }

                                                        }
                                                    }
                                                    break;
                                            }

                                        }
                                    }
                                }
                                break;

                                //case "dtgvCandidates":
                                //    Telerik.WinControls.UI.RadGridView gridView = (Telerik.WinControls.UI.RadGridView)ctrl;
                                //    for (int iAllPages = 0; iAllPages < dvView.Count; iAllPages++)
                                //    {
                                //        for (int iColumns = 0; iColumns < gridView.Columns.Count; iColumns++)
                                //        {
                                //            if (Convert.ToString(dvView[iAllPages]["ControlName"]) == gridView.Columns[iColumns].Name)
                                //                gridView.Columns[iColumns].IsVisible = Convert.ToBoolean(dvView[iAllPages]["Permission"]);


                                //            if (Convert.ToString(dvView[iAllPages]["ControlName"]) == "colExams")
                                //                Variables.SecurityExamination = Convert.ToBoolean(dvView[iAllPages]["Permission"]);

                                //            if (Convert.ToString(dvView[iAllPages]["ControlName"]) == "colReSend")
                                //                Variables.SecurityReSending = Convert.ToBoolean(dvView[iAllPages]["Permission"]);
                                //        }
                                //    }
                                //    break;
                        }
                    }
                }
                #endregion
            }
            //else if (vName == "frmPreEmp_Attachments")
            //{
            //    #region ATTACHMENT
            //    dvView = new DataView(dtTable);
            //    dvView.RowFilter = "FormName = '" + vName + "'";

            //    if (dvView.Count > 0)
            //    {
            //        foreach (Control ctrl in _ctrl.Controls)
            //        {
            //            string ControlNames = ctrl.Name;
            //            string controlTypes = ctrl.GetType().ToString();

            //            switch (ctrl.Name)
            //            {
            //                case "toolStrip1":
            //                    ctrl.Visible = Convert.ToBoolean(dvView[0]["Permission"]);
            //                    Variables.SecurityEditAttachment = Convert.ToBoolean(dvView[0]["Permission"]);
            //                    break;
            //                case "tableLayoutPanel1":
            //                    ctrl.Visible = Convert.ToBoolean(dvView[0]["Permission"]);
            //                    Variables.SecurityEditAttachment = Convert.ToBoolean(dvView[0]["Permission"]);
            //                    break;
            //            }
            //        }
            //    }
            //    #endregion
            //}
            //else if (vName == "frmPreEmp_ExaminationMainForm")
            //{
            //    #region EXAMINATION MASTER
            //    dvView = new DataView(dtTable);
            //    dvView.RowFilter = "FormName = '" + vName + "'";

            //    if (dvView.Count > 0)
            //    {
            //        foreach (Control ctrl in _ctrl.Controls)
            //        {
            //            string ControlNames = ctrl.Name;
            //            string controlTypes = ctrl.GetType().ToString();

            //            switch (ctrl.Name)
            //            {
            //                case "toolStrip1":
            //                    System.Windows.Forms.ToolStrip toolstrip = (System.Windows.Forms.ToolStrip)ctrl;
            //                    for (int iAllPages = 0; iAllPages < dvView.Count; iAllPages++)
            //                    {
            //                        for (int iControls = 0; iControls < toolstrip.Items.Count; iControls++)
            //                        {
            //                            if (Convert.ToString(dvView[iAllPages]["ControlName"]) == toolstrip.Items[iControls].Name)
            //                            {
            //                                toolstrip.Items[iControls].Visible = Convert.ToBoolean(dvView[iAllPages]["Permission"]);
            //                            }
            //                        }
            //                    }
            //                    break;
            //            }
            //        }
            //    }
            //    #endregion
            //}

            dtTable = null;
            dvView = null;
        }

        public static void LogErrorIntoStoredProcedure(string procedureName, string FormName, string errorMessage, DateTime logDateTime , Control _ctrl)
        {
            int len = _ctrl.GetType().ToString().Length - _ctrl.GetType().ToString().LastIndexOf('.');
            string vName = _ctrl.GetType().ToString().Substring(_ctrl.GetType().ToString().LastIndexOf('.') + 1, len - 1);
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString()))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("sp_LogError", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Add parameters
                        command.Parameters.AddWithValue("@ProcedureName", procedureName);
                        command.Parameters.AddWithValue("@frmName", vName);
                        command.Parameters.AddWithValue("@FormName", FormName);
                        command.Parameters.AddWithValue("@UserId", Variables.UserID);
                        command.Parameters.AddWithValue("@ErrorMessage", errorMessage);                
                        command.Parameters.AddWithValue("@LogDateTime", logDateTime);

                        // Execute the stored procedure
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        public static void GetNotification(string CaptionText, string CaptionText2)
        {

            RadDesktopAlert radDesktopAlert1 = new RadDesktopAlert();
            //radDesktopAlert1.ContentImage = Properties.Resources.download24x24;
            radDesktopAlert1.CaptionText = CaptionText;
            radDesktopAlert1.ContentText = CaptionText2;
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
}
