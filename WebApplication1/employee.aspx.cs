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
            
            SqlCommand check = new SqlCommand("SELECT 1 FROM PATIENT WHERE pid='"+dispID.Text+"'", con);
            check.Connection = con;
            SqlDataReader reader = check.ExecuteReader();
            if (reader.Read())
            {
                reader.Close();
                SqlCommand dis = new SqlCommand("DELETE FROM patient WHERE pid='" + dispID.Text + "'", con);
                dis.ExecuteNonQuery();
                disFail.Visible= false;
                disSuccess.Visible= true;
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
                if (doctorExist != 0)
                {

                    dateDropdown.Items.Clear();


                    SqlCommand counter = new SqlCommand("SELECT COUNT(*) FROM hasAppointment WHERE did = @ID", con);
                    counter.Parameters.Add("@ID", SqlDbType.Int);
                    counter.Parameters["@ID"].Value = IDentry.Text;
                    int count = (int)counter.ExecuteScalar();


                    for (int i = 0; i < count; i++)
                    {

                        SqlCommand getDate = new SqlCommand("select appointmentDate from hasAppointment  where did = @ID order by appointmentDate offset @Offset rows fetch next 1 rows only", con);
                        getDate.Parameters.Add("@Offset", SqlDbType.Int);
                        getDate.Parameters.Add("@ID", SqlDbType.Int);
                        getDate.Parameters["@ID"].Value = IDentry.Text;
                        getDate.Parameters["@Offset"].Value = i;
                        DateTime date = DateTime.Parse(getDate.ExecuteScalar().ToString());

                        SqlCommand getTime = new SqlCommand("select appointmentTime from hasAppointment where did = @ID order by appointmentTime offset @Offset rows fetch next 1 rows only", con);
                        getTime.Parameters.Add("@Offset", SqlDbType.Int);
                        getTime.Parameters.Add("@ID", SqlDbType.Int);
                        getTime.Parameters["@ID"].Value = IDentry.Text;
                        getTime.Parameters["@Offset"].Value = i;
                        DateTime time = DateTime.Parse(getTime.ExecuteScalar().ToString());

                        dateDropdown.Items.Add(new ListItem(date.ToString("MMMM dd, yyyy") + " at " + time.ToString("HH:mm")));

                    }


                    notExistRU.Visible = false;
                }
                else
                {
                    ExistRU.Visible = false;
                    notExistRU.Visible = true;
                }
            }
            else
            {
                if (patientExist != 0)
                {
                    dateDropdown.Items.Clear();

                    SqlCommand counter = new SqlCommand("SELECT COUNT(*) FROM hasAppointment WHERE pid = @ID", con);
                    counter.Parameters.Add("@ID", SqlDbType.Int);
                    counter.Parameters["@ID"].Value = IDentry.Text;
                    int count = (int)counter.ExecuteScalar();


                    for (int i = 0; i < count; i++)
                    {

                        SqlCommand getDate = new SqlCommand("select appointmentDate from hasAppointment  where pid = @ID order by appointmentDate offset @Offset rows fetch next 1 rows only", con);
                        getDate.Parameters.Add("@Offset", SqlDbType.Int);
                        getDate.Parameters.Add("@ID", SqlDbType.Int);
                        getDate.Parameters["@ID"].Value = IDentry.Text;
                        getDate.Parameters["@Offset"].Value = i;
                        DateTime date = DateTime.Parse(getDate.ExecuteScalar().ToString());

                        SqlCommand getTime = new SqlCommand("select appointmentTime from hasAppointment where pid = @ID order by appointmentTime offset @Offset rows fetch next 1 rows only", con);
                        getTime.Parameters.Add("@ID", SqlDbType.Int);
                        getTime.Parameters["@ID"].Value = IDentry.Text;
                        getTime.Parameters.Add("@Offset", SqlDbType.Int);
                        getTime.Parameters["@Offset"].Value = i;
                        DateTime time = DateTime.Parse(getTime.ExecuteScalar().ToString());

                        dateDropdown.Items.Add(new ListItem(date.ToString("MMMM dd, yyyy") + " at " + time.ToString("HH:mm")));

                    }

                    notExistRU.Visible = false;
                }
                else
                {
                    ExistRU.Visible = false;
                    notExistRU.Visible = true;
                }
            }
        }
        protected void find_Click(object sender, EventArgs e)
        {
            find1();
        }

        protected void delete_Click(object sender, EventArgs e)
        {
            if (dateDropdown.SelectedItem.Text != "Date & Time")
            {
                string removeString = " at ";
                string dateTime = dateDropdown.SelectedItem.Text.Replace(removeString, " ");
                DateTime fulldate = DateTime.Parse(dateTime);
                string date = fulldate.ToString("MMMM dd, yyyy");
                string time = fulldate.ToString("HH:mm");
                SqlCommand delDateP = new SqlCommand("DELETE FROM hasAppointment WHERE appointmentDate = @date and appointmentTime = @time and pid=@pid", con);
                delDateP.Parameters.Add("@date", SqlDbType.Date);
                delDateP.Parameters["@date"].Value = date;
                delDateP.Parameters.Add("@time", SqlDbType.Time);
                delDateP.Parameters["@time"].Value = time;
                delDateP.Parameters.Add("@pid", SqlDbType.Int);
                delDateP.Parameters["@pid"].Value = IDentry.Text;

                SqlCommand delDateD = new SqlCommand("DELETE FROM hasAppointment WHERE appointmentDate = @date and appointmentTime = @time and did=@did", con);
                delDateD.Parameters.Add("@date", SqlDbType.Date);
                delDateD.Parameters["@date"].Value = date;
                delDateD.Parameters.Add("@time", SqlDbType.Time);
                delDateD.Parameters["@time"].Value = time;
                delDateD.Parameters.Add("@did", SqlDbType.Int);
                delDateD.Parameters["@did"].Value = IDentry.Text;
                if (radioList.SelectedItem.Value == "did")
                {
                    delDateD.ExecuteNonQuery();
                }
                else
                {
                    delDateP.ExecuteNonQuery();
                }
                ExistRU.Visible = true;
                notExistRU.Visible = false;
                invDate.Visible = false;
                find1();
            }
            else
            {
                invDate.Visible = true;
                ExistRU.Visible = false;
                notExistRU.Visible = false;
            }
        }


        protected void updateRemove_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (updateRemove.SelectedItem.Value == "Remove")
            {
                dPicker.Visible = false;
                tPicker.Visible = false;
                update.Visible = false;
                delete.Visible = true;
            }
            else
            {
                dPicker.Visible = true;
                tPicker.Visible = true;
                update.Visible = true;
                delete.Visible = false;
            }
        }

        protected void update_Click(object sender, EventArgs e)
        {
            string date = dPicker.Text;
            DateTime time = DateTime.Parse(tPicker.Text);
            string t = time.ToString("HH:mm");
            SqlCommand updateP = new SqlCommand("UPDATE hasAppointment SET appointmentDate = @date, appointmentTime = @time WHERE pid=@pid", con);
            SqlCommand updateD = new SqlCommand("UPDATE hasAppointment SET appointmentDate = @date, appointmentTime = @time WHERE did=@did", con);
            updateP.Parameters.Add("@date", SqlDbType.Date);
            updateP.Parameters["@date"].Value = date;
            updateP.Parameters.Add("@time", SqlDbType.Time);
            updateP.Parameters["@time"].Value = t;
            updateP.Parameters.Add("@pid", SqlDbType.Int);
            updateP.Parameters["@pid"].Value = IDentry.Text;

            updateD.Parameters.Add("@date", SqlDbType.Date);
            updateD.Parameters["@date"].Value = date;
            updateD.Parameters.Add("@time", SqlDbType.Time);
            updateD.Parameters["@time"].Value = t;
            updateD.Parameters.Add("@did", SqlDbType.Int);
            updateD.Parameters["@did"].Value = IDentry.Text;

          if (radioList.SelectedItem.Value == "did")
            {
                updateD.ExecuteNonQuery();
            }
          else
            {
                updateP.ExecuteNonQuery();
            }
            ExistRU.Visible = true;
            notExistRU.Visible = false;
            invDate.Visible = false;
            find1();
        }
    }
    }