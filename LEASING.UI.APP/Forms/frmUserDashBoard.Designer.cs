namespace LEASING.UI.APP.Forms
{
    partial class frmUserDashBoard
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
            this.btnNewUser = new System.Windows.Forms.ToolStripButton();
            this.btnEditUser = new System.Windows.Forms.ToolStripButton();
            this.btnSave = new System.Windows.Forms.ToolStripButton();
            this.btnUndo = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.btnRefresh = new System.Windows.Forms.ToolStripButton();
            this.radGroupBox1 = new Telerik.WinControls.UI.RadGroupBox();
            this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
            this.radLabel1 = new Telerik.WinControls.UI.RadLabel();
            this.ddlUserGroup = new Telerik.WinControls.UI.RadDropDownList();
            this.radLabel3 = new Telerik.WinControls.UI.RadLabel();
            this.radLabel4 = new Telerik.WinControls.UI.RadLabel();
            this.txtMiddlename = new Telerik.WinControls.UI.RadTextBox();
            this.txtStaffName = new Telerik.WinControls.UI.RadTextBox();
            this.radLabel6 = new Telerik.WinControls.UI.RadLabel();
            this.txtLastname = new Telerik.WinControls.UI.RadTextBox();
            this.radLabel7 = new Telerik.WinControls.UI.RadLabel();
            this.txtUserPassword = new Telerik.WinControls.UI.RadTextBox();
            this.radLabel5 = new Telerik.WinControls.UI.RadLabel();
            this.txtPhone = new Telerik.WinControls.UI.RadTextBox();
            this.radLabel2 = new Telerik.WinControls.UI.RadLabel();
            this.txtEmailAddress = new Telerik.WinControls.UI.RadTextBox();
            this.btnShowPassword = new Telerik.WinControls.UI.RadButton();
            this.tableLayoutPanel1.SuspendLayout();
            this.toolStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox1)).BeginInit();
            this.radGroupBox1.SuspendLayout();
            this.tableLayoutPanel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ddlUserGroup)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMiddlename)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtStaffName)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel6)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtLastname)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel7)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtUserPassword)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel5)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtPhone)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtEmailAddress)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnShowPassword)).BeginInit();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Controls.Add(this.toolStrip1, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.radGroupBox1, 0, 1);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 3;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 28F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 128F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(723, 493);
            this.tableLayoutPanel1.TabIndex = 3;
            // 
            // toolStrip1
            // 
            this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.btnNewUser,
            this.btnEditUser,
            this.btnSave,
            this.btnUndo,
            this.toolStripSeparator1,
            this.btnRefresh});
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(723, 25);
            this.toolStrip1.TabIndex = 0;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // btnNewUser
            // 
            this.btnNewUser.Image = global::LEASING.UI.APP.Properties.Resources.document_16;
            this.btnNewUser.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnNewUser.Name = "btnNewUser";
            this.btnNewUser.Size = new System.Drawing.Size(51, 22);
            this.btnNewUser.Text = "New";
            // 
            // btnEditUser
            // 
            this.btnEditUser.Image = global::LEASING.UI.APP.Properties.Resources.edit;
            this.btnEditUser.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnEditUser.Name = "btnEditUser";
            this.btnEditUser.Size = new System.Drawing.Size(47, 22);
            this.btnEditUser.Text = "Edit";
            // 
            // btnSave
            // 
            this.btnSave.Image = global::LEASING.UI.APP.Properties.Resources.save_16;
            this.btnSave.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(51, 22);
            this.btnSave.Text = "Save";
            // 
            // btnUndo
            // 
            this.btnUndo.Image = global::LEASING.UI.APP.Properties.Resources.co_arrow_left_16;
            this.btnUndo.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnUndo.Name = "btnUndo";
            this.btnUndo.Size = new System.Drawing.Size(56, 22);
            this.btnUndo.Text = "Undo";
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // btnRefresh
            // 
            this.btnRefresh.Image = global::LEASING.UI.APP.Properties.Resources._16_RefreshArrowGreen;
            this.btnRefresh.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnRefresh.Name = "btnRefresh";
            this.btnRefresh.Size = new System.Drawing.Size(66, 22);
            this.btnRefresh.Text = "Refresh";
            // 
            // radGroupBox1
            // 
            this.radGroupBox1.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox1.Controls.Add(this.tableLayoutPanel2);
            this.radGroupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox1.HeaderText = "User Details";
            this.radGroupBox1.Location = new System.Drawing.Point(3, 31);
            this.radGroupBox1.Name = "radGroupBox1";
            this.radGroupBox1.Size = new System.Drawing.Size(717, 122);
            this.radGroupBox1.TabIndex = 1;
            this.radGroupBox1.Text = "User Details";
            // 
            // tableLayoutPanel2
            // 
            this.tableLayoutPanel2.ColumnCount = 6;
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 105F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 190F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 122F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 191F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 26F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 726F));
            this.tableLayoutPanel2.Controls.Add(this.radLabel1, 0, 0);
            this.tableLayoutPanel2.Controls.Add(this.ddlUserGroup, 1, 0);
            this.tableLayoutPanel2.Controls.Add(this.radLabel3, 0, 1);
            this.tableLayoutPanel2.Controls.Add(this.radLabel4, 0, 2);
            this.tableLayoutPanel2.Controls.Add(this.txtMiddlename, 1, 2);
            this.tableLayoutPanel2.Controls.Add(this.txtStaffName, 1, 1);
            this.tableLayoutPanel2.Controls.Add(this.radLabel6, 0, 3);
            this.tableLayoutPanel2.Controls.Add(this.txtLastname, 1, 3);
            this.tableLayoutPanel2.Controls.Add(this.radLabel7, 2, 3);
            this.tableLayoutPanel2.Controls.Add(this.txtUserPassword, 3, 3);
            this.tableLayoutPanel2.Controls.Add(this.radLabel5, 2, 2);
            this.tableLayoutPanel2.Controls.Add(this.txtPhone, 3, 2);
            this.tableLayoutPanel2.Controls.Add(this.radLabel2, 2, 1);
            this.tableLayoutPanel2.Controls.Add(this.txtEmailAddress, 3, 1);
            this.tableLayoutPanel2.Controls.Add(this.btnShowPassword, 4, 3);
            this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel2.Location = new System.Drawing.Point(2, 18);
            this.tableLayoutPanel2.Name = "tableLayoutPanel2";
            this.tableLayoutPanel2.RowCount = 4;
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel2.Size = new System.Drawing.Size(713, 102);
            this.tableLayoutPanel2.TabIndex = 0;
            // 
            // radLabel1
            // 
            this.radLabel1.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.radLabel1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel1.Location = new System.Drawing.Point(23, 3);
            this.radLabel1.Name = "radLabel1";
            this.radLabel1.Size = new System.Drawing.Size(79, 19);
            this.radLabel1.TabIndex = 0;
            this.radLabel1.Text = "User Group :";
            // 
            // ddlUserGroup
            // 
            this.ddlUserGroup.Location = new System.Drawing.Point(108, 3);
            this.ddlUserGroup.Name = "ddlUserGroup";
            this.ddlUserGroup.Size = new System.Drawing.Size(150, 19);
            this.ddlUserGroup.TabIndex = 1;
            // 
            // radLabel3
            // 
            this.radLabel3.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.radLabel3.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel3.Location = new System.Drawing.Point(54, 28);
            this.radLabel3.Name = "radLabel3";
            this.radLabel3.Size = new System.Drawing.Size(48, 19);
            this.radLabel3.TabIndex = 0;
            this.radLabel3.Text = "Name :";
            // 
            // radLabel4
            // 
            this.radLabel4.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.radLabel4.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel4.Location = new System.Drawing.Point(10, 53);
            this.radLabel4.Name = "radLabel4";
            this.radLabel4.Size = new System.Drawing.Size(92, 19);
            this.radLabel4.TabIndex = 0;
            this.radLabel4.Text = "Middle Name :";
            // 
            // txtMiddlename
            // 
            this.txtMiddlename.Location = new System.Drawing.Point(108, 53);
            this.txtMiddlename.Name = "txtMiddlename";
            this.txtMiddlename.Size = new System.Drawing.Size(184, 19);
            this.txtMiddlename.TabIndex = 2;
            // 
            // txtStaffName
            // 
            this.txtStaffName.Location = new System.Drawing.Point(108, 28);
            this.txtStaffName.Name = "txtStaffName";
            this.txtStaffName.Size = new System.Drawing.Size(184, 19);
            this.txtStaffName.TabIndex = 2;
            // 
            // radLabel6
            // 
            this.radLabel6.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.radLabel6.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel6.Location = new System.Drawing.Point(28, 79);
            this.radLabel6.Name = "radLabel6";
            this.radLabel6.Size = new System.Drawing.Size(74, 19);
            this.radLabel6.TabIndex = 0;
            this.radLabel6.Text = "Last Name :";
            // 
            // txtLastname
            // 
            this.txtLastname.Location = new System.Drawing.Point(108, 78);
            this.txtLastname.Name = "txtLastname";
            this.txtLastname.Size = new System.Drawing.Size(184, 20);
            this.txtLastname.TabIndex = 2;
            // 
            // radLabel7
            // 
            this.radLabel7.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.radLabel7.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel7.Location = new System.Drawing.Point(298, 79);
            this.radLabel7.Name = "radLabel7";
            this.radLabel7.Size = new System.Drawing.Size(119, 19);
            this.radLabel7.TabIndex = 0;
            this.radLabel7.Text = "Security Password :";
            // 
            // txtUserPassword
            // 
            this.txtUserPassword.Location = new System.Drawing.Point(420, 78);
            this.txtUserPassword.Name = "txtUserPassword";
            this.txtUserPassword.PasswordChar = '*';
            this.txtUserPassword.Size = new System.Drawing.Size(184, 20);
            this.txtUserPassword.TabIndex = 2;
            // 
            // radLabel5
            // 
            this.radLabel5.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.radLabel5.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel5.Location = new System.Drawing.Point(336, 53);
            this.radLabel5.Name = "radLabel5";
            this.radLabel5.Size = new System.Drawing.Size(78, 19);
            this.radLabel5.TabIndex = 0;
            this.radLabel5.Text = "Mobile No. :";
            // 
            // txtPhone
            // 
            this.txtPhone.Location = new System.Drawing.Point(420, 53);
            this.txtPhone.Name = "txtPhone";
            this.txtPhone.Size = new System.Drawing.Size(184, 19);
            this.txtPhone.TabIndex = 2;
            // 
            // radLabel2
            // 
            this.radLabel2.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.radLabel2.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel2.Location = new System.Drawing.Point(319, 28);
            this.radLabel2.Name = "radLabel2";
            this.radLabel2.Size = new System.Drawing.Size(95, 19);
            this.radLabel2.TabIndex = 0;
            this.radLabel2.Text = "Email Address :";
            // 
            // txtEmailAddress
            // 
            this.txtEmailAddress.Location = new System.Drawing.Point(420, 28);
            this.txtEmailAddress.Name = "txtEmailAddress";
            this.txtEmailAddress.Size = new System.Drawing.Size(184, 19);
            this.txtEmailAddress.TabIndex = 2;
            // 
            // btnShowPassword
            // 
            this.btnShowPassword.Image = global::LEASING.UI.APP.Properties.Resources.eye1;
            this.btnShowPassword.Location = new System.Drawing.Point(611, 78);
            this.btnShowPassword.Name = "btnShowPassword";
            this.btnShowPassword.Size = new System.Drawing.Size(19, 18);
            this.btnShowPassword.TabIndex = 3;
            this.btnShowPassword.Click += new System.EventHandler(this.btnShowPassword_Click);
            // 
            // frmUserDashBoard
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(723, 493);
            this.Controls.Add(this.tableLayoutPanel1);
            this.DoubleBuffered = true;
            this.Name = "frmUserDashBoard";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "MY DASHBOARD";
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            this.toolStrip1.ResumeLayout(false);
            this.toolStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox1)).EndInit();
            this.radGroupBox1.ResumeLayout(false);
            this.tableLayoutPanel2.ResumeLayout(false);
            this.tableLayoutPanel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ddlUserGroup)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMiddlename)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtStaffName)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel6)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtLastname)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel7)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtUserPassword)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel5)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtPhone)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtEmailAddress)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnShowPassword)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.ToolStripButton btnNewUser;
        private System.Windows.Forms.ToolStripButton btnEditUser;
        private System.Windows.Forms.ToolStripButton btnSave;
        private System.Windows.Forms.ToolStripButton btnUndo;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripButton btnRefresh;
        private Telerik.WinControls.UI.RadGroupBox radGroupBox1;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel2;
        private Telerik.WinControls.UI.RadLabel radLabel1;
        private Telerik.WinControls.UI.RadDropDownList ddlUserGroup;
        private Telerik.WinControls.UI.RadLabel radLabel3;
        private Telerik.WinControls.UI.RadLabel radLabel4;
        private Telerik.WinControls.UI.RadTextBox txtMiddlename;
        private Telerik.WinControls.UI.RadTextBox txtStaffName;
        private Telerik.WinControls.UI.RadLabel radLabel6;
        private Telerik.WinControls.UI.RadTextBox txtLastname;
        private Telerik.WinControls.UI.RadLabel radLabel7;
        private Telerik.WinControls.UI.RadTextBox txtUserPassword;
        private Telerik.WinControls.UI.RadLabel radLabel5;
        private Telerik.WinControls.UI.RadTextBox txtPhone;
        private Telerik.WinControls.UI.RadLabel radLabel2;
        private Telerik.WinControls.UI.RadTextBox txtEmailAddress;
        private Telerik.WinControls.UI.RadButton btnShowPassword;
    }
}