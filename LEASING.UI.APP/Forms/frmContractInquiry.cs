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
    public partial class frmContractInquiry : Form
    {
        public frmContractInquiry()
        {
            InitializeComponent();
        }

        private void frmContractInquiry_Load(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Maximized;
            pictureBox1.Image = Properties.Resources.tick_64;
            pictureBox2.Image = Properties.Resources.tick_64;
            pictureBox3.Image = Properties.Resources.tick_64;
            pictureBox4.Image = Properties.Resources.tick_64;
            pictureBox5.Image = Properties.Resources.tick_64;
            pictureBox6.Image = Properties.Resources.tick_64;

        }
    }
}
