using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Models
{
    public class CompanyModel : CommonModel
    {
        public int RecId { get; set; }
        public string CompanyName { get; set; }
        public string CompanyAddress { get; set; }
        public string CompanyTIN { get; set; }
        public string CompanyOwnerName { get; set; }

    }
}
