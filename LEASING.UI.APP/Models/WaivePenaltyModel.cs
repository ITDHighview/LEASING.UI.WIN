using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Models
{
    public class WaivePenaltyModel : CommonModel
    {
        public string RefId { get; set; }
        public int ReferenceID { get; set; }
        public string LedgeMonth { get; set; }
        public int LedgerRecId { get; set; }
        public decimal Amount { get; set; }
        public decimal PenaltyOldAmount { get; set; }
        public string Requestor { get; set; }
        public string Remarks { get; set; }

    }
}
