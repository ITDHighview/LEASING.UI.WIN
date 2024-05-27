namespace LEASING.UI.APP.Forms
{
    partial class frmClientRecieptTransactionList
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
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.radGroupBox2 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvReceiptList = new Telerik.WinControls.UI.RadGridView();
            this.office2007SilverTheme1 = new Telerik.WinControls.Themes.Office2007SilverTheme();
            this.visualStudio2012DarkTheme1 = new Telerik.WinControls.Themes.VisualStudio2012DarkTheme();
            this.tableLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).BeginInit();
            this.radGroupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvReceiptList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvReceiptList.MasterTemplate)).BeginInit();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Controls.Add(this.radGroupBox2, 0, 0);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 1;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(916, 430);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // radGroupBox2
            // 
            this.radGroupBox2.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox2.Controls.Add(this.dgvReceiptList);
            this.radGroupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox2.HeaderText = "RECEIPT LIST";
            this.radGroupBox2.Location = new System.Drawing.Point(3, 3);
            this.radGroupBox2.Name = "radGroupBox2";
            this.radGroupBox2.Size = new System.Drawing.Size(910, 424);
            this.radGroupBox2.TabIndex = 2;
            this.radGroupBox2.Text = "RECEIPT LIST";
            this.radGroupBox2.ThemeName = "Office2007Silver";
            // 
            // dgvReceiptList
            // 
            this.dgvReceiptList.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.dgvReceiptList.Cursor = System.Windows.Forms.Cursors.Default;
            this.dgvReceiptList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvReceiptList.Font = new System.Drawing.Font("Segoe UI", 8.25F);
            this.dgvReceiptList.ForeColor = System.Drawing.Color.Black;
            this.dgvReceiptList.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.dgvReceiptList.Location = new System.Drawing.Point(2, 18);
            // 
            // dgvReceiptList
            // 
            this.dgvReceiptList.MasterTemplate.AllowAddNewRow = false;
            this.dgvReceiptList.MasterTemplate.AllowColumnReorder = false;
            gridViewCommandColumn1.FieldName = "ColPrint";
            gridViewCommandColumn1.HeaderImage = global::LEASING.UI.APP.Properties.Resources.print_16;
            gridViewCommandColumn1.HeaderText = "";
            gridViewCommandColumn1.Image = global::LEASING.UI.APP.Properties.Resources.print_16;
            gridViewCommandColumn1.Name = "ColPrint";
            gridViewCommandColumn1.Width = 30;
            gridViewCommandColumn2.FieldName = "ColEditOR";
            gridViewCommandColumn2.HeaderText = "";
            gridViewCommandColumn2.Image = global::LEASING.UI.APP.Properties.Resources.co_folder_20;
            gridViewCommandColumn2.Name = "ColEditOR";
            gridViewCommandColumn2.Width = 30;
            gridViewTextBoxColumn1.FieldName = "RefId";
            gridViewTextBoxColumn1.HeaderText = "Contract ID";
            gridViewTextBoxColumn1.Name = "RefId";
            gridViewTextBoxColumn1.Width = 150;
            gridViewTextBoxColumn2.FieldName = "TranID";
            gridViewTextBoxColumn2.HeaderText = "Transaction ID";
            gridViewTextBoxColumn2.Name = "TranID";
            gridViewTextBoxColumn2.Width = 120;
            gridViewTextBoxColumn3.FieldName = "RcptID";
            gridViewTextBoxColumn3.HeaderText = "Receipt ID";
            gridViewTextBoxColumn3.Name = "RcptID";
            gridViewTextBoxColumn3.Width = 120;
            gridViewTextBoxColumn4.FieldName = "PayID";
            gridViewTextBoxColumn4.HeaderText = "Payment ID";
            gridViewTextBoxColumn4.Name = "PayID";
            gridViewTextBoxColumn4.Width = 120;
            gridViewTextBoxColumn5.FieldName = "PaidAmount";
            gridViewTextBoxColumn5.HeaderText = "Paid Amount";
            gridViewTextBoxColumn5.Name = "PaidAmount";
            gridViewTextBoxColumn5.Width = 100;
            gridViewTextBoxColumn6.FieldName = "PayDate";
            gridViewTextBoxColumn6.HeaderText = "Pay Date";
            gridViewTextBoxColumn6.Name = "PayDate";
            gridViewTextBoxColumn6.Width = 120;
            gridViewTextBoxColumn7.FieldName = "CompanyORNo";
            gridViewTextBoxColumn7.HeaderText = "OR No.";
            gridViewTextBoxColumn7.Name = "CompanyORNo";
            gridViewTextBoxColumn7.Width = 150;
            gridViewTextBoxColumn8.FieldName = "CompanyPRNo";
            gridViewTextBoxColumn8.HeaderText = "PR No.";
            gridViewTextBoxColumn8.Name = "CompanyPRNo";
            gridViewTextBoxColumn8.Width = 150;
            this.dgvReceiptList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn1,
            gridViewCommandColumn2,
            gridViewTextBoxColumn1,
            gridViewTextBoxColumn2,
            gridViewTextBoxColumn3,
            gridViewTextBoxColumn4,
            gridViewTextBoxColumn5,
            gridViewTextBoxColumn6,
            gridViewTextBoxColumn7,
            gridViewTextBoxColumn8});
            this.dgvReceiptList.MasterTemplate.EnableFiltering = true;
            this.dgvReceiptList.MasterTemplate.ShowRowHeaderColumn = false;
            this.dgvReceiptList.Name = "dgvReceiptList";
            this.dgvReceiptList.Padding = new System.Windows.Forms.Padding(0, 0, 0, 1);
            this.dgvReceiptList.ReadOnly = true;
            this.dgvReceiptList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvReceiptList.ShowGroupPanel = false;
            this.dgvReceiptList.Size = new System.Drawing.Size(906, 404);
            this.dgvReceiptList.TabIndex = 0;
            this.dgvReceiptList.Text = "radGridView1";
            this.dgvReceiptList.ThemeName = "VisualStudio2012Dark";
            this.dgvReceiptList.CellFormatting += new Telerik.WinControls.UI.CellFormattingEventHandler(this.dgvReceiptList_CellFormatting);
            this.dgvReceiptList.CellClick += new Telerik.WinControls.UI.GridViewCellEventHandler(this.dgvReceiptList_CellClick);
            // 
            // frmClientRecieptTransactionList
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.ClientSize = new System.Drawing.Size(916, 430);
            this.Controls.Add(this.tableLayoutPanel1);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmClientRecieptTransactionList";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Reciept Transaction";
            this.Load += new System.EventHandler(this.frmClientRecieptTransaction_Load);
            this.tableLayoutPanel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).EndInit();
            this.radGroupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvReceiptList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvReceiptList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private Telerik.WinControls.UI.RadGroupBox radGroupBox2;
        private Telerik.WinControls.UI.RadGridView dgvReceiptList;
        private Telerik.WinControls.Themes.Office2007SilverTheme office2007SilverTheme1;
        private Telerik.WinControls.Themes.VisualStudio2012DarkTheme visualStudio2012DarkTheme1;
    }
}