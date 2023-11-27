namespace LEASING.UI.APP.Forms
{
    partial class frmGetContactSignedDocumentsByReference
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
            this.radGroupBox4 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvFileList = new Telerik.WinControls.UI.RadGridView();
            this.visualStudio2012DarkTheme1 = new Telerik.WinControls.Themes.VisualStudio2012DarkTheme();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox4)).BeginInit();
            this.radGroupBox4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvFileList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvFileList.MasterTemplate)).BeginInit();
            this.SuspendLayout();
            // 
            // radGroupBox4
            // 
            this.radGroupBox4.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox4.Controls.Add(this.dgvFileList);
            this.radGroupBox4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox4.HeaderText = "ATTACHMENT LIST";
            this.radGroupBox4.Location = new System.Drawing.Point(0, 0);
            this.radGroupBox4.Name = "radGroupBox4";
            this.radGroupBox4.Size = new System.Drawing.Size(899, 239);
            this.radGroupBox4.TabIndex = 2;
            this.radGroupBox4.Text = "ATTACHMENT LIST";
            this.radGroupBox4.ThemeName = "Office2007Black";
            // 
            // dgvFileList
            // 
            this.dgvFileList.BackColor = System.Drawing.SystemColors.Control;
            this.dgvFileList.Cursor = System.Windows.Forms.Cursors.Default;
            this.dgvFileList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvFileList.Font = new System.Drawing.Font("Segoe UI", 8.25F);
            this.dgvFileList.ForeColor = System.Drawing.Color.Black;
            this.dgvFileList.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.dgvFileList.Location = new System.Drawing.Point(2, 18);
            // 
            // dgvFileList
            // 
            this.dgvFileList.MasterTemplate.AllowAddNewRow = false;
            this.dgvFileList.MasterTemplate.AllowColumnReorder = false;
            gridViewCommandColumn1.FieldName = "ColView";
            gridViewCommandColumn1.HeaderImage = global::LEASING.UI.APP.Properties.Resources.magnifier;
            gridViewCommandColumn1.HeaderText = "";
            gridViewCommandColumn1.Image = global::LEASING.UI.APP.Properties.Resources.magnifier;
            gridViewCommandColumn1.IsPinned = true;
            gridViewCommandColumn1.Name = "ColView";
            gridViewCommandColumn1.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn1.Width = 30;
            gridViewCommandColumn2.FieldName = "ColDelete";
            gridViewCommandColumn2.HeaderImage = global::LEASING.UI.APP.Properties.Resources._16_DeleteRed;
            gridViewCommandColumn2.HeaderText = "";
            gridViewCommandColumn2.Image = global::LEASING.UI.APP.Properties.Resources._16_DeleteRed;
            gridViewCommandColumn2.IsPinned = true;
            gridViewCommandColumn2.IsVisible = false;
            gridViewCommandColumn2.Name = "ColDelete";
            gridViewCommandColumn2.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn2.Width = 30;
            gridViewTextBoxColumn1.FieldName = "Id";
            gridViewTextBoxColumn1.HeaderText = "File ID";
            gridViewTextBoxColumn1.IsPinned = true;
            gridViewTextBoxColumn1.Name = "Id";
            gridViewTextBoxColumn1.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewTextBoxColumn2.FieldName = "Files";
            gridViewTextBoxColumn2.HeaderText = "File Name";
            gridViewTextBoxColumn2.Name = "Files";
            gridViewTextBoxColumn2.Width = 200;
            gridViewTextBoxColumn3.FieldName = "FileNames";
            gridViewTextBoxColumn3.HeaderText = "Description";
            gridViewTextBoxColumn3.Name = "FileNames";
            gridViewTextBoxColumn3.Width = 300;
            gridViewTextBoxColumn4.FieldName = "FilePath";
            gridViewTextBoxColumn4.HeaderText = "File Path";
            gridViewTextBoxColumn4.IsVisible = false;
            gridViewTextBoxColumn4.Name = "FilePath";
            gridViewTextBoxColumn4.Width = 300;
            gridViewTextBoxColumn5.FieldName = "Notes";
            gridViewTextBoxColumn5.HeaderText = "Notes";
            gridViewTextBoxColumn5.Name = "Notes";
            gridViewTextBoxColumn5.Width = 450;
            this.dgvFileList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn1,
            gridViewCommandColumn2,
            gridViewTextBoxColumn1,
            gridViewTextBoxColumn2,
            gridViewTextBoxColumn3,
            gridViewTextBoxColumn4,
            gridViewTextBoxColumn5});
            this.dgvFileList.MasterTemplate.EnableFiltering = true;
            this.dgvFileList.Name = "dgvFileList";
            this.dgvFileList.ReadOnly = true;
            this.dgvFileList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvFileList.ShowGroupPanel = false;
            this.dgvFileList.Size = new System.Drawing.Size(895, 219);
            this.dgvFileList.TabIndex = 0;
            this.dgvFileList.Text = "radGridView2";
            this.dgvFileList.ThemeName = "VisualStudio2012Dark";
            this.dgvFileList.CellClick += new Telerik.WinControls.UI.GridViewCellEventHandler(this.dgvFileList_CellClick);
            // 
            // frmGetContactSignedDocumentsByReference
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(899, 239);
            this.Controls.Add(this.radGroupBox4);
            this.DoubleBuffered = true;
            this.Name = "frmGetContactSignedDocumentsByReference";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Documents";
            this.Load += new System.EventHandler(this.frmGetContactSignedDocumentsByReference_Load);
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox4)).EndInit();
            this.radGroupBox4.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvFileList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvFileList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Telerik.WinControls.UI.RadGroupBox radGroupBox4;
        private Telerik.WinControls.UI.RadGridView dgvFileList;
        private Telerik.WinControls.Themes.VisualStudio2012DarkTheme visualStudio2012DarkTheme1;
    }
}