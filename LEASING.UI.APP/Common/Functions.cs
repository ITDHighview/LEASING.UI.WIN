using LEASING.UI.APP.Context;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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

    }
}
