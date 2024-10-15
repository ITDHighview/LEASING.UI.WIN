using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Models
{
    public class OtherPaymentTypeModel
    {
        public int RecId { get; set; }
        public string OtherPaymentTypeName { get; set; }
        public decimal OtherPaymentVatPCT { get; set; }
        public decimal OtherPaymentTaxPCT { get; set; }
        public string Remarks { get; set; }
        public int EncodedBy { get; set; }
        public DateTime EncodedDate { get; set; }
        public int LastChangedBy { get; set; }
        public DateTime LastChangedDate { get; set; }
        public string ComputerName { get; set; }
        public bool IsActive { get; set; }
    }
}
