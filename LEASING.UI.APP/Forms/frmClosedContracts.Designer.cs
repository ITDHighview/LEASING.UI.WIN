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
            Telerik.WinControls.UI.GridViewCommandColumn gridViewCommandColumn4 = new Telerik.WinControls.UI.GridViewCommandColumn();
            Telerik.WinControls.UI.GridViewCommandColumn gridViewCommandColumn5 = new Telerik.WinControls.UI.GridViewCommandColumn();
            Telerik.WinControls.UI.GridViewCommandColumn gridViewCommandColumn6 = new Telerik.WinControls.UI.GridViewCommandColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn6 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn7 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn8 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn9 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn10 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            this.radGroupBox1 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvList = new Telerik.WinControls.UI.RadGridView();
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
            gridViewCommandColumn4.FieldName = "ColLedger";
            gridViewCommandColumn4.HeaderImage = global::LEASING.UI.APP.Properties.Resources._16_MyLogsBook;
            gridViewCommandColumn4.HeaderText = "";
            gridViewCommandColumn4.Image = global::LEASING.UI.APP.Properties.Resources._16_MyLogsBook;
            gridViewCommandColumn4.Name = "ColLedger";
            gridViewCommandColumn4.Width = 30;
            gridViewCommandColumn5.FieldName = "ColViewFile";
            gridViewCommandColumn5.HeaderImage = global::LEASING.UI.APP.Properties.Resources.attach;
            gridViewCommandColumn5.HeaderText = "";
            gridViewCommandColumn5.Image = global::LEASING.UI.APP.Properties.Resources.attach;
            gridViewCommandColumn5.Name = "ColViewFile";
            gridViewCommandColumn5.Width = 30;
            gridViewCommandColumn6.FieldName = "ColView";
            gridViewCommandColumn6.HeaderImage = global::LEASING.UI.APP.Properties.Resources.magnifier;
            gridViewCommandColumn6.HeaderText = "";
            gridViewCommandColumn6.Image = global::LEASING.UI.APP.Properties.Resources.magnifier;
            gridViewCommandColumn6.Name = "ColView";
            gridViewCommandColumn6.Width = 30;
            gridViewTextBoxColumn6.FieldName = "RefId";
            gridViewTextBoxColumn6.HeaderText = "Referrence ID";
            gridViewTextBoxColumn6.Name = "RefId";
            gridViewTextBoxColumn6.Width = 150;
            gridViewTextBoxColumn7.FieldName = "ClientID";
            gridViewTextBoxColumn7.HeaderText = "Client ID";
            gridViewTextBoxColumn7.Name = "ClientID";
            gridViewTextBoxColumn7.Width = 150;
            gridViewTextBoxColumn8.FieldName = "InquiringClient";
            gridViewTextBoxColumn8.HeaderText = "Client";
            gridViewTextBoxColumn8.Name = "InquiringClient";
            gridViewTextBoxColumn8.Width = 200;
            gridViewTextBoxColumn9.FieldName = "Contract_Status";
            gridViewTextBoxColumn9.HeaderText = "Status";
            gridViewTextBoxColumn9.Name = "Contract_Status";
            gridViewTextBoxColumn9.Width = 150;
            gridViewTextBoxColumn10.FieldName = "RecId";
            gridViewTextBoxColumn10.HeaderText = "RecId";
            gridViewTextBoxColumn10.IsVisible = false;
            gridViewTextBoxColumn10.Name = "RecId";
            this.dgvList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn4,
            gridViewCommandColumn5,
            gridViewCommandColumn6,
            gridViewTextBoxColumn6,
            gridViewTextBoxColumn7,
            gridViewTextBoxColumn8,
            gridViewTextBoxColumn9,
            gridViewTextBoxColumn10});
            this.dgvList.MasterTemplate.EnableFiltering = true;
            this.dgvList.Name = "dgvList";
            this.dgvList.ReadOnly = true;
            this.dgvList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvList.ShowGroupPanel = false;
            this.dgvList.Size = new System.Drawing.Size(759, 318);
            this.dgvList.TabIndex = 0;
            this.dgvList.Text = "radGridView1";
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
    }
}