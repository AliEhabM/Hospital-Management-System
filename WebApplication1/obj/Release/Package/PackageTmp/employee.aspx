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
        <a class="sidebarLink" href="index.html#hero">Home</a><br />
        <a class="sidebarLink" href="index.html#about">About Us</a><br />
        <a class="sidebarLink" href="index.html#footer">Contact Us</a><br />
        <a class="sidebarLink" href="loginform.aspx">Log Out</a><br />
    </div>
    <div id="sidebarOpener"><button class="sidebarBtn" onclick="sidebarCtrl()">☰</button></div>
    <div>
        <img class="grayscale" src="hospital.png" />
    </div>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div>
        <br /><br />
        <fieldset style="width:25%; float: left; position: relative; left: 25%; text-align: center; height:15vh">
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
                 <asp:Label ID="disSuccess" runat="server" Text="Patient Discharged" Font-Bold="True" ForeColor="Green" Visible="False"></asp:Label>
                 <asp:Label ID="disFail" runat="server" Text="Patient does not exist!" Font-Bold="True" ForeColor="Red" Visible="False"></asp:Label>
             </div>
            </fieldset>
        <fieldset style="width:25%; float: left; position: relative; left: 25%; text-align:center; height:15vh">
            <legend>Remove/Update Appointment</legend>
            
            <asp:RadioButtonList ID="radioList" runat="server" RepeatDirection="Horizontal" align="center">
                <asp:ListItem Selected="True" Value="did">Doctor ID</asp:ListItem>
                <asp:ListItem Value="pid">Patient ID</asp:ListItem>
            </asp:RadioButtonList>
            <asp:TextBox ID="IDentry" runat="server" TextMode="Number"></asp:TextBox>
            <asp:Button ID="find" runat="server" Text="View Appointments" OnClick="find_Click" />
            <br />
            
<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:HospitalManagementConnectionString %>" SelectCommand="SELECT * FROM [hasAppointment] WHERE ([pid] = @pid)" DeleteCommand="DELETE FROM [hasAppointment] WHERE [pid] = @pid AND [did] = @did AND [appointmentDate] = @appointmentDate AND [appointmentTime] = @appointmentTime" InsertCommand="INSERT INTO [hasAppointment] ([pid], [did], [appointmentDate], [appointmentTime]) VALUES (@pid, @did, @appointmentDate, @appointmentTime)" UpdateCommand="IF NOT EXISTS(SELECT * FROM hasAppointment WHERE appointmentDate = @newdate and appointmentTime = @newtime and pid = @pid)
Begin
UPDATE hasAppointment SET appointmentDate = @newdate, appointmentTime = @newtime WHERE pid = @pid and appointmentDate = @appointmentDate and appointmentTime = @appointmentTime
end">
                <DeleteParameters>
                    <asp:Parameter Name="pid" Type="Int32" />
                    <asp:Parameter Name="did" Type="Int32" />
                    <asp:Parameter Name="appointmentDate" DbType="Date" />
                    <asp:Parameter DbType="Time" Name="appointmentTime" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="pid" Type="Int32" />
                    <asp:Parameter Name="did" Type="Int32" />
                    <asp:Parameter DbType="Date" Name="appointmentDate" />
                    <asp:Parameter DbType="Time" Name="appointmentTime" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="IDentry" Name="pid" PropertyName="Text" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="dateUpdate" Name="newdate" PropertyName="Text" DefaultValue="2023-01-01"/>
                    <asp:ControlParameter ControlID="timeUpdate" Name="newtime" PropertyName="Text" DefaultValue="09:00"/>
                    <asp:Parameter Name="pid" />
                    <asp:Parameter DbType="Date" Name="appointmentDate" />
                    <asp:Parameter DbType="Time" Name="appointmentTime" />
                </UpdateParameters>
            </asp:SqlDataSource>



            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HospitalManagementConnectionString %>" SelectCommand="SELECT * FROM [hasAppointment] WHERE did = @did" DeleteCommand="DELETE FROM [hasAppointment] WHERE [pid] = @pid AND [did] = @did AND [appointmentDate] = @appointmentDate AND [appointmentTime] = @appointmentTime" UpdateCommand="IF NOT EXISTS(SELECT * FROM hasAppointment WHERE appointmentDate = @newdate and appointmentTime = @newtime and did = @did)
Begin
UPDATE hasAppointment SET appointmentDate = @newdate, appointmentTime = @newtime WHERE did = @did and appointmentDate = @appointmentDate and appointmentTime = @appointmentTime
end">
                <DeleteParameters>
                    <asp:Parameter Name="pid" Type="Int32" />
                    <asp:Parameter Name="did" Type="Int32" />
                    <asp:Parameter Name="appointmentDate" DbType="Date" />
                    <asp:Parameter DbType="Time" Name="appointmentTime" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="IDentry" Name="did" PropertyName="Text" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="dateUpdate" Name="newdate" PropertyName="Text" DbType="Date" DefaultValue="2023-01-01"/>
                    <asp:ControlParameter ControlID="timeUpdate" Name="newtime" PropertyName="Text" DbType="Time" DefaultValue="09:00"/>
                    <asp:Parameter Name="did" />
                    <asp:Parameter DbType="Date" Name="appointmentDate" />
                    <asp:Parameter DbType="Time" Name="appointmentTime" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="update" runat="server" Text="Update Input "></asp:Label>
            <asp:TextBox ID="dateUpdate" runat="server" TextMode="Date"></asp:TextBox>
            <asp:TextBox ID="timeUpdate" runat="server" TextMode="Time"></asp:TextBox>
        </fieldset>
            <asp:GridView ID="didView" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ShowHeader="True" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" DataKeyNames="pid,did,appointmentDate,appointmentTime" BorderStyle="Solid" Width="50%" HorizontalAlign="Center" OnSelectedIndexChanged="didView_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="pid" HeaderText="Patient ID" SortExpression="pid" ReadOnly="True" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="did" HeaderText="did" SortExpression="did" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="appointmentDate" HeaderText="Date" ReadOnly="True" SortExpression="appointmentDate" DataFormatString="{0:MMMM dd, yyyy}" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="appointmentTime" HeaderText="Time" ReadOnly="True" SortExpression="appointmentTime" DataFormatString="{0:hh\:mm}" ItemStyle-HorizontalAlign="Center" />
                </Columns>

<HeaderStyle CssClass="header"></HeaderStyle>

<RowStyle CssClass="rows"></RowStyle>
            </asp:GridView>
            <asp:GridView ID="pidView" runat="server" ShowHeader="True" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" Visible="False" DataKeyNames="pid,did,appointmentDate,appointmentTime" BorderStyle="Solid" Width="50%" HorizontalAlign="Center" OnSelectedIndexChanged="pidView_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="pid" HeaderText="pid" SortExpression="pid" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="did" HeaderText="Doctor ID" SortExpression="did" ReadOnly="True" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="appointmentDate" HeaderText="Date" ReadOnly="True" SortExpression="appointmentDate" DataFormatString="{0:MMMM dd, yyyy}" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="appointmentTime" HeaderText="Time" ReadOnly="True" SortExpression="appointmentTime" DataFormatString="{0:hh\:mm}" ItemStyle-HorizontalAlign="Center"/>
                </Columns>
                <HeaderStyle CssClass="header" />
                <RowStyle CssClass="rows" />
            </asp:GridView>



        </div>

 </form>
    <script src="sidebar.js"></script>
</body>
</html>
