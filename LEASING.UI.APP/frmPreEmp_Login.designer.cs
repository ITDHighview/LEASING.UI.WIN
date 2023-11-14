namespace LEASING.UI.APP.Forms
{
    partial class frmPreEmp_Login
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
            Telerik.WinControls.UI.GridViewTextBoxColumn gridViewTextBoxColumn2 = new Telerik.WinControls.UI.GridViewTextBoxColumn();
            Telerik.WinControls.Data.SortDescriptor sortDescriptor1 = new Telerik.WinControls.Data.SortDescriptor();
            this.label1 = new System.Windows.Forms.Label();
            this.txtUserName = new System.Windows.Forms.TextBox();
            this.txtPass = new System.Windows.Forms.TextBox();
            this.lblPass = new System.Windows.Forms.Label();
            this.lblUserName = new System.Windows.Forms.Label();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.picBoxClose = new System.Windows.Forms.PictureBox();
            this.label2 = new System.Windows.Forms.Label();
            this.btnLogIn = new System.Windows.Forms.Button();
            this.pictureBox4 = new System.Windows.Forms.PictureBox();
            this.lblLedger = new System.Windows.Forms.Label();
            this.cboGroup = new Telerik.WinControls.UI.RadMultiColumnComboBox();
            this.radThemeManager1 = new Telerik.WinControls.RadThemeManager();
            this.lblServerDatabase = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.pictureBox3 = new System.Windows.Forms.PictureBox();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.picBoxClose)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cboGroup)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cboGroup.EditorControl)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cboGroup.EditorControl.MasterTemplate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox3)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.BackColor = System.Drawing.Color.Transparent;
            this.label1.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.White;
            this.label1.Location = new System.Drawing.Point(316, 318);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(118, 19);
            this.label1.TabIndex = 1;
            this.label1.Text = "LEASING SYSTEM";
            // 
            // txtUserName
            // 
            this.txtUserName.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
            this.txtUserName.Font = new System.Drawing.Font("Tahoma", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtUserName.ForeColor = System.Drawing.Color.White;
            this.txtUserName.Location = new System.Drawing.Point(96, 84);
            this.txtUserName.MaxLength = 10;
            this.txtUserName.Multiline = true;
            this.txtUserName.Name = "txtUserName";
            this.txtUserName.Size = new System.Drawing.Size(278, 33);
            this.txtUserName.TabIndex = 1;
            this.txtUserName.TextChanged += new System.EventHandler(this.txtUserName_TextChanged);
            this.txtUserName.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtUserName_KeyPress);
            // 
            // txtPass
            // 
            this.txtPass.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
            this.txtPass.Font = new System.Drawing.Font("Tahoma", 14.25F);
            this.txtPass.ForeColor = System.Drawing.Color.White;
            this.txtPass.Location = new System.Drawing.Point(95, 129);
            this.txtPass.MaxLength = 20;
            this.txtPass.Multiline = true;
            this.txtPass.Name = "txtPass";
            this.txtPass.PasswordChar = '*';
            this.txtPass.Size = new System.Drawing.Size(278, 33);
            this.txtPass.TabIndex = 2;
            this.txtPass.TextChanged += new System.EventHandler(this.txtPass_TextChanged);
            this.txtPass.Enter += new System.EventHandler(this.txtPass_Enter);
            this.txtPass.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtPass_KeyPress);
            // 
            // lblPass
            // 
            this.lblPass.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
            this.lblPass.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblPass.ForeColor = System.Drawing.Color.White;
            this.lblPass.Location = new System.Drawing.Point(113, 133);
            this.lblPass.Name = "lblPass";
            this.lblPass.Size = new System.Drawing.Size(251, 25);
            this.lblPass.TabIndex = 5;
            this.lblPass.Text = "Password";
            this.lblPass.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.lblPass.Click += new System.EventHandler(this.lblPass_Click);
            // 
            // lblUserName
            // 
            this.lblUserName.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
            this.lblUserName.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblUserName.ForeColor = System.Drawing.Color.White;
            this.lblUserName.Location = new System.Drawing.Point(114, 88);
            this.lblUserName.Name = "lblUserName";
            this.lblUserName.Size = new System.Drawing.Size(257, 25);
            this.lblUserName.TabIndex = 5;
            this.lblUserName.Text = "Username";
            this.lblUserName.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.lblUserName.Click += new System.EventHandler(this.lblUserName_Click);
            // 
            // pictureBox2
            // 
            this.pictureBox2.BackColor = System.Drawing.Color.Transparent;
            this.pictureBox2.BackgroundImage = global::LEASING.UI.APP.Properties.Resources.Lock11;
            this.pictureBox2.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.pictureBox2.Location = new System.Drawing.Point(33, 126);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(48, 38);
            this.pictureBox2.TabIndex = 6;
            this.pictureBox2.TabStop = false;
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackColor = System.Drawing.Color.Transparent;
            this.pictureBox1.BackgroundImage = global::LEASING.UI.APP.Properties.Resources.User11;
            this.pictureBox1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.pictureBox1.Location = new System.Drawing.Point(34, 81);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(48, 38);
            this.pictureBox1.TabIndex = 6;
            this.pictureBox1.TabStop = false;
            // 
            // picBoxClose
            // 
            this.picBoxClose.BackColor = System.Drawing.Color.Transparent;
            this.picBoxClose.BackgroundImage = global::LEASING.UI.APP.Properties.Resources.co_delete_16;
            this.picBoxClose.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.picBoxClose.Location = new System.Drawing.Point(429, 7);
            this.picBoxClose.Name = "picBoxClose";
            this.picBoxClose.Size = new System.Drawing.Size(24, 20);
            this.picBoxClose.TabIndex = 5;
            this.picBoxClose.TabStop = false;
            this.picBoxClose.Click += new System.EventHandler(this.picBoxClose_Click);
            // 
            // label2
            // 
            this.label2.BackColor = System.Drawing.Color.DarkSlateGray;
            this.label2.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.ForeColor = System.Drawing.Color.DarkSlateGray;
            this.label2.Location = new System.Drawing.Point(51, 311);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(377, 3);
            this.label2.TabIndex = 1;
            // 
            // btnLogIn
            // 
            this.btnLogIn.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
            this.btnLogIn.FlatAppearance.BorderColor = System.Drawing.Color.White;
            this.btnLogIn.FlatAppearance.BorderSize = 2;
            this.btnLogIn.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnLogIn.Font = new System.Drawing.Font("Tahoma", 14.25F);
            this.btnLogIn.ForeColor = System.Drawing.Color.White;
            this.btnLogIn.Location = new System.Drawing.Point(282, 216);
            this.btnLogIn.Name = "btnLogIn";
            this.btnLogIn.Size = new System.Drawing.Size(92, 38);
            this.btnLogIn.TabIndex = 4;
            this.btnLogIn.Text = "LOG IN";
            this.btnLogIn.UseVisualStyleBackColor = false;
            this.btnLogIn.Click += new System.EventHandler(this.btnLogIn_Click);
            // 
            // pictureBox4
            // 
            this.pictureBox4.BackColor = System.Drawing.Color.Transparent;
            this.pictureBox4.BackgroundImage = global::LEASING.UI.APP.Properties.Resources.Icon_Group1;
            this.pictureBox4.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.pictureBox4.Location = new System.Drawing.Point(33, 170);
            this.pictureBox4.Name = "pictureBox4";
            this.pictureBox4.Size = new System.Drawing.Size(48, 38);
            this.pictureBox4.TabIndex = 6;
            this.pictureBox4.TabStop = false;
            // 
            // lblLedger
            // 
            this.lblLedger.BackColor = System.Drawing.Color.Transparent;
            this.lblLedger.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblLedger.ForeColor = System.Drawing.Color.Red;
            this.lblLedger.Location = new System.Drawing.Point(12, 266);
            this.lblLedger.Name = "lblLedger";
            this.lblLedger.Size = new System.Drawing.Size(436, 41);
            this.lblLedger.TabIndex = 7;
            this.lblLedger.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // cboGroup
            // 
            this.cboGroup.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
            this.cboGroup.DisplayMember = "Group_Code";
            this.cboGroup.DropDownStyle = Telerik.WinControls.RadDropDownStyle.DropDownList;
            // 
            // cboGroup.NestedRadGridView
            // 
            this.cboGroup.EditorControl.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
            this.cboGroup.EditorControl.Cursor = System.Windows.Forms.Cursors.Default;
            this.cboGroup.EditorControl.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
            this.cboGroup.EditorControl.ForeColor = System.Drawing.Color.Red;
            this.cboGroup.EditorControl.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.cboGroup.EditorControl.Location = new System.Drawing.Point(0, 0);
            // 
            // 
            // 
            this.cboGroup.EditorControl.MasterTemplate.AllowAddNewRow = false;
            this.cboGroup.EditorControl.MasterTemplate.AllowCellContextMenu = false;
            this.cboGroup.EditorControl.MasterTemplate.AllowColumnChooser = false;
            gridViewTextBoxColumn1.EnableExpressionEditor = false;
            gridViewTextBoxColumn1.FieldName = "Group_Code";
            gridViewTextBoxColumn1.HeaderText = "Group_Code";
            gridViewTextBoxColumn1.IsVisible = false;
            gridViewTextBoxColumn1.Name = "Group_Code";
            gridViewTextBoxColumn2.EnableExpressionEditor = false;
            gridViewTextBoxColumn2.FieldName = "Group_Name";
            gridViewTextBoxColumn2.HeaderText = "Group_Name";
            gridViewTextBoxColumn2.Name = "Group_Name";
            gridViewTextBoxColumn2.Width = 219;
            this.cboGroup.EditorControl.MasterTemplate.Columns.AddRange(new Telerik.WinControls.UI.GridViewDataColumn[] {
            gridViewTextBoxColumn1,
            gridViewTextBoxColumn2});
            this.cboGroup.EditorControl.MasterTemplate.EnableGrouping = false;
            this.cboGroup.EditorControl.MasterTemplate.ShowColumnHeaders = false;
            this.cboGroup.EditorControl.MasterTemplate.ShowFilteringRow = false;
            this.cboGroup.EditorControl.MasterTemplate.ShowRowHeaderColumn = false;
            sortDescriptor1.Direction = System.ComponentModel.ListSortDirection.Descending;
            sortDescriptor1.PropertyName = "column2";
            this.cboGroup.EditorControl.MasterTemplate.SortDescriptors.AddRange(new Telerik.WinControls.Data.SortDescriptor[] {
            sortDescriptor1});
            this.cboGroup.EditorControl.Name = "NestedRadGridView";
            this.cboGroup.EditorControl.ReadOnly = true;
            this.cboGroup.EditorControl.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.cboGroup.EditorControl.ShowGroupPanel = false;
            this.cboGroup.EditorControl.Size = new System.Drawing.Size(240, 150);
            this.cboGroup.EditorControl.TabIndex = 0;
            this.cboGroup.Font = new System.Drawing.Font("Tahoma", 14.25F);
            this.cboGroup.Location = new System.Drawing.Point(95, 173);
            this.cboGroup.Name = "cboGroup";
            this.cboGroup.Size = new System.Drawing.Size(278, 31);
            this.cboGroup.TabIndex = 8;
            this.cboGroup.TabStop = false;
            ((Telerik.WinControls.UI.RadMultiColumnComboBoxElement)(this.cboGroup.GetChildAt(0))).DropDownStyle = Telerik.WinControls.RadDropDownStyle.DropDownList;
            ((Telerik.WinControls.UI.RadTextBoxElement)(this.cboGroup.GetChildAt(0).GetChildAt(2).GetChildAt(0))).Text = "";
            ((Telerik.WinControls.UI.RadTextBoxElement)(this.cboGroup.GetChildAt(0).GetChildAt(2).GetChildAt(0))).ForeColor = System.Drawing.Color.White;
            ((Telerik.WinControls.UI.RadTextBoxElement)(this.cboGroup.GetChildAt(0).GetChildAt(2).GetChildAt(0))).BackColor = System.Drawing.SystemColors.InactiveCaptionText;
            // 
            // lblServerDatabase
            // 
            this.lblServerDatabase.BackColor = System.Drawing.Color.Transparent;
            this.lblServerDatabase.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblServerDatabase.ForeColor = System.Drawing.Color.White;
            this.lblServerDatabase.Location = new System.Drawing.Point(6, 351);
            this.lblServerDatabase.Name = "lblServerDatabase";
            this.lblServerDatabase.Size = new System.Drawing.Size(278, 19);
            this.lblServerDatabase.TabIndex = 1;
            // 
            // label3
            // 
            this.label3.BackColor = System.Drawing.Color.Transparent;
            this.label3.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Italic);
            this.label3.ForeColor = System.Drawing.Color.White;
            this.label3.Location = new System.Drawing.Point(290, 351);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(163, 19);
            this.label3.TabIndex = 1;
            this.label3.Text = "Version 1.0 0.2023";
            this.label3.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // pictureBox3
            // 
            this.pictureBox3.BackColor = System.Drawing.Color.Transparent;
            this.pictureBox3.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.pictureBox3.Location = new System.Drawing.Point(13, 4);
            this.pictureBox3.Name = "pictureBox3";
            this.pictureBox3.Size = new System.Drawing.Size(207, 53);
            this.pictureBox3.TabIndex = 10;
            this.pictureBox3.TabStop = false;
            // 
            // frmPreEmp_Login
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.Gainsboro;
            this.BackgroundImage = global::LEASING.UI.APP.Properties.Resources.DarkBackground1;
            this.ClientSize = new System.Drawing.Size(460, 375);
            this.ControlBox = false;
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.pictureBox3);
            this.Controls.Add(this.cboGroup);
            this.Controls.Add(this.lblLedger);
            this.Controls.Add(this.btnLogIn);
            this.Controls.Add(this.lblUserName);
            this.Controls.Add(this.picBoxClose);
            this.Controls.Add(this.lblPass);
            this.Controls.Add(this.pictureBox4);
            this.Controls.Add(this.pictureBox2);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.lblServerDatabase);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtPass);
            this.Controls.Add(this.txtUserName);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Name = "frmPreEmp_Login";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.picBoxClose)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cboGroup.EditorControl.MasterTemplate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cboGroup.EditorControl)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cboGroup)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox3)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtPass;
        private System.Windows.Forms.TextBox txtUserName;
        private System.Windows.Forms.Label lblPass;
        private System.Windows.Forms.PictureBox picBoxClose;
        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label lblUserName;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnLogIn;
        private System.Windows.Forms.PictureBox pictureBox4;
        private System.Windows.Forms.Label lblLedger;
        private Telerik.WinControls.UI.RadMultiColumnComboBox cboGroup;
        private Telerik.WinControls.RadThemeManager radThemeManager1;
        private System.Windows.Forms.Label lblServerDatabase;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.PictureBox pictureBox3;
    }
}