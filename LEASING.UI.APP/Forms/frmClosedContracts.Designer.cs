namespace LEASING.UI.APP.Forms
{
    partial class frmClosedContracts
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
            this.radGroupBox1 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvList = new Telerik.WinControls.UI.RadGridView();
            this.office2007SilverTheme1 = new Telerik.WinControls.Themes.Office2007SilverTheme();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox1)).BeginInit();
            this.radGroupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvList.MasterTemplate)).BeginInit();
            this.SuspendLayout();
            // 
            // radGroupBox1
            // 
            this.radGroupBox1.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox1.Controls.Add(this.dgvList);
            this.radGroupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox1.HeaderText = "CONTRACT LIST";
            this.radGroupBox1.Location = new System.Drawing.Point(0, 0);
            this.radGroupBox1.Name = "radGroupBox1";
            this.radGroupBox1.Size = new System.Drawing.Size(763, 338);
            this.radGroupBox1.TabIndex = 2;
            this.radGroupBox1.Text = "CONTRACT LIST";
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
            gridViewCommandColumn1.FieldName = "ColLedger";
            gridViewCommandColumn1.HeaderImage = global::LEASING.UI.APP.Properties.Resources._16_MyLogsBook;
            gridViewCommandColumn1.HeaderText = "";
            gridViewCommandColumn1.Image = global::LEASING.UI.APP.Properties.Resources._16_MyLogsBook;
            gridViewCommandColumn1.Name = "ColLedger";
            gridViewCommandColumn1.Width = 30;
            gridViewCommandColumn2.FieldName = "ColViewFile";
            gridViewCommandColumn2.HeaderImage = global::LEASING.UI.APP.Properties.Resources.attach;
            gridViewCommandColumn2.HeaderText = "";
            gridViewCommandColumn2.Image = global::LEASING.UI.APP.Properties.Resources.attach;
            gridViewCommandColumn2.Name = "ColViewFile";
            gridViewCommandColumn2.Width = 30;
            gridViewCommandColumn3.FieldName = "ColView";
            gridViewCommandColumn3.HeaderImage = global::LEASING.UI.APP.Properties.Resources.magnifier;
            gridViewCommandColumn3.HeaderText = "";
            gridViewCommandColumn3.Image = global::LEASING.UI.APP.Properties.Resources.magnifier;
            gridViewCommandColumn3.Name = "ColView";
            gridViewCommandColumn3.Width = 30;
            gridViewTextBoxColumn1.FieldName = "RefId";
            gridViewTextBoxColumn1.HeaderText = "Contract ID";
            gridViewTextBoxColumn1.Name = "RefId";
            gridViewTextBoxColumn1.Width = 150;
            gridViewTextBoxColumn2.FieldName = "ClientID";
            gridViewTextBoxColumn2.HeaderText = "Client ID";
            gridViewTextBoxColumn2.Name = "ClientID";
            gridViewTextBoxColumn2.Width = 150;
            gridViewTextBoxColumn3.FieldName = "InquiringClient";
            gridViewTextBoxColumn3.HeaderText = "Client";
            gridViewTextBoxColumn3.Name = "InquiringClient";
            gridViewTextBoxColumn3.Width = 200;
            gridViewTextBoxColumn4.FieldName = "Contract_Status";
            gridViewTextBoxColumn4.HeaderText = "Status";
            gridViewTextBoxColumn4.Name = "Contract_Status";
            gridViewTextBoxColumn4.Width = 150;
            gridViewTextBoxColumn5.FieldName = "RecId";
            gridViewTextBoxColumn5.HeaderText = "RecId";
            gridViewTextBoxColumn5.IsVisible = false;
            gridViewTextBoxColumn5.Name = "RecId";
            this.dgvList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn1,
            gridViewCommandColumn2,
            gridViewCommandColumn3,
            gridViewTextBoxColumn1,
            gridViewTextBoxColumn2,
            gridViewTextBoxColumn3,
            gridViewTextBoxColumn4,
            gridViewTextBoxColumn5});
            this.dgvList.MasterTemplate.EnableFiltering = true;
            this.dgvList.Name = "dgvList";
            this.dgvList.Padding = new System.Windows.Forms.Padding(0, 0, 0, 1);
            this.dgvList.ReadOnly = true;
            this.dgvList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvList.ShowGroupPanel = false;
            this.dgvList.Size = new System.Drawing.Size(759, 318);
            this.dgvList.TabIndex = 0;
            this.dgvList.Text = "radGridView1";
            this.dgvList.ThemeName = "Office2007Silver";
            this.dgvList.CellClick += new Telerik.WinControls.UI.GridViewCellEventHandler(this.dgvList_CellClick);
            // 
            // frmClosedContracts
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(763, 338);
            this.Controls.Add(this.radGroupBox1);
            this.DoubleBuffered = true;
            this.Name = "frmClosedContracts";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Closed Contracts";
            this.Load += new System.EventHandler(this.frmClosedContracts_Load);
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox1)).EndInit();
            this.radGroupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Telerik.WinControls.UI.RadGroupBox radGroupBox1;
        private Telerik.WinControls.UI.RadGridView dgvList;
        private Telerik.WinControls.Themes.Office2007SilverTheme office2007SilverTheme1;
    }
}