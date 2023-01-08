using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;
using System.Text;

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
            string fname = firstname.Text;
            string lname = lastname.Text;
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
                string sqlstmt = "insert into patient (pid,pFirstname,pLastname,pPword,pEmail) Values (@id,@fname,@lname,@pass,@email)";
                string conString = "Data Source=DESKTOP-NIIEL8L;Initial Catalog=HospitalManagement;Integrated Security=True";
                SqlConnection cn = new SqlConnection(conString);
                SqlCommand cmd = new SqlCommand(sqlstmt, cn);
                cmd.Parameters.Add(new SqlParameter("@id", SqlDbType.Int));
                cmd.Parameters.Add(new SqlParameter("@fname", SqlDbType.NVarChar, 16));
                cmd.Parameters.Add(new SqlParameter("@lname", SqlDbType.NVarChar, 16));
                cmd.Parameters.Add(new SqlParameter("@pass", SqlDbType.NVarChar, 12));
                cmd.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar, 255));
                cmd.Parameters["@fname"].Value = firstname.Text;
                cmd.Parameters["@lname"].Value = lastname.Text;
                cmd.Parameters["@pass"].Value = password.Text;
                cmd.Parameters["@id"].Value = Convert.ToInt32(userID.Text);
                cmd.Parameters["@email"].Value = email.Text;
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();
                string to = email.Text.ToString();
                string from = "easycare2022@gmail.com"; 
                MailMessage message = new MailMessage(from, to);
                string mailbody = "Thank you for registering with Easy Care Hospitals!";
                mailbody += '\n' + "Your userID:" + '\t' + id + '\n' + "Your password:" + '\t' + pass;
                message.Subject = "Welcome Aboard!";
                message.Body = mailbody;
                message.BodyEncoding = Encoding.UTF8;
                message.IsBodyHtml = true;
                SmtpClient client = new SmtpClient("smtp.gmail.com", 587); 
                System.Net.NetworkCredential basicCredential1 = new
                System.Net.NetworkCredential("easycare2023@gmail.com", "lhjcxewjzqkyppgl");
                client.EnableSsl = true;
                client.UseDefaultCredentials = false;
                client.Credentials = basicCredential1;
                try
                {
                    client.Send(message);
                }

                catch (Exception ex)
                {
                    throw ex;
                }
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

        protected void firstname_TextChanged(object sender, EventArgs e)
        {

        }

        protected void lastname_TextChanged(object sender, EventArgs e)
        {

        }

        protected void email_TextChanged(object sender, EventArgs e)
        {

        }
    }
}