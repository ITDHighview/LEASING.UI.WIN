namespace LEASING.UI.APP.Forms
{
    partial class frmUploadFile
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
            this.btnOk = new Telerik.WinControls.UI.RadButton();
            this.radLabel2 = new Telerik.WinControls.UI.RadLabel();
            this.txtnotes = new Telerik.WinControls.UI.RadTextBox();
            this.btnReference = new Telerik.WinControls.UI.RadButton();
            this.txtClientID = new Telerik.WinControls.UI.RadTextBox();
            this.radLabel3 = new Telerik.WinControls.UI.RadLabel();
            this.radLabel1 = new Telerik.WinControls.UI.RadLabel();
            this.txtfilename = new Telerik.WinControls.UI.RadTextBox();
            this.txtReference = new Telerik.WinControls.UI.RadTextBox();
            this.radGroupBox1 = new Telerik.WinControls.UI.RadGroupBox();
            this.office2007SilverTheme1 = new Telerik.WinControls.Themes.Office2007SilverTheme();
            this.tableLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.btnOk)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtnotes)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnReference)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtClientID)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtfilename)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtReference)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox1)).BeginInit();
            this.radGroupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.tableLayoutPanel1.ColumnCount = 4;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 97F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 118F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 107F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 220F));
            this.tableLayoutPanel1.Controls.Add(this.btnOk, 1, 4);
            this.tableLayoutPanel1.Controls.Add(this.radLabel2, 0, 3);
            this.tableLayoutPanel1.Controls.Add(this.txtnotes, 1, 3);
            this.tableLayoutPanel1.Controls.Add(this.btnReference, 3, 0);
            this.tableLayoutPanel1.Controls.Add(this.txtClientID, 1, 0);
            this.tableLayoutPanel1.Controls.Add(this.radLabel3, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.radLabel1, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.txtfilename, 1, 1);
            this.tableLayoutPanel1.Controls.Add(this.txtReference, 3, 1);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(2, 18);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 5;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 212F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(448, 129);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // btnOk
            // 
            this.btnOk.Image = global::LEASING.UI.APP.Properties.Resources.co_checkmark_16;
            this.btnOk.Location = new System.Drawing.Point(100, 103);
            this.btnOk.Name = "btnOk";
            this.btnOk.Size = new System.Drawing.Size(112, 21);
            this.btnOk.TabIndex = 3;
            this.btnOk.Text = "ok";
            this.btnOk.ThemeName = "Office2007Silver";
            this.btnOk.Click += new System.EventHandler(this.btnOk_Click);
            // 
            // radLabel2
            // 
            this.radLabel2.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.radLabel2.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel2.Location = new System.Drawing.Point(46, 78);
            this.radLabel2.Name = "radLabel2";
            this.radLabel2.Size = new System.Drawing.Size(48, 19);
            this.radLabel2.TabIndex = 1;
            this.radLabel2.Text = "Notes :";
            // 
            // txtnotes
            // 
            this.tableLayoutPanel1.SetColumnSpan(this.txtnotes, 3);
            this.txtnotes.Location = new System.Drawing.Point(100, 78);
            this.txtnotes.Name = "txtnotes";
            this.txtnotes.NullText = "Type here...";
            this.txtnotes.Size = new System.Drawing.Size(341, 20);
            this.txtnotes.TabIndex = 2;
            this.txtnotes.ThemeName = "Office2007Silver";
            // 
            // btnReference
            // 
            this.btnReference.Image = global::LEASING.UI.APP.Properties.Resources.magnifier;
            this.btnReference.Location = new System.Drawing.Point(325, 3);
            this.btnReference.Name = "btnReference";
            this.btnReference.Size = new System.Drawing.Size(116, 19);
            this.btnReference.TabIndex = 5;
            this.btnReference.Text = "Reference List";
            this.btnReference.ThemeName = "Office2007Silver";
            this.btnReference.Click += new System.EventHandler(this.btnReference_Click);
            // 
            // txtClientID
            // 
            this.txtClientID.Location = new System.Drawing.Point(100, 3);
            this.txtClientID.Name = "txtClientID";
            this.txtClientID.Size = new System.Drawing.Size(112, 20);
            this.txtClientID.TabIndex = 2;
            this.txtClientID.ThemeName = "Office2007Silver";
            // 
            // radLabel3
            // 
            this.radLabel3.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.radLabel3.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel3.Location = new System.Drawing.Point(27, 3);
            this.radLabel3.Name = "radLabel3";
            this.radLabel3.Size = new System.Drawing.Size(67, 19);
            this.radLabel3.TabIndex = 1;
            this.radLabel3.Text = "Client ID  :";
            // 
            // radLabel1
            // 
            this.radLabel1.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.radLabel1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel1.Location = new System.Drawing.Point(23, 28);
            this.radLabel1.Name = "radLabel1";
            this.radLabel1.Size = new System.Drawing.Size(71, 19);
            this.radLabel1.TabIndex = 1;
            this.radLabel1.Text = "File Name :";
            // 
            // txtfilename
            // 
            this.tableLayoutPanel1.SetColumnSpan(this.txtfilename, 2);
            this.txtfilename.Location = new System.Drawing.Point(100, 28);
            this.txtfilename.Name = "txtfilename";
            this.txtfilename.NullText = "Type here...";
            this.txtfilename.Size = new System.Drawing.Size(219, 20);
            this.txtfilename.TabIndex = 2;
            this.txtfilename.ThemeName = "Office2007Silver";
            // 
            // txtReference
            // 
            this.txtReference.Location = new System.Drawing.Point(325, 28);
            this.txtReference.Name = "txtReference";
            this.txtReference.Size = new System.Drawing.Size(116, 20);
            this.txtReference.TabIndex = 2;
            this.txtReference.ThemeName = "Office2007Silver";
            // 
            // radGroupBox1
            // 
            this.radGroupBox1.AccessibleRole = System.Windows.Forms.AccessibleRole.Grouping;
            this.radGroupBox1.Controls.Add(this.tableLayoutPanel1);
            this.radGroupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radGroupBox1.HeaderText = "FILE DETAILS";
            this.radGroupBox1.Location = new System.Drawing.Point(0, 0);
            this.radGroupBox1.Name = "radGroupBox1";
            this.radGroupBox1.Size = new System.Drawing.Size(452, 149);
            this.radGroupBox1.TabIndex = 4;
            this.radGroupBox1.Text = "FILE DETAILS";
            this.radGroupBox1.ThemeName = "Office2007Silver";
            // 
            // frmUploadFile
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(452, 149);
            this.Controls.Add(this.radGroupBox1);
            this.DoubleBuffered = true;
            this.Name = "frmUploadFile";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Upload File";
            this.Load += new System.EventHandler(this.frmUploadFile_Load);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.btnOk)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtnotes)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnReference)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtClientID)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtfilename)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtReference)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radGroupBox1)).EndInit();
            this.radGroupBox1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private Telerik.WinControls.UI.RadLabel radLabel1;
        private Telerik.WinControls.UI.RadLabel radLabel2;
        private Telerik.WinControls.UI.RadButton btnOk;
        public Telerik.WinControls.UI.RadTextBox txtnotes;
        public Telerik.WinControls.UI.RadTextBox txtfilename;
        private Telerik.WinControls.UI.RadGroupBox radGroupBox1;
        private Telerik.WinControls.UI.RadButton btnReference;
        public Telerik.WinControls.UI.RadTextBox txtReference;
        public Telerik.WinControls.UI.RadTextBox txtClientID;
        private Telerik.WinControls.UI.RadLabel radLabel3;
        private Telerik.WinControls.Themes.Office2007SilverTheme office2007SilverTheme1;
    }
}