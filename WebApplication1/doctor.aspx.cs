using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Runtime.InteropServices;

namespace EasyHealthcare
{
    public partial class doctor : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=localhost;Initial Catalog=HospitalManagement;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            con.Open();
            TableRow r = new TableRow();
            TableCell C = new TableCell();
            C.Controls.Add(new LiteralControl("ID"));
            r.Controls.Add(C);
            TableCell c = new TableCell();
            c.Controls.Add(new LiteralControl("Name"));
            r.Controls.Add(c);
            patients.Rows.Add(r);
            string user = Session["userid"].ToString();
            SqlCommand patient = new SqlCommand("SELECT COUNT(DISTINCT pid) FROM hasAppointment WHERE did = '" + user + "'", con);
            int allPat = (int)patient.ExecuteScalar();
            SqlCommand patientID = new SqlCommand("SELECT a.pid FROM (SELECT DISTINCT patient.pid, patient.pFirstname, patient.pLastname FROM patient, hasAppointment WHERE hasAppointment.did = @user) as a  ORDER BY a.pid OFFSET @Offset rows FETCH next 1 rows only", con);
            SqlCommand patientFN = new SqlCommand("SELECT a.pFirstName FROM (SELECT DISTINCT patient.pid, patient.pFirstName, patient.pLastName FROM patient, hasAppointment WHERE hasAppointment.did = @user) as a  ORDER BY a.pid OFFSET @Offset rows FETCH next 1 rows only", con);
            SqlCommand patientLN = new SqlCommand("SELECT a.pLastName FROM (SELECT DISTINCT patient.pid, patient.pFirstName, patient.pLastName FROM patient, hasAppointment WHERE hasAppointment.did = @user) as a  ORDER BY a.pid OFFSET @Offset rows FETCH next 1 rows only", con);
            patientID.Parameters.Add("@user", SqlDbType.Int);
            patientFN.Parameters.Add("@user", SqlDbType.Int);
            patientLN.Parameters.Add("@user", SqlDbType.Int);
            patientID.Parameters["@user"].Value = user;
            patientFN.Parameters["@user"].Value = user;
            patientLN.Parameters["@user"].Value = user;
            patientID.Parameters.Add("@Offset", SqlDbType.Int);
            patientFN.Parameters.Add("@Offset", SqlDbType.Int);
            patientLN.Parameters.Add("@Offset", SqlDbType.Int);
            for (int i = 0; i < allPat; i++)
            {
                patientID.Parameters["@Offset"].Value = i;
                patientFN.Parameters["@Offset"].Value = i;
                patientLN.Parameters["@Offset"].Value = i;
                string id = patientID.ExecuteScalar().ToString();
                string first = patientFN.ExecuteScalar().ToString();
                string last = patientLN.ExecuteScalar().ToString();
                r = new TableRow();
                TableCell c1 = new TableCell();
                c1.Controls.Add(new LiteralControl(id));
                r.Cells.Add(c1);
                TableCell c2 = new TableCell();
                c2.Controls.Add(new LiteralControl(first + ' ' + last));
                r.Cells.Add(c2);
                patients.Rows.Add(r);
            }
        }

        protected void uploadNote_Click(object sender, EventArgs e)
        {
            string command = "INSERT INTO attachNote(pid, did, medical_note) values(@pID, @dID, @note)";
            string user = Session["userid"].ToString();
            SqlCommand check_PID = new SqlCommand("SELECT COUNT(*) FROM patient WHERE pid='" + pID.Text + "'", con);
            int userExist = (int)check_PID.ExecuteScalar();

            if (userExist != 0)
            {
                SqlCommand cmd = new SqlCommand(command, con);
                cmd.Parameters.Add("@pID", SqlDbType.Int);
                cmd.Parameters["@pID"].Value = pID.Text;
                cmd.Parameters.Add("@dID", SqlDbType.Int);
                cmd.Parameters["@dID"].Value = user;
                cmd.Parameters.Add("@note", SqlDbType.NVarChar);
                cmd.Parameters["@note"].Value = note.Text;
                cmd.ExecuteNonQuery();
                con.Close();
                Label1.Visible = true;
                Label2.Visible = false;
                pID.Text = "";
                note.Text = "";
            }
            else
            {
                Label2.Visible = true;
                Label1.Visible = false;
            }
        }

        protected void View_Click(object sender, EventArgs e)
        {
            string user = Session["userid"].ToString();
            SqlCommand check_PID = new SqlCommand("SELECT COUNT(*) FROM patient WHERE pid='" + pID.Text + "'", con);
            int userExist = (int)check_PID.ExecuteScalar();

            if (userExist != 0)
            {
                // PATIENT INFORMATION
                Label2.Visible = false;
                string getId = "SELECT pid FROM PATIENT WHERE pid='" + pID.Text + "'";
                string getFName = "SELECT pFirstname FROM PATIENT WHERE pid='" + pID.Text + "'";
                string getLName = "SELECT pLastname FROM PATIENT WHERE  pid='" + pID.Text + "'";
                string getAddress = "SELECT pAddress FROM PATIENT WHERE pid='" + pID.Text + "'";
                string getPhone = "SELECT pPhone FROM PATIENT WHERE pid='" + pID.Text + "'";
                SqlCommand cmd1 = new SqlCommand(getId, con);
                SqlCommand cmd2 = new SqlCommand(getFName, con);
                SqlCommand cmd3 = new SqlCommand(getLName, con);
                SqlCommand cmd4 = new SqlCommand(getAddress, con);
                SqlCommand cmd5 = new SqlCommand(getPhone, con);
                pIDlabel.Text = cmd1.ExecuteScalar().ToString();
                firstName.Text = cmd2.ExecuteScalar().ToString();
                lastName.Text = cmd3.ExecuteScalar().ToString();
                address.Text = cmd4.ExecuteScalar().ToString();
                phone.Text = cmd5.ExecuteScalar().ToString();

                appointments.Rows.Clear();
                //APPOINTMENTS TABLE
                SqlCommand appDates = new SqlCommand("SELECT COUNT(*) FROM hasAppointment WHERE pid= @pid and did = '" +user+ "'", con);
                appDates.Parameters.Add("@pid", SqlDbType.Int);
                appDates.Parameters["@pid"].Value = pID.Text;
                int rows = (int)appDates.ExecuteScalar();

                for (int i = 0; i < rows; i++)
                {

                    SqlCommand getDate = new SqlCommand("SELECT DISTINCT appointmentDate FROM hasAppointment ORDER BY appointmentDate OFFSET @Offset rows fetch next 1 rows only", con);
                    getDate.Parameters.Add("@Offset", SqlDbType.Int);
                    getDate.Parameters["@Offset"].Value = i;
                    DateTime date = DateTime.Parse(getDate.ExecuteScalar().ToString());
                    SqlCommand appTimes = new SqlCommand("SELECT COUNT(*) FROM hasAppointment WHERE appointmentDate = @date and pid = '" +pID.Text+ "' and did = '" +user+"'", con);
                    appTimes.Parameters.Add("@date", SqlDbType.Date);
                    appTimes.Parameters["@date"].Value = date;
                    int count = (int)appTimes.ExecuteScalar();
                    for (int j = 0; j < count; j++)
                    {

                        SqlCommand getTime = new SqlCommand("select appointmentTime from hasAppointment where appointmentDate = @date and pid = '" +pID.Text+ "' and did = '" +user+"' order by appointmentTime offset @Offset2 rows fetch next 1 rows only", con);
                        getTime.Parameters.Add("@Offset2", SqlDbType.Int);
                        getTime.Parameters.Add("@date", SqlDbType.Date);
                        getTime.Parameters["@date"].Value = date;
                        TableRow r = new TableRow();
                        getTime.Parameters["@Offset2"].Value = j;
                        DateTime time = DateTime.Parse(getTime.ExecuteScalar().ToString());
                        TableCell c = new TableCell();
                        c.Controls.Add(new LiteralControl(date.ToString("MMMM dd, yyyy") + " at " + time.ToString("HH:mm")));
                        r.Cells.Add(c);
                        appointments.Rows.Add(r);
                    }
                }
            }
            else
            {
                Label2.Visible = true;
            }
        }
    }
}