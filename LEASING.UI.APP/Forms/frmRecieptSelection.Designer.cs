namespace LEASING.UI.APP.Forms
{
    partial class frmRecieptSelection
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
            this.btnNATURE_OR = new Telerik.WinControls.UI.RadButton();
            this.btnNATURE_PR = new Telerik.WinControls.UI.RadButton();
            this.btnONGCHING_OR = new Telerik.WinControls.UI.RadButton();
            this.office2010BlueTheme1 = new Telerik.WinControls.Themes.Office2010BlueTheme();
            ((System.ComponentModel.ISupportInitialize)(this.btnNATURE_OR)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnNATURE_PR)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnONGCHING_OR)).BeginInit();
            this.SuspendLayout();
            // 
            // btnNATURE_OR
            // 
            this.btnNATURE_OR.Image = global::LEASING.UI.APP.Properties.Resources.print_16;
            this.btnNATURE_OR.Location = new System.Drawing.Point(13, 12);
            this.btnNATURE_OR.Name = "btnNATURE_OR";
            this.btnNATURE_OR.Size = new System.Drawing.Size(188, 24);
            this.btnNATURE_OR.TabIndex = 0;
            this.btnNATURE_OR.Text = "NATURE_OR";
            this.btnNATURE_OR.ThemeName = "Office2010Blue";
            this.btnNATURE_OR.Click += new System.EventHandler(this.btnNATURE_OR_Click);
            // 
            // btnNATURE_PR
            // 
            this.btnNATURE_PR.Image = global::LEASING.UI.APP.Properties.Resources.print_16;
            this.btnNATURE_PR.Location = new System.Drawing.Point(13, 42);
            this.btnNATURE_PR.Name = "btnNATURE_PR";
            this.btnNATURE_PR.Size = new System.Drawing.Size(188, 24);
            this.btnNATURE_PR.TabIndex = 0;
            this.btnNATURE_PR.Text = "NATURE_PR";
            this.btnNATURE_PR.ThemeName = "Office2010Blue";
            this.btnNATURE_PR.Click += new System.EventHandler(this.btnNATURE_PR_Click);
            // 
            // btnONGCHING_OR
            // 
            this.btnONGCHING_OR.Image = global::LEASING.UI.APP.Properties.Resources.print_16;
            this.btnONGCHING_OR.Location = new System.Drawing.Point(13, 72);
            this.btnONGCHING_OR.Name = "btnONGCHING_OR";
            this.btnONGCHING_OR.Size = new System.Drawing.Size(188, 24);
            this.btnONGCHING_OR.TabIndex = 0;
            this.btnONGCHING_OR.Text = "ONGCHING_OR";
            this.btnONGCHING_OR.ThemeName = "Office2010Blue";
            this.btnONGCHING_OR.Click += new System.EventHandler(this.btnONGCHING_OR_Click);
            // 
            // frmRecieptSelection
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
            this.ClientSize = new System.Drawing.Size(217, 111);
            this.Controls.Add(this.btnONGCHING_OR);
            this.Controls.Add(this.btnNATURE_PR);
            this.Controls.Add(this.btnNATURE_OR);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmRecieptSelection";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "PRINT";
            this.Load += new System.EventHandler(this.frmRecieptSelection_Load);
            ((System.ComponentModel.ISupportInitialize)(this.btnNATURE_OR)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnNATURE_PR)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.btnONGCHING_OR)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Telerik.WinControls.UI.RadButton btnNATURE_OR;
        private Telerik.WinControls.UI.RadButton btnNATURE_PR;
        private Telerik.WinControls.UI.RadButton btnONGCHING_OR;
        private Telerik.WinControls.Themes.Office2010BlueTheme office2010BlueTheme1;
    }
}