﻿using LEASING.UI.APP.Context;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmContractSignedUnit : Form
    {
        PaymentContext PaymentContext = new PaymentContext();
        public bool IsContractSigned { get; set; } = true;
        public frmContractSignedUnit()
        {
            InitializeComponent();
        }

        private void M_GetForContractSignedUnitList()
        {
            dgvList.DataSource = null;
            using (DataSet dt = PaymentContext.GetForContractSignedUnitList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvList.DataSource = dt.Tables[0];
                }
            }
        }

        private void frmContractSignedUnit_Load(object sender, EventArgs e)
        {
            M_GetForContractSignedUnitList();
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            M_GetForContractSignedUnitList();
        }

        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColApproved")
                {
                    frmEditClient forms = new frmEditClient();
                    forms.ClientID = Convert.ToString(dgvList.CurrentRow.Cells["ClientID"].Value);
                    forms.IsContractSigned = IsContractSigned;
                    forms.ShowDialog();
                    if (forms.IsProceed)
                    {
                        // M_GetProjectList();
                    }
                    //if (Convert.ToString(dgvList.CurrentRow.Cells["TypeOf"].Value) == "TYPE OF PARKING")
                    //{
                    //    frmEditParkingComputation forms = new frmEditParkingComputation();
                    //    forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                    //    forms.Text = Convert.ToString(dgvList.CurrentRow.Cells["ProjectName"].Value) + " - " + " UNIT";
                    //    forms.ShowDialog();
                    //}
                    //else
                    //{
                    //    frmEditUnitComputation forms = new frmEditUnitComputation();
                    //    forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                    //    forms.Text = Convert.ToString(dgvList.CurrentRow.Cells["ProjectName"].Value) + " - " + " UNIT";
                    //    forms.ShowDialog();
                    //}
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "View")
                {
                    //if (MessageBox.Show("Are you sure you want to generate transaction to this reference?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    //{
                    //    if (Convert.ToString(dgvList.CurrentRow.Cells["TypeOf"].Value) == "TYPE OF PARKING")
                    //    {
                    //        frmClientTransactionParking forms = new frmClientTransactionParking();
                    //        forms.ComputationRecid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                    //        forms.ClientId = Convert.ToString(dgvList.CurrentRow.Cells["ClientID"].Value);
                    //        forms.ShowDialog();
                    //    }
                    //    else
                    //    {
                    //        frmSelectClient forms = new frmSelectClient();
                    //        forms.ComputationRecid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                    //        forms.ShowDialog();
                            
                    //    }
                    //}
                }
            }
        }
    }
}
