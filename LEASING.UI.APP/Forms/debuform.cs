using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Windows.Forms;
using CrystalDecisions.Shared;

namespace LEASING.UI.APP.Forms
{
    public partial class debuform : Form
    {
        public debuform()
        {
            InitializeComponent();
        }

        private void debuform_Load(object sender, EventArgs e)
        {
            try
            {
                Cursor.Current = Cursors.AppStarting;
                string report = ConfigurationManager.AppSettings["ReportPath"].ToString();
                CrystalDecisions.CrystalReports.Engine.ReportDocument locRptDocument = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
                locRptDocument.Load(report);
                //locRptDocument.SetParameterValue("@BookingNo", "1");
                //locRptDocument.SetParameterValue("@Encounter_No", "");
                ConnectionInfo crConnectionInfo = new ConnectionInfo();
                crConnectionInfo.ServerName = "MARKJASON";
                crConnectionInfo.DatabaseName = "LEASINGDB";
                crConnectionInfo.UserID = "sa";
                crConnectionInfo.Password = "1216012";

                Tables CrTables = locRptDocument.Database.Tables;
                CrTables = locRptDocument.Database.Tables;
                foreach (CrystalDecisions.CrystalReports.Engine.Table CrTable in CrTables)
                {
                    TableLogOnInfo crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo = CrTable.LogOnInfo;
                    crtableLogoninfo.ConnectionInfo = crConnectionInfo;
                    CrTable.ApplyLogOnInfo(crtableLogoninfo);
                }
                CrystalReportViewer crv = new CrystalReportViewer();
                crv.Dock = DockStyle.Fill;
                crv.ReportSource = locRptDocument;
                crv.Refresh();

              
                this.Controls.Add(crv);
                this.WindowState = FormWindowState.Maximized;
                //this.ShowDialog();

                Cursor.Current = Cursors.Default;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }



        }

    }
}
