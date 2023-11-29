using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LEASING.UI.APP.Common
{
    public class Config
    {
        const string NATURE_OR = "Nature_OR_REPORT.rpt";
        const string NATURE_PR = "Nature_PR_REPORT.rpt";
        const string ONGCHING_OR = "Ongching_OR_REPORT.rpt";

        public static string baseFolderPath = ConfigurationManager.AppSettings["ClientDocumentPath"].ToString();

        public static string SqlServerName = ConfigurationManager.AppSettings["SqlServerName"].ToString();
        public static string SqlDatabaseName = ConfigurationManager.AppSettings["SqlDatabaseName"].ToString();
        public static string SqlUserID = ConfigurationManager.AppSettings["SqlUserID"].ToString();
        public static string SqlPassword = ConfigurationManager.AppSettings["SqlPassword"].ToString();

        public static string Nature_OR_REPORT = ConfigurationManager.AppSettings["ReportPath"].ToString() + NATURE_OR;
        public static string Nature_PR_REPORT = ConfigurationManager.AppSettings["ReportPath"].ToString() + NATURE_PR;
        public static string Ongching_OR_REPORT = ConfigurationManager.AppSettings["ReportPath"].ToString() + ONGCHING_OR;

        public static bool RecieptReportOption = Convert.ToBoolean(ConfigurationManager.AppSettings["RecieptReportOption"]);

    }
}
