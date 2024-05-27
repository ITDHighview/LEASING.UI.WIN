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
            this.radGroupBox2 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvPurchaseItemList = new Telerik.WinControls.UI.RadGridView();
            this.office2007SilverTheme1 = new Telerik.WinControls.Themes.Office2007SilverTheme();
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
            this.radGroupBox2.ThemeName = "Office2007Silver";
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
            gridViewCommandColumn1.FieldName = "coledit";
            gridViewCommandColumn1.HeaderImage = global::LEASING.UI.APP.Properties.Resources.co_folder_20;
            gridViewCommandColumn1.HeaderText = "";
            gridViewCommandColumn1.Image = global::LEASING.UI.APP.Properties.Resources.co_folder_20;
            gridViewCommandColumn1.IsPinned = true;
            gridViewCommandColumn1.IsVisible = false;
            gridViewCommandColumn1.Name = "coledit";
            gridViewCommandColumn1.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn1.Width = 30;
            gridViewCommandColumn2.FieldName = "coldelete";
            gridViewCommandColumn2.HeaderImage = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            gridViewCommandColumn2.HeaderText = "";
            gridViewCommandColumn2.Image = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            gridViewCommandColumn2.IsPinned = true;
            gridViewCommandColumn2.IsVisible = false;
            gridViewCommandColumn2.Name = "coldelete";
            gridViewCommandColumn2.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn2.Width = 30;
            gridViewTextBoxColumn1.FieldName = "RecId";
            gridViewTextBoxColumn1.HeaderText = "ITEM ID";
            gridViewTextBoxColumn1.IsPinned = true;
            gridViewTextBoxColumn1.IsVisible = false;
            gridViewTextBoxColumn1.Name = "RecId";
            gridViewTextBoxColumn1.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewTextBoxColumn1.Width = 100;
            gridViewTextBoxColumn1.WrapText = true;
            gridViewTextBoxColumn2.FieldName = "PurchItemID";
            gridViewTextBoxColumn2.HeaderText = "ITEM ID";
            gridViewTextBoxColumn2.IsPinned = true;
            gridViewTextBoxColumn2.Name = "PurchItemID";
            gridViewTextBoxColumn2.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewTextBoxColumn2.Width = 150;
            gridViewTextBoxColumn3.EnableExpressionEditor = false;
            gridViewTextBoxColumn3.FieldName = "ProjectName";
            gridViewTextBoxColumn3.HeaderText = "Project Name";
            gridViewTextBoxColumn3.IsPinned = true;
            gridViewTextBoxColumn3.IsVisible = false;
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
            gridViewTextBoxColumn9.FieldName = "Remarks";
            gridViewTextBoxColumn9.HeaderText = "Remarks";
            gridViewTextBoxColumn9.Name = "Remarks";
            gridViewTextBoxColumn9.Width = 200;
            gridViewTextBoxColumn10.EnableExpressionEditor = false;
            gridViewTextBoxColumn10.FieldName = "IsActive";
            gridViewTextBoxColumn10.HeaderText = "Status";
            gridViewTextBoxColumn10.IsVisible = false;
            gridViewTextBoxColumn10.Name = "IsActive";
            gridViewTextBoxColumn10.Width = 100;
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
            gridViewTextBoxColumn10});
            this.dgvPurchaseItemList.MasterTemplate.EnableFiltering = true;
            this.dgvPurchaseItemList.MasterTemplate.ShowRowHeaderColumn = false;
            this.dgvPurchaseItemList.Name = "dgvPurchaseItemList";
            this.dgvPurchaseItemList.Padding = new System.Windows.Forms.Padding(0, 0, 0, 1);
            this.dgvPurchaseItemList.ReadOnly = true;
            this.dgvPurchaseItemList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvPurchaseItemList.ShowGroupPanel = false;
            this.dgvPurchaseItemList.Size = new System.Drawing.Size(760, 483);
            this.dgvPurchaseItemList.TabIndex = 4;
            this.dgvPurchaseItemList.Text = "radGridView1";
            this.dgvPurchaseItemList.ThemeName = "Office2007Silver";
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
        private Telerik.WinControls.Themes.Office2007SilverTheme office2007SilverTheme1;
    }
}