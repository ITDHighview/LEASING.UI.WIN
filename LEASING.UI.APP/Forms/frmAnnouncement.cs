using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmAnnouncement : Form
    {
        AnnouncementContext AnnouncementContext = new AnnouncementContext();
        public frmAnnouncement()
        {
            InitializeComponent();
        }
        private void GetAnnouncement()
        {
            txtAnnouncementMessage.Text = string.Empty;
            using (DataSet dt = AnnouncementContext.GetAnnouncement())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    txtAnnouncementMessage.Text = Convert.ToString(dt.Tables[0].Rows[0]["AnnounceMessage"]);
                }
            }
        }

        private void M_UpdateAnnouncement()
        {

            string result = AnnouncementContext.UpdateAnnouncement(txtAnnouncementMessage.Text);
            if (result.Equals("SUCCESS"))
            {
                Functions.MessageShow("Updated!.");
            }
            else
            {
                Functions.MessageShow(result);
            }

        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            M_UpdateAnnouncement();
        }

        private void frmAnnouncement_Load(object sender, EventArgs e)
        {
            GetAnnouncement();
        }
    }
}
