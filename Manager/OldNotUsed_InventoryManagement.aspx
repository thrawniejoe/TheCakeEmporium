﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="OldNotUsed_InventoryManagement.aspx.cs" Inherits="Manager_InventoryManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 102px;
        }
        .auto-style2 {
            width: 225px;
        }
        .auto-style3 {
            width: 102px;
            height: 20px;
        }
        .auto-style4 {
            width: 225px;
            height: 20px;
        }
        .auto-style5 {
            height: 20px;
        }
        .auto-style9 {
            width: 229px;
        }
        .auto-style10 {
            height: 20px;
            width: 229px;
        }
        </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="productContainer">
    <h1>Inventory Management</h1>
        <p>
            <asp:Button ID="btnBack" runat="server" cssClass="profileButton" OnClick="btnBack_Click" Text="Back" />
        </p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="lblError" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductId" DataSourceID="SqlDataSource1" Width="1000px">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="ProductId" HeaderText="ID" ReadOnly="True" SortExpression="ProductId" >
            <ItemStyle Width="20px" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Name" SortExpression="Name">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" ItemStyle-CssClass="productNameField">
<ItemStyle CssClass="productNameField"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Image" HeaderText="Image" SortExpression="Image" ItemStyle-CssClass="productNameField">
<ItemStyle CssClass="productNameField"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="UnitPrice" HeaderText="Price" SortExpression="UnitPrice" DataFormatString="{0:C}" ItemStyle-CssClass="productNameField">
            <HeaderStyle HorizontalAlign="Center" />
<ItemStyle CssClass="productNameField" HorizontalAlign="Center" Width="100px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="OnHand" HeaderText="On Hand" SortExpression="OnHand" ItemStyle-CssClass="productNameField">
            <HeaderStyle HorizontalAlign="Center" />
<ItemStyle CssClass="productNameField" HorizontalAlign="Center" Width="80px"></ItemStyle>
            </asp:BoundField>
            <asp:CommandField ButtonType="Button" ShowEditButton="True" ControlStyle-CssClass="btn-edit">
<ControlStyle CssClass="btn-edit"></ControlStyle>
            </asp:CommandField>
            <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ControlStyle-CssClass="btn-dataview">
<ControlStyle CssClass="btn-dataview"></ControlStyle>
            </asp:CommandField>
        </Columns>
        <EditRowStyle BorderColor="#7C6F57" />
        <FooterStyle BackColor="#1C5E55" ForeColor="White" />
        <HeaderStyle BackColor="#1C5E55" ForeColor="White" />
        <RowStyle BackColor="#E3EAEB" />
    </asp:GridView>
    <br />
    To add a cake to the inventory, enter the information and click Add Cake<br />
        <table class="nav-justified">
            <tr>
                <td class="auto-style1">ID:</td>
                <td class="auto-style2">
                    <asp:TextBox ID="txtID" runat="server" CssClass="form-control" ValidationGroup="invmgGroup" Width="72px"></asp:TextBox>
                </td>
                <td class="auto-style9">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtID" Display="Dynamic" ErrorMessage="ID is required" Font-Italic="True" ValidationGroup="invmgGroup"></asp:RequiredFieldValidator>
                </td>
                <td>
                    Upload Image: .png files only, 500kb size limit, 250x250</td>
            </tr>
            <tr>
                <td class="auto-style1">Name:</td>
                <td class="auto-style2">
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" ValidationGroup="invmgGroup" Width="200px"></asp:TextBox>
                </td>
                <td class="auto-style9">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtName" Display="Dynamic" ErrorMessage="Name is Required" Font-Italic="True" ValidationGroup="invmgGroup"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Description:</td>
                <td class="auto-style2">
                    <asp:TextBox ID="txtDescript" runat="server" CssClass="form-control" ValidationGroup="invmgGroup" Width="200px"></asp:TextBox>
                </td>
                <td class="auto-style9">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDescript" Display="Dynamic" ErrorMessage="Description is Required" Font-Italic="True" ValidationGroup="invmgGroup"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:Button ID="btnUpload" runat="server" cssClass="profileButton" OnClick="btnUpload_Click" Text="Upload Image" />
                </td>
            </tr>
            <tr>
                <td class="auto-style3">Image File:</td>
                <td class="auto-style4">
                    <asp:TextBox ID="txtImageFile" runat="server" CssClass="form-control" ValidationGroup="invmgGroup" Width="200px"></asp:TextBox>
                </td>
                <td class="auto-style10">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtImageFile" ErrorMessage="The file name is required" Font-Italic="True" ValidationGroup="invmgGroup"></asp:RequiredFieldValidator>
                </td>
                <td class="auto-style5">
                    <asp:Label ID="lblErrorImage" runat="server" Font-Italic="True" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Unit Price:</td>
                <td class="auto-style2">
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" ValidationGroup="invmgGroup" Width="72px"></asp:TextBox>
                </td>
                <td class="auto-style9">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtPrice" ErrorMessage="A price is required" Font-Italic="True" ValidationGroup="invmgGroup"></asp:RequiredFieldValidator>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1">On Hand:</td>
                <td class="auto-style2">
                    <asp:TextBox ID="txtOnHand" runat="server" CssClass="form-control" ValidationGroup="invmgGroup" Width="72px"></asp:TextBox>
                </td>
                <td class="auto-style9">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtOnHand" ErrorMessage="A quantity is required" Font-Italic="True" ValidationGroup="invmgGroup"></asp:RequiredFieldValidator>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <asp:Button ID="btnAddCake" runat="server" cssClass="profileButton" OnClick="btnAddCake_Click" Text="Add Cake" ValidationGroup="invmgGroup" />
                </td>
                <td class="auto-style2">&nbsp;</td>
                <td class="auto-style9">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [Products] WHERE [ProductId] = @ProductId" InsertCommand="INSERT INTO [Products] ([ProductId], [Name], [Description], [Image], [UnitPrice], [OnHand]) VALUES (@ProductId, @Name, @Description, @Image, @UnitPrice, @OnHand)" SelectCommand="SELECT [ProductId], [Name], [Description], [Image], [UnitPrice], [OnHand] FROM [Products]" UpdateCommand="UPDATE [Products] SET [Name] = @Name, [Description] = @Description, [Image] = @Image, [UnitPrice] = @UnitPrice, [OnHand] = @OnHand WHERE [ProductId] = @ProductId">
        <DeleteParameters>
            <asp:Parameter Name="ProductId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ProductId" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Image" Type="String" />
            <asp:Parameter Name="UnitPrice" Type="Decimal" />
            <asp:Parameter Name="OnHand" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Image" Type="String" />
            <asp:Parameter Name="UnitPrice" Type="Decimal" />
            <asp:Parameter Name="OnHand" Type="Int32" />
            <asp:Parameter Name="ProductId" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    </div>

</asp:Content>

