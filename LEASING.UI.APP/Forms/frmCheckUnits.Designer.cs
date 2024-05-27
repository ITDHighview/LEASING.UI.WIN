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
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn25 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn26 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            this.radGroupBox2 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvUnitList = new Telerik.WinControls.UI.RadGridView();
            this.office2007SilverTheme1 = new Telerik.WinControls.Themes.Office2007SilverTheme();
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
            this.radGroupBox2.Size = new System.Drawing.Size(730, 503);
            this.radGroupBox2.TabIndex = 7;
            this.radGroupBox2.Text = "UNIT LIST";
            this.radGroupBox2.ThemeName = "Office2007Silver";
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
            gridViewTextBoxColumn14.FieldName = "RecId";
            gridViewTextBoxColumn14.HeaderText = "ID";
            gridViewTextBoxColumn14.Name = "RecId";
            gridViewTextBoxColumn14.Width = 30;
            gridViewTextBoxColumn15.FieldName = "UnitStatus";
            gridViewTextBoxColumn15.HeaderText = "Unit Status";
            gridViewTextBoxColumn15.Name = "UnitStatus";
            gridViewTextBoxColumn15.Width = 200;
            gridViewTextBoxColumn16.FieldName = "DetailsofProperty";
            gridViewTextBoxColumn16.HeaderText = "Details of Property";
            gridViewTextBoxColumn16.Name = "DetailsofProperty";
            gridViewTextBoxColumn16.Width = 200;
            gridViewTextBoxColumn17.FieldName = "UnitNo";
            gridViewTextBoxColumn17.HeaderText = "Unit No";
            gridViewTextBoxColumn17.Name = "UnitNo";
            gridViewTextBoxColumn17.Width = 100;
            gridViewTextBoxColumn18.FieldName = "UnitDescription";
            gridViewTextBoxColumn18.HeaderText = "Description";
            gridViewTextBoxColumn18.Name = "UnitDescription";
            gridViewTextBoxColumn18.Width = 150;
            gridViewTextBoxColumn19.FieldName = "ProjectName";
            gridViewTextBoxColumn19.HeaderText = "Project Name";
            gridViewTextBoxColumn19.IsVisible = false;
            gridViewTextBoxColumn19.Name = "ProjectName";
            gridViewTextBoxColumn19.Width = 200;
            gridViewTextBoxColumn20.FieldName = "FloorNo";
            gridViewTextBoxColumn20.HeaderText = "Floor No.";
            gridViewTextBoxColumn20.Name = "FloorNo";
            gridViewTextBoxColumn20.Width = 80;
            gridViewTextBoxColumn21.FieldName = "AreaSqm";
            gridViewTextBoxColumn21.HeaderText = "Area Sqm.";
            gridViewTextBoxColumn21.Name = "AreaSqm";
            gridViewTextBoxColumn21.Width = 80;
            gridViewTextBoxColumn22.FieldName = "AreaRateSqm";
            gridViewTextBoxColumn22.HeaderText = "Area Rate Sqm.";
            gridViewTextBoxColumn22.Name = "AreaRateSqm";
            gridViewTextBoxColumn22.Width = 150;
            gridViewTextBoxColumn23.FieldName = "FloorType";
            gridViewTextBoxColumn23.HeaderText = "Floor Type";
            gridViewTextBoxColumn23.Name = "FloorType";
            gridViewTextBoxColumn23.Width = 150;
            gridViewTextBoxColumn24.FieldName = "BaseRental";
            gridViewTextBoxColumn24.HeaderText = "Base Rental";
            gridViewTextBoxColumn24.Name = "BaseRental";
            gridViewTextBoxColumn24.Width = 150;
            gridViewTextBoxColumn25.FieldName = "IsActive";
            gridViewTextBoxColumn25.HeaderText = "Is Active";
            gridViewTextBoxColumn25.IsVisible = false;
            gridViewTextBoxColumn25.Name = "IsActive";
            gridViewTextBoxColumn25.Width = 80;
            gridViewTextBoxColumn26.FieldName = "UnitStat";
            gridViewTextBoxColumn26.HeaderText = "UnitStat";
            gridViewTextBoxColumn26.IsVisible = false;
            gridViewTextBoxColumn26.Name = "UnitStat";
            this.dgvUnitList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn3,
            gridViewCommandColumn4,
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
            gridViewTextBoxColumn24,
            gridViewTextBoxColumn25,
            gridViewTextBoxColumn26});
            this.dgvUnitList.MasterTemplate.EnableFiltering = true;
            this.dgvUnitList.Name = "dgvUnitList";
            this.dgvUnitList.Padding = new System.Windows.Forms.Padding(0, 0, 0, 1);
            this.dgvUnitList.ReadOnly = true;
            this.dgvUnitList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvUnitList.ShowGroupPanel = false;
            this.dgvUnitList.Size = new System.Drawing.Size(726, 483);
            this.dgvUnitList.TabIndex = 1;
            this.dgvUnitList.Text = "radGridView1";
            this.dgvUnitList.ThemeName = "Office2007Silver";
            this.dgvUnitList.CellFormatting += new Telerik.WinControls.UI.CellFormattingEventHandler(this.dgvUnitList_CellFormatting);
            // 
            // frmCheckUnits
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(730, 503);
            this.Controls.Add(this.radGroupBox2);
            this.DoubleBuffered = true;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
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
        private Telerik.WinControls.Themes.Office2007SilverTheme office2007SilverTheme1;
    }
}