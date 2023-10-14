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
            this.radLabel20 = new Telerik.WinControls.UI.RadLabel();
            this.radLabel1 = new Telerik.WinControls.UI.RadLabel();
            this.radLabel2 = new Telerik.WinControls.UI.RadLabel();
            this.txtFilePath = new Telerik.WinControls.UI.RadTextBox();
            this.txtfilename = new Telerik.WinControls.UI.RadTextBox();
            this.txtnotes = new Telerik.WinControls.UI.RadTextBox();
            this.btnOk = new Telerik.WinControls.UI.RadButton();
            this.tableLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel20)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtFilePath)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtfilename)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtnotes)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnOk)).BeginInit();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 2;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 97F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 405F));
            this.tableLayoutPanel1.Controls.Add(this.radLabel20, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.radLabel1, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.radLabel2, 0, 2);
            this.tableLayoutPanel1.Controls.Add(this.txtFilePath, 1, 0);
            this.tableLayoutPanel1.Controls.Add(this.txtfilename, 1, 1);
            this.tableLayoutPanel1.Controls.Add(this.txtnotes, 1, 2);
            this.tableLayoutPanel1.Controls.Add(this.btnOk, 1, 3);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 4;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 25F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(502, 102);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // radLabel20
            // 
            this.radLabel20.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.radLabel20.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel20.Location = new System.Drawing.Point(31, 3);
            this.radLabel20.Name = "radLabel20";
            this.radLabel20.Size = new System.Drawing.Size(63, 19);
            this.radLabel20.TabIndex = 1;
            this.radLabel20.Text = "File Path :";
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
            // radLabel2
            // 
            this.radLabel2.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.radLabel2.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel2.Location = new System.Drawing.Point(46, 53);
            this.radLabel2.Name = "radLabel2";
            this.radLabel2.Size = new System.Drawing.Size(48, 19);
            this.radLabel2.TabIndex = 1;
            this.radLabel2.Text = "Notes :";
            // 
            // txtFilePath
            // 
            this.txtFilePath.Location = new System.Drawing.Point(100, 3);
            this.txtFilePath.Name = "txtFilePath";
            this.txtFilePath.Size = new System.Drawing.Size(399, 19);
            this.txtFilePath.TabIndex = 2;
            // 
            // txtfilename
            // 
            this.txtfilename.Location = new System.Drawing.Point(100, 28);
            this.txtfilename.Name = "txtfilename";
            this.txtfilename.Size = new System.Drawing.Size(257, 19);
            this.txtfilename.TabIndex = 2;
            // 
            // txtnotes
            // 
            this.txtnotes.Location = new System.Drawing.Point(100, 53);
            this.txtnotes.Name = "txtnotes";
            this.txtnotes.Size = new System.Drawing.Size(257, 19);
            this.txtnotes.TabIndex = 2;
            // 
            // btnOk
            // 
            this.btnOk.Image = global::LEASING.UI.APP.Properties.Resources.co_checkmark_16;
            this.btnOk.Location = new System.Drawing.Point(100, 78);
            this.btnOk.Name = "btnOk";
            this.btnOk.Size = new System.Drawing.Size(81, 21);
            this.btnOk.TabIndex = 3;
            this.btnOk.Text = "ok";
            this.btnOk.Click += new System.EventHandler(this.btnOk_Click);
            // 
            // frmUploadFile
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(502, 102);
            this.Controls.Add(this.tableLayoutPanel1);
            this.DoubleBuffered = true;
            this.Name = "frmUploadFile";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Upload File";
            this.Load += new System.EventHandler(this.frmUploadFile_Load);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel20)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtFilePath)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtfilename)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtnotes)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnOk)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private Telerik.WinControls.UI.RadLabel radLabel20;
        private Telerik.WinControls.UI.RadLabel radLabel1;
        private Telerik.WinControls.UI.RadLabel radLabel2;
        private Telerik.WinControls.UI.RadTextBox txtFilePath;
        private Telerik.WinControls.UI.RadButton btnOk;
        public Telerik.WinControls.UI.RadTextBox txtnotes;
        public Telerik.WinControls.UI.RadTextBox txtfilename;
    }
}