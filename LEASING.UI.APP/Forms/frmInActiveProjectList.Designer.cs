namespace LEASING.UI.APP.Forms
{
    partial class frmInActiveProjectList
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
            this.radGroupBox4 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvProjectList = new Telerik.WinControls.UI.RadGridView();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox4)).BeginInit();
            this.radGroupBox4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvProjectList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvProjectList.MasterTemplate)).BeginInit();
            this.SuspendLayout();
            // 
            // radGroupBox4
            // 
            this.radGroupBox4.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox4.Controls.Add(this.dgvProjectList);
            this.radGroupBox4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox4.HeaderText = "PROJECT LIST";
            this.radGroupBox4.Location = new System.Drawing.Point(0, 0);
            this.radGroupBox4.Name = "radGroupBox4";
            this.radGroupBox4.Size = new System.Drawing.Size(1028, 465);
            this.radGroupBox4.TabIndex = 2;
            this.radGroupBox4.Text = "PROJECT LIST";
            // 
            // dgvProjectList
            // 
            this.dgvProjectList.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(233)))), ((int)(((byte)(240)))), ((int)(((byte)(249)))));
            this.dgvProjectList.Cursor = System.Windows.Forms.Cursors.Default;
            this.dgvProjectList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvProjectList.Font = new System.Drawing.Font("Segoe UI", 8.25F);
            this.dgvProjectList.ForeColor = System.Drawing.Color.Black;
            this.dgvProjectList.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.dgvProjectList.Location = new System.Drawing.Point(2, 18);
            // 
            // dgvProjectList
            // 
            this.dgvProjectList.MasterTemplate.AllowAddNewRow = false;
            this.dgvProjectList.MasterTemplate.AllowColumnReorder = false;
            gridViewCommandColumn1.FieldName = "ColActivate";
            gridViewCommandColumn1.HeaderImage = global::LEASING.UI.APP.Properties.Resources.co_checkmark_16;
            gridViewCommandColumn1.HeaderText = "";
            gridViewCommandColumn1.Image = global::LEASING.UI.APP.Properties.Resources.co_checkmark_16;
            gridViewCommandColumn1.IsPinned = true;
            gridViewCommandColumn1.Name = "ColActivate";
            gridViewCommandColumn1.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn1.Width = 30;
            gridViewCommandColumn2.FieldName = "ColDelete";
            gridViewCommandColumn2.HeaderImage = global::LEASING.UI.APP.Properties.Resources._16_DeleteRed;
            gridViewCommandColumn2.HeaderText = "";
            gridViewCommandColumn2.Image = global::LEASING.UI.APP.Properties.Resources._16_DeleteRed;
            gridViewCommandColumn2.IsPinned = true;
            gridViewCommandColumn2.Name = "ColDelete";
            gridViewCommandColumn2.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn2.Width = 30;
            gridViewTextBoxColumn1.FieldName = "RecId";
            gridViewTextBoxColumn1.HeaderText = "PROJECT ID";
            gridViewTextBoxColumn1.IsPinned = true;
            gridViewTextBoxColumn1.Name = "RecId";
            gridViewTextBoxColumn1.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewTextBoxColumn1.WrapText = true;
            gridViewTextBoxColumn2.EnableExpressionEditor = false;
            gridViewTextBoxColumn2.FieldName = "LocationName";
            gridViewTextBoxColumn2.HeaderText = "Location";
            gridViewTextBoxColumn2.Name = "LocationName";
            gridViewTextBoxColumn2.Width = 150;
            gridViewTextBoxColumn3.FieldName = "ProjectAddress";
            gridViewTextBoxColumn3.HeaderText = "Address";
            gridViewTextBoxColumn3.Name = "ProjectAddress";
            gridViewTextBoxColumn3.Width = 300;
            gridViewTextBoxColumn4.EnableExpressionEditor = false;
            gridViewTextBoxColumn4.FieldName = "ProjectName";
            gridViewTextBoxColumn4.HeaderText = "Name";
            gridViewTextBoxColumn4.Name = "ProjectName";
            gridViewTextBoxColumn4.Width = 300;
            gridViewTextBoxColumn5.EnableExpressionEditor = false;
            gridViewTextBoxColumn5.FieldName = "Descriptions";
            gridViewTextBoxColumn5.HeaderText = "Descriptions";
            gridViewTextBoxColumn5.Name = "Descriptions";
            gridViewTextBoxColumn5.Width = 200;
            gridViewTextBoxColumn6.EnableExpressionEditor = false;
            gridViewTextBoxColumn6.FieldName = "IsActive";
            gridViewTextBoxColumn6.HeaderText = "Status";
            gridViewTextBoxColumn6.IsVisible = false;
            gridViewTextBoxColumn6.Name = "IsActive";
            gridViewTextBoxColumn6.Width = 100;
            this.dgvProjectList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn1,
            gridViewCommandColumn2,
            gridViewTextBoxColumn1,
            gridViewTextBoxColumn2,
            gridViewTextBoxColumn3,
            gridViewTextBoxColumn4,
            gridViewTextBoxColumn5,
            gridViewTextBoxColumn6});
            this.dgvProjectList.MasterTemplate.EnableFiltering = true;
            this.dgvProjectList.MasterTemplate.ShowRowHeaderColumn = false;
            this.dgvProjectList.Name = "dgvProjectList";
            this.dgvProjectList.ReadOnly = true;
            this.dgvProjectList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvProjectList.ShowGroupPanel = false;
            this.dgvProjectList.Size = new System.Drawing.Size(1024, 445);
            this.dgvProjectList.TabIndex = 3;
            this.dgvProjectList.Text = "radGridView1";
            this.dgvProjectList.ThemeName = "ControlDefault";
            this.dgvProjectList.CellClick += new Telerik.WinControls.UI.GridViewCellEventHandler(this.dgvProjectList_CellClick);
            // 
            // frmInActiveProjectList
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1028, 465);
            this.Controls.Add(this.radGroupBox4);
            this.DoubleBuffered = true;
            this.Name = "frmInActiveProjectList";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "In-Active Project";
            this.Load += new System.EventHandler(this.frmInActiveProjectList_Load);
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox4)).EndInit();
            this.radGroupBox4.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvProjectList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvProjectList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Telerik.WinControls.UI.RadGroupBox radGroupBox4;
        private Telerik.WinControls.UI.RadGridView dgvProjectList;
    }
}