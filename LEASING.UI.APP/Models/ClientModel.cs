using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Models
{
    public class ClientModel : CommonModel
    {
        public int RecId { get; set; }
        public string ClientID { get; set; }
        public string ClientType { get; set; }
        public string ClientName { get; set; }
        public int Age { get; set; }
        public string PostalAddress { get; set; }
        public string Address { get; set; }
        public string DateOfBirth { get; set; }
        public string TelNumber { get; set; }
        public bool Gender { get; set; }
        public string Nationality { get; set; }
        public string Occupation { get; set; }
        public int AnnualIncome { get; set; }
        public string EmployerName { get; set; }
        public string EmployerAddress { get; set; }
        public string SpouseName { get; set; }
        public string ChildrenNames { get; set; }
        public int TotalPersons { get; set; }
        public string MaidName { get; set; }
        public string DriverName { get; set; }
        public int NoVisitorsPerDay { get; set; }
        public int BuildingSecretary { get; set; }
    }
}
