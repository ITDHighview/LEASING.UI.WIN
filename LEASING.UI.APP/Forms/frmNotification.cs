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
using Telerik.WinControls.UI;

namespace LEASING.UI.APP.Forms
{
    public partial class frmNotification : Form
    {
        OtherContext OtherContext = new OtherContext();
        //RadPanel panels = new RadPanel();
        //RadLabel lables = new RadLabel();
        FlowLayoutPanel layoutpanels = new FlowLayoutPanel();
        public frmNotification()
        {
            InitializeComponent();
        }

        private void GetNotificationList()
        {
           
            using (DataSet dt = OtherContext.GetNotificationList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                   

                    for (int i = 0; i < dt.Tables[0].Rows.Count; i++)
                    { 
                        Panel panels = new Panel();

                        PictureBox picturebox = new PictureBox();

                        if (Convert.ToString(dt.Tables[0].Rows[i]["Status"]) =="DUE")
                        {
                            picturebox.Image = Properties.Resources.warning_48;
                        }
                        else
                        {
                            picturebox.Image = Properties.Resources.info_48;
                        }
                       
                       
                        picturebox.Dock = DockStyle.Right;
                        //panels.Dock = DockStyle.Top;
                        panels.Width = 500;
                        panels.Height = 80;
                        panels.BackgroundImage = Properties.Resources.DarkBackground1;
                        //panels.BackColor = Color.Aqua;

                        Label lables = new Label();
                       
                        lables.Dock = DockStyle.Top;
                        lables.Text = "";
                        lables.ForeColor = Color.White;
                        lables.BackColor = Color.RoyalBlue;
                        lables.Font = new System.Drawing.Font("Segoe UI", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
                        lables.TextAlign = ContentAlignment.MiddleCenter;
                        lables.Text ="NAME : "+ Convert.ToString(dt.Tables[0].Rows[i]["Client"])+"-("+ Convert.ToString(dt.Tables[0].Rows[i]["ClientID"])+")";

                        Label lables2 = new Label();
                        lables2.Dock = DockStyle.Top;
                        lables2.Text = "";
                        lables2.ForeColor = Color.Black;
                        lables2.BackColor = Color.White;

                        lables2.Text ="CONTRACT ID :"+ Convert.ToString(dt.Tables[0].Rows[i]["ContractID"])+"  AMOUNT : "+Convert.ToString(dt.Tables[0].Rows[i]["Amounth"]) + "  FOR MONTH : " + Convert.ToString(dt.Tables[0].Rows[i]["ForMonth"]);

                        Label lables3 = new Label();
                        lables3.Dock = DockStyle.Top;
                        lables3.Text = "";
                        lables3.TextAlign = ContentAlignment.MiddleCenter;
                        lables3.Font = new System.Drawing.Font("Segoe UI", 11.25F, System.Drawing.FontStyle.Bold);
                        if (Convert.ToString(dt.Tables[0].Rows[i]["Status"]) == "DUE")
                        {
                            lables3.ForeColor = Color.White;
                            lables3.BackColor = Color.Red;
                        }
                        else
                        {
                            lables3.ForeColor = Color.White;
                            lables3.BackColor = Color.Tomato;
                        }
                       

                        lables3.Text = Convert.ToString(dt.Tables[0].Rows[i]["Status"]);

                        panels.Controls.Add(lables2);
                        panels.Controls.Add(lables);
                        panels.Controls.Add(lables3);
                        panels.Controls.Add(picturebox);



                        flowLayoutPanel1.Controls.Add(panels);
                    }
                   
                    
                  
                }
            }
        }

        private void frmNotification_Load(object sender, EventArgs e)
        {
            GetNotificationList();
        }
    }
}
