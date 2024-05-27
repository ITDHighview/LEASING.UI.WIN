namespace LEASING.UI.APP.Forms
{
    partial class frmSelectClientReferencePaid
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
            this.radGroupBox1.HeaderText = "Contract List";
            this.radGroupBox1.Location = new System.Drawing.Point(0, 0);
            this.radGroupBox1.Name = "radGroupBox1";
            this.radGroupBox1.Size = new System.Drawing.Size(228, 280);
            this.radGroupBox1.TabIndex = 0;
            this.radGroupBox1.Text = "Contract List";
            this.radGroupBox1.ThemeName = "Office2007Silver";
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
            gridViewTextBoxColumn1.FieldName = "RefId";
            gridViewTextBoxColumn1.HeaderText = "Contract ID";
            gridViewTextBoxColumn1.Name = "RefId";
            gridViewTextBoxColumn1.Width = 200;
            this.dgvList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewTextBoxColumn1});
            this.dgvList.Name = "dgvList";
            this.dgvList.Padding = new System.Windows.Forms.Padding(0, 0, 0, 1);
            this.dgvList.ReadOnly = true;
            this.dgvList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvList.ShowGroupPanel = false;
            this.dgvList.Size = new System.Drawing.Size(224, 260);
            this.dgvList.TabIndex = 0;
            this.dgvList.Text = "radGridView1";
            this.dgvList.ThemeName = "Office2007Silver";
            this.dgvList.CellDoubleClick += new Telerik.WinControls.UI.GridViewCellEventHandler(this.dgvList_CellDoubleClick);
            // 
            // frmSelectClientReferencePaid
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(228, 280);
            this.Controls.Add(this.radGroupBox1);
            this.DoubleBuffered = true;
            this.Name = "frmSelectClientReferencePaid";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Reference";
            this.Load += new System.EventHandler(this.frmSelectClientReferencePaid_Load);
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