using LEASING.UI.APP.Common;
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

namespace LEASING.UI.APP.Forms
{
    public partial class ForContractSignedUnitBrowse : Form
    {
        private ClientContext _client;
        PaymentContext PaymentContext = new PaymentContext();
        ClientContext ClientContext = new ClientContext();
        public ForContractSignedUnitBrowse()
        {
            _client = new ClientContext();
            InitializeComponent();
        }
        public bool IsContractSigned { get; set; } = true;
        public string ReferenceId { get; set; } = string.Empty;
        private void M_GetForContractSignedUnitList()
        {
            try
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
            catch (Exception ex)
            {
                Functions.LogError("M_GetForContractSignedUnitList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetForContractSignedUnitList()", ex.ToString());
            }
        }
        private void frmContractSignedUnit_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            M_GetForContractSignedUnitList();
        }
        private void btnRefresh_Click(object sender, EventArgs e)
        {
            M_GetForContractSignedUnitList();
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
                                ContractSingedResidentialReport contractResidential = new ContractSingedResidentialReport(refid);
                                contractResidential.Show();
                            }
                            else if (Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]) == "COMMERCIAL")
                            {
                                ContractSingedCommercialReport contractCommercial = new ContractSingedCommercialReport(refid);
                                contractCommercial.Show();
                            }
                            else
                            {
                                ContractSingedWareHouseReport contractWareHouse = new ContractSingedWareHouseReport(refid);
                                contractWareHouse.Show();
                            }
                        }
                        else
                        {
                            ContractSingedParkingReport parking = new ContractSingedParkingReport(refid);
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
                    EditClientForm forms = new EditClientForm();
                    forms.ClientID = Convert.ToString(dgvList.CurrentRow.Cells["ClientID"].Value);
                    forms.IsContractSigned = IsContractSigned;
                    forms.ReferenceId = Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value);
                    forms.ShowDialog();
                    M_GetForContractSignedUnitList();                                    
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColByPass")
                {
                    if (MessageBox.Show("Are you sure you want to approved?", "System Message",MessageBoxButtons.YesNo,MessageBoxIcon.Question,MessageBoxDefaultButton.Button2)== DialogResult.Yes)
                    {
                        try
                        {
                            var result = ClientContext.ConrtactSignedByPass(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value));
                            if (result.Equals("SUCCESS"))
                            {
                                MessageBox.Show("Approved Successfully!", "System Message");
                                M_GetForContractSignedUnitList();
                            }
                            else
                            {
                                MessageBox.Show(result, "System Message");
                            }
                        }
                        catch (Exception ex)
                        {
                            Functions.LogError("Cell Click : ColByPass", this.Text, ex.ToString(), DateTime.Now, this);
                            Functions.ErrorShow("Cell Click : ColByPass", ex.ToString());
                        }
                    }
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColView")
                {
                    ViewContractUnitInfo forms = new ViewContractUnitInfo();
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
    }
}
