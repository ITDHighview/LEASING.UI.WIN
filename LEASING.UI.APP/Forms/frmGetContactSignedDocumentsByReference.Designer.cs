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
            Telerik.WinControls.UI.GridViewCommandColumn gridViewCommandColumn3 = new Telerik.WinControls.UI.GridViewCommandColumn();
            Telerik.WinControls.UI.GridViewCommandColumn gridViewCommandColumn4 = new Telerik.WinControls.UI.GridViewCommandColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn6 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn7 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn8 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn9 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn10 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            this.radGroupBox4 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvFileList = new Telerik.WinControls.UI.RadGridView();
            this.visualStudio2012DarkTheme1 = new Telerik.WinControls.Themes.VisualStudio2012DarkTheme();
            this.office2007SilverTheme1 = new Telerik.WinControls.Themes.Office2007SilverTheme();
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
            this.radGroupBox4.ThemeName = "Office2007Silver";
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
            gridViewCommandColumn3.FieldName = "ColView";
            gridViewCommandColumn3.HeaderImage = global::LEASING.UI.APP.Properties.Resources.magnifier;
            gridViewCommandColumn3.HeaderText = "";
            gridViewCommandColumn3.Image = global::LEASING.UI.APP.Properties.Resources.magnifier;
            gridViewCommandColumn3.IsPinned = true;
            gridViewCommandColumn3.Name = "ColView";
            gridViewCommandColumn3.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn3.Width = 30;
            gridViewCommandColumn4.FieldName = "ColDelete";
            gridViewCommandColumn4.HeaderImage = global::LEASING.UI.APP.Properties.Resources._16_DeleteRed;
            gridViewCommandColumn4.HeaderText = "";
            gridViewCommandColumn4.Image = global::LEASING.UI.APP.Properties.Resources._16_DeleteRed;
            gridViewCommandColumn4.IsPinned = true;
            gridViewCommandColumn4.IsVisible = false;
            gridViewCommandColumn4.Name = "ColDelete";
            gridViewCommandColumn4.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewCommandColumn4.Width = 30;
            gridViewTextBoxColumn6.FieldName = "Id";
            gridViewTextBoxColumn6.HeaderText = "File ID";
            gridViewTextBoxColumn6.IsPinned = true;
            gridViewTextBoxColumn6.Name = "Id";
            gridViewTextBoxColumn6.PinPosition = Telerik.WinControls.UI.PinnedColumnPosition.Left;
            gridViewTextBoxColumn7.FieldName = "Files";
            gridViewTextBoxColumn7.HeaderText = "File Name";
            gridViewTextBoxColumn7.Name = "Files";
            gridViewTextBoxColumn7.Width = 200;
            gridViewTextBoxColumn8.FieldName = "FileNames";
            gridViewTextBoxColumn8.HeaderText = "Description";
            gridViewTextBoxColumn8.Name = "FileNames";
            gridViewTextBoxColumn8.Width = 300;
            gridViewTextBoxColumn9.FieldName = "FilePath";
            gridViewTextBoxColumn9.HeaderText = "File Path";
            gridViewTextBoxColumn9.IsVisible = false;
            gridViewTextBoxColumn9.Name = "FilePath";
            gridViewTextBoxColumn9.Width = 300;
            gridViewTextBoxColumn10.FieldName = "Notes";
            gridViewTextBoxColumn10.HeaderText = "Notes";
            gridViewTextBoxColumn10.Name = "Notes";
            gridViewTextBoxColumn10.Width = 450;
            this.dgvFileList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn3,
            gridViewCommandColumn4,
            gridViewTextBoxColumn6,
            gridViewTextBoxColumn7,
            gridViewTextBoxColumn8,
            gridViewTextBoxColumn9,
            gridViewTextBoxColumn10});
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
        private Telerik.WinControls.Themes.Office2007SilverTheme office2007SilverTheme1;
    }
}