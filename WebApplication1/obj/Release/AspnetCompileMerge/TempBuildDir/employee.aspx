<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="employee.aspx.cs" Inherits="EasyHealthcare.employee" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

    <link href="style.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <title>Employee Page</title>
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
        <br /><br />
        <fieldset style="width:25%; float: left; position: relative; left: 25%; text-align: center;">
            <legend>Discharge Patient</legend><div>
                    <div>
                        <span>Patient ID</span>
                        <span>
            <asp:TextBox ID="dispID" runat="server" TextMode="Number"></asp:TextBox></span>
                    </div>
                    <div>
                        <span>
                            <br />
                            <asp:Button ID="discharge" runat="server" Text="Discharge" OnClick="discharge_Click"/></span>
                    </div>
            </div>
             <div style="text-align: center;">
                 <br />
                 <asp:Label ID="disSuccess" runat="server" Text="Patient Discharged" Font-Bold="True" ForeColor="Green" Visible="False"></asp:Label>
                 <asp:Label ID="disFail" runat="server" Text="Patient does not exist!" Font-Bold="True" ForeColor="Red" Visible="False"></asp:Label>
             </div>
            </fieldset>
        <fieldset style="width:25%; float: left; position: relative; left: 25%; text-align:center">
            <legend>Remove/Update Appointment</legend>
            
            <asp:RadioButtonList ID="radioList" runat="server" RepeatDirection="Horizontal" align="center">
                <asp:ListItem Selected="True" Value="did">Doctor ID</asp:ListItem>
                <asp:ListItem Value="pid">Patient ID</asp:ListItem>
            </asp:RadioButtonList>
            <asp:TextBox ID="IDentry" runat="server" TextMode="Number"></asp:TextBox>
            <asp:Button ID="find" runat="server" Text="View Appointments" OnClick="find_Click" />
            <br />
            <asp:DropDownList ID="dateDropdown" runat="server">
                <asp:ListItem Selected="True" hidden="True">Date & Time</asp:ListItem>
            </asp:DropDownList><br />
            <asp:RadioButtonList ID="updateRemove" runat="server" OnSelectedIndexChanged="updateRemove_SelectedIndexChanged" RepeatDirection="Horizontal" AutoPostBack="True" align="center">
                <asp:ListItem Selected="True" Value="Remove">Remove</asp:ListItem>
                <asp:ListItem Value="Update">Update</asp:ListItem>
            </asp:RadioButtonList>
            <asp:Button ID="delete" runat="server" Text="Remove" OnClick="delete_Click" />
            <asp:TextBox ID="dPicker" runat="server" TextMode="Date" Visible="False" Width="81px">DD/MM/YY</asp:TextBox>
            <asp:TextBox ID="tPicker" runat="server" TextMode="Time" Visible="False" Width="53px">HH:mm</asp:TextBox>
            <asp:Button ID="update" runat="server" Text="Update" Visible="False" OnClick="update_Click" />
            <br />
            <asp:Label ID="invDate" runat="server" Font-Bold="True" ForeColor="Red" Text="Invalid Date" Visible="False"></asp:Label>
            <asp:Label ID="notExistRU" runat="server" Text="ID not found" Font-Bold="True" ForeColor="Red" Visible="False"></asp:Label>
            <asp:Label ID="ExistRU" runat="server" Text="Success!" Font-Bold="True" ForeColor="Green" Visible="False"></asp:Label>
        </fieldset>

 </form>
    <script src="sidebar.js"></script>
</body>
</html>

