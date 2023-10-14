namespace LEASING.UI.APP.Forms
{
    partial class frmInActiveLocationList
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
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn5 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn6 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn7 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn8 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            this.radGroupBox2 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvLocationList = new Telerik.WinControls.UI.RadGridView();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).BeginInit();
            this.radGroupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvLocationList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvLocationList.MasterTemplate)).BeginInit();
            this.SuspendLayout();
            // 
            // radGroupBox2
            // 
            this.radGroupBox2.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox2.Controls.Add(this.dgvLocationList);
            this.radGroupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox2.HeaderText = "LOCATION LIST";
            this.radGroupBox2.Location = new System.Drawing.Point(0, 0);
            this.radGroupBox2.Name = "radGroupBox2";
            this.radGroupBox2.Size = new System.Drawing.Size(736, 465);
            this.radGroupBox2.TabIndex = 2;
            this.radGroupBox2.Text = "LOCATION LIST";
            // 
            // dgvLocationList
            // 
            this.dgvLocationList.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(233)))), ((int)(((byte)(240)))), ((int)(((byte)(249)))));
            this.dgvLocationList.Cursor = System.Windows.Forms.Cursors.Default;
            this.dgvLocationList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvLocationList.Font = new System.Drawing.Font("Segoe UI", 8.25F);
            this.dgvLocationList.ForeColor = System.Drawing.Color.Black;
            this.dgvLocationList.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.dgvLocationList.Location = new System.Drawing.Point(2, 18);
            // 
            // dgvLocationList
            // 
            this.dgvLocationList.MasterTemplate.AllowAddNewRow = false;
            this.dgvLocationList.MasterTemplate.AllowColumnReorder = false;
            gridViewCommandColumn3.FieldName = "ColActivate";
            gridViewCommandColumn3.HeaderImage = global::LEASING.UI.APP.Properties.Resources.co_checkmark_16;
            gridViewCommandColumn3.HeaderText = "";
            gridViewCommandColumn3.Image = global::LEASING.UI.APP.Properties.Resources.co_checkmark_16;
            gridViewCommandColumn3.Name = "ColActivate";
            gridViewCommandColumn3.Width = 30;
            gridViewCommandColumn4.FieldName = "ColDiActivate";
            gridViewCommandColumn4.HeaderImage = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            gridViewCommandColumn4.HeaderText = "";
            gridViewCommandColumn4.Image = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            gridViewCommandColumn4.Name = "ColDiActivate";
            gridViewCommandColumn4.Width = 30;
            gridViewTextBoxColumn5.EnableExpressionEditor = false;
            gridViewTextBoxColumn5.FieldName = "RecId";
            gridViewTextBoxColumn5.HeaderText = "LOC ID";
            gridViewTextBoxColumn5.Name = "RecId";
            gridViewTextBoxColumn5.Width = 100;
            gridViewTextBoxColumn6.EnableExpressionEditor = false;
            gridViewTextBoxColumn6.FieldName = "Descriptions";
            gridViewTextBoxColumn6.HeaderText = "Descriptions";
            gridViewTextBoxColumn6.Name = "Descriptions";
            gridViewTextBoxColumn6.Width = 200;
            gridViewTextBoxColumn7.EnableExpressionEditor = false;
            gridViewTextBoxColumn7.FieldName = "LocAddress";
            gridViewTextBoxColumn7.HeaderText = "Address";
            gridViewTextBoxColumn7.Name = "LocAddress";
            gridViewTextBoxColumn7.Width = 400;
            gridViewTextBoxColumn8.EnableExpressionEditor = false;
            gridViewTextBoxColumn8.FieldName = "IsActive";
            gridViewTextBoxColumn8.HeaderText = "Status";
            gridViewTextBoxColumn8.IsVisible = false;
            gridViewTextBoxColumn8.Name = "IsActive";
            gridViewTextBoxColumn8.Width = 100;
            this.dgvLocationList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn3,
            gridViewCommandColumn4,
            gridViewTextBoxColumn5,
            gridViewTextBoxColumn6,
            gridViewTextBoxColumn7,
            gridViewTextBoxColumn8});
            this.dgvLocationList.MasterTemplate.EnableFiltering = true;
            this.dgvLocationList.MasterTemplate.ShowRowHeaderColumn = false;
            this.dgvLocationList.Name = "dgvLocationList";
            this.dgvLocationList.ReadOnly = true;
            this.dgvLocationList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvLocationList.ShowGroupPanel = false;
            this.dgvLocationList.Size = new System.Drawing.Size(732, 445);
            this.dgvLocationList.TabIndex = 0;
            this.dgvLocationList.Text = "radGridView1";
            this.dgvLocationList.ThemeName = "ControlDefault";
            this.dgvLocationList.CellClick += new Telerik.WinControls.UI.GridViewCellEventHandler(this.dgvLocationList_CellClick);
            // 
            // frmInActiveLocationList
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(736, 465);
            this.Controls.Add(this.radGroupBox2);
            this.Name = "frmInActiveLocationList";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = " In-Active Location";
            this.Load += new System.EventHandler(this.frmInActiveLocationList_Load);
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).EndInit();
            this.radGroupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvLocationList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvLocationList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Telerik.WinControls.UI.RadGroupBox radGroupBox2;
        private Telerik.WinControls.UI.RadGridView dgvLocationList;
    }
}