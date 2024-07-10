using LEASING.UI.APP.Common;
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
    public partial class frmContractInquiryAdvanceSearch : Form
    {
        public frmContractInquiryAdvanceSearch()
        {
            InitializeComponent();
        }
        //private void M_GetPatientList()
        //{
        //    try
        //    {
        //        dgvPatientList.DataSource = null;
        //        using (DataSet dt = ComputationContext.GetLedgerBrowseByContractIdClientId(ComputationRecid, ClientId))
        //        {
        //            if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
        //            {
        //                dgvPatientList.DataSource = dt.Tables[0];
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Functions.LogError("M_GetLedgerList()", this.Text, ex.ToString(), DateTime.Now, this);
        //        Functions.ErrorShow("M_GetLedgerList()", ex.ToString());
        //    }
        //}
        //private void M_GetContractList()
        //{
        //    try
        //    {
        //        dgvContractList.DataSource = null;
        //        using (DataSet dt = ComputationContext.GetLedgerBrowseByContractIdClientId(ComputationRecid, ClientId))
        //        {
        //            if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
        //            {
        //                dgvContractList.DataSource = dt.Tables[0];
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Functions.LogError("M_GetLedgerList()", this.Text, ex.ToString(), DateTime.Now, this);
        //        Functions.ErrorShow("M_GetLedgerList()", ex.ToString());
        //    }
        //}
    }
}
