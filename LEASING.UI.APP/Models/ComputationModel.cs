using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Models
{
    public class ComputationModel : CommonModel
    {
        public int RecId { get; set; }
        public string RefId { get; set; }
        public int ProjectId { get; set; }
        public string InquiringClient { get; set; }
        public string ClientMobile { get; set; }
        public int UnitId { get; set; }
        public string UnitNo { get; set; }
        public string StatDate { get; set; }
        public string FinishDate { get; set; }
        public string TransactionDate { get; set; }
        public decimal Rental { get; set; }
        public decimal SecAndMaintenance { get; set; }
        public decimal TotalRent { get; set; }
        public decimal SecDeposit { get; set; }
        public decimal Total { get; set; }
        public bool IsActive { get; set; }
        public string ClientID { get; set; }
        public string XML { get; set; }
        public decimal AdvancePaymentAmount { get; set; }
        public bool IsFullPayment { get; set; }

    }

}
