namespace LEASING.UI.APP.Forms
{
    partial class frmPostDatedCheckMonthsList
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn1 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn2 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            this.dgvList = new Telerik.WinControls.UI.RadGridView();
            ((System.ComponentModel.ISupportInitialize)(this.dgvList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvList.MasterTemplate)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvList
            // 
            this.dgvList.BackColor = System.Drawing.SystemColors.Control;
            this.dgvList.Cursor = System.Windows.Forms.Cursors.Default;
            this.dgvList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvList.Font = new System.Drawing.Font("Segoe UI", 8.25F);
            this.dgvList.ForeColor = System.Drawing.SystemColors.ControlText;
            this.dgvList.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.dgvList.Location = new System.Drawing.Point(0, 0);
            // 
            // dgvList
            // 
            this.dgvList.MasterTemplate.AllowAddNewRow = false;
            this.dgvList.MasterTemplate.AllowColumnReorder = false;
            gridViewTextBoxColumn1.EnableExpressionEditor = false;
            gridViewTextBoxColumn1.FieldName = "seq";
            gridViewTextBoxColumn1.HeaderText = "Seq.";
            gridViewTextBoxColumn1.Name = "seq";
            gridViewTextBoxColumn2.EnableExpressionEditor = false;
            gridViewTextBoxColumn2.FieldName = "Dates";
            gridViewTextBoxColumn2.HeaderText = "Months";
            gridViewTextBoxColumn2.Name = "Dates";
            gridViewTextBoxColumn2.Width = 120;
            this.dgvList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewTextBoxColumn1,
            gridViewTextBoxColumn2});
            this.dgvList.MasterTemplate.ShowRowHeaderColumn = false;
            this.dgvList.Name = "dgvList";
            this.dgvList.ReadOnly = true;
            this.dgvList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvList.ShowGroupPanel = false;
            this.dgvList.Size = new System.Drawing.Size(173, 328);
            this.dgvList.TabIndex = 0;
            this.dgvList.Text = "radGridView1";
            this.dgvList.CellDoubleClick += new Telerik.WinControls.UI.GridViewCellEventHandler(this.dgvList_CellDoubleClick);
            // 
            // frmPostDatedCheckMonthsList
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(173, 328);
            this.Controls.Add(this.dgvList);
            this.DoubleBuffered = true;
            this.Name = "frmPostDatedCheckMonthsList";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Months List";
            this.Load += new System.EventHandler(this.frmPostDatedCheckMonthsList_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Telerik.WinControls.UI.RadGridView dgvList;
    }
}