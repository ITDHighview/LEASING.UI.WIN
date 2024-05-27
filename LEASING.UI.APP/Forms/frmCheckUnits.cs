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
using Telerik.WinControls;

namespace LEASING.UI.APP.Forms
{
    public partial class frmCheckUnits : Form
    {
        private UnitContext _unit;
        public frmCheckUnits()
        {
            _unit = new UnitContext();
            InitializeComponent();
        }
        public int Recid { get; set; }
        private void M_GetUnitByProjectId()
        {
            try
            {
                dgvUnitList.DataSource = null;
                using (DataSet dt = _unit.GetUnitByProjectId(Recid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvUnitList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetUnitByProjectId()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetUnitByProjectId()", ex.ToString());
            }
        }
        private void frmCheckUnits_Load(object sender, EventArgs e)
        {
            M_GetUnitByProjectId();
        }
        private void dgvUnitList_CellFormatting(object sender, Telerik.WinControls.UI.CellFormattingEventArgs e)
        {
            if (!string.IsNullOrEmpty(Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStatus"].Value)))
            {
                if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStatus"].Value) == "VACANT")
                {
                    //e.CellElement.ForeColor = Color.Green;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.ForeColor = Color.Black;
                    e.CellElement.BackColor = Color.Yellow;
                }
                else if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStat"].Value) == "RESERVED")
                {
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.ForeColor = Color.Black;
                    e.CellElement.BackColor = Color.LightSkyBlue;
                }
                else if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStatus"].Value) == "OCCUPIED")
                {
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.ForeColor = Color.Black;
                    e.CellElement.BackColor = Color.LightGreen;
                }
                else if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStatus"].Value) == "NOT AVAILABLE")
                {
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.ForeColor = Color.Black;
                    e.CellElement.BackColor = Color.LightSalmon;

                }
                else if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStatus"].Value) == "HOLD")
                {
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.ForeColor = Color.White;
                    e.CellElement.BackColor = Color.Red;
                }
            }
        }
    }
}
