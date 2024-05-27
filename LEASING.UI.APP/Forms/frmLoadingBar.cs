using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmLoadingBar : Form
    {
        public string LoadingTitle { get; set; } = string.Empty;
   
        public frmLoadingBar()
        {
            InitializeComponent();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (progressBar1.Value < 25)
            {
                progressBar1.Value += 1;
                //lbl.text = prog.Value.ToString() + "%";

            }
            else
            {
                timer1.Stop();
                //Code
                this.Close();
            }
        }

        private void frmLoadingBar_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(LoadingTitle))
            {
                label1.Text = LoadingTitle;
            }
           
            timer1.Start();
        }
    }
}
