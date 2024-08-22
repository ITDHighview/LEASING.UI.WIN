using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Windows.Forms;
using LEASING.UI.APP.Context;
using LEASING.UI.APP.Forms;
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
        public static void ShowLoadingBar(string sLoadingTitle)
        {

            frmLoadingBar losding = new frmLoadingBar();
            losding.LoadingTitle = sLoadingTitle;
            losding.ShowDialog();
        }
        public static void EventCapturefrmName(Control _ctrl)
        {
            string vName = string.Empty;
            if (_ctrl != null)
            {
                int len = _ctrl.GetType().ToString().Length - _ctrl.GetType().ToString().LastIndexOf('.');
                vName = _ctrl.GetType().ToString().Substring(_ctrl.GetType().ToString().LastIndexOf('.') + 1, len - 1);
            }
            if (ConfigurationManager.AppSettings["CapturefrmName"] != "")
            {
                Functions.LogEvent("Capture frmName", vName);
            }

        }
        public static void SecurityControls(Control _ctrl)
        {
            DataTable dtTable = new DataTable();
            DataView dvView;
            using (SecurityControlContext mngrSecurityManager = new SecurityControlContext())
            {
                using (DataSet ds = mngrSecurityManager.GetControls(Variables.UserGroupCode))
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

                                                                #region CLIENT
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
                                                                #endregion

                                                                #region CONTRACTS
                                                                case "radPanel3":
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
                                                                                case "radMenu3":
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
                                                                                        RadMenuItem radMenuItemContracts = RadMenu.Items["radMenuItemContracts"] as RadMenuItem;

                                                                                        for (int targetMenuItems = 0; targetMenuItems < radMenuItemContracts.Items.Count; targetMenuItems++)
                                                                                        {

                                                                                            if (Convert.ToString(dvView[iAllPages]["ControlName"]) == radMenuItemContracts.Items[targetMenuItems].Name)
                                                                                            {
                                                                                                if (Convert.ToBoolean(dvView[iAllPages]["Permission"]))
                                                                                                {
                                                                                                    radMenuItemContracts.Items[targetMenuItems].Visibility = ElementVisibility.Visible;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    radMenuItemContracts.Items[targetMenuItems].Visibility = ElementVisibility.Collapsed;
                                                                                                }
                                                                                            }


                                                                                            RadMenuItem radMenuItemUnitContracts = radMenuItemContracts.Items["radMenuItemUnitContracts"] as RadMenuItem;

                                                                                            for (int targetMenuItems2 = 0; targetMenuItems2 < radMenuItemUnitContracts.Items.Count; targetMenuItems2++)
                                                                                            {

                                                                                                if (Convert.ToString(dvView[iAllPages]["ControlName"]) == radMenuItemUnitContracts.Items[targetMenuItems2].Name)
                                                                                                {
                                                                                                    if (Convert.ToBoolean(dvView[iAllPages]["Permission"]))
                                                                                                    {
                                                                                                        radMenuItemUnitContracts.Items[targetMenuItems2].Visibility = ElementVisibility.Visible;
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        radMenuItemUnitContracts.Items[targetMenuItems2].Visibility = ElementVisibility.Collapsed;
                                                                                                    }
                                                                                                }


                                                                                            }
                                                                                            RadMenuItem radMenuItemParkingContracts = radMenuItemContracts.Items["radMenuItemParkingContracts"] as RadMenuItem;
                                                                                            for (int targetMenuItems3 = 0; targetMenuItems3 < radMenuItemParkingContracts.Items.Count; targetMenuItems3++)
                                                                                            {

                                                                                                if (Convert.ToString(dvView[iAllPages]["ControlName"]) == radMenuItemParkingContracts.Items[targetMenuItems3].Name)
                                                                                                {
                                                                                                    if (Convert.ToBoolean(dvView[iAllPages]["Permission"]))
                                                                                                    {
                                                                                                        radMenuItemParkingContracts.Items[targetMenuItems3].Visibility = ElementVisibility.Visible;
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        radMenuItemParkingContracts.Items[targetMenuItems3].Visibility = ElementVisibility.Collapsed;
                                                                                                    }
                                                                                                }


                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    break;
                                                                            }
                                                                        }
                                                                    }
                                                                    break;
                                                                #endregion

                                                                #region REPORTS
                                                                case "radPanel4":
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
                                                                                case "radMenu4":
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
                                                                                        RadMenuItem targetMenuItem = RadMenu.Items["radMenuItemReports"] as RadMenuItem;

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
                                                                #endregion

                                                                #region PAYMENTS
                                                                case "radPanel5":
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
                                                                                case "radMenu5":
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
                                                                                        RadMenuItem targetMenuItem = RadMenu.Items["radMenuItemPayments"] as RadMenuItem;

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
                                                                #endregion

                                                                #region COMPUTATION
                                                                case "radPanel6":
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
                                                                                case "radMenu6":
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
                                                                                        RadMenuItem radMenuItemContracts = RadMenu.Items["radMenuItemComputation"] as RadMenuItem;

                                                                                        for (int targetMenuItems = 0; targetMenuItems < radMenuItemContracts.Items.Count; targetMenuItems++)
                                                                                        {
                                                                                            if (Convert.ToString(dvView[iAllPages]["ControlName"]) == radMenuItemContracts.Items[targetMenuItems].Name)
                                                                                            {
                                                                                                if (Convert.ToBoolean(dvView[iAllPages]["Permission"]))
                                                                                                {
                                                                                                    radMenuItemContracts.Items[targetMenuItems].Visibility = ElementVisibility.Visible;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    radMenuItemContracts.Items[targetMenuItems].Visibility = ElementVisibility.Collapsed;
                                                                                                }
                                                                                            }

                                                                                            RadMenuItem radMenuItemUnitContracts = radMenuItemContracts.Items["radMenuGenerateComputation"] as RadMenuItem;

                                                                                            for (int targetMenuItems2 = 0; targetMenuItems2 < radMenuItemUnitContracts.Items.Count; targetMenuItems2++)
                                                                                            {

                                                                                                if (Convert.ToString(dvView[iAllPages]["ControlName"]) == radMenuItemUnitContracts.Items[targetMenuItems2].Name)
                                                                                                {
                                                                                                    if (Convert.ToBoolean(dvView[iAllPages]["Permission"]))
                                                                                                    {
                                                                                                        radMenuItemUnitContracts.Items[targetMenuItems2].Visibility = ElementVisibility.Visible;
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        radMenuItemUnitContracts.Items[targetMenuItems2].Visibility = ElementVisibility.Collapsed;
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    break;
                                                                            }
                                                                        }
                                                                    }
                                                                    break;
                                                                #endregion

                                                                #region ADMINISTRATIVE
                                                                case "radPanel7":
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
                                                                                case "radMenu7":
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
                                                                                        RadMenuItem radMenuItemContracts = RadMenu.Items["radMenuItemAdministrative"] as RadMenuItem;

                                                                                        for (int targetMenuItems = 0; targetMenuItems < radMenuItemContracts.Items.Count; targetMenuItems++)
                                                                                        {
                                                                                            if (Convert.ToString(dvView[iAllPages]["ControlName"]) == radMenuItemContracts.Items[targetMenuItems].Name)
                                                                                            {
                                                                                                if (Convert.ToBoolean(dvView[iAllPages]["Permission"]))
                                                                                                {
                                                                                                    radMenuItemContracts.Items[targetMenuItems].Visibility = ElementVisibility.Visible;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    radMenuItemContracts.Items[targetMenuItems].Visibility = ElementVisibility.Collapsed;
                                                                                                }
                                                                                            }

                                                                                            RadMenuItem radMenuItemRates2 = radMenuItemContracts.Items["radMenuItemRates2"] as RadMenuItem;

                                                                                            for (int targetMenuItems2 = 0; targetMenuItems2 < radMenuItemRates2.Items.Count; targetMenuItems2++)
                                                                                            {

                                                                                                if (Convert.ToString(dvView[iAllPages]["ControlName"]) == radMenuItemRates2.Items[targetMenuItems2].Name)
                                                                                                {
                                                                                                    if (Convert.ToBoolean(dvView[iAllPages]["Permission"]))
                                                                                                    {
                                                                                                        radMenuItemRates2.Items[targetMenuItems2].Visibility = ElementVisibility.Visible;
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        radMenuItemRates2.Items[targetMenuItems2].Visibility = ElementVisibility.Collapsed;
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    break;
                                                                            }
                                                                        }
                                                                    }
                                                                    break;
                                                                #endregion

                                                                #region SECURITY
                                                                case "radPanel9":
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
                                                                                case "radMenu8":
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
                                                                                        RadMenuItem targetMenuItem = RadMenu.Items["radMenuItemSecurity"] as RadMenuItem;

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
                                                                #endregion

                                                                #region PURCHASE ITEM
                                                                case "radPanel10":
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
                                                                                case "radMenu9":
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
                                                                                        RadMenuItem targetMenuItem = RadMenu.Items["radMenuItemPurchaseItem"] as RadMenuItem;

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
                                                                    #endregion
                                                            }
                                                        }
                                                    }
                                                    break;
                                            }
                                        }
                                    }
                                }
                                break;
                        }
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
        public static void SpecialSecurityControls(Control _ctrl)
        {
            DataTable dtTable = new DataTable();
            DataView dvView;
            using (SecurityControlContext mngrSecurityManager = new SecurityControlContext())
            {
                using (DataSet ds = mngrSecurityManager.GetSpecialControls(Variables.UserID))
                {
                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        dtTable = ds.Tables[0];
                }
            }

            int len = _ctrl.GetType().ToString().Length - _ctrl.GetType().ToString().LastIndexOf('.');
            string vName = _ctrl.GetType().ToString().Substring(_ctrl.GetType().ToString().LastIndexOf('.') + 1, len - 1);

            if (vName == "frmClientInformation")
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
           
            dtTable = null;
            dvView = null;
        }
        public static void LogError(string procedureName, string FormName, string errorMessage, DateTime logDateTime, Control _ctrl)
        {
            string vName = string.Empty;
            if (_ctrl != null)
            {
                int len = _ctrl.GetType().ToString().Length - _ctrl.GetType().ToString().LastIndexOf('.');
                vName = _ctrl.GetType().ToString().Substring(_ctrl.GetType().ToString().LastIndexOf('.') + 1, len - 1);
            }

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
        public static void LogEvent(string EventType, string EventMessage)
        {
            //Control _ctrl
            //string vName = string.Empty;
            //if (_ctrl != null)
            //{
            //    int len = _ctrl.GetType().ToString().Length - _ctrl.GetType().ToString().LastIndexOf('.');
            //    vName = _ctrl.GetType().ToString().Substring(_ctrl.GetType().ToString().LastIndexOf('.') + 1, len - 1);
            //}
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString()))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("sp_LogEvent", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        // Add parameters
                        command.Parameters.AddWithValue("@EventType", EventType);
                        command.Parameters.AddWithValue("@EventMessage", EventMessage);
                        command.Parameters.AddWithValue("@UserId", Variables.UserID);
                        command.Parameters.AddWithValue("@ComputerName", Environment.MachineName);
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
            radDesktopAlert1.AutoCloseDelay = 10;
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
        public static void GetReceiptReport(string report, Form frm, bool IsPreview, string TranID, string Mode, string PaymentLevel)
        {

            try
            {
                Cursor.Current = Cursors.AppStarting;
                CrystalDecisions.CrystalReports.Engine.ReportDocument locRptDocument = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
                locRptDocument.Load(report);
                locRptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.DefaultPaperSize;
                locRptDocument.SetParameterValue("@TranID", TranID);
                locRptDocument.SetParameterValue("@Mode", Mode);
                locRptDocument.SetParameterValue("@PaymentLevel", PaymentLevel);
                ConnectionInfo crConnectionInfo = new ConnectionInfo();
                crConnectionInfo.ServerName = Config.SqlServerName;
                crConnectionInfo.DatabaseName = Config.SqlDatabaseName;
                crConnectionInfo.UserID = Config.SqlUserID;
                crConnectionInfo.Password = Config.SqlPassword;
                Tables CrTables = locRptDocument.Database.Tables;
                CrTables = locRptDocument.Database.Tables;
                foreach (CrystalDecisions.CrystalReports.Engine.Table CrTable in CrTables)
                {
                    TableLogOnInfo crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo.ConnectionInfo = crConnectionInfo;
                    CrTable.ApplyLogOnInfo(crtableLogoninfo);
                }
                CrystalReportViewer crv = new CrystalReportViewer();
                if (IsPreview)
                {
                    crv.Dock = DockStyle.Fill;
                    crv.ReportSource = locRptDocument;
                    crv.Refresh();
                    frm.Controls.Add(crv);
                    frm.WindowState = FormWindowState.Maximized;
                    frm.Show();
                }
                else
                {

                    crv.ReportSource = locRptDocument;
                    frm.Opacity = 0;
                    frm.Show();
                    locRptDocument.PrintToPrinter(1, false, 1, 1);
                    frm.Close();
                }


                Cursor.Current = Cursors.Default;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }
        public static void GetMoveInAthorizationReport(string report, Form frm, bool IsPreview, string RefId)
        {

            try
            {
                Cursor.Current = Cursors.AppStarting;
                CrystalDecisions.CrystalReports.Engine.ReportDocument locRptDocument = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
                locRptDocument.Load(report);
                locRptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.DefaultPaperSize;
                locRptDocument.SetParameterValue("@RefId", RefId);
                //locRptDocument.SetParameterValue("@Encounter_No", "");
                ConnectionInfo crConnectionInfo = new ConnectionInfo();
                crConnectionInfo.ServerName = Config.SqlServerName;
                crConnectionInfo.DatabaseName = Config.SqlDatabaseName;
                crConnectionInfo.UserID = Config.SqlUserID;
                crConnectionInfo.Password = Config.SqlPassword;
                Tables CrTables = locRptDocument.Database.Tables;
                CrTables = locRptDocument.Database.Tables;
                foreach (CrystalDecisions.CrystalReports.Engine.Table CrTable in CrTables)
                {
                    TableLogOnInfo crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo.ConnectionInfo = crConnectionInfo;
                    CrTable.ApplyLogOnInfo(crtableLogoninfo);
                }
                CrystalReportViewer crv = new CrystalReportViewer();
                if (IsPreview)
                {
                    crv.Dock = DockStyle.Fill;
                    crv.ReportSource = locRptDocument;
                    crv.Refresh();
                    frm.Controls.Add(crv);
                    frm.WindowState = FormWindowState.Maximized;
                    frm.Show();
                }
                else
                {

                    crv.ReportSource = locRptDocument;
                    frm.Opacity = 0;
                    frm.Show();
                    locRptDocument.PrintToPrinter(1, false, 1, 1);
                    frm.Close();
                }


                Cursor.Current = Cursors.Default;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }
        public static void GetContractSignedResidentialReport(string report, Form frm, bool IsPreview, string RefId)
        {

            try
            {
                Cursor.Current = Cursors.AppStarting;
                CrystalDecisions.CrystalReports.Engine.ReportDocument locRptDocument = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
                locRptDocument.Load(report);
                locRptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.DefaultPaperSize;
                locRptDocument.SetParameterValue("@RefId", RefId);
                //locRptDocument.SetParameterValue("@Encounter_No", "");
                ConnectionInfo crConnectionInfo = new ConnectionInfo();
                crConnectionInfo.ServerName = Config.SqlServerName;
                crConnectionInfo.DatabaseName = Config.SqlDatabaseName;
                crConnectionInfo.UserID = Config.SqlUserID;
                crConnectionInfo.Password = Config.SqlPassword;
                Tables CrTables = locRptDocument.Database.Tables;
                CrTables = locRptDocument.Database.Tables;
                foreach (CrystalDecisions.CrystalReports.Engine.Table CrTable in CrTables)
                {
                    TableLogOnInfo crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo.ConnectionInfo = crConnectionInfo;
                    CrTable.ApplyLogOnInfo(crtableLogoninfo);
                }
                CrystalReportViewer crv = new CrystalReportViewer();
                if (IsPreview)
                {
                    crv.Dock = DockStyle.Fill;
                    crv.ReportSource = locRptDocument;
                    crv.Refresh();
                    frm.Controls.Add(crv);
                    frm.WindowState = FormWindowState.Maximized;
                    frm.Show();
                }
                else
                {

                    crv.ReportSource = locRptDocument;
                    frm.Opacity = 0;
                    frm.Show();
                    locRptDocument.PrintToPrinter(1, false, 1, 1);
                    frm.Close();
                }


                Cursor.Current = Cursors.Default;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }
        public static void GetContractSignedParkingReport(string report, Form frm, bool IsPreview, string RefId)
        {

            try
            {
                Cursor.Current = Cursors.AppStarting;
                CrystalDecisions.CrystalReports.Engine.ReportDocument locRptDocument = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
                locRptDocument.Load(report);
                locRptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.DefaultPaperSize;
                locRptDocument.SetParameterValue("@RefId", RefId);
                //locRptDocument.SetParameterValue("@Encounter_No", "");
                ConnectionInfo crConnectionInfo = new ConnectionInfo();
                crConnectionInfo.ServerName = Config.SqlServerName;
                crConnectionInfo.DatabaseName = Config.SqlDatabaseName;
                crConnectionInfo.UserID = Config.SqlUserID;
                crConnectionInfo.Password = Config.SqlPassword;
                Tables CrTables = locRptDocument.Database.Tables;
                CrTables = locRptDocument.Database.Tables;
                foreach (CrystalDecisions.CrystalReports.Engine.Table CrTable in CrTables)
                {
                    TableLogOnInfo crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo.ConnectionInfo = crConnectionInfo;
                    CrTable.ApplyLogOnInfo(crtableLogoninfo);
                }
                CrystalReportViewer crv = new CrystalReportViewer();
                if (IsPreview)
                {
                    crv.Dock = DockStyle.Fill;
                    crv.ReportSource = locRptDocument;
                    crv.Refresh();
                    frm.Controls.Add(crv);
                    frm.WindowState = FormWindowState.Maximized;
                    frm.Show();
                }
                else
                {

                    crv.ReportSource = locRptDocument;
                    frm.Opacity = 0;
                    frm.Show();
                    locRptDocument.PrintToPrinter(1, false, 1, 1);
                    frm.Close();
                }


                Cursor.Current = Cursors.Default;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }
        public static void GetContractSignedWareHouseReport(string report, Form frm, bool IsPreview, string RefId)
        {

            try
            {
                Cursor.Current = Cursors.AppStarting;
                CrystalDecisions.CrystalReports.Engine.ReportDocument locRptDocument = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
                locRptDocument.Load(report);
                locRptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.DefaultPaperSize;
                locRptDocument.SetParameterValue("@RefId", RefId);
                //locRptDocument.SetParameterValue("@Encounter_No", "");
                ConnectionInfo crConnectionInfo = new ConnectionInfo();
                crConnectionInfo.ServerName = Config.SqlServerName;
                crConnectionInfo.DatabaseName = Config.SqlDatabaseName;
                crConnectionInfo.UserID = Config.SqlUserID;
                crConnectionInfo.Password = Config.SqlPassword;
                Tables CrTables = locRptDocument.Database.Tables;
                CrTables = locRptDocument.Database.Tables;
                foreach (CrystalDecisions.CrystalReports.Engine.Table CrTable in CrTables)
                {
                    TableLogOnInfo crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo.ConnectionInfo = crConnectionInfo;
                    CrTable.ApplyLogOnInfo(crtableLogoninfo);
                }
                CrystalReportViewer crv = new CrystalReportViewer();
                if (IsPreview)
                {
                    crv.Dock = DockStyle.Fill;
                    crv.ReportSource = locRptDocument;
                    crv.Refresh();
                    frm.Controls.Add(crv);
                    frm.WindowState = FormWindowState.Maximized;
                    frm.Show();
                }
                else
                {

                    crv.ReportSource = locRptDocument;
                    frm.Opacity = 0;
                    frm.Show();
                    locRptDocument.PrintToPrinter(1, false, 1, 1);
                    frm.Close();
                }


                Cursor.Current = Cursors.Default;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }
        public static void GetContractSignedCommercialReport(string report, Form frm, bool IsPreview, string RefId)
        {

            try
            {
                Cursor.Current = Cursors.AppStarting;
                CrystalDecisions.CrystalReports.Engine.ReportDocument locRptDocument = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
                locRptDocument.Load(report);
                locRptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.DefaultPaperSize;
                locRptDocument.SetParameterValue("@RefId", RefId);
                //locRptDocument.SetParameterValue("@Encounter_No", "");
                ConnectionInfo crConnectionInfo = new ConnectionInfo();
                crConnectionInfo.ServerName = Config.SqlServerName;
                crConnectionInfo.DatabaseName = Config.SqlDatabaseName;
                crConnectionInfo.UserID = Config.SqlUserID;
                crConnectionInfo.Password = Config.SqlPassword;
                Tables CrTables = locRptDocument.Database.Tables;
                CrTables = locRptDocument.Database.Tables;
                foreach (CrystalDecisions.CrystalReports.Engine.Table CrTable in CrTables)
                {
                    TableLogOnInfo crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo.ConnectionInfo = crConnectionInfo;
                    CrTable.ApplyLogOnInfo(crtableLogoninfo);
                }
                CrystalReportViewer crv = new CrystalReportViewer();
                if (IsPreview)
                {
                    crv.Dock = DockStyle.Fill;
                    crv.ReportSource = locRptDocument;
                    crv.Refresh();
                    frm.Controls.Add(crv);
                    frm.WindowState = FormWindowState.Maximized;
                    frm.Show();
                }
                else
                {

                    crv.ReportSource = locRptDocument;
                    frm.Opacity = 0;
                    frm.Show();
                    locRptDocument.PrintToPrinter(1, false, 1, 1);
                    frm.Close();
                }


                Cursor.Current = Cursors.Default;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }
        public static void GetGeneralReport(string report, Form frm, bool IsPreview, string RefId)
        {

            try
            {
                Cursor.Current = Cursors.AppStarting;
                CrystalDecisions.CrystalReports.Engine.ReportDocument locRptDocument = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
                locRptDocument.Load(report);
                locRptDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.DefaultPaperSize;
                //locRptDocument.SetParameterValue("@RefId", RefId);
                //locRptDocument.SetParameterValue("@Encounter_No", "");
                ConnectionInfo crConnectionInfo = new ConnectionInfo();
                crConnectionInfo.ServerName = Config.SqlServerName;
                crConnectionInfo.DatabaseName = Config.SqlDatabaseName;
                crConnectionInfo.UserID = Config.SqlUserID;
                crConnectionInfo.Password = Config.SqlPassword;
                Tables CrTables = locRptDocument.Database.Tables;
                CrTables = locRptDocument.Database.Tables;
                foreach (CrystalDecisions.CrystalReports.Engine.Table CrTable in CrTables)
                {
                    TableLogOnInfo crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo.ConnectionInfo = crConnectionInfo;
                    CrTable.ApplyLogOnInfo(crtableLogoninfo);
                }
                CrystalReportViewer crv = new CrystalReportViewer();
                if (IsPreview)
                {
                    crv.Dock = DockStyle.Fill;
                    crv.ReportSource = locRptDocument;
                    crv.Refresh();
                    frm.Controls.Add(crv);
                    frm.WindowState = FormWindowState.Maximized;
                    frm.Show();
                }
                else
                {

                    crv.ReportSource = locRptDocument;
                    frm.Opacity = 0;
                    frm.Show();
                    locRptDocument.PrintToPrinter(1, false, 1, 1);
                    frm.Close();
                }


                Cursor.Current = Cursors.Default;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }
        public static DialogResult MessageShow(string message)
        {
            return MessageBox.Show(message, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        public static DialogResult ErrorShow(string functionName, string errorMessage)
        {
            return MessageBox.Show($"An error occurred from {functionName} - {errorMessage} Please check the [ErrorLog] ", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        public static DialogResult MessageConfirm(string message)
        {
            return MessageBox.Show(message, "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2);
        }

        public static int ConvertStringToInt(string amountString)
        {
            if (string.IsNullOrEmpty(amountString) || string.IsNullOrWhiteSpace(amountString) || amountString == "0" || amountString == "0.00")
            {
                return 0;
            }
            return int.Parse(amountString);
        }

        public static decimal ConvertStringToDecimal(string amountString)
        {
            if (string.IsNullOrEmpty(amountString) || string.IsNullOrWhiteSpace(amountString)  || amountString == "0" || amountString == "0.00")
            {
                return 0;
            }
            return decimal.Parse(amountString);
        }
    }
}
