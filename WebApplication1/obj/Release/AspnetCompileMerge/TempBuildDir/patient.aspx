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
        <div>
            <fieldset style=" position: relative;">
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
            <fieldset style=" position: relative;">
                <legend>Appointments</legend>
                <asp:Table ID="appointments" runat="server">
                </asp:Table>
            </fieldset>
            <fieldset style=" position: relative;">
                <legend>Reserve Appointment</legend>
                <asp:TextBox ID="datePicker" runat="server" TextMode="Date"></asp:TextBox>
                <asp:TextBox ID="timePicker" runat="server" TextMode="Time"></asp:TextBox>&nbsp;<asp:TextBox ID="did" runat="server" TextMode="Number" placeholder="Enter Doctor ID here"></asp:TextBox>
                <asp:Button ID="reserve" runat="server" Text="Reserve" OnClick="reserve_Click" /><br />
                <asp:Label ID="existDate" runat="server" Text="You already have an appointment at this time." Font-Bold="True" ForeColor="Red" Visible="False"></asp:Label>
                <asp:Label ID="success" runat="server" Text="Reserve Successful" Font-Bold="True" ForeColor="Green" Visible="False"></asp:Label>
                <asp:Label ID="docUn" runat="server" Font-Bold="True" ForeColor="Red" Text="Sorry, the doctor you requested is unavailable at this time." Visible="False"></asp:Label>
            </fieldset>
            </div>
        <div>
            <fieldset style="position: center;">
                <legend>View Medical Note</legend>
                <asp:Table ID="noteView" runat="server"></asp:Table>
            </fieldset>
        </div>
    </form>
</body>
</html>
