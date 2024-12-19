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
    public partial class PenaltyQuestionDetails : Form
    {
        private string MonthHavePenalty = string.Empty;
        private string AmountOfPenalty = string.Empty;
        public bool IsProceed = false;
        public PenaltyQuestionDetails(string MonthHavePenalty, string AmountOfPenalty)
        {
            InitializeComponent();
            this.MonthHavePenalty = MonthHavePenalty;
            this.AmountOfPenalty = AmountOfPenalty;
        }
        private void btnYes_Click(object sender, EventArgs e)
        {
            IsProceed = true;
            this.Close();
        }

        private void btnNo_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void PenaltyQuestionDetails_Load(object sender, EventArgs e)
        {
            txtMonth.ReadOnly = true;
            txtAmount.ReadOnly = true;
            txtMonth.Text = MonthHavePenalty;
            txtAmount.Text = AmountOfPenalty;
            btnNo.Focus();
        }
    }
}
