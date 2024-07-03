namespace LEASING.UI.APP.Forms
{
    partial class frmAddFloorType
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
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn1 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn2 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.btnNew = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.btnSave = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.btnUndo = new System.Windows.Forms.ToolStripButton();
            this.radGroupBox1 = new Telerik.WinControls.UI.RadGroupBox();
            this.txtTypeName = new Telerik.WinControls.UI.RadTextBox();
            this.radLabel1 = new Telerik.WinControls.UI.RadLabel();
            this.radGroupBox2 = new Telerik.WinControls.UI.RadGroupBox();
            this.dgvList = new Telerik.WinControls.UI.RadGridView();
            this.tableLayoutPanel1.SuspendLayout();
            this.toolStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox1)).BeginInit();
            this.radGroupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.txtTypeName)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).BeginInit();
            this.radGroupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvList.MasterTemplate)).BeginInit();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Controls.Add(this.toolStrip1, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.radGroupBox1, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.radGroupBox2, 0, 2);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 3;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 68F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(313, 417);
            this.tableLayoutPanel1.TabIndex = 1;
            // 
            // toolStrip1
            // 
            this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.btnNew,
            this.toolStripSeparator1,
            this.btnSave,
            this.toolStripSeparator2,
            this.btnUndo});
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(313, 25);
            this.toolStrip1.TabIndex = 0;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // btnNew
            // 
            this.btnNew.Image = global::LEASING.UI.APP.Properties.Resources.document_32;
            this.btnNew.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnNew.Name = "btnNew";
            this.btnNew.Size = new System.Drawing.Size(51, 22);
            this.btnNew.Text = "New";
            this.btnNew.Click += new System.EventHandler(this.btnNew_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // btnSave
            // 
            this.btnSave.Image = global::LEASING.UI.APP.Properties.Resources.save_32;
            this.btnSave.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(51, 22);
            this.btnSave.Text = "Save";
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(6, 25);
            // 
            // btnUndo
            // 
            this.btnUndo.Image = global::LEASING.UI.APP.Properties.Resources.co_arrow_left_16;
            this.btnUndo.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnUndo.Name = "btnUndo";
            this.btnUndo.Size = new System.Drawing.Size(56, 22);
            this.btnUndo.Text = "Undo";
            this.btnUndo.Click += new System.EventHandler(this.btnUndo_Click);
            // 
            // radGroupBox1
            // 
            this.radGroupBox1.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox1.Controls.Add(this.txtTypeName);
            this.radGroupBox1.Controls.Add(this.radLabel1);
            this.radGroupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox1.HeaderText = "Details";
            this.radGroupBox1.Location = new System.Drawing.Point(3, 28);
            this.radGroupBox1.Name = "radGroupBox1";
            this.radGroupBox1.Size = new System.Drawing.Size(307, 62);
            this.radGroupBox1.TabIndex = 1;
            this.radGroupBox1.Text = "Details";
            this.radGroupBox1.ThemeName = "Office2007Silver";
            // 
            // txtTypeName
            // 
            this.txtTypeName.Location = new System.Drawing.Point(94, 26);
            this.txtTypeName.Name = "txtTypeName";
            this.txtTypeName.NullText = "Type here...";
            this.txtTypeName.Size = new System.Drawing.Size(206, 20);
            this.txtTypeName.TabIndex = 1;
            this.txtTypeName.ThemeName = "Office2007Silver";
            // 
            // radLabel1
            // 
            this.radLabel1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel1.Location = new System.Drawing.Point(8, 26);
            this.radLabel1.Name = "radLabel1";
            this.radLabel1.Size = new System.Drawing.Size(79, 19);
            this.radLabel1.TabIndex = 0;
            this.radLabel1.Text = "Type Name :";
            // 
            // radGroupBox2
            // 
            this.radGroupBox2.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox2.Controls.Add(this.dgvList);
            this.radGroupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox2.HeaderText = "List";
            this.radGroupBox2.Location = new System.Drawing.Point(3, 96);
            this.radGroupBox2.Name = "radGroupBox2";
            this.radGroupBox2.Size = new System.Drawing.Size(307, 318);
            this.radGroupBox2.TabIndex = 2;
            this.radGroupBox2.Text = "List";
            this.radGroupBox2.ThemeName = "Office2007Silver";
            // 
            // dgvList
            // 
            this.dgvList.BackColor = System.Drawing.SystemColors.ButtonHighlight;
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
            this.dgvList.MasterTemplate.AutoSizeColumnsMode = Telerik.WinControls.UI.GridViewAutoSizeColumnsMode.Fill;
            gridViewCommandColumn1.FieldName = "ColRemoved";
            gridViewCommandColumn1.HeaderImage = global::LEASING.UI.APP.Properties.Resources.Remove1;
            gridViewCommandColumn1.HeaderText = "";
            gridViewCommandColumn1.Image = global::LEASING.UI.APP.Properties.Resources.Remove1;
            gridViewCommandColumn1.Name = "ColRemoved";
            gridViewCommandColumn1.Width = 40;
            gridViewTextBoxColumn1.FieldName = "RecId";
            gridViewTextBoxColumn1.HeaderText = "ID";
            gridViewTextBoxColumn1.IsVisible = false;
            gridViewTextBoxColumn1.Name = "RecId";
            gridViewTextBoxColumn1.Width = 46;
            gridViewTextBoxColumn2.FieldName = "FloorTypeName";
            gridViewTextBoxColumn2.HeaderText = "Type Name";
            gridViewTextBoxColumn2.Name = "FloorTypeName";
            gridViewTextBoxColumn2.Width = 263;
            this.dgvList.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewCommandColumn1,
            gridViewTextBoxColumn1,
            gridViewTextBoxColumn2});
            this.dgvList.MasterTemplate.EnableFiltering = true;
            this.dgvList.MasterTemplate.ShowRowHeaderColumn = false;
            this.dgvList.Name = "dgvList";
            this.dgvList.Padding = new System.Windows.Forms.Padding(0, 0, 0, 1);
            this.dgvList.ReadOnly = true;
            this.dgvList.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dgvList.ShowGroupPanel = false;
            this.dgvList.Size = new System.Drawing.Size(303, 298);
            this.dgvList.TabIndex = 0;
            this.dgvList.Text = "radGridView1";
            this.dgvList.ThemeName = "Office2007Silver";
            this.dgvList.CellClick += new Telerik.WinControls.UI.GridViewCellEventHandler(this.dgvList_CellClick);
            // 
            // frmAddFloorType
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(313, 417);
            this.Controls.Add(this.tableLayoutPanel1);
            this.DoubleBuffered = true;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmAddFloorType";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Floor Type";
            this.Load += new System.EventHandler(this.frmAddFloorType_Load);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            this.toolStrip1.ResumeLayout(false);
            this.toolStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox1)).EndInit();
            this.radGroupBox1.ResumeLayout(false);
            this.radGroupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.txtTypeName)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox2)).EndInit();
            this.radGroupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvList.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvList)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.ToolStripButton btnNew;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripButton btnSave;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripButton btnUndo;
        private Telerik.WinControls.UI.RadGroupBox radGroupBox1;
        private Telerik.WinControls.UI.RadTextBox txtTypeName;
        private Telerik.WinControls.UI.RadLabel radLabel1;
        private Telerik.WinControls.UI.RadGroupBox radGroupBox2;
        private Telerik.WinControls.UI.RadGridView dgvList;
    }
}