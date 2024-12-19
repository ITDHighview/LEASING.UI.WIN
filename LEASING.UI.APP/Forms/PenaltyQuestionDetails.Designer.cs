namespace LEASING.UI.APP.Forms
{
    partial class PenaltyQuestionDetails
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
            this.radLabel1 = new Telerik.WinControls.UI.RadLabel();
            this.radLabel2 = new Telerik.WinControls.UI.RadLabel();
            this.txtMonth = new Telerik.WinControls.UI.RadTextBox();
            this.txtAmount = new Telerik.WinControls.UI.RadTextBox();
            this.btnYes = new Telerik.WinControls.UI.RadButton();
            this.btnNo = new Telerik.WinControls.UI.RadButton();
            this.radLabel3 = new Telerik.WinControls.UI.RadLabel();
            this.tableLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMonth)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtAmount)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnYes)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnNo)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel3)).BeginInit();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 2;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 38.76812F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 61.23188F));
            this.tableLayoutPanel1.Controls.Add(this.radLabel1, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.radLabel2, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.txtMonth, 1, 0);
            this.tableLayoutPanel1.Controls.Add(this.txtAmount, 1, 1);
            this.tableLayoutPanel1.Controls.Add(this.btnYes, 0, 3);
            this.tableLayoutPanel1.Controls.Add(this.btnNo, 1, 3);
            this.tableLayoutPanel1.Controls.Add(this.radLabel3, 0, 2);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 4;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 102F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 29F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 55F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(276, 203);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // radLabel1
            // 
            this.radLabel1.Font = new System.Drawing.Font("Segoe UI Semibold", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel1.Location = new System.Drawing.Point(3, 3);
            this.radLabel1.Name = "radLabel1";
            this.radLabel1.Size = new System.Drawing.Size(44, 19);
            this.radLabel1.TabIndex = 0;
            this.radLabel1.Text = "Month";
            // 
            // radLabel2
            // 
            this.radLabel2.Font = new System.Drawing.Font("Segoe UI Semibold", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel2.Location = new System.Drawing.Point(3, 43);
            this.radLabel2.Name = "radLabel2";
            this.radLabel2.Size = new System.Drawing.Size(97, 19);
            this.radLabel2.TabIndex = 1;
            this.radLabel2.Text = "Penalty Amount";
            // 
            // txtMonth
            // 
            this.txtMonth.AutoSize = false;
            this.txtMonth.Location = new System.Drawing.Point(110, 3);
            this.txtMonth.Name = "txtMonth";
            this.txtMonth.Size = new System.Drawing.Size(158, 29);
            this.txtMonth.TabIndex = 2;
            this.txtMonth.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // txtAmount
            // 
            this.txtAmount.AutoSize = false;
            this.txtAmount.Location = new System.Drawing.Point(110, 43);
            this.txtAmount.Name = "txtAmount";
            this.txtAmount.Size = new System.Drawing.Size(158, 29);
            this.txtAmount.TabIndex = 3;
            this.txtAmount.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // btnYes
            // 
            this.btnYes.Location = new System.Drawing.Point(3, 174);
            this.btnYes.Name = "btnYes";
            this.btnYes.Size = new System.Drawing.Size(101, 24);
            this.btnYes.TabIndex = 4;
            this.btnYes.Text = "YES";
            this.btnYes.Click += new System.EventHandler(this.btnYes_Click);
            // 
            // btnNo
            // 
            this.btnNo.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnNo.Location = new System.Drawing.Point(163, 174);
            this.btnNo.Name = "btnNo";
            this.btnNo.Size = new System.Drawing.Size(110, 24);
            this.btnNo.TabIndex = 5;
            this.btnNo.Text = "NO";
            this.btnNo.Click += new System.EventHandler(this.btnNo_Click);
            // 
            // radLabel3
            // 
            this.radLabel3.AutoSize = false;
            this.tableLayoutPanel1.SetColumnSpan(this.radLabel3, 2);
            this.radLabel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.radLabel3.Font = new System.Drawing.Font("Segoe UI Semibold", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radLabel3.ForeColor = System.Drawing.Color.DarkRed;
            this.radLabel3.Location = new System.Drawing.Point(3, 145);
            this.radLabel3.Name = "radLabel3";
            this.radLabel3.Size = new System.Drawing.Size(270, 23);
            this.radLabel3.TabIndex = 1;
            this.radLabel3.Text = "Would you like to apply the penalty?";
            // 
            // PenaltyQuestionDetails
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(276, 203);
            this.Controls.Add(this.tableLayoutPanel1);
            this.DoubleBuffered = true;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "PenaltyQuestionDetails";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "DUE";
            this.Load += new System.EventHandler(this.PenaltyQuestionDetails_Load);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMonth)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtAmount)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnYes)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnNo)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel3)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private Telerik.WinControls.UI.RadLabel radLabel1;
        private Telerik.WinControls.UI.RadLabel radLabel2;
        private Telerik.WinControls.UI.RadTextBox txtMonth;
        private Telerik.WinControls.UI.RadTextBox txtAmount;
        private Telerik.WinControls.UI.RadButton btnYes;
        private Telerik.WinControls.UI.RadButton btnNo;
        private Telerik.WinControls.UI.RadLabel radLabel3;
    }
}