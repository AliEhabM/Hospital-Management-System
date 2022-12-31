using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class loginform : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblErrorMessage.Visible = false;
        }

        protected void login_Click(object sender, EventArgs e)
        {
            string id = TextBox1.Text;
            string password = TextBox2.Text;
            Session["userid"] = TextBox1.Text;
            string connection_string = "Data Source=DESKTOP-NIIEL8L;Initial Catalog=HospitalManagement;Integrated Security=True";
            SqlConnection con = new SqlConnection(connection_string);
            con.Open();
            if (con.State == System.Data.ConnectionState.Open)
            {
                if (patientRadio.Checked)
                {

                    string query = "select count(1) from patient where pid = @pid AND pPword = @password";
                    SqlCommand sqlCmd = new SqlCommand(query, con);
                    sqlCmd.Parameters.AddWithValue("@pid", id);
                    sqlCmd.Parameters.AddWithValue("@password", password);
                    int count = Convert.ToInt32(sqlCmd.ExecuteScalar());
                    if (count == 1)
                    {
                        Response.Redirect("patient.aspx");
                    }
                    else
                    {
                        lblErrorMessage.Visible = true;
                    }
                }
                else if (doctorRadio.Checked)
                {
                    string query = "select count(1) from doctor where did = @did AND dPword = @password";
                    SqlCommand sqlCmd = new SqlCommand(query, con);
                    sqlCmd.Parameters.AddWithValue("@did", id);
                    sqlCmd.Parameters.AddWithValue("@password", password);
                    int count = Convert.ToInt32(sqlCmd.ExecuteScalar());
                    if (count == 1)
                    {
                        Response.Redirect("doctor.aspx");
                    }
                    else
                    {
                        lblErrorMessage.Visible = true;
                    }
                }
                else if (empRadio.Checked)
                {

                    string query = "select count(1) from employee where eid = @eid AND ePword = @password";
                    SqlCommand sqlCmd = new SqlCommand(query, con);
                    sqlCmd.Parameters.AddWithValue("@eid", id);
                    sqlCmd.Parameters.AddWithValue("@password", password);
                    int count = Convert.ToInt32(sqlCmd.ExecuteScalar());
                    if (count == 1)
                    {
                        Response.Redirect("employee.aspx");
                    }
                    else
                    {
                        lblErrorMessage.Visible = true;
                    }
                }

            }
            else
            {
                lblErrorMessage.Visible = true;
            }
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("signupform.aspx");
        }

        protected void empRadio_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void doctorRadio_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void patientRadio_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}