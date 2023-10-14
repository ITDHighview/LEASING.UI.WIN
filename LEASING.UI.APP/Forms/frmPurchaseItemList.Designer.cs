namespace LEASING.UI.APP.Forms
{
    partial class frmPurchaseItemList
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
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn11 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn12 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn13 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn14 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn15 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn16 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn17 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn18 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn19 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn20 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            this.radGroupBox2 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvPurchaseItemList = new Telerik.WinControls.UI.RadGridView();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).BeginInit();
            this.radGroupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPurchaseItemList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPurchaseItemList.MasterTemplate)).BeginInit();
            this.SuspendLayout();
            // 
            // radGroupBox2
            // 
            this.radGroupBox2.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox2.Controls.Add(this.dgvPurchaseItemList);
            this.radGroupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox2.HeaderText = "PURCHASE ITEM LIST";
            this.radGroupBox2.Location = new System.Drawing.Point(0, 0);
            this.radGroupBox2.Name = "radGroupBox2";
            this.radGroupBox2.Size = new System.Drawing.Size(764, 503);
            this.radGroupBox2.TabIndex = 7;
            this.radGroupBox2.Text = "PURCHASE ITEM LIST";
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
            gridViewCommandColumn3.FieldName = "coledit";
            gridViewCommandColumn3.HeaderImage = global::LEASING.UI.APP.Properties.Resources.co_folder_20;
            gridViewCommandColumn3.HeaderText = "";
            gridViewCommandColumn3.Image = global::LEASING.UI.APP.Properties.Resources.co_folder_20;
            gridViewCommandColumn3.IsPinned = true;
            gridViewCommandColumn3.IsVisible = false;
            gridViewCommandColumn3.Name = "coledit";
            gridViewCommandColumn3.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn3.Width = 30;
            gridViewCommandColumn4.FieldName = "coldelete";
            gridViewCommandColumn4.HeaderImage = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            gridViewCommandColumn4.HeaderText = "";
            gridViewCommandColumn4.Image = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            gridViewCommandColumn4.IsPinned = true;
            gridViewCommandColumn4.IsVisible = false;
            gridViewCommandColumn4.Name = "coldelete";
            gridViewCommandColumn4.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn4.Width = 30;
            gridViewTextBoxColumn11.FieldName = "RecId";
            gridViewTextBoxColumn11.HeaderText = "ITEM ID";
            gridViewTextBoxColumn11.IsPinned = true;
            gridViewTextBoxColumn11.IsVisible = false;
            gridViewTextBoxColumn11.Name = "RecId";
            gridViewTextBoxColumn11.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewTextBoxColumn11.Width = 100;
            gridViewTextBoxColumn11.WrapText = true;
            gridViewTextBoxColumn12.FieldName = "PurchItemID";
            gridViewTextBoxColumn12.HeaderText = "ITEM ID";
            gridViewTextBoxColumn12.IsPinned = true;
            gridViewTextBoxColumn12.Name = "PurchItemID";
            gridViewTextBoxColumn12.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewTextBoxColumn12.Width = 150;
            gridViewTextBoxColumn13.EnableExpressionEditor = false;
            gridViewTextBoxColumn13.FieldName = "ProjectName";
            gridViewTextBoxColumn13.HeaderText = "Project Name";
            gridViewTextBoxColumn13.IsPinned = true;
            gridViewTextBoxColumn13.IsVisible = false;
            gridViewTextBoxColumn13.Name = "ProjectName";
            gridViewTextBoxColumn13.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewTextBoxColumn13.Width = 150;
            gridViewTextBoxColumn14.EnableExpressionEditor = false;
            gridViewTextBoxColumn14.FieldName = "ProjectAddress";
            gridViewTextBoxColumn14.HeaderText = "Project Address";
            gridViewTextBoxColumn14.IsVisible = false;
            gridViewTextBoxColumn14.Name = "ProjectAddress";
            gridViewTextBoxColumn14.Width = 300;
            gridViewTextBoxColumn15.EnableExpressionEditor = false;
            gridViewTextBoxColumn15.FieldName = "Descriptions";
            gridViewTextBoxColumn15.HeaderText = "Descriptions";
            gridViewTextBoxColumn15.Name = "Descriptions";
            gridViewTextBoxColumn15.Width = 200;
            gridViewTextBoxColumn16.FieldName = "DatePurchase";
            gridViewTextBoxColumn16.HeaderText = "Date Purchase";
            gridViewTextBoxColumn16.Name = "DatePurchase";
            gridViewTextBoxColumn16.Width = 100;
            gridViewTextBoxColumn17.FieldName = "UnitAmount";
            gridViewTextBoxColumn17.HeaderText = "Unit Amount";
            gridViewTextBoxColumn17.Name = "UnitAmount";
            gridViewTextBoxColumn17.Width = 80;
            gridViewTextBoxColumn18.FieldName = "Amount";
            gridViewTextBoxColumn18.HeaderText = "Amount";
            gridViewTextBoxColumn18.Name = "Amount";
            gridViewTextBoxColumn18.Width = 70;
            gridViewTextBoxColumn19.FieldName = "Remarks";
            gridViewTextBoxColumn19.HeaderText = "Remarks";
            gridViewTextBoxColumn19.Name = "Remarks";
            gridViewTextBoxColumn19.Width = 200;
            gridViewTextBoxColumn20.EnableExpressionEditor = false;
            gridViewTextBoxColumn20.FieldName = "IsActive";
            gridViewTextBoxColumn20.HeaderText = "Status";
            gridViewTextBoxColumn20.IsVisible = false;
            gridViewTextBoxColumn20.Name = "IsActive";
            gridViewTextBoxColumn20.Width = 100;
            this.dgvPurchaseItemList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn3,
            gridViewCommandColumn4,
            gridViewTextBoxColumn11,
            gridViewTextBoxColumn12,
            gridViewTextBoxColumn13,
            gridViewTextBoxColumn14,
            gridViewTextBoxColumn15,
            gridViewTextBoxColumn16,
            gridViewTextBoxColumn17,
            gridViewTextBoxColumn18,
            gridViewTextBoxColumn19,
            gridViewTextBoxColumn20});
            this.dgvPurchaseItemList.MasterTemplate.EnableFiltering = true;
            this.dgvPurchaseItemList.MasterTemplate.ShowRowHeaderColumn = false;
            this.dgvPurchaseItemList.Name = "dgvPurchaseItemList";
            this.dgvPurchaseItemList.ReadOnly = true;
            this.dgvPurchaseItemList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvPurchaseItemList.ShowGroupPanel = false;
            this.dgvPurchaseItemList.Size = new System.Drawing.Size(760, 483);
            this.dgvPurchaseItemList.TabIndex = 4;
            this.dgvPurchaseItemList.Text = "radGridView1";
            this.dgvPurchaseItemList.ThemeName = "Office2013Light";
            // 
            // frmPurchaseItemList
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(764, 503);
            this.Controls.Add(this.radGroupBox2);
            this.DoubleBuffered = true;
            this.Name = "frmPurchaseItemList";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Purchase Item List";
            this.Load += new System.EventHandler(this.frmPurchaseItemList_Load);
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).EndInit();
            this.radGroupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvPurchaseItemList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPurchaseItemList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Telerik.WinControls.UI.RadGroupBox radGroupBox2;
        private Telerik.WinControls.UI.RadGridView dgvPurchaseItemList;
    }
}