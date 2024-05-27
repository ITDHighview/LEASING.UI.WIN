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
    public partial class frmCheckClientUnits : Form
    {
        private UnitContext _unit;
        public frmCheckClientUnits()
        {
            _unit = new UnitContext();
            InitializeComponent();
        }
        public bool IsProceed = false;
        public string ClientId { get; set; }     
        private void M_GetClientUnitList()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = _unit.GetClientUnitList(ClientId))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetClientUnitList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetClientUnitList()", ex.ToString());
            }
        }
        private void frmCheckClientUnits_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            M_GetClientUnitList();
        }
    }
}
