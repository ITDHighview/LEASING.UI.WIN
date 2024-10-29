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
using Telerik.WinControls.UI;

namespace LEASING.UI.APP.Forms
{
    public partial class UnitsBrowse : Form
    {
        private UnitContext _unit;
        public int Recid { get; set; }
        public string UnitType { get; set; } = string.Empty;
        public UnitsBrowse()
        {
            _unit = new UnitContext();
            InitializeComponent();
        }
        private DataTable ValidateDataTable(DataSet dt)
        {
            DataTable dTable = new DataTable();
            if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
            {
                dTable = dt.Tables[0];
            }
            return dTable;
        }
        private void SetGridDataItem(RadGridView dgv, DataSet Context)
        {
            dgv.DataSource = null;
            using (DataSet dt = Context)
            {
                dgv.DataSource = this.ValidateDataTable(dt);
            }
        }
       
        private void M_GetUnitByProjectId()
        {
            try
            {
                this.SetGridDataItem(this.dgvUnitList, _unit.GetCheckUnits(this.Recid, this.UnitType));
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetUnitByProjectId()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetUnitByProjectId()", ex.ToString());
            }
        }
        private void frmCheckUnits_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
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
                else if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStat"].Value) == "MOVE-IN")
                {
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.ForeColor = Color.White;
                    e.CellElement.BackColor = Color.Green;

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
                    if (column.Name == "ColSelect")
                    {
                        if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStatus"].Value) == "VACANT")
                        {
                            //element.ImageAlignment = ContentAlignment.MiddleCenter;
                            //element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            //element.Text = "Un-Map";
                            element.Image = Properties.Resources._16_handIcon;
                            //element.ToolTipText = "This button is disabled";
                            element.Enabled = true;
                        }
                        else
                        {
                            //element.ImageAlignment = ContentAlignment.MiddleCenter;
                            //element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            //element.Text = "Un-Map";
                            element.Image = Properties.Resources.block_16;
                            element.ToolTipText = "This button is disabled";
                            element.Enabled = false;
                        }
                    }
                }
                }
        }
        public bool IsProceed = false;
        public int UnitRecId = 0;
        private void dgvUnitList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvUnitList.Columns[e.ColumnIndex].Name == "ColSelect")
                {
                    if (Convert.ToString(dgvUnitList.CurrentRow.Cells["UnitStat"].Value)== "VACANT")
                    {
                        if (Functions.MessageConfirm("Are you sure you want to select this UNIT ?") == DialogResult.Yes)
                        {
                            this.IsProceed = true;
                            this.UnitRecId = Convert.ToInt32(dgvUnitList.CurrentRow.Cells["RecId"].Value);
                            this.Close();
                        }

                    }
                    else
                    {
                        Functions.MessageShow("Only VACANT Unit is Available for selection");
                    }
                   
                }
            }
        }
    }
}
