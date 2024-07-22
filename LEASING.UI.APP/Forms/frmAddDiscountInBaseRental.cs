using LEASING.UI.APP.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmAddDiscountInBaseRental : Form
    {

        public decimal vUnit_Vat { get; set; } = 0;
        public decimal vUnit_BaseRental { get; set; } = 0;
        public decimal vDiscounted_BaseRental { get; set; } = 0;
        public decimal vUnit_BaseRentalVatAmount { get; set; } = 0;
        public decimal vDiscounted_BaseRentalVatAmount { get; set; } = 0;
        public decimal vUnit_BaseRentalWithVatAmount { get; set; } = 0;
        public decimal vDiscounted_BaseRentalWithVatAmount { get; set; } = 0;


        public decimal vUnit_Tax { get; set; } = 0;
        public decimal vUnit_TaxAmount { get; set; } = 0;
        public decimal vUnit_TotalRentalAmount { get; set; } = 0;
        public decimal vDiscounted_TotalRentalAmount { get; set; } = 0;
        public decimal vDiscount_Amount { get; set; } = 0;
        public decimal vContract_DiscountAmount { get; set; } = 0;

        public bool IsDiscounted = false;
        public bool IsProceed = false;
        private void DisableFields()
        {
            txtUnit_Vat.Enabled = false;
            txtUnit_BaseRental.Enabled = false;
            txtUnit_BaseRentalVatAmount.Enabled = false;
            txtUnit_BaseRentalWithVatAmount.Enabled = false;
            txtUnit_Tax.Enabled = false;
            txtUnit_TaxAmount.Enabled = false;
            txtUnit_TotalRentalAmount.Enabled = false;
            btnApply.Enabled = false;
        }
        public frmAddDiscountInBaseRental()
        {
            InitializeComponent();
        }

        private void getDiscountedBaseRental()
        {
            this.vDiscounted_BaseRental = (this.vUnit_BaseRental - this.vDiscount_Amount);
            txtUnit_BaseRental.Text = string.Empty;
            txtUnit_BaseRental.Text = this.vDiscounted_BaseRental.ToString();

        }
        private void getDiscountedBaseRentalVatAmount()
        {
            this.vDiscounted_BaseRentalVatAmount = ((this.vDiscounted_BaseRental * vUnit_Vat) / 100);
            txtUnit_BaseRentalVatAmount.Text = string.Empty;
            txtUnit_BaseRentalVatAmount.Text = this.vDiscounted_BaseRentalVatAmount.ToString("0.00");

        }
        private void getDiscountedBaseRentalWithVatAmount()
        {
            this.vDiscounted_BaseRentalWithVatAmount = (this.vDiscounted_BaseRental+ this.vDiscounted_BaseRentalVatAmount);
            txtUnit_BaseRentalWithVatAmount.Text = string.Empty;
            txtUnit_BaseRentalWithVatAmount.Text = this.vDiscounted_BaseRentalWithVatAmount.ToString("0.00");
        }
        private void getDiscountedTotalAmount()
        {

            this.vDiscounted_TotalRentalAmount = (this.vDiscounted_BaseRentalWithVatAmount - vUnit_TaxAmount);
            txtUnit_TotalRentalAmount.Text = string.Empty;
            txtUnit_TotalRentalAmount.Text = this.vDiscounted_TotalRentalAmount.ToString("0.00");
        }
        private void btnApply_Click(object sender, EventArgs e)
        {
            if (Functions.MessageConfirm("Are you sure you want to apply the Discounted Amount?") == DialogResult.Yes)
            {
                this.IsProceed = true;
                this.vContract_DiscountAmount = Functions.ConvertStringToDecimal(txtContract_DiscountAmount.Text);
                this.Close();
            }
    
        }

        private void frmAddDiscountInBaseRental_Load(object sender, EventArgs e)
        {
            DisableFields();
            txtUnit_Vat.Text = Convert.ToString(vUnit_Vat);
            txtUnit_BaseRental.Text = Convert.ToString(vUnit_BaseRental);
            txtUnit_BaseRentalVatAmount.Text = Convert.ToString(vUnit_BaseRentalVatAmount);
            txtUnit_BaseRentalWithVatAmount.Text = Convert.ToString(vUnit_BaseRentalWithVatAmount);
            txtUnit_Tax.Text = Convert.ToString(vUnit_Tax);
            txtUnit_TaxAmount.Text = Convert.ToString(vUnit_TaxAmount);
            txtUnit_TotalRentalAmount.Text = Convert.ToString(vUnit_TotalRentalAmount);

        }

        private void txtUnit_Vat_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtUnit_BaseRental_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtUnit_BaseRentalVatAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void Unit_BaseRentalWithVatAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtUnit_Tax_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtUnit_TaxAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtUnit_TotalRentalAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtContract_DiscountAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtContract_DiscountAmount_TextChanged(object sender, EventArgs e)
        {
            if (Functions.ConvertStringToDecimal(txtContract_DiscountAmount.Text) > 0)
            {
                this.IsDiscounted = true;
                btnApply.Enabled = this.IsDiscounted;
                this.vDiscount_Amount = Functions.ConvertStringToDecimal(txtContract_DiscountAmount.Text);
                this.getDiscountedBaseRental();
                this.getDiscountedBaseRentalVatAmount();
                this.getDiscountedBaseRentalWithVatAmount();
                this.getDiscountedTotalAmount();
            }
            else
            {
                this.IsDiscounted = false;
                btnApply.Enabled = this.IsDiscounted;
                txtUnit_Vat.Text = Convert.ToString(vUnit_Vat);
                txtUnit_BaseRental.Text = Convert.ToString(vUnit_BaseRental);
                txtUnit_BaseRentalVatAmount.Text = Convert.ToString(vUnit_BaseRentalVatAmount);
                txtUnit_BaseRentalWithVatAmount.Text = Convert.ToString(vUnit_BaseRentalWithVatAmount);
                txtUnit_Tax.Text = Convert.ToString(vUnit_Tax);
                txtUnit_TaxAmount.Text = Convert.ToString(vUnit_TaxAmount);
                txtUnit_TotalRentalAmount.Text = Convert.ToString(vUnit_TotalRentalAmount);
            }

        }
    }
}
