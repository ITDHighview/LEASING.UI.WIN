namespace LEASING.UI.APP.Forms
{
    partial class frmInActivePurchaseItemList
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
            this.radGroupBox4 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvPurchaseItemList = new Telerik.WinControls.UI.RadGridView();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox4)).BeginInit();
            this.radGroupBox4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPurchaseItemList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPurchaseItemList.MasterTemplate)).BeginInit();
            this.SuspendLayout();
            // 
            // radGroupBox4
            // 
            this.radGroupBox4.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox4.Controls.Add(this.dgvPurchaseItemList);
            this.radGroupBox4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox4.HeaderText = "PURCHASE LIST";
            this.radGroupBox4.Location = new System.Drawing.Point(0, 0);
            this.radGroupBox4.Name = "radGroupBox4";
            this.radGroupBox4.Size = new System.Drawing.Size(1011, 399);
            this.radGroupBox4.TabIndex = 2;
            this.radGroupBox4.Text = "PURCHASE LIST";
            this.radGroupBox4.ThemeName = "Office2007Black";
            // 
            // dgvPurchaseItemList
            // 
            this.dgvPurchaseItemList.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(233)))), ((int)(((byte)(240)))), ((int)(((byte)(249)))));
            this.dgvPurchaseItemList.Cursor = System.Windows.Forms.Cursors.Default;
            this.dgvPurchaseItemList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvPurchaseItemList.Font = new System.Drawing.Font("Segoe UI", 8.25F);
            this.dgvPurchaseItemList.ForeColor = System.Drawing.Color.Black;
            this.dgvPurchaseItemList.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.dgvPurchaseItemList.Location = new System.Drawing.Point(2, 18);
            // 
            // dgvPurchaseItemList
            // 
            this.dgvPurchaseItemList.MasterTemplate.AllowAddNewRow = false;
            this.dgvPurchaseItemList.MasterTemplate.AllowColumnReorder = false;
            gridViewCommandColumn1.FieldName = "ColActivate";
            gridViewCommandColumn1.HeaderImage = global::LEASING.UI.APP.Properties.Resources.co_checkmark_16;
            gridViewCommandColumn1.HeaderText = "";
            gridViewCommandColumn1.Image = global::LEASING.UI.APP.Properties.Resources.co_checkmark_16;
            gridViewCommandColumn1.IsPinned = true;
            gridViewCommandColumn1.Name = "ColActivate";
            gridViewCommandColumn1.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn1.Width = 30;
            gridViewCommandColumn2.FieldName = "ColDelete";
            gridViewCommandColumn2.HeaderImage = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            gridViewCommandColumn2.HeaderText = "";
            gridViewCommandColumn2.Image = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            gridViewCommandColumn2.IsPinned = true;
            gridViewCommandColumn2.Name = "ColDelete";
            gridViewCommandColumn2.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn2.Width = 30;
            gridViewTextBoxColumn1.FieldName = "PurchItemID";
            gridViewTextBoxColumn1.HeaderText = "ITEM ID";
            gridViewTextBoxColumn1.IsPinned = true;
            gridViewTextBoxColumn1.Name = "PurchItemID";
            gridViewTextBoxColumn1.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewTextBoxColumn1.Width = 110;
            gridViewTextBoxColumn2.FieldName = "RecId";
            gridViewTextBoxColumn2.HeaderText = "ITEM ID";
            gridViewTextBoxColumn2.IsPinned = true;
            gridViewTextBoxColumn2.IsVisible = false;
            gridViewTextBoxColumn2.Name = "RecId";
            gridViewTextBoxColumn2.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewTextBoxColumn2.Width = 100;
            gridViewTextBoxColumn2.WrapText = true;
            gridViewTextBoxColumn3.EnableExpressionEditor = false;
            gridViewTextBoxColumn3.FieldName = "ProjectName";
            gridViewTextBoxColumn3.HeaderText = "Project Name";
            gridViewTextBoxColumn3.IsPinned = true;
            gridViewTextBoxColumn3.Name = "ProjectName";
            gridViewTextBoxColumn3.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewTextBoxColumn3.Width = 150;
            gridViewTextBoxColumn4.EnableExpressionEditor = false;
            gridViewTextBoxColumn4.FieldName = "ProjectAddress";
            gridViewTextBoxColumn4.HeaderText = "Project Address";
            gridViewTextBoxColumn4.IsVisible = false;
            gridViewTextBoxColumn4.Name = "ProjectAddress";
            gridViewTextBoxColumn4.Width = 300;
            gridViewTextBoxColumn5.EnableExpressionEditor = false;
            gridViewTextBoxColumn5.FieldName = "Descriptions";
            gridViewTextBoxColumn5.HeaderText = "Descriptions";
            gridViewTextBoxColumn5.Name = "Descriptions";
            gridViewTextBoxColumn5.Width = 200;
            gridViewTextBoxColumn6.FieldName = "DatePurchase";
            gridViewTextBoxColumn6.HeaderText = "Date Purchase";
            gridViewTextBoxColumn6.Name = "DatePurchase";
            gridViewTextBoxColumn6.Width = 100;
            gridViewTextBoxColumn7.FieldName = "UnitAmount";
            gridViewTextBoxColumn7.HeaderText = "Unit Amount";
            gridViewTextBoxColumn7.Name = "UnitAmount";
            gridViewTextBoxColumn7.Width = 80;
            gridViewTextBoxColumn8.FieldName = "Amount";
            gridViewTextBoxColumn8.HeaderText = "Amount";
            gridViewTextBoxColumn8.Name = "Amount";
            gridViewTextBoxColumn8.Width = 70;
            gridViewTextBoxColumn9.FieldName = "TotalAmount";
            gridViewTextBoxColumn9.HeaderText = "Total";
            gridViewTextBoxColumn9.Name = "TotalAmount";
            gridViewTextBoxColumn9.Width = 80;
            gridViewTextBoxColumn10.FieldName = "Remarks";
            gridViewTextBoxColumn10.HeaderText = "Remarks";
            gridViewTextBoxColumn10.Name = "Remarks";
            gridViewTextBoxColumn10.Width = 200;
            gridViewTextBoxColumn11.EnableExpressionEditor = false;
            gridViewTextBoxColumn11.FieldName = "IsActive";
            gridViewTextBoxColumn11.HeaderText = "Status";
            gridViewTextBoxColumn11.IsVisible = false;
            gridViewTextBoxColumn11.Name = "IsActive";
            gridViewTextBoxColumn11.Width = 100;
            this.dgvPurchaseItemList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn1,
            gridViewCommandColumn2,
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
            gridViewTextBoxColumn11});
            this.dgvPurchaseItemList.MasterTemplate.EnableFiltering = true;
            this.dgvPurchaseItemList.MasterTemplate.ShowRowHeaderColumn = false;
            this.dgvPurchaseItemList.Name = "dgvPurchaseItemList";
            this.dgvPurchaseItemList.ReadOnly = true;
            this.dgvPurchaseItemList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvPurchaseItemList.ShowGroupPanel = false;
            this.dgvPurchaseItemList.Size = new System.Drawing.Size(1007, 379);
            this.dgvPurchaseItemList.TabIndex = 4;
            this.dgvPurchaseItemList.Text = "radGridView1";
            this.dgvPurchaseItemList.ThemeName = "ControlDefault";
            this.dgvPurchaseItemList.CellFormatting += new Telerik.WinControls.UI.CellFormattingEventHandler(this.dgvPurchaseItemList_CellFormatting);
            this.dgvPurchaseItemList.CellClick += new Telerik.WinControls.UI.GridViewCellEventHandler(this.dgvPurchaseItemList_CellClick);
            // 
            // frmInActivePurchaseItemList
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1011, 399);
            this.Controls.Add(this.radGroupBox4);
            this.DoubleBuffered = true;
            this.Name = "frmInActivePurchaseItemList";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "In-Active Purchase Item";
            this.Load += new System.EventHandler(this.frmInActivePurchaseItemList_Load);
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox4)).EndInit();
            this.radGroupBox4.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvPurchaseItemList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPurchaseItemList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Telerik.WinControls.UI.RadGroupBox radGroupBox4;
        private Telerik.WinControls.UI.RadGridView dgvPurchaseItemList;
    }
}