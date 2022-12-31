using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class signupform : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            lblErrorMessage1.Visible = false;
            lblErrorMessage2.Visible = false;
            primaryKeyError.Visible = false;

        }

        protected void userID_TextChanged(object sender, EventArgs e)
        {

        }

        protected void username_TextChanged(object sender, EventArgs e)
        {

        }

        protected void password_TextChanged(object sender, EventArgs e)
        {

        }

        protected void password2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string id = userID.Text;
            string name = username.Text;
            string pass = password.Text;
            string confirm_pass = password2.Text;
            if (pass != confirm_pass)
            {
                lblErrorMessage2.Visible = true;
            }
            if (id[0] != '1')
            {
                lblErrorMessage1.Visible = true;
            }
            try
            {
                string sqlstmt = "insert into patient (pid,pFirstname,pPword) Values (@id,@name,@pass)";
                string conString = "Data Source=DESKTOP-NIIEL8L;Initial Catalog=HospitalManagement;Integrated Security=True";
                SqlConnection cn = new SqlConnection(conString);
                SqlCommand cmd = new SqlCommand(sqlstmt, cn);
                cmd.Parameters.Add(new SqlParameter("@id", SqlDbType.Int));
                cmd.Parameters.Add(new SqlParameter("@name", SqlDbType.NVarChar, 16));
                cmd.Parameters.Add(new SqlParameter("@pass", SqlDbType.NVarChar, 12));
                cmd.Parameters["@name"].Value = username.Text;
                cmd.Parameters["@pass"].Value = password.Text;
                cmd.Parameters["@id"].Value = Convert.ToInt32(userID.Text);
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627)
                {
                    primaryKeyError.Visible = true;
                    primaryKeyError.Text = "Id is already taken, Please choose another one.";
                }
            }

        }
    }
}