namespace LEASING.UI.APP.Forms
{
    partial class frmCheckUnits
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
            Telerik.WinControls.UI.GridViewCommandColumn gridViewCommandColumn3 = new Telerik.WinControls.UI.GridViewCommandColumn();
            Telerik.WinControls.UI.GridViewCommandColumn gridViewCommandColumn4 = new Telerik.WinControls.UI.GridViewCommandColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn13 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn14 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn15 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn16 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn17 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn18 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn19 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn20 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn21 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn22 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn23 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn24 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            this.radGroupBox2 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvUnitList = new Telerik.WinControls.UI.RadGridView();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).BeginInit();
            this.radGroupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvUnitList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvUnitList.MasterTemplate)).BeginInit();
            this.SuspendLayout();
            // 
            // radGroupBox2
            // 
            this.radGroupBox2.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox2.Controls.Add(this.dgvUnitList);
            this.radGroupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox2.HeaderText = "UNIT LIST";
            this.radGroupBox2.Location = new System.Drawing.Point(0, 0);
            this.radGroupBox2.Name = "radGroupBox2";
            this.radGroupBox2.Size = new System.Drawing.Size(764, 503);
            this.radGroupBox2.TabIndex = 7;
            this.radGroupBox2.Text = "UNIT LIST";
            // 
            // dgvUnitList
            // 
            this.dgvUnitList.BackColor = System.Drawing.SystemColors.Control;
            this.dgvUnitList.Cursor = System.Windows.Forms.Cursors.Default;
            this.dgvUnitList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvUnitList.Font = new System.Drawing.Font("Segoe UI", 8.25F);
            this.dgvUnitList.ForeColor = System.Drawing.Color.Black;
            this.dgvUnitList.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.dgvUnitList.Location = new System.Drawing.Point(2, 18);
            // 
            // dgvUnitList
            // 
            this.dgvUnitList.MasterTemplate.AllowAddNewRow = false;
            this.dgvUnitList.MasterTemplate.AllowColumnReorder = false;
            gridViewCommandColumn3.FieldName = "ColEdit";
            gridViewCommandColumn3.HeaderImage = global::LEASING.UI.APP.Properties.Resources.co_folder_20;
            gridViewCommandColumn3.HeaderText = "";
            gridViewCommandColumn3.Image = global::LEASING.UI.APP.Properties.Resources.co_folder_20;
            gridViewCommandColumn3.IsVisible = false;
            gridViewCommandColumn3.Name = "ColEdit";
            gridViewCommandColumn3.Width = 30;
            gridViewCommandColumn4.FieldName = "ColDeActivate";
            gridViewCommandColumn4.HeaderImage = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            gridViewCommandColumn4.HeaderText = "";
            gridViewCommandColumn4.Image = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            gridViewCommandColumn4.IsVisible = false;
            gridViewCommandColumn4.Name = "ColDeActivate";
            gridViewCommandColumn4.Width = 30;
            gridViewTextBoxColumn13.FieldName = "RecId";
            gridViewTextBoxColumn13.HeaderText = "ID";
            gridViewTextBoxColumn13.Name = "RecId";
            gridViewTextBoxColumn13.Width = 30;
            gridViewTextBoxColumn14.FieldName = "UnitStatus";
            gridViewTextBoxColumn14.HeaderText = "Unit Status";
            gridViewTextBoxColumn14.Name = "UnitStatus";
            gridViewTextBoxColumn14.Width = 150;
            gridViewTextBoxColumn15.FieldName = "DetailsofProperty";
            gridViewTextBoxColumn15.HeaderText = "Details of Property";
            gridViewTextBoxColumn15.Name = "DetailsofProperty";
            gridViewTextBoxColumn15.Width = 200;
            gridViewTextBoxColumn16.FieldName = "UnitNo";
            gridViewTextBoxColumn16.HeaderText = "Unit No";
            gridViewTextBoxColumn16.Name = "UnitNo";
            gridViewTextBoxColumn16.Width = 100;
            gridViewTextBoxColumn17.FieldName = "UnitDescription";
            gridViewTextBoxColumn17.HeaderText = "Description";
            gridViewTextBoxColumn17.Name = "UnitDescription";
            gridViewTextBoxColumn17.Width = 150;
            gridViewTextBoxColumn18.FieldName = "ProjectName";
            gridViewTextBoxColumn18.HeaderText = "Project Name";
            gridViewTextBoxColumn18.IsVisible = false;
            gridViewTextBoxColumn18.Name = "ProjectName";
            gridViewTextBoxColumn18.Width = 200;
            gridViewTextBoxColumn19.FieldName = "FloorNo";
            gridViewTextBoxColumn19.HeaderText = "Floor No.";
            gridViewTextBoxColumn19.Name = "FloorNo";
            gridViewTextBoxColumn19.Width = 80;
            gridViewTextBoxColumn20.FieldName = "AreaSqm";
            gridViewTextBoxColumn20.HeaderText = "Area Sqm.";
            gridViewTextBoxColumn20.Name = "AreaSqm";
            gridViewTextBoxColumn20.Width = 80;
            gridViewTextBoxColumn21.FieldName = "AreaRateSqm";
            gridViewTextBoxColumn21.HeaderText = "Area Rate Sqm.";
            gridViewTextBoxColumn21.Name = "AreaRateSqm";
            gridViewTextBoxColumn21.Width = 150;
            gridViewTextBoxColumn22.FieldName = "FloorType";
            gridViewTextBoxColumn22.HeaderText = "Floor Type";
            gridViewTextBoxColumn22.Name = "FloorType";
            gridViewTextBoxColumn22.Width = 150;
            gridViewTextBoxColumn23.FieldName = "BaseRental";
            gridViewTextBoxColumn23.HeaderText = "Base Rental";
            gridViewTextBoxColumn23.Name = "BaseRental";
            gridViewTextBoxColumn23.Width = 150;
            gridViewTextBoxColumn24.FieldName = "IsActive";
            gridViewTextBoxColumn24.HeaderText = "Is Active";
            gridViewTextBoxColumn24.IsVisible = false;
            gridViewTextBoxColumn24.Name = "IsActive";
            gridViewTextBoxColumn24.Width = 80;
            this.dgvUnitList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn3,
            gridViewCommandColumn4,
            gridViewTextBoxColumn13,
            gridViewTextBoxColumn14,
            gridViewTextBoxColumn15,
            gridViewTextBoxColumn16,
            gridViewTextBoxColumn17,
            gridViewTextBoxColumn18,
            gridViewTextBoxColumn19,
            gridViewTextBoxColumn20,
            gridViewTextBoxColumn21,
            gridViewTextBoxColumn22,
            gridViewTextBoxColumn23,
            gridViewTextBoxColumn24});
            this.dgvUnitList.MasterTemplate.EnableFiltering = true;
            this.dgvUnitList.Name = "dgvUnitList";
            this.dgvUnitList.ReadOnly = true;
            this.dgvUnitList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvUnitList.ShowGroupPanel = false;
            this.dgvUnitList.Size = new System.Drawing.Size(760, 483);
            this.dgvUnitList.TabIndex = 1;
            this.dgvUnitList.Text = "radGridView1";
            this.dgvUnitList.CellFormatting += new Telerik.WinControls.UI.CellFormattingEventHandler(this.dgvUnitList_CellFormatting);
            // 
            // frmCheckUnits
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(764, 503);
            this.Controls.Add(this.radGroupBox2);
            this.DoubleBuffered = true;
            this.Name = "frmCheckUnits";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Check Units";
            this.Load += new System.EventHandler(this.frmCheckUnits_Load);
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).EndInit();
            this.radGroupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvUnitList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvUnitList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Telerik.WinControls.UI.RadGroupBox radGroupBox2;
        private Telerik.WinControls.UI.RadGridView dgvUnitList;
    }
}