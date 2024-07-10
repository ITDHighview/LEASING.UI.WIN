namespace LEASING.UI.APP.Forms
{
    partial class frmContractInquiryAdvanceSearch
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
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn3 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewCommandColumn gridViewCommandColumn1 = new Telerik.WinControls.UI.GridViewCommandColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn4 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn5 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn6 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn7 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.radGroupBox1 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvClientList = new Telerik.WinControls.UI.RadGridView();
            this.radGroupBox2 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvContractList = new Telerik.WinControls.UI.RadGridView();
            this.office2010SilverTheme1 = new Telerik.WinControls.Themes.Office2010SilverTheme();
            this.tableLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox1)).BeginInit();
            this.radGroupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvClientList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvClientList.MasterTemplate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).BeginInit();
            this.radGroupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvContractList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvContractList.MasterTemplate)).BeginInit();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 47.57785F));
            this.tableLayoutPanel1.Controls.Add(this.toolStrip1, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.radGroupBox1, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.radGroupBox2, 0, 2);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 3;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 44.06779F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 55.93221F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(670, 497);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // toolStrip1
            // 
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(670, 25);
            this.toolStrip1.TabIndex = 1;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // radGroupBox1
            // 
            this.radGroupBox1.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox1.Controls.Add(this.dgvClientList);
            this.radGroupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox1.HeaderText = "Client";
            this.radGroupBox1.HeaderTextAlignment = System.Drawing.ContentAlignment.BottomRight;
            this.radGroupBox1.Location = new System.Drawing.Point(3, 28);
            this.radGroupBox1.Name = "radGroupBox1";
            this.radGroupBox1.Size = new System.Drawing.Size(664, 201);
            this.radGroupBox1.TabIndex = 2;
            this.radGroupBox1.Text = "Client";
            this.radGroupBox1.ThemeName = "Office2010Silver";
            // 
            // dgvClientList
            // 
            this.dgvClientList.BackColor = System.Drawing.SystemColors.Control;
            this.dgvClientList.Cursor = System.Windows.Forms.Cursors.Default;
            this.dgvClientList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvClientList.Font = new System.Drawing.Font("Segoe UI", 8.25F);
            this.dgvClientList.ForeColor = System.Drawing.Color.Black;
            this.dgvClientList.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.dgvClientList.Location = new System.Drawing.Point(2, 18);
            // 
            // dgvClientList
            // 
            this.dgvClientList.MasterTemplate.AllowAddNewRow = false;
            this.dgvClientList.MasterTemplate.AllowColumnReorder = false;
            gridViewTextBoxColumn1.FieldName = "ClientID";
            gridViewTextBoxColumn1.HeaderText = "Client ID";
            gridViewTextBoxColumn1.Name = "ClientID";
            gridViewTextBoxColumn1.Width = 150;
            gridViewTextBoxColumn2.FieldName = "ClientType";
            gridViewTextBoxColumn2.HeaderText = "Type";
            gridViewTextBoxColumn2.Name = "ClientType";
            gridViewTextBoxColumn2.Width = 150;
            gridViewTextBoxColumn3.FieldName = "ClientName";
            gridViewTextBoxColumn3.HeaderText = " Name";
            gridViewTextBoxColumn3.Name = "ClientName";
            gridViewTextBoxColumn3.Width = 350;
            this.dgvClientList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewTextBoxColumn1,
            gridViewTextBoxColumn2,
            gridViewTextBoxColumn3});
            this.dgvClientList.MasterTemplate.EnableFiltering = true;
            this.dgvClientList.Name = "dgvClientList";
            this.dgvClientList.ReadOnly = true;
            this.dgvClientList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvClientList.ShowGroupPanel = false;
            this.dgvClientList.Size = new System.Drawing.Size(660, 181);
            this.dgvClientList.TabIndex = 0;
            this.dgvClientList.Text = "radGridView1";
            this.dgvClientList.ThemeName = "Office2010Silver";
            this.dgvClientList.SelectionChanged += new System.EventHandler(this.dgvClientList_SelectionChanged);
            // 
            // radGroupBox2
            // 
            this.radGroupBox2.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox2.Controls.Add(this.dgvContractList);
            this.radGroupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox2.HeaderText = "Contract";
            this.radGroupBox2.Location = new System.Drawing.Point(3, 235);
            this.radGroupBox2.Name = "radGroupBox2";
            this.radGroupBox2.Size = new System.Drawing.Size(664, 259);
            this.radGroupBox2.TabIndex = 2;
            this.radGroupBox2.Text = "Contract";
            this.radGroupBox2.ThemeName = "Office2010Silver";
            // 
            // dgvContractList
            // 
            this.dgvContractList.BackColor = System.Drawing.SystemColors.Control;
            this.dgvContractList.Cursor = System.Windows.Forms.Cursors.Default;
            this.dgvContractList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvContractList.Font = new System.Drawing.Font("Segoe UI", 8.25F);
            this.dgvContractList.ForeColor = System.Drawing.Color.Black;
            this.dgvContractList.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.dgvContractList.Location = new System.Drawing.Point(2, 18);
            // 
            // dgvContractList
            // 
            this.dgvContractList.MasterTemplate.AllowAddNewRow = false;
            this.dgvContractList.MasterTemplate.AllowColumnReorder = false;
            gridViewCommandColumn1.FieldName = "ColSelect";
            gridViewCommandColumn1.HeaderImage = global::LEASING.UI.APP.Properties.Resources._16_handIcon;
            gridViewCommandColumn1.HeaderText = "";
            gridViewCommandColumn1.Image = global::LEASING.UI.APP.Properties.Resources._16_handIcon;
            gridViewCommandColumn1.Name = "ColSelect";
            gridViewCommandColumn1.Width = 30;
            gridViewTextBoxColumn4.FieldName = "RefId";
            gridViewTextBoxColumn4.HeaderText = "Contract ID";
            gridViewTextBoxColumn4.Name = "RefId";
            gridViewTextBoxColumn4.Width = 150;
            gridViewTextBoxColumn5.FieldName = "TransactionDate";
            gridViewTextBoxColumn5.HeaderText = "Transaction Date";
            gridViewTextBoxColumn5.Name = "TransactionDate";
            gridViewTextBoxColumn5.Width = 150;
            gridViewTextBoxColumn6.FieldName = "UnitNo";
            gridViewTextBoxColumn6.HeaderText = "Unit No";
            gridViewTextBoxColumn6.Name = "UnitNo";
            gridViewTextBoxColumn6.Width = 150;
            gridViewTextBoxColumn7.FieldName = "Unit_TotalRental";
            gridViewTextBoxColumn7.HeaderText = "Total Monthly Rental";
            gridViewTextBoxColumn7.Name = "Unit_TotalRental";
            gridViewTextBoxColumn7.Width = 180;
            this.dgvContractList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn1,
            gridViewTextBoxColumn4,
            gridViewTextBoxColumn5,
            gridViewTextBoxColumn6,
            gridViewTextBoxColumn7});
            this.dgvContractList.MasterTemplate.EnableFiltering = true;
            this.dgvContractList.MasterTemplate.ShowRowHeaderColumn = false;
            this.dgvContractList.Name = "dgvContractList";
            this.dgvContractList.ReadOnly = true;
            this.dgvContractList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvContractList.ShowGroupPanel = false;
            this.dgvContractList.Size = new System.Drawing.Size(660, 239);
            this.dgvContractList.TabIndex = 0;
            this.dgvContractList.Text = "radGridView2";
            this.dgvContractList.ThemeName = "Office2010Silver";
            this.dgvContractList.CellClick += new Telerik.WinControls.UI.GridViewCellEventHandler(this.dgvContractList_CellClick);
            // 
            // frmContractInquiryAdvanceSearch
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(670, 497);
            this.Controls.Add(this.tableLayoutPanel1);
            this.DoubleBuffered = true;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmContractInquiryAdvanceSearch";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Contract Inquiry Advance Search";
            this.Load += new System.EventHandler(this.frmContractInquiryAdvanceSearch_Load);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox1)).EndInit();
            this.radGroupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvClientList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvClientList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).EndInit();
            this.radGroupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvContractList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvContractList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private Telerik.WinControls.UI.RadGroupBox radGroupBox1;
        private Telerik.WinControls.UI.RadGridView dgvClientList;
        private Telerik.WinControls.UI.RadGroupBox radGroupBox2;
        private Telerik.WinControls.UI.RadGridView dgvContractList;
        private Telerik.WinControls.Themes.Office2010SilverTheme office2010SilverTheme1;
    }
}