<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="loginform.aspx.cs" Inherits="WebApplication1.loginform" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <link rel="stylesheet" href="login.css" >
     <link rel="icon" href="logo.png" type="image/gif" sizes="16x16">
     <meta charset="UTF-8">
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <title>Hospital Management System | Login Page</title>
</head>
<body>
    <img src="background.png" alt="logo" id="backgroundimg">
    <div class="login-box">
    <img src="logo.png" alt="Logo" class="avatar">
        <h1>Login Here</h1>
    <form id="form1" runat="server">
    <asp:RadioButton ID="patientRadio" GroupName="choice" runat="server" TextAlign="Left" name="choice" Text="Patient" OnCheckedChanged="patientRadio_CheckedChanged" Checked="True" />
    <asp:RadioButton ID="doctorRadio" GroupName="choice" runat="server" textAlign="Left" name="choice" Text="Doctor" OnCheckedChanged="doctorRadio_CheckedChanged"/>
    <asp:RadioButton ID="empRadio" GroupName="choice" runat="server" textAlign="Left" name="choice" Text="Employee" OnCheckedChanged="empRadio_CheckedChanged"/>
        <p>ID</p>
        <asp:TextBox ID="TextBox1" runat="server" required name="username" placeholder="Enter userID here" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
        <p>Password</p>
        <asp:TextBox ID="TextBox2" runat="server" type="password" name="password" required placeholder="Enter Password here" OnTextChanged="TextBox2_TextChanged" ></asp:TextBox>        

        <a href="#" class="linking">Forget Password?</a><br>
        <asp:Button ID="loginButton" runat="server" Text="Login" OnClick="login_Click"/>
        <br>
        <asp:LinkButton ID="LinkButton1" runat="server" class="linking" OnClick="LinkButton1_Click">Sign Up</asp:LinkButton>
        <br />
        <asp:Label ID="lblErrorMessage" runat="server" Text="Incorrect User Credentials" ForeColor="Red"></asp:Label>
    </form>
    </div>
</body>
</html>
