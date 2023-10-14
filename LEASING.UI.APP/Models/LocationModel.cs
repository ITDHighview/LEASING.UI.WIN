using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Models
{
    public class LocationModel : CommonModel
    {
        public int LocId { get; set; }
        public string Description { get; set; }
        public string LocAddress { get; set; }
        public bool LocStatus { get; set; }
    }
}
