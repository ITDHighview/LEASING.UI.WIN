using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Telerik.WinControls;
using Telerik.WinControls.UI;

namespace LEASING.UI.APP.Forms
{
    public partial class ContractPenaltyList : Form
    {
        private PaymentContext _payment;

        public int contractid { get; set; } = 0;
        public string SelectedMonthToWaive { get; set; } = string.Empty;
        public ContractPenaltyList()
        {
            _payment = new PaymentContext();
            InitializeComponent();
        }







        private void GetForPenaltyMonthList()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = _payment.GetForPenaltyMonthList(contractid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetForPenaltyMonthList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetForPenaltyMonthList()", ex.ToString());
            }

        }

        private void ContractPenaltyList_Load(object sender, EventArgs e)
        {
            GetForPenaltyMonthList();
        }

        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColWaivePenalty")
                {
                    SelectedMonthToWaive = Convert.ToString(dgvList.CurrentRow.Cells["SelectLedgMonth"].Value);
                    PenaltyWaiveDetails form = new PenaltyWaiveDetails(this.contractid, SelectedMonthToWaive);
                    form.ShowDialog();
                }
            }
        }

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
        private string M_getXMLData()
        {
            StringBuilder sbPayment = new StringBuilder();
            ArrayList alAdvancePayment = new ArrayList();
            this.dgvList.BeginEdit();

            for (int iRow = 0; iRow < dgvList.Rows.Count; iRow++)
            {
                //if (Convert.ToBoolean(this.dgvList.Rows[iRow].Cells["ColCheck"].Value) && (Convert.ToString(this.dgvList.Rows[iRow].Cells["PaymentStatus"].Value) == "PENDING" || Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "HOLD" || Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "DUE"))
                //{
                //alDoctorSchedule.Add(Convert.ToString(vMasterRecordID));

                if (Convert.ToBoolean(this.dgvList.Rows[iRow].Cells["chkSelectMonth"].Value))
                {
                    alAdvancePayment.Add(Convert.ToString(this.dgvList.Rows[iRow].Cells["SelectLedgMonth"].Value));
                    sbPayment.Append(SetXMLTable(ref alAdvancePayment));
                }

                //}
            }


            return sbPayment.ToString();
        }
        #endregion


        string SaveResult = string.Empty;
        private void savePenaltyGeneration(string date)
        {
            try
            {
                SaveResult = _payment.ApplyBulkPenalty(date, contractid);
            }
            catch (Exception ex)
            {
                Functions.LogError("savePenaltyGeneration()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("savePenaltyGeneration()", ex.ToString());
            }
        }
        private bool IsGridCheckboxCheck()
        {
            dgvList.EndEdit();
            foreach (GridViewRowInfo row in dgvList.Rows)
            {
                GridViewCellInfo cell = row.Cells["chkSelectMonth"] as GridViewCellInfo;
                if (Convert.ToBoolean(cell.Value))
                {
                    return true;
                }
               
            }
            return false;
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (IsGridCheckboxCheck() == true)
            {
                if (Functions.MessageConfirm("Are you sure you want to generate a penalty for following selected Month?") == DialogResult.Yes)
                {
                    Functions.ShowLoadingBar("Processing...");
                    for (int iRow = 0; iRow < dgvList.Rows.Count; iRow++)
                    {
                        if (Convert.ToBoolean(this.dgvList.Rows[iRow].Cells["chkSelectMonth"].Value))
                        {
                            savePenaltyGeneration(Convert.ToString(this.dgvList.Rows[iRow].Cells["SelectLedgMonth"].Value));
                        }

                    }

                    if (SaveResult.Equals("SUCCESS"))
                    {
                        Functions.MessageShow($"Generate :  SUCCESS");
                        GetForPenaltyMonthList();
                    }
                    else
                    {
                        Functions.MessageShow(SaveResult);
                    }
                }
            }
            else
            {
                Functions.MessageShow("Please Select Month");
            }
            
        }

        private void dgvList_CellFormatting(object sender, Telerik.WinControls.UI.CellFormattingEventArgs e)
        {
            //if (!string.IsNullOrEmpty(Convert.ToString(this.dgvList.Rows[e.RowIndex].Cells["PaymentStatus"].Value)))
            //{
            if (Convert.ToString(this.dgvList.Rows[e.RowIndex].Cells["IsForMonthlyPenalty"].Value) == "YES" && Convert.ToString(this.dgvList.Rows[e.RowIndex].Cells["IsPenaltyApplied"].Value) == "YES")
            {
                e.CellElement.ForeColor = Color.White;
                //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);
                e.CellElement.DrawFill = true;
                e.CellElement.GradientStyle = GradientStyles.Solid;
                e.CellElement.BackColor = Color.Green;
                this.dgvList.Rows[e.RowIndex].Cells["chkSelectMonth"].ReadOnly = true;
                //this.dgvLedgerList.Rows[e.RowIndex].Cells["ColCheck"].Style.DrawFill = true;
            }
            else if (Convert.ToString(this.dgvList.Rows[e.RowIndex].Cells["IsForMonthlyPenalty"].Value) == "YES" && Convert.ToString(this.dgvList.Rows[e.RowIndex].Cells["IsPenaltyApplied"].Value) == "NO")
            {
                e.CellElement.ForeColor = Color.Black;
                e.CellElement.DrawFill = true;
                e.CellElement.GradientStyle = GradientStyles.Solid;
                e.CellElement.BackColor = Color.Yellow;
                this.dgvList.Rows[e.RowIndex].Cells["chkSelectMonth"].ReadOnly = false;
            }
            //}

            if (e.CellElement.ColumnInfo is GridViewCommandColumn && !(e.CellElement.RowElement is GridTableHeaderRowElement))
            {
                GridViewCommandColumn column = (GridViewCommandColumn)e.CellElement.ColumnInfo;
                RadButtonElement element = (RadButtonElement)e.CellElement.Children[0];
                (element.Children[2] as Telerik.WinControls.Primitives.BorderPrimitive).Visibility =
                Telerik.WinControls.ElementVisibility.Collapsed;
                element.DisplayStyle = DisplayStyle.Image;
                element.ImageAlignment = ContentAlignment.MiddleCenter;
                element.Enabled = true;
                element.Alignment = ContentAlignment.MiddleCenter;
                element.Visibility = ElementVisibility.Visible;
                if (column.Name == "ColWaivePenalty")
                {
                    if (Convert.ToString(this.dgvList.Rows[e.RowIndex].Cells["IsForMonthlyPenalty"].Value) == "YES" && Convert.ToString(this.dgvList.Rows[e.RowIndex].Cells["IsPenaltyApplied"].Value) == "YES")
                    {
                        //element.ImageAlignment = ContentAlignment.MiddleCenter;
                        //element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //element.Text = "Un-Map";
                        element.Image = Properties.Resources.ico_edit;
                        element.ToolTipText = "Waive Penalty Option is Available";
                        element.Enabled = true;                       
                    }
                    else
                    {
                        //element.ImageAlignment = ContentAlignment.MiddleCenter;
                        //element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //element.Text = "Un-Map";
                        element.Image = Properties.Resources.cancel16;
                        element.ToolTipText = "This button is disabled";
                        element.Enabled = false;
                    }
                }
            }
        }
    }
}
