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
    public partial class frmPostDatedCheckMonthsList : Form
    {
        ComputationContext ComputationContext = new ComputationContext();
        public bool isProceed = false;
        public string sFromDate { get; set; } = string.Empty;
        public string sEndDate { get; set; } = string.Empty;
        public string sXML { get; set; } = string.Empty;
        public string SelectedDate { get; set; } = string.Empty;
        public frmPostDatedCheckMonthsList(string FromDate, string EndDate, string XML)
        {
            InitializeComponent();
            sFromDate = FromDate;
            sEndDate = EndDate;
            sXML = XML;
        }

        private void M_GetPostDatedMonthList()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = ComputationContext.GetPostDatedMonthList(sFromDate, sEndDate, sXML))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetPostDatedMonthList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetPostDatedMonthList()", ex.ToString());
            }

        }

        private void frmPostDatedCheckMonthsList_Load(object sender, EventArgs e)
        {
            M_GetPostDatedMonthList();
        }

        private void dgvList_CellDoubleClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            //if (!string.IsNullOrEmpty(sFromDate) && !string.IsNullOrEmpty(sEndDate))
            //{
            isProceed = true;
            SelectedDate = Convert.ToString(dgvList.CurrentRow.Cells["Dates"].Value);
            this.Close();
            //}        
        }
    }
}
