<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signupform.aspx.cs" Inherits="WebApplication1.signupform" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <link rel="stylesheet" href="login.css" >
     <link rel="icon" href="logo.png" type="image/gif" sizes="16x16">
     <title>Hospital Management System | Login Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <img src="background.png" alt="logo" id="backgroundimg">
    <div class="login-box">

    <img src="logo.png" alt="Logo" class="avatar">
    <h1>Sign Up Here</h1>
    <form action="#">
        <p>ID</p>
        <%--<input type="text" required name="username" placeholder="Enter userID here">--%>
        <asp:TextBox ID="userID" runat="server" required name="userID" placeholder="Enter userID here" OnTextChanged="userID_TextChanged"> </asp:TextBox>
        <p>Enter Username</p>
        <asp:TextBox ID="username" runat="server" required name="username" placeholder="Enter username here" OnTextChanged="username_TextChanged"></asp:TextBox>
        <p>Create Password</p>
        <%--<input type="password" name="password" required placeholder="Enter Password here">--%>
        <asp:TextBox ID="password" runat="server" type="password" name="password" required placeholder="Enter Password here" OnTextChanged="password_TextChanged"></asp:TextBox>
        <p>Re-enter Password</p>
        <%--<input type="password" name="password" required placeholder="Enter Password again">--%>
        <asp:TextBox ID="password2" runat="server" type="password" name="password" required placeholder="Enter Password again" OnTextChanged="password2_TextChanged"></asp:TextBox>
        <%--<input type="submit" name="submit" value="Sign up">--%>
        <asp:Button ID="Button1" runat="server" type="submit" name="submit" value="Sign up" Text="Sign up" OnClick="Button1_Click"/>
        <asp:Label ID="lblErrorMessage1" runat="server" Text="Label" ForeColor="Red" class="linking">For Patient userId must begin with 1</asp:Label>
        <br />
        <asp:Label ID="lblErrorMessage2" runat="server" Text="Label" ForeColor="Red" class="linking">Passwords don't match</asp:Label>
        <a href="loginform.aspx" class="linking">Already have an account?</a>
        <br />
        <a href="loginform.aspx" class="linking">Login Page</a>
        <asp:Label ID="primaryKeyError" runat="server" Text="Label" ForeColor="Red"></asp:Label>
    </form>
    </div>
    </form>
</body>
</html>
