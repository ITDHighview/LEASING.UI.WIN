namespace LEASING.UI.APP.Forms
{
    partial class frmReceivePayment
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
            this.btnOK = new Telerik.WinControls.UI.RadButton();
            this.radLabel2 = new Telerik.WinControls.UI.RadLabel();
            this.radLabel1 = new Telerik.WinControls.UI.RadLabel();
            this.txtPaidAmount = new Telerik.WinControls.UI.RadTextBox();
            this.txtReceiveAmount = new Telerik.WinControls.UI.RadTextBox();
            this.office2007SilverTheme1 = new Telerik.WinControls.Themes.Office2007SilverTheme();
            this.tableLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.btnOK)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtPaidAmount)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtReceiveAmount)).BeginInit();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.tableLayoutPanel1.ColumnCount = 2;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 46.66667F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 53.33333F));
            this.tableLayoutPanel1.Controls.Add(this.btnOK, 1, 3);
            this.tableLayoutPanel1.Controls.Add(this.radLabel2, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.radLabel1, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.txtPaidAmount, 1, 0);
            this.tableLayoutPanel1.Controls.Add(this.txtReceiveAmount, 1, 1);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 4;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 35F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 35F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 35F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 35F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(450, 147);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // btnOK
            // 
            this.btnOK.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnOK.Font = new System.Drawing.Font("Segoe UI", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnOK.Location = new System.Drawing.Point(213, 108);
            this.btnOK.Name = "btnOK";
            this.btnOK.Size = new System.Drawing.Size(234, 36);
            this.btnOK.TabIndex = 0;
            this.btnOK.Text = "PROCEED >>>";
            this.btnOK.ThemeName = "Office2007Silver";
            this.btnOK.Click += new System.EventHandler(this.btnOK_Click);
            // 
            // radLabel2
            // 
            this.radLabel2.AutoSize = false;
            this.radLabel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radLabel2.Font = new System.Drawing.Font("Segoe UI", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel2.Location = new System.Drawing.Point(3, 3);
            this.radLabel2.Name = "radLabel2";
            this.radLabel2.Size = new System.Drawing.Size(204, 29);
            this.radLabel2.TabIndex = 1;
            this.radLabel2.Text = "Due Amount :";
            // 
            // radLabel1
            // 
            this.radLabel1.AutoSize = false;
            this.radLabel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radLabel1.Font = new System.Drawing.Font("Segoe UI", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel1.Location = new System.Drawing.Point(3, 38);
            this.radLabel1.Name = "radLabel1";
            this.radLabel1.Size = new System.Drawing.Size(204, 29);
            this.radLabel1.TabIndex = 1;
            this.radLabel1.Text = "Received Amount :";
            // 
            // txtPaidAmount
            // 
            this.txtPaidAmount.AutoSize = false;
            this.txtPaidAmount.Dock = System.Windows.Forms.DockStyle.Fill;
            this.txtPaidAmount.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtPaidAmount.Location = new System.Drawing.Point(213, 3);
            this.txtPaidAmount.Name = "txtPaidAmount";
            this.txtPaidAmount.NullText = "0.00";
            this.txtPaidAmount.Size = new System.Drawing.Size(234, 29);
            this.txtPaidAmount.TabIndex = 2;
            this.txtPaidAmount.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.txtPaidAmount.ThemeName = "Office2007Silver";
            this.txtPaidAmount.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtPaidAmount_KeyPress);
            // 
            // txtReceiveAmount
            // 
            this.txtReceiveAmount.AutoSize = false;
            this.txtReceiveAmount.Dock = System.Windows.Forms.DockStyle.Fill;
            this.txtReceiveAmount.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtReceiveAmount.Location = new System.Drawing.Point(213, 38);
            this.txtReceiveAmount.Name = "txtReceiveAmount";
            this.txtReceiveAmount.NullText = "Type here...";
            this.txtReceiveAmount.Size = new System.Drawing.Size(234, 29);
            this.txtReceiveAmount.TabIndex = 2;
            this.txtReceiveAmount.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.txtReceiveAmount.ThemeName = "Office2007Silver";
            this.txtReceiveAmount.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtReceiveAmount_KeyPress);
            // 
            // frmReceivePayment
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(450, 147);
            this.Controls.Add(this.tableLayoutPanel1);
            this.DoubleBuffered = true;
            this.Name = "frmReceivePayment";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Receive Payment";
            this.Load += new System.EventHandler(this.frmReceivePayment_Load);
            this.tableLayoutPanel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.btnOK)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtPaidAmount)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtReceiveAmount)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private Telerik.WinControls.UI.RadButton btnOK;
        private Telerik.WinControls.UI.RadLabel radLabel2;
        private Telerik.WinControls.UI.RadLabel radLabel1;
        public Telerik.WinControls.UI.RadTextBox txtPaidAmount;
        public Telerik.WinControls.UI.RadTextBox txtReceiveAmount;
        private Telerik.WinControls.Themes.Office2007SilverTheme office2007SilverTheme1;
    }
}