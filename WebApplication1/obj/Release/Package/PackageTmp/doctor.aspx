<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="doctor.aspx.cs" Inherits="EasyHealthcare.doctor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

    <link href="style.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <title>Doctor Page</title>
    <style type="text/css">
        .auto-style1 {
            width: 170px;
        }
    </style>
</head>
<body>
    <div id="sidebar" style="display:none">
        <a class="sidebarLink" href="home.html">Home</a><br />
        <a class="sidebarLink" href="about.html">About Us</a><br />
        <a class="sidebarLink" href="contact.html">Contact Us</a><br />
        <a class="sidebarLink" href="loginform.aspx">Log Out</a><br />
    </div>
    <div id="sidebarOpener"><button class="sidebarBtn" onclick="sidebarCtrl()">☰</button></div>
    <div>
        <img class="grayscale" src="hospital.png" />
    </div>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div>
            <fieldset>
                <legend>Patients</legend>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="pid" DataSourceID="SqlDataSource1" ShowHeader="False" CssClass="mydatagrid" PagerStyle-CssClass="pager" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" AllowPaging="True">
                    <Columns>
                        <asp:BoundField DataField="pid" HeaderText="pid" ReadOnly="True" SortExpression="pid" />
                        <asp:BoundField DataField="pFirstname" HeaderText="pFirstname" SortExpression="pFirstname" />
                        <asp:BoundField DataField="pLastname" HeaderText="pLastname" SortExpression="pLastname" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=localhost;Initial Catalog=HospitalManagement;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT a.pid, a.pFirstname, a.pLastname FROM patient as a, hasAppointment WHERE hasAppointment.did = @userid">
                    <SelectParameters>
                        <asp:SessionParameter Name="userid" SessionField="userid" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </fieldset>
        </div>
        <div style="text-align: center;">
            <br />
            <span>Patient ID <br />
            <asp:TextBox ID="pID" runat="server" Width="172px" TextMode="Number"></asp:TextBox>
                        <asp:Button ID="View" runat="server" Text="View Information" OnClick="View_Click" BorderStyle="Groove" />
            <br />
                 <asp:Label ID="Label2" runat="server" Text="Patient does not exist!" Font-Bold="True" ForeColor="Red" Visible="False"></asp:Label>
            </span>
        </div>
        <div>
        <fieldset style="width: 25%; float:left; position: relative; left: 6em">
            <legend>Patient Information</legend>
                <div>
                    <table>
                        <tr>
                            <td>ID: </td>
                            <td class="auto-style1">
                                <asp:Label ID="pIDlabel" runat="server" Text=" "></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>First Name: </td>
                            <td class="auto-style1">
                                <asp:Label ID="firstName" runat="server" Text=" "></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Last Name: </td>
                            <td class="auto-style1">
                                <asp:Label ID="lastName" runat="server" Text=" "></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Phone Number: </td>
                            <td class="auto-style1">
                                <asp:Label ID="phone" runat="server" Text=" "></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Address: </td>
                            <td class="auto-style1">
                                <asp:Label ID="address" runat="server" Text=" "></asp:Label>
                            </td>
                        </tr>
                    </table>
                    
                </div>
        </fieldset>
        <fieldset style="height: 265px; width: 25%; float:left; position:relative; left:6em">
            <legend>Add Medical Note</legend><div>
                    <div style="text-align:center;">
                        <span>Medical Note</span><br />
                        <span>
                        <asp:TextBox ID="note" runat="server" TextMode="MultiLine" Height="166px" Width="250px" MaxLength="150"></asp:TextBox>
                        </span><br />
                        <span>
                        <asp:Button ID="uploadNote" runat="server" Text="Add" OnClick="uploadNote_Click" BorderStyle="Double" />
                        <br />
                        </span>
                 <asp:Label ID="Label1" runat="server" Text="Report Uploaded Successfully!" Font-Bold="True" ForeColor="Green" Visible="False"></asp:Label>
                    </div></div>
            </fieldset>
            <fieldset style="width: 23%; float:left; position:relative; left: 6em">
                <legend>Appointments</legend>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" ShowHeader="False" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows">
                    <Columns>
                        <asp:BoundField DataField="appointmentDate" HeaderText="appointmentDate" DataFormatString="{0:MMMM dd, yyyy}" SortExpression="appointmentDate" />
                        <asp:BoundField DataField="appointmentTime" HeaderText="appointmentTime" SortExpression="appointmentTime" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=localhost;Initial Catalog=HospitalManagement;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT appointmentDate, appointmentTime FROM hasAppointment WHERE pid = @pid">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="pID" Name="pid" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </fieldset>
        </div>

 </form>
    <script src="sidebar.js"></script>
</body>
</html>
