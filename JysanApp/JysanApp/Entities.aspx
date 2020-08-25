<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Entities.aspx.cs" Inherits="JysanApp.Entities" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 45px;
            height: 26px;
        }
        .auto-style2 {
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HiddenField ID="hfEntityID" runat="server" />
            <table>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="BIN:"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtBin" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Name:"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="Created/Updated By"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtCreatedBy" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td colspan="2">
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td colspan="2">
                        <asp:Label ID="lblSuccessMessage" runat="server" Text="" ForeColor="Green"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td colspan="2">
                        <asp:Label ID="lblErrorMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="gvEntity" runat="server" AutoGenerateColumns ="false">
                <Columns>
                    <asp:BoundField DataField="EntityID" HeaderText="ID" />
                    <asp:BoundField DataField="CreatedAt" HeaderText="Created at" />
                    <asp:BoundField DataField="CreatedBy" HeaderText="Created by" />
                    <asp:BoundField DataField="ChangedAt" HeaderText="Changet at" />
                    <asp:BoundField DataField="ChangedBy" HeaderText="Changed By" />
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkView" runat="server" CommandArgument='<%# Eval("EntityID") %>' OnClick="lnk_OnClick">View</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkView2" runat="server" CommandArgument='<%# Eval("EntityID") %>' OnClick="contacts_OnClick">List of Contacts</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <table>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label3" runat="server" Text="Contacts of Entity with id"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:Label ID="outputEntity" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <asp:GridView ID="gvContacts" runat="server" AutoGenerateColumns ="false">
                    <Columns>
                        <asp:BoundField DataField="FirstName" HeaderText="First name" />
                        <asp:BoundField DataField="LastName" HeaderText="Last name" />
                        <asp:BoundField DataField="EntityID" HeaderText="Entity ID" />
                    </Columns>
                </asp:GridView>
            </table>
        </div>
        
    </form>
</body>
</html>
