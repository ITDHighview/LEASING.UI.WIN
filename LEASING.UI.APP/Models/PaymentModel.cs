using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Models
{
    public class PaymentModel
    {
        public long RecId { get; set; }
        public string PayID { get; set; }
        public string TranId { get; set; }
        public decimal Amount { get; set; }
        public DateTime ForMonth { get; set; }
        public string Remarks { get; set; }
        public int EncodedBy { get; set; }
        public DateTime EncodedDate { get; set; }
        public int LastChangedBy { get; set; }
        public DateTime LastChangedDate { get; set; }
        public string ComputerName { get; set; }
        public bool IsActive { get; set; }
        public string RefId { get; set; }
        public string Notes { get; set; }
        public long LedgeRecid { get; set; }
        public string ClientID { get; set; }
        public string OtherPaymentTypeName { get; set; }
        public decimal OtherPaymentAmount { get; set; }
        public decimal OtherPaymentVatPCT { get; set; }
        public decimal OtherPaymentVatAmount { get; set; }
        public bool OtherPaymentIsVatApplied { get; set; }
        public decimal OtherPaymentTaxPCT { get; set; }
        public decimal OtherPaymentTaxAmount { get; set; }
        public bool OtherPaymentTaxIsApplied { get; set; }
    }
}
