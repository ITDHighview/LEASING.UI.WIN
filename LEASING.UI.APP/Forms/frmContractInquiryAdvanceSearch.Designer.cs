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
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.radGroupBox1 = new Telerik.WinControls.UI.RadGroupBox();
            this.radGroupBox2 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvPatientList = new Telerik.WinControls.UI.RadGridView();
            this.dgvContractList = new Telerik.WinControls.UI.RadGridView();
            this.tableLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox1)).BeginInit();
            this.radGroupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).BeginInit();
            this.radGroupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPatientList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPatientList.MasterTemplate)).BeginInit();
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
            this.tableLayoutPanel1.Size = new System.Drawing.Size(578, 497);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // toolStrip1
            // 
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(578, 25);
            this.toolStrip1.TabIndex = 1;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // radGroupBox1
            // 
            this.radGroupBox1.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox1.Controls.Add(this.dgvPatientList);
            this.radGroupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox1.HeaderText = "Patient";
            this.radGroupBox1.HeaderTextAlignment = System.Drawing.ContentAlignment.BottomRight;
            this.radGroupBox1.Location = new System.Drawing.Point(3, 28);
            this.radGroupBox1.Name = "radGroupBox1";
            this.radGroupBox1.Size = new System.Drawing.Size(572, 201);
            this.radGroupBox1.TabIndex = 2;
            this.radGroupBox1.Text = "Patient";
            // 
            // radGroupBox2
            // 
            this.radGroupBox2.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox2.Controls.Add(this.dgvContractList);
            this.radGroupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox2.HeaderText = "Contract";
            this.radGroupBox2.Location = new System.Drawing.Point(3, 235);
            this.radGroupBox2.Name = "radGroupBox2";
            this.radGroupBox2.Size = new System.Drawing.Size(572, 259);
            this.radGroupBox2.TabIndex = 2;
            this.radGroupBox2.Text = "Contract";
            // 
            // dgvPatientList
            // 
            this.dgvPatientList.BackColor = System.Drawing.SystemColors.Control;
            this.dgvPatientList.Cursor = System.Windows.Forms.Cursors.Default;
            this.dgvPatientList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvPatientList.Font = new System.Drawing.Font("Segoe UI", 8.25F);
            this.dgvPatientList.ForeColor = System.Drawing.Color.Black;
            this.dgvPatientList.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.dgvPatientList.Location = new System.Drawing.Point(2, 18);
            // 
            // dgvPatientList
            // 
            this.dgvPatientList.MasterTemplate.AllowAddNewRow = false;
            this.dgvPatientList.MasterTemplate.AllowColumnReorder = false;
            this.dgvPatientList.MasterTemplate.EnableFiltering = true;
            this.dgvPatientList.Name = "dgvPatientList";
            this.dgvPatientList.ReadOnly = true;
            this.dgvPatientList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvPatientList.ShowGroupPanel = false;
            this.dgvPatientList.Size = new System.Drawing.Size(568, 181);
            this.dgvPatientList.TabIndex = 0;
            this.dgvPatientList.Text = "radGridView1";
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
            this.dgvContractList.MasterTemplate.EnableFiltering = true;
            this.dgvContractList.Name = "dgvContractList";
            this.dgvContractList.ReadOnly = true;
            this.dgvContractList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvContractList.ShowGroupPanel = false;
            this.dgvContractList.Size = new System.Drawing.Size(568, 239);
            this.dgvContractList.TabIndex = 0;
            this.dgvContractList.Text = "radGridView2";
            // 
            // frmContractInquiryAdvanceSearch
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(578, 497);
            this.Controls.Add(this.tableLayoutPanel1);
            this.DoubleBuffered = true;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmContractInquiryAdvanceSearch";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Contract Inquiry Advance Search";
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox1)).EndInit();
            this.radGroupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).EndInit();
            this.radGroupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvPatientList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPatientList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvContractList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvContractList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private Telerik.WinControls.UI.RadGroupBox radGroupBox1;
        private Telerik.WinControls.UI.RadGridView dgvPatientList;
        private Telerik.WinControls.UI.RadGroupBox radGroupBox2;
        private Telerik.WinControls.UI.RadGridView dgvContractList;
    }
}