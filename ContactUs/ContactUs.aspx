﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ContactUs.aspx.cs" Inherits="ContactUs_ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <style>
       .autostyle1 {
           margin-top: 5px;
           margin-left: 5px;
           margin-bottom: 5px;
       }
       .auto-style1 {
           text-align: center;
           margin-left: 40px;
       }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid">  
         <div class="row">
<!--left section--> <section class="col-lg-6  col-md-6 col-sm-6 col-xs-12 col-xs-offset-0">
                             <h2 class="text-center heading">Contact Us</h2>                        
                                  <div class="text-center">
                                     <label> Name:  </label>&nbsp;
                                     <asp:TextBox ID="txtName" runat="server" placeholder="name" CssClass="txtboxWidth"></asp:TextBox><br/>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="*Please include your name." Display="Dynamic" Font-Italic="True" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                  </div>
                                  <div class="text-center">
                                     <label> Email: </label>
                                     <asp:TextBox ID="txtEmail" runat="server" placeholder="email address" CssClass="txtboxWidth"></asp:TextBox><br/>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail" ErrorMessage="*Email is a required field." Display="Dynamic" Font-Italic="True" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="*Please enter a valid email address" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                  </div>
                                  <div class="text-center">
                                     <label class="txtboxWidth">What is your question/comment regarding? </label>

                                  </div>
                                  <div class="auto-style1">
                                      <asp:DropDownList ID="DropDownList1" runat="server" CssClass="txtboxWidth autostyle1">
                                         <asp:ListItem>General Comment</asp:ListItem>
                                         <asp:ListItem>Issue with Order</asp:ListItem>
                                         <asp:ListItem>Custom Cakes</asp:ListItem>
                                         <asp:ListItem>Cancel/Postpone order</asp:ListItem>
                                         <asp:ListItem>Products offered</asp:ListItem>
                                      </asp:DropDownList>
                                      <br />
                                  </div> 
                                  <div class="text-center">
                                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                     <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Rows="5" CssClass="txtboxWidth" placeholder="Write your comments here"></asp:TextBox>  <br/>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtComments" ErrorMessage="*Do you really want to submit a blank comment? " SetFocusOnError="True"></asp:RequiredFieldValidator>
                                  </div>
                                  <div class="text-center">
                                      <asp:Button ID="btnSubmitComment" runat="server" Text="Submit Comments" cssClass="checkOutRed" OnClick="btnSubmitComment_Click"/>
                                  </div>
                    </section>
<!--right section--><section class="col-lg-5 col-md-5 col-sm-6 col-xs-12 col-xs-offset-0">
                        <h2 class="text-center heading">Upcoming Events</h2>
                                 <asp:Calendar ID="Calendar1" runat="server" BackColor="White" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" CssClass="calendarSize" Height="300px" Width="100%" BorderColor="White" BorderStyle="None">
                                       <DayHeaderStyle BackColor="#F1BC75" ForeColor="White" Height="1px" />
                                       <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                                       <OtherMonthDayStyle ForeColor="#999999" />
                                       <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                       <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                       <TitleStyle BackColor="white" Font-Bold="True" Font-Size="10pt" ForeColor="#D16956" Height="25px" BorderStyle="None" />
                                       <TodayDayStyle BackColor="#F1BC75" ForeColor="White" />
                                       <WeekendDayStyle BackColor="#6FA398" ForeColor="#F2F2F2" HorizontalAlign="Center" />
                                </asp:Calendar>                
                    </section>
        </div>
    </div>
</asp:Content>

