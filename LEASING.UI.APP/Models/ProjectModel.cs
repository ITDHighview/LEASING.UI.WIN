using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Models
{
    public class ProjectModel : CommonModel
    {
        public int ProjectId { get; set; }
        public string ProjectType { get; set; }
        public int LocId { get; set; }
        public string ProjectName { get; set; }
        public string Description { get; set; }
        public string ProjectAddress { get; set; }
        public bool ProjectStatus { get; set; }
        public int CompanyId { get; set; }
    }
}
