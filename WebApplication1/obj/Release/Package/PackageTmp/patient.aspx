<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="patient.aspx.cs" Inherits="EasyHealthcare.patient" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="style.css" rel="stylesheet" />
    <script src="sidebar.js"></script>
    <title></title>
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
    <form id="form1" runat="server">
        <div style="float:right; width:50%;">
            <fieldset>
                <legend>List of Doctors</legend>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="dId" DataSourceID="SqlDataSource2" ShowHeader="False" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows">
                    <Columns>
                        <asp:BoundField DataField="dId" HeaderText="dId" ReadOnly="True" SortExpression="dId" />
                        <asp:BoundField DataField="dFirstname" HeaderText="dFirstname" SortExpression="dFirstname" />
                        <asp:BoundField DataField="dLastname" HeaderText="dLastname" SortExpression="dLastname" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=localhost;Initial Catalog=HospitalManagement;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [dId], [dFirstname], [dLastname] FROM [doctor] ORDER BY [dId], [dFirstname], [dLastname]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
            </fieldset>
        </div>
        <div style="float:left; width:50%;">
            <div >
            <fieldset>
                <legend>Patient Information</legend>
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
            </fieldset>
            <fieldset>
                <legend>Appointments</legend>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" ShowHeader="False" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows">
                    <Columns>
                        <asp:BoundField DataField="appointmentDate" HeaderText="appointmentDate" DataFormatString="{0:MMMM dd, yyyy}" SortExpression="appointmentDate" />
                        <asp:BoundField DataField="appointmentTime" HeaderText="appointmentTime" SortExpression="appointmentTime" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="Data Source=localhost;Initial Catalog=HospitalManagement;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT appointmentDate, appointmentTime FROM hasAppointment WHERE pid = @pid">
                    <SelectParameters>
                        <asp:SessionParameter Name="pid" SessionField="userid" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </fieldset>
            <fieldset>
                <legend>Reserve Appointment</legend>
                <asp:TextBox ID="datePicker" runat="server" TextMode="Date"></asp:TextBox>
                <asp:TextBox ID="timePicker" runat="server" TextMode="Time"></asp:TextBox>&nbsp;<asp:TextBox ID="did" runat="server" TextMode="Number"></asp:TextBox>
                <asp:Button ID="reserve" runat="server" Text="Reserve" OnClick="reserve_Click" /><br />
                <asp:Label ID="existDate" runat="server" Text="You already have an appointment at this time." Font-Bold="True" ForeColor="Red" Visible="False"></asp:Label>
                <asp:Label ID="success" runat="server" Text="Reserve Successful" Font-Bold="True" ForeColor="Green" Visible="False"></asp:Label>
                <asp:Label ID="docUn" runat="server" Font-Bold="True" ForeColor="Red" Text="Sorry, the doctor you requested is unavailable at this time." Visible="False"></asp:Label>
            </fieldset>
            </div>
        <div>
            <fieldset>
                <legend>View Medical Note</legend>
                <asp:Table ID="noteView" runat="server"></asp:Table>
            </fieldset>
        </div>
        </div>
    </form>
</body>
</html>

