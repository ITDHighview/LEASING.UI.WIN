﻿using LEASING.UI.APP.Forms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;



namespace LEASING.UI.APP
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            try
            {
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);
                Application.Run(new frmPreEmp_Login(frmPreEmp_Login.LoginMethod.Login));
                //Application.Run(new GeneralReport());
                //Application.Run(new UnitRenewalContractRegistrationForm());
                //Application.Run(new ParkingRenewalContractRegistrationForm());
                //Application.Run(new PrintReceiptSecondPaymentCategoryTest("TRN10000000", "REF10000000", "SECOND"));
                //Application.Run(new PrintReceiptFirstPaymentCategory("TRN10000000", "REF10000000", "SECOND"));
                
            }

            catch (Exception vValue)
            {
                MessageBox.Show(vValue.Message, "Programs");
            }

        }
    }
}
