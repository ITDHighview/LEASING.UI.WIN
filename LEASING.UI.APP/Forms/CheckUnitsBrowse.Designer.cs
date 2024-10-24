namespace LEASING.UI.APP.Forms
{
    partial class CheckUnitsBrowse
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
            Telerik.WinControls.UI.GridViewCommandColumn gridViewCommandColumn1 = new Telerik.WinControls.UI.GridViewCommandColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn1 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn2 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn3 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn4 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn5 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn6 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn7 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn8 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn9 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn10 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn11 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn12 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn13 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
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
            this.radGroupBox2.Size = new System.Drawing.Size(1304, 503);
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
            gridViewCommandColumn1.FieldName = "ColSelect";
            gridViewCommandColumn1.HeaderImage = global::LEASING.UI.APP.Properties.Resources._16_handIcon;
            gridViewCommandColumn1.HeaderText = "";
            gridViewCommandColumn1.Name = "ColSelect";
            gridViewCommandColumn1.Width = 30;
            gridViewTextBoxColumn1.FieldName = "RecId";
            gridViewTextBoxColumn1.HeaderText = "ID";
            gridViewTextBoxColumn1.IsVisible = false;
            gridViewTextBoxColumn1.Name = "RecId";
            gridViewTextBoxColumn1.Width = 30;
            gridViewTextBoxColumn2.FieldName = "UnitStatus";
            gridViewTextBoxColumn2.HeaderText = "Unit Status";
            gridViewTextBoxColumn2.Name = "UnitStatus";
            gridViewTextBoxColumn2.Width = 200;
            gridViewTextBoxColumn3.FieldName = "DetailsofProperty";
            gridViewTextBoxColumn3.HeaderText = "Details of Property";
            gridViewTextBoxColumn3.Name = "DetailsofProperty";
            gridViewTextBoxColumn3.Width = 200;
            gridViewTextBoxColumn4.FieldName = "UnitNo";
            gridViewTextBoxColumn4.HeaderText = "Unit No";
            gridViewTextBoxColumn4.Name = "UnitNo";
            gridViewTextBoxColumn4.Width = 100;
            gridViewTextBoxColumn5.FieldName = "UnitDescription";
            gridViewTextBoxColumn5.HeaderText = "Description";
            gridViewTextBoxColumn5.Name = "UnitDescription";
            gridViewTextBoxColumn5.Width = 150;
            gridViewTextBoxColumn6.FieldName = "ProjectName";
            gridViewTextBoxColumn6.HeaderText = "Project Name";
            gridViewTextBoxColumn6.IsVisible = false;
            gridViewTextBoxColumn6.Name = "ProjectName";
            gridViewTextBoxColumn6.Width = 200;
            gridViewTextBoxColumn7.FieldName = "FloorNo";
            gridViewTextBoxColumn7.HeaderText = "Floor No.";
            gridViewTextBoxColumn7.Name = "FloorNo";
            gridViewTextBoxColumn7.Width = 80;
            gridViewTextBoxColumn8.FieldName = "AreaSqm";
            gridViewTextBoxColumn8.HeaderText = "Area Sqm.";
            gridViewTextBoxColumn8.Name = "AreaSqm";
            gridViewTextBoxColumn8.Width = 80;
            gridViewTextBoxColumn9.FieldName = "AreaRateSqm";
            gridViewTextBoxColumn9.HeaderText = "Area Rate Sqm.";
            gridViewTextBoxColumn9.Name = "AreaRateSqm";
            gridViewTextBoxColumn9.Width = 150;
            gridViewTextBoxColumn10.FieldName = "FloorType";
            gridViewTextBoxColumn10.HeaderText = "Floor Type";
            gridViewTextBoxColumn10.Name = "FloorType";
            gridViewTextBoxColumn10.Width = 150;
            gridViewTextBoxColumn11.FieldName = "BaseRental";
            gridViewTextBoxColumn11.HeaderText = "Base Rental";
            gridViewTextBoxColumn11.Name = "BaseRental";
            gridViewTextBoxColumn11.Width = 150;
            gridViewTextBoxColumn12.FieldName = "IsActive";
            gridViewTextBoxColumn12.HeaderText = "Is Active";
            gridViewTextBoxColumn12.IsVisible = false;
            gridViewTextBoxColumn12.Name = "IsActive";
            gridViewTextBoxColumn12.Width = 80;
            gridViewTextBoxColumn13.FieldName = "UnitStat";
            gridViewTextBoxColumn13.HeaderText = "UnitStat";
            gridViewTextBoxColumn13.IsVisible = false;
            gridViewTextBoxColumn13.Name = "UnitStat";
            this.dgvUnitList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn1,
            gridViewTextBoxColumn1,
            gridViewTextBoxColumn2,
            gridViewTextBoxColumn3,
            gridViewTextBoxColumn4,
            gridViewTextBoxColumn5,
            gridViewTextBoxColumn6,
            gridViewTextBoxColumn7,
            gridViewTextBoxColumn8,
            gridViewTextBoxColumn9,
            gridViewTextBoxColumn10,
            gridViewTextBoxColumn11,
            gridViewTextBoxColumn12,
            gridViewTextBoxColumn13});
            this.dgvUnitList.MasterTemplate.EnableFiltering = true;
            this.dgvUnitList.MasterTemplate.ShowRowHeaderColumn = false;
            this.dgvUnitList.Name = "dgvUnitList";
            this.dgvUnitList.Padding = new System.Windows.Forms.Padding(0, 0, 0, 1);
            this.dgvUnitList.ReadOnly = true;
            this.dgvUnitList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvUnitList.ShowGroupPanel = false;
            this.dgvUnitList.Size = new System.Drawing.Size(1300, 483);
            this.dgvUnitList.TabIndex = 1;
            this.dgvUnitList.Text = "radGridView1";
            this.dgvUnitList.ThemeName = "Office2007Silver";
            this.dgvUnitList.CellFormatting += new Telerik.WinControls.UI.CellFormattingEventHandler(this.dgvUnitList_CellFormatting);
            this.dgvUnitList.CellClick += new Telerik.WinControls.UI.GridViewCellEventHandler(this.dgvUnitList_CellClick);
            // 
            // frmCheckUnits
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1304, 503);
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