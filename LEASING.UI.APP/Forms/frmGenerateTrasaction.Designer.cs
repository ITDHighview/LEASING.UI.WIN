namespace LEASING.UI.APP.Forms
{
    partial class frmGenerateTrasaction
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
            Telerik.WinControls.UI.GridViewCommandColumn gridViewCommandColumn2 = new Telerik.WinControls.UI.GridViewCommandColumn();
            Telerik.WinControls.UI.GridViewCommandColumn gridViewCommandColumn3 = new Telerik.WinControls.UI.GridViewCommandColumn();
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
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn14 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn15 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn16 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            this.radGroupBox2 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvList = new Telerik.WinControls.UI.RadGridView();
            this.office2007SilverTheme1 = new Telerik.WinControls.Themes.Office2007SilverTheme();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).BeginInit();
            this.radGroupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvList.MasterTemplate)).BeginInit();
            this.SuspendLayout();
            // 
            // radGroupBox2
            // 
            this.radGroupBox2.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox2.Controls.Add(this.dgvList);
            this.radGroupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox2.HeaderText = "CONTRACT LIST";
            this.radGroupBox2.Location = new System.Drawing.Point(0, 0);
            this.radGroupBox2.Name = "radGroupBox2";
            this.radGroupBox2.Size = new System.Drawing.Size(821, 449);
            this.radGroupBox2.TabIndex = 6;
            this.radGroupBox2.Text = "CONTRACT LIST";
            // 
            // dgvList
            // 
            this.dgvList.BackColor = System.Drawing.SystemColors.Control;
            this.dgvList.Cursor = System.Windows.Forms.Cursors.Default;
            this.dgvList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvList.Font = new System.Drawing.Font("Segoe UI", 8.25F);
            this.dgvList.ForeColor = System.Drawing.Color.Black;
            this.dgvList.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.dgvList.Location = new System.Drawing.Point(2, 18);
            // 
            // dgvList
            // 
            this.dgvList.MasterTemplate.AllowAddNewRow = false;
            this.dgvList.MasterTemplate.AllowColumnReorder = false;
            gridViewCommandColumn1.FieldName = "ColGenerate";
            gridViewCommandColumn1.HeaderImage = global::LEASING.UI.APP.Properties.Resources.Bullet15_Arrow_Blue;
            gridViewCommandColumn1.HeaderText = "";
            gridViewCommandColumn1.Image = global::LEASING.UI.APP.Properties.Resources.Bullet15_Arrow_Blue;
            gridViewCommandColumn1.IsPinned = true;
            gridViewCommandColumn1.Name = "ColGenerate";
            gridViewCommandColumn1.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn1.Width = 30;
            gridViewCommandColumn2.FieldName = "ColEdit";
            gridViewCommandColumn2.HeaderImage = global::LEASING.UI.APP.Properties.Resources.magnifier;
            gridViewCommandColumn2.HeaderText = "";
            gridViewCommandColumn2.Image = global::LEASING.UI.APP.Properties.Resources.magnifier;
            gridViewCommandColumn2.IsPinned = true;
            gridViewCommandColumn2.Name = "ColEdit";
            gridViewCommandColumn2.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn2.Width = 30;
            gridViewCommandColumn3.FieldName = "ColRemoved";
            gridViewCommandColumn3.HeaderImage = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            gridViewCommandColumn3.HeaderText = "";
            gridViewCommandColumn3.Image = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            gridViewCommandColumn3.IsPinned = true;
            gridViewCommandColumn3.IsVisible = false;
            gridViewCommandColumn3.Name = "ColRemoved";
            gridViewCommandColumn3.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn3.Width = 30;
            gridViewTextBoxColumn1.FieldName = "RefId";
            gridViewTextBoxColumn1.HeaderText = "Contract ID";
            gridViewTextBoxColumn1.Name = "RefId";
            gridViewTextBoxColumn1.Width = 100;
            gridViewTextBoxColumn2.FieldName = "TransactionDate";
            gridViewTextBoxColumn2.HeaderText = "Transaction Date";
            gridViewTextBoxColumn2.Name = "TransactionDate";
            gridViewTextBoxColumn2.Width = 100;
            gridViewTextBoxColumn3.FieldName = "UnitNo";
            gridViewTextBoxColumn3.HeaderText = "Unit No";
            gridViewTextBoxColumn3.Name = "UnitNo";
            gridViewTextBoxColumn3.Width = 60;
            gridViewTextBoxColumn4.FieldName = "TypeOf";
            gridViewTextBoxColumn4.HeaderText = "Type";
            gridViewTextBoxColumn4.Name = "TypeOf";
            gridViewTextBoxColumn4.Width = 100;
            gridViewTextBoxColumn5.FieldName = "InquiringClient";
            gridViewTextBoxColumn5.HeaderText = "Inquiring Client";
            gridViewTextBoxColumn5.Name = "InquiringClient";
            gridViewTextBoxColumn5.Width = 200;
            gridViewTextBoxColumn6.FieldName = "ClientMobile";
            gridViewTextBoxColumn6.HeaderText = " Mobile";
            gridViewTextBoxColumn6.IsVisible = false;
            gridViewTextBoxColumn6.Name = "ClientMobile";
            gridViewTextBoxColumn6.Width = 150;
            gridViewTextBoxColumn7.FieldName = "StatDate";
            gridViewTextBoxColumn7.HeaderText = "Stat Date";
            gridViewTextBoxColumn7.Name = "StatDate";
            gridViewTextBoxColumn7.Width = 100;
            gridViewTextBoxColumn8.FieldName = "FinishDate";
            gridViewTextBoxColumn8.HeaderText = "Finish Date";
            gridViewTextBoxColumn8.Name = "FinishDate";
            gridViewTextBoxColumn8.Width = 100;
            gridViewTextBoxColumn9.FieldName = "Rental";
            gridViewTextBoxColumn9.HeaderText = "Rental";
            gridViewTextBoxColumn9.IsVisible = false;
            gridViewTextBoxColumn9.Name = "Rental";
            gridViewTextBoxColumn9.Width = 100;
            gridViewTextBoxColumn10.FieldName = "SecAndMaintenance";
            gridViewTextBoxColumn10.HeaderText = "Sec And Maintenance";
            gridViewTextBoxColumn10.IsVisible = false;
            gridViewTextBoxColumn10.Name = "SecAndMaintenance";
            gridViewTextBoxColumn10.Width = 120;
            gridViewTextBoxColumn10.WrapText = true;
            gridViewTextBoxColumn11.FieldName = "TotalRent";
            gridViewTextBoxColumn11.HeaderText = "Total Rent";
            gridViewTextBoxColumn11.IsVisible = false;
            gridViewTextBoxColumn11.Name = "TotalRent";
            gridViewTextBoxColumn11.Width = 100;
            gridViewTextBoxColumn12.FieldName = "Total";
            gridViewTextBoxColumn12.HeaderText = "Total";
            gridViewTextBoxColumn12.IsVisible = false;
            gridViewTextBoxColumn12.Name = "Total";
            gridViewTextBoxColumn12.Width = 100;
            gridViewTextBoxColumn13.FieldName = "RecId";
            gridViewTextBoxColumn13.HeaderText = "RecId";
            gridViewTextBoxColumn13.IsVisible = false;
            gridViewTextBoxColumn13.Name = "RecId";
            gridViewTextBoxColumn14.FieldName = "UnitId";
            gridViewTextBoxColumn14.HeaderText = "UnitId";
            gridViewTextBoxColumn14.IsVisible = false;
            gridViewTextBoxColumn14.Name = "UnitId";
            gridViewTextBoxColumn15.FieldName = "ProjectName";
            gridViewTextBoxColumn15.HeaderText = "ProjectName";
            gridViewTextBoxColumn15.IsVisible = false;
            gridViewTextBoxColumn15.Name = "ProjectName";
            gridViewTextBoxColumn16.FieldName = "ClientID";
            gridViewTextBoxColumn16.HeaderText = "";
            gridViewTextBoxColumn16.IsVisible = false;
            gridViewTextBoxColumn16.Name = "ClientID";
            this.dgvList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn1,
            gridViewCommandColumn2,
            gridViewCommandColumn3,
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
            gridViewTextBoxColumn13,
            gridViewTextBoxColumn14,
            gridViewTextBoxColumn15,
            gridViewTextBoxColumn16});
            this.dgvList.MasterTemplate.EnableFiltering = true;
            this.dgvList.MasterTemplate.ShowRowHeaderColumn = false;
            this.dgvList.Name = "dgvList";
            this.dgvList.Padding = new System.Windows.Forms.Padding(0, 0, 0, 1);
            this.dgvList.ReadOnly = true;
            this.dgvList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvList.ShowGroupPanel = false;
            this.dgvList.Size = new System.Drawing.Size(817, 429);
            this.dgvList.TabIndex = 0;
            this.dgvList.Text = "radGridView1";
            this.dgvList.ThemeName = "Office2007Silver";
            this.dgvList.CellClick += new Telerik.WinControls.UI.GridViewCellEventHandler(this.dgvList_CellClick);
            // 
            // frmGenerateTrasaction
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(821, 449);
            this.Controls.Add(this.radGroupBox2);
            this.DoubleBuffered = true;
            this.Name = "frmGenerateTrasaction";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Generate Trasaction";
            this.Load += new System.EventHandler(this.frmGenerateTrasaction_Load);
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).EndInit();
            this.radGroupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Telerik.WinControls.UI.RadGroupBox radGroupBox2;
        private Telerik.WinControls.UI.RadGridView dgvList;
        private Telerik.WinControls.Themes.Office2007SilverTheme office2007SilverTheme1;
    }
}