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
        public decimal AreaTotalAmount { get; set; }
        public string FloorType { get; set; }
       
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

        public decimal BaseRental { get; set; }
        public decimal BaseRentalVatAmount { get; set; }
        public decimal BaseRentalWithVatAmount { get; set; }
        public decimal BaseRentalTax { get; set; }

        public bool IsNonVat { get; set; }
        public bool IsNonTax { get; set; }

        public bool IsNonCusa { get; set; }
        public decimal TotalRental { get; set; }

        public decimal SecAndMainAmount { get; set; }
        public decimal SecAndMainVatAmount { get; set; }
        public decimal SecAndMainWithVatAmount { get; set; }

        public decimal Tax { get; set; }
        public decimal TaxAmount { get; set; }

        public decimal Vat { get; set; }

        public bool IsNotRoundOff { get; set; }
        public bool IsOverrideSecAndMain { get; set; }
        



    }
}
