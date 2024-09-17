using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmTenantMoveUnit : Form
    {
        public string sRefId { get; set; } = string.Empty;
        private ClientContext _client;
        PaymentContext PaymentContext = new PaymentContext();
        UnitContext UnitContext = new UnitContext();
        public frmTenantMoveUnit()
        {
            _client = new ClientContext();
            InitializeComponent();
        }

        private void M_GetForMoveInUnitList()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = PaymentContext.GetForMoveInUnitList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetForMoveInUnitList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetForMoveInUnitList()", ex.ToString());
            }

        }
        private void frmTenantMoveUnit_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            M_GetForMoveInUnitList();
        }
        private void btnRefresh_Click(object sender, EventArgs e)
        {
            M_GetForMoveInUnitList();
        }
        private void _getContractProjectTypeReport(string refid)
        {
            try
            {
                using (DataSet dt = _client.GetCheckContractProjectType(refid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        if (Convert.ToString(dt.Tables[0].Rows[0]["UnitType"]) == "UNIT")
                        {
                            if (Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]) == "RESIDENTIAL")
                            {
                                frmContractSingedResidentialReport contractResidential = new frmContractSingedResidentialReport(refid);
                                contractResidential.Show();
                            }
                            else if (Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]) == "COMMERCIAL")
                            {
                                frmContractSingedCommercialReport contractCommercial = new frmContractSingedCommercialReport(refid);
                                contractCommercial.Show();
                            }
                            else
                            {
                                frmContractSingedWareHouseReport contractWareHouse = new frmContractSingedWareHouseReport(refid);
                                contractWareHouse.Show();
                            }
                        }
                        else
                        {
                            frmContractSingedParkingReport parking = new frmContractSingedParkingReport(refid);
                            parking.Show();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("_getContractProjectTypeReport()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("_getContractProjectTypeReport()", ex.ToString());
            }
        }
        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColApproved")
                {

                    if (MessageBox.Show("Are you sure you want tag this as Move-in?", "", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        try
                        {
                            string result = UnitContext.MovedIn(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value));
                            if (result.Equals("SUCCESS"))
                            {
                                MessageBox.Show("Move-In Successfully! ", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                M_GetForMoveInUnitList();
                            }
                            else
                            {
                                MessageBox.Show(result, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            }
                        }
                        catch (Exception ex)
                        {
                            Functions.LogError("Cell Click : ColApproved", this.Text, ex.ToString(), DateTime.Now, this);
                            Functions.ErrorShow("Cell Click : ColApproved", ex.ToString());
                        }
                    }
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColView")
                {
                    frmEditUnitComputation forms = new frmEditUnitComputation();
                    forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                    forms.ShowDialog();
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColContract")
                {
                    if (dgvList.Rows.Count > 0)
                    {
                        this._getContractProjectTypeReport(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value));
                    }
                }
            }
        }

        private void btnPrintAuthorization_Click(object sender, EventArgs e)
        {//RefId
            if (dgvList.Rows.Count > 0)
            {
                if (!string.IsNullOrEmpty(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value)))
                {
                    frmMoveInAuthorizationReport MoveIn = new frmMoveInAuthorizationReport(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value));
                    MoveIn.Show();
                }
            }
        }
    }
}
