using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;
using System.Security.Cryptography;
using System.Web.WebSockets;

namespace EasyHealthcare
{
    public partial class employee : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=localhost;Initial Catalog=HospitalManagement;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            con.Open();
        }

        protected void discharge_Click(object sender, EventArgs e)
        {

            SqlCommand check = new SqlCommand("SELECT 1 FROM PATIENT WHERE pid='" + dispID.Text + "'", con);
            check.Connection = con;
            SqlDataReader reader = check.ExecuteReader();
            if (reader.Read())
            {
                reader.Close();
                SqlCommand dis = new SqlCommand("DELETE FROM patient WHERE pid='" + dispID.Text + "'", con);
                dis.ExecuteNonQuery();
                disFail.Visible = false;
                disSuccess.Visible = true;
            }
            else
            {
                disFail.Visible = true;
                disSuccess.Visible = false;
            }
            con.Close();
        }

        protected void find1()
        {
            SqlCommand check_PID = new SqlCommand("SELECT COUNT(*) FROM patient WHERE pid='" + IDentry.Text + "'", con);
            int patientExist = (int)check_PID.ExecuteScalar();
            SqlCommand check_DID = new SqlCommand("SELECT COUNT(*) FROM doctor WHERE did='" + IDentry.Text + "'", con);
            int doctorExist = (int)check_DID.ExecuteScalar();
            if (radioList.SelectedItem.Value == "did")
            {
                didView.Visible = true;
                pidView.Visible = false;
                didView.DataBind();
            }
            else
            {
                pidView.Visible = true;
                didView.Visible = false;
                didView.DataBind();
            }
        }
        protected void find_Click(object sender, EventArgs e)
        {
            find1();
        }

        protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
        }

        protected void didView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void pidView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}