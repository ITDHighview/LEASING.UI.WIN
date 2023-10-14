using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Models
{
    public class UnitModel : CommonModel
    {
        public int UnitId { get; set; }
        public int ProjectId { get; set; }
        public string UnitDescription { get; set; }
        public int FloorNo { get; set; }
        public decimal AreaSqm { get; set; }
        public decimal AreaRateSqm { get; set; }
        public string FloorType { get; set; }
        public decimal BaseRental { get; set; }
        public string UnitStatus { get; set; }
        public string DetailsofProperty { get; set; }
        public string UnitNo { get; set; }
        public int UnitSequence { get; set; }
        public int GenVat { get; set; }
        public int SecurityAndMaintenance { get; set; }
        public int SecurityAndMaintenanceVat { get; set; }
        public int ClientID { get; set; }
        public string Tenant { get; set; }
        public bool IsParking { get; set; }
    }
}
