﻿using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using System;
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
    public partial class frmClientRecieptTransaction : Form
    {
      private  ComputationContext _computation;
        public frmClientRecieptTransaction()
        {
            _computation = new ComputationContext();
            InitializeComponent();
        }
        private void M_GetContractList()
        {
            try
            {
                dgvContractList.DataSource = null;
                using (DataSet dt = _computation.GetContractList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvContractList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetContractList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetContractList()", ex.ToString());
            }
        }
        private void M_GetContractList(string refid)
        {
            try
            {
                dgvReceiptList.DataSource = null;
                using (DataSet dt = _computation.GetReceiptByRefId(refid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvReceiptList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetContractList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetContractList()", ex.ToString());
            }
        }
        private void frmClientRecieptTransaction_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            M_GetContractList();
        }
        private void dgvContractList_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvContractList.Rows.Count > 0)
            {
                M_GetContractList(Convert.ToString(dgvContractList.CurrentRow.Cells["RefId"].Value));
            }
        }
        private string GetPaymentLevel()
        {
            if (Convert.ToString(dgvReceiptList.CurrentRow.Cells["Description"].Value) == "FIRST PAYMENT")
            {
                return "FIRST";
            }
            else if (Convert.ToString(dgvReceiptList.CurrentRow.Cells["Description"].Value) == "FULL PAYMENT")
            {
                return "FIRST";
            }
            else
            {
                return "SECOND";
            }
            return "";
        }
        private void dgvReceiptList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvReceiptList.Columns[e.ColumnIndex].Name == "ColPrint")
                {
                    bool IsNoOR = false;

                    if (string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyORNo"].Value)) && !string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyPRNo"].Value)))
                    {
                        IsNoOR = true;
                    }
                    else if (!string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyORNo"].Value)) && string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyPRNo"].Value)))
                    {
                        IsNoOR = false;
                    }
                    else if (!string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyORNo"].Value)) && !string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyPRNo"].Value)))
                    {
                        IsNoOR = false;
                    }

                    if (this.GetPaymentLevel() == "FIRST")
                    {
                        frmRecieptSelection forms = new frmRecieptSelection(Convert.ToString(dgvReceiptList.CurrentRow.Cells["TranID"].Value), Convert.ToString(dgvReceiptList.CurrentRow.Cells["RefId"].Value), this.GetPaymentLevel());
                        forms.IsNoOR = IsNoOR;
                        forms.ShowDialog();
                    }
                    else
                    {
                        frmRecieptSelectionSecondPayment formsSecond = new frmRecieptSelectionSecondPayment(Convert.ToString(dgvReceiptList.CurrentRow.Cells["TranID"].Value), Convert.ToString(dgvReceiptList.CurrentRow.Cells["RefId"].Value), this.GetPaymentLevel());
                        formsSecond.IsNoOR = IsNoOR;
                        formsSecond.ShowDialog();
                    }
                }
                else if (this.dgvReceiptList.Columns[e.ColumnIndex].Name == "ColEditOR")
                {
                    if (string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyORNo"].Value)) && !string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyPRNo"].Value)))
                    {
                        frmEditORNumber forms = new frmEditORNumber();
                        forms.RcptID = Convert.ToString(dgvReceiptList.CurrentRow.Cells["RcptID"].Value);
                        forms.ShowDialog();
                        if (forms.IsProceed)
                        {
                            M_GetContractList();
                        }
                    }
                }
            }
        }
        private void dgvReceiptList_CellFormatting(object sender, Telerik.WinControls.UI.CellFormattingEventArgs e)
        {
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

                if (column.Name == "ColEditOR")
                {
                    if (string.IsNullOrEmpty(Convert.ToString(this.dgvReceiptList.Rows[e.RowIndex].Cells["CompanyORNo"].Value)))
                    {
                        //element.ImageAlignment = ContentAlignment.MiddleCenter;
                        //element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //element.Text = "Un-Map";
                        //element.Image = Properties.Resources.cancel16;
                        element.ToolTipText = "Update OR NUMBER.";
                        element.Enabled = true;
                    }
                    else
                    {
                        element.ImageAlignment = ContentAlignment.MiddleCenter;
                        element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //element.Text = "Un-Map";
                        element.Image = Properties.Resources.Remove1;
                        element.ToolTipText = "this button is disable";
                        element.Enabled = false;
                    }
                }
            }
        }
    }
}
