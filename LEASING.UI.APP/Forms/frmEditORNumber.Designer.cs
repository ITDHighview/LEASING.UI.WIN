namespace LEASING.UI.APP.Forms
{
    partial class frmEditORNumber
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
            this.radLabel1 = new Telerik.WinControls.UI.RadLabel();
            this.txtORNumber = new Telerik.WinControls.UI.RadTextBox();
            this.btnCancel = new Telerik.WinControls.UI.RadButton();
            this.btnSave = new Telerik.WinControls.UI.RadButton();
            this.radLabel2 = new Telerik.WinControls.UI.RadLabel();
            this.txtReceiptNumber = new Telerik.WinControls.UI.RadTextBox();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtORNumber)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnCancel)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSave)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtReceiptNumber)).BeginInit();
            this.SuspendLayout();
            // 
            // radLabel1
            // 
            this.radLabel1.Location = new System.Drawing.Point(28, 26);
            this.radLabel1.Name = "radLabel1";
            this.radLabel1.Size = new System.Drawing.Size(68, 18);
            this.radLabel1.TabIndex = 0;
            this.radLabel1.Text = "OR Number.";
            // 
            // txtORNumber
            // 
            this.txtORNumber.Location = new System.Drawing.Point(105, 26);
            this.txtORNumber.Name = "txtORNumber";
            this.txtORNumber.NullText = "Type here...";
            this.txtORNumber.Size = new System.Drawing.Size(146, 20);
            this.txtORNumber.TabIndex = 1;
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(194, 51);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(61, 24);
            this.btnCancel.TabIndex = 2;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(88, 51);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(61, 24);
            this.btnSave.TabIndex = 2;
            this.btnSave.Text = "Save";
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // radLabel2
            // 
            this.radLabel2.Location = new System.Drawing.Point(6, 4);
            this.radLabel2.Name = "radLabel2";
            this.radLabel2.Size = new System.Drawing.Size(90, 18);
            this.radLabel2.TabIndex = 0;
            this.radLabel2.Text = "Receipt Number.";
            // 
            // txtReceiptNumber
            // 
            this.txtReceiptNumber.Location = new System.Drawing.Point(105, 4);
            this.txtReceiptNumber.Name = "txtReceiptNumber";
            this.txtReceiptNumber.NullText = "Type here...";
            this.txtReceiptNumber.Size = new System.Drawing.Size(146, 20);
            this.txtReceiptNumber.TabIndex = 1;
            // 
            // frmEditORNumber
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(263, 83);
            this.ControlBox = false;
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.txtReceiptNumber);
            this.Controls.Add(this.txtORNumber);
            this.Controls.Add(this.radLabel2);
            this.Controls.Add(this.radLabel1);
            this.DoubleBuffered = true;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmEditORNumber";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Add OR Number";
            this.Load += new System.EventHandler(this.frmEditORNumber_Load);
            ((System.ComponentModel.ISupportInitialize)(this.radLabel1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtORNumber)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnCancel)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnSave)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.radLabel2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtReceiptNumber)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Telerik.WinControls.UI.RadLabel radLabel1;
        private Telerik.WinControls.UI.RadTextBox txtORNumber;
        private Telerik.WinControls.UI.RadButton btnCancel;
        private Telerik.WinControls.UI.RadButton btnSave;
        private Telerik.WinControls.UI.RadLabel radLabel2;
        private Telerik.WinControls.UI.RadTextBox txtReceiptNumber;
    }
}