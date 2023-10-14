using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Models
{
    public class PurchaseItemModel : CommonModel
    {
        public int RecId { get; set; }
        public int ProjectId { get; set; }
        public string ProjectName { get; set; }
        public string ProjectAddress { get; set; }
        public string Descriptions { get; set; }
        public string DatePurchase { get; set; }
        public int UnitAmount { get; set; }
        public decimal Amount { get; set; }
        public decimal TotalAmount { get; set; }
        public string Remarks { get; set; }
        public string UnitNumber { get; set; }
        public int UnitID { get; set; }
        public bool PurchaseItemStatus { get; set; }
    }
}
