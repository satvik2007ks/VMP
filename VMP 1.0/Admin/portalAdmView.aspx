﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/vmpAdmMaster.Master" AutoEventWireup="true" CodeBehind="portalAdmView.aspx.cs" Inherits="VMP_1._0.Admin.portalAdmView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .grid td, .grid th {
            text-align: center !important;
        }
    </style>
    <script type="text/javascript">
        function openModalConfirmation() {
            //jQuery.noConflict();
            $("#myModal1").modal("show");
        }
        function openModalReject() {
            //jQuery.noConflict();
            $("#myModal2").modal("show");
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: gainsboro; border-radius: 6px;">
        <div class="row" style="margin-top: 20px; margin-bottom: 20px;">
            <div class="col-md-12">
                <div class="col-md-3">
                    <asp:HyperLink ID="hypBack" runat="server" NavigateUrl="vmpAdmHome" Text="Back To Admin Dashboard" CssClass="btn btn-primary"></asp:HyperLink>
                </div>
                <div class="col-md-9">
                    <div class="col-md-3"></div>
                    <div class="col-md-5">
                        <h4>Application Details</h4>
                    </div>
                    <div class="col-md-4"></div>
                </div>
            </div>
        </div>
        <br />
        <%-- <div class="row" style="margin-top: 20px; margin-bottom: 20px;">
            <div class="col-md-3"></div>
            <div class="col-md-9">
                <div class="col-md-3"></div>
                <div class="col-md-5">
                </div>
                <div class="col-md-4"></div>
            </div>
        </div>--%>
        <div class="row">
            <div class="col-md-4" style="margin-left: 5px">
                <h4>
                    <asp:Label ID="lblVendorName" runat="server"></asp:Label></h4>
            </div>
            <div class="col-md-8"></div>
        </div>
        <div class="row" style="margin-top: 20px; margin-bottom: 20px;">
            <div class="col-md-12">
                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingOne">

                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                <h4 class="panel-title">Basic Details </h4>
                            </a>

                        </div>
                        <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Business Name: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblBusName" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Address: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>City: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblCity" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>State: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblState" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Zipcode: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblZipcode" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>County: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblCounty" runat="server"></asp:Label>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Telephone: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblTelephone" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Fax: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblFax" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Email ID: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblEmail" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Web Address: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblWebAddress" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Received Date: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblDate" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="col-md-2">
                                                    <label>Description: </label>
                                                </div>
                                                <div class="col-md-10">
                                                    <asp:Label ID="lblDesc" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingTwo">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                <h4 class="panel-title">Owners </h4>
                            </a>
                        </div>
                        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                            <div class="panel-body">
                                <asp:Repeater ID="rptOwners" runat="server" OnItemDataBound="rptOwners_ItemDataBound">
                                    <HeaderTemplate>
                                        <div class="panel-group" id="accordionOwners">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <a data-toggle="collapse" data-parent="#accordionOwners" href="#collapse<%# Container.ItemIndex %>">
                                                    <h4 class="panel-title"><%# Eval("ownerFirstName")+" "+Eval("ownerLastName") %></h4>
                                                </a>
                                            </div>
                                            <div id="collapse<%# Container.ItemIndex %>" class="panel-collapse collapse">
                                                <div class="panel-body">
                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-10">
                                                            <div class="col-md-12">
                                                                <div class="row">
                                                                    <div class="col-md-6">
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4">
                                                                                <label>First Name:</label>
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <asp:Label ID="lblFName" runat="server" Text='<%# Eval("ownerFirstName") %>'></asp:Label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4">
                                                                                <label>Last Name:</label>
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <asp:Label ID="lblLName" runat="server" Text='<%# Eval("ownerLastName") %>'></asp:Label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4">
                                                                                <label>Address:</label>
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("address") %>'></asp:Label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4">
                                                                                <label>City</label>
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <asp:Label ID="lblCity" runat="server" Text='<%# Eval("city") %>'></asp:Label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4">
                                                                                <label>State:</label>
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <asp:Label ID="lblState" runat="server" Text='<%# Eval("state") %>'></asp:Label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4">
                                                                                <label>Zip Code:</label>
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <asp:Label ID="lblZipCode" runat="server" Text='<%# Eval("zipCode") %>'></asp:Label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4">
                                                                                <label>Phone:</label>
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("phone") %>'></asp:Label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4">
                                                                                <label>Other Phone:</label>
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <asp:Label ID="lblOtherPhone" runat="server" Text='<%# Eval("otherPhone") %>'></asp:Label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4">
                                                                                <label>Current Position:</label>
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <asp:Label ID="lblCurrentPosition" runat="server" Text='<%# Eval("otherPosition") %>'></asp:Label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4">
                                                                                <label>Percent Ownership:</label>
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <asp:Label ID="lblPOwnership" runat="server" Text='<%# Eval("ownershipPercentage") %>'></asp:Label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4">
                                                                                <label>No. of Shares Owned:</label>
                                                                            </div>
                                                                            <divk class="col-md-8">
                                                                                <asp:Label ID="lblSharesOwned" runat="server" Text='<%# Eval("noSharesOwned") %>'></asp:Label>
                                                                            </divk>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px; border-bottom-style: ridge;">
                                                                            <div class="col-md-4">
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <div class="col-md-12">
                                                                                    <asp:CheckBox ID="chkCitizen" runat="server" CssClass="checkbox" Text="Citizen/Permanent Resident" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4" style="margin-top: 10px;">
                                                                                <label>Targeted Group:</label>
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <div class="col-md-12">
                                                                                    <asp:CheckBoxList ID="chkbxTargetGroup" runat="server" CssClass="checkbox">
                                                                                        <asp:ListItem>Asian/Pacific</asp:ListItem>
                                                                                        <asp:ListItem>Black</asp:ListItem>
                                                                                        <asp:ListItem>Hispanic</asp:ListItem>
                                                                                        <asp:ListItem>Indigenous American</asp:ListItem>
                                                                                    </asp:CheckBoxList>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px;" runat="server" id="divIndiginess">
                                                                            <div class="col-md-4">
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <div class="col-md-12">
                                                                                    <asp:CheckBoxList ID="chkIndiginess" runat="server" CssClass="checkbox">
                                                                                        <%-- <asp:ListItem>Aluets/Eskimos</asp:ListItem>
                                                                                                <asp:ListItem>Native Hawaiians</asp:ListItem>--%>
                                                                                        <asp:ListItem>American Indian</asp:ListItem>
                                                                                    </asp:CheckBoxList>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px; display: none;" id="divTribal" runat="server">
                                                                            <div class="col-md-4">
                                                                                <label>Tribal ID:</label>
                                                                            </div>
                                                                            <div class="col-md-7">
                                                                                <asp:Label ID="lblTribalID" runat="server" Text='<%# Eval("tribalID") %>' Style="margin-left: 14px;"></asp:Label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px; border-bottom-style: ridge;">
                                                                            <div class="col-md-4">
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <div class="col-md-12">
                                                                                    <asp:CheckBoxList ID="chkTG1" runat="server" AutoPostBack="true" CssClass="checkbox">
                                                                                        <asp:ListItem>Physical Disability</asp:ListItem>
                                                                                        <asp:ListItem>Woman</asp:ListItem>
                                                                                    </asp:CheckBoxList>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" style="margin-bottom: 5px; border-bottom-style: ridge;">
                                                                            <div class="col-md-4" style="margin-top: 10px;">
                                                                                <label>Veteran:</label>
                                                                            </div>
                                                                            <div class="col-md-8">
                                                                                <div class="col-md-12">
                                                                                    <asp:RadioButtonList ID="radVeteran" runat="server" CssClass="radio">
                                                                                        <asp:ListItem>Veteran</asp:ListItem>
                                                                                        <asp:ListItem>Service Disabled Veteran</asp:ListItem>
                                                                                        <%--<asp:ListItem>None</asp:ListItem>--%>
                                                                                    </asp:RadioButtonList>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <br />
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                        <h5><b>Personal Networth</b></h5>
                                                                    </div>
                                                                    <div class="col-md-12">
                                                                        <div class="col-md-6">
                                                                            <div class="row" style="margin-bottom: 10px;">
                                                                                <div class="col-md-5">
                                                                                    <label>Year</label>
                                                                                </div>
                                                                                <div class="col-md-7">
                                                                                    <asp:Label ID="lblPNWYear" runat="server"></asp:Label>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-md-5">
                                                                                    <label>Total Liabilities</label>
                                                                                </div>
                                                                                <div class="col-md-7">
                                                                                    <asp:Label ID="lblLiabilities" runat="server" Text='<%# Eval("liabilities") %>'></asp:Label>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="row" style="margin-bottom: 10px;">
                                                                                <div class="col-md-5">
                                                                                    <label>Total Current Asset</label>
                                                                                </div>
                                                                                <div class="col-md-7">
                                                                                    <asp:Label ID="lblCAsset" runat="server" Text='<%# Eval("assets") %>'></asp:Label>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-md-5">
                                                                                    <label>Personal Networth</label>
                                                                                </div>
                                                                                <div class="col-md-7">
                                                                                    <asp:Label ID="lblPNetworth" runat="server" Text='<%# Eval("personalNetWorth") %>'></asp:Label>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <br />
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                        <h5><b>Current Responsibilities</b></h5>
                                                                    </div>
                                                                    <div class="col-md-12">
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="chkBusinessPlanning" CssClass="checkbox" runat="server" Text="Business Planning" />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="chkSalesMarketing" CssClass="checkbox" runat="server" Text="Sales & Marketing" />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="chkFinancial" CssClass="checkbox" runat="server" Text="Financial" />
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="chkPersonnel" CssClass="checkbox" runat="server" Text="Personnel" />
                                                                        </div>
                                                                        <%-- <div class="col-md-2">
                                                                        </div>--%>
                                                                    </div>
                                                                    <div class="col-md-12">
                                                                        <div class="col-md-3">
                                                                            <asp:CheckBox ID="chkProjManagement" CssClass="checkbox" runat="server" Text="Project Management" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <br />
                                                            </div>
                                                            <br />
                                                        </div>
                                                        <div class="col-md-1"></div>
                                                    </div>
                                                    <div class="row" id="divSecFirms" runat="server">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-10">
                                                            <div class="col-md-12">
                                                                <h4>Secondary Firms</h4>
                                                            </div>
                                                            <div class="col-md-12">
                                                                <div class="row">
                                                                    <asp:Repeater ID="rptSecFirms" runat="server">
                                                                        <HeaderTemplate>
                                                                            <div class="panel-group" id="accordionSec">
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <div class="panel panel-default">
                                                                                <div class="panel-heading">
                                                                                    <a data-toggle="collapse" data-parent="#accordionSec" href="#collapseSecFirms<%# ((RepeaterItem)Container.Parent.Parent.Parent).ItemIndex %><%# Container.ItemIndex %>">
                                                                                        <h4 class="panel-title"><%# Eval("firmName") %></h4>
                                                                                    </a>
                                                                                    <%-- <a data-toggle="collapse" data-parent="#accordionSec" href="#collapseSecFirms">
                                                                        <h4 class="panel-title"><%# Eval("firmName") %></h4>
                                                                    </a>--%>
                                                                                </div>
                                                                                <div id="collapseSecFirms<%# ((RepeaterItem)Container.Parent.Parent.Parent).ItemIndex %><%# Container.ItemIndex %>" class="panel-collapse collapse">
                                                                                    <%--<div id="collapseSecFirms" class="panel-collapse collapse">--%>
                                                                                    <div class="panel-body">
                                                                                        <div class="row">
                                                                                            <div class="col-md-1"></div>
                                                                                            <div class="col-md-11">
                                                                                                <div class="row">
                                                                                                    <div class="col-md-5">
                                                                                                        <label>Firm:</label>
                                                                                                    </div>
                                                                                                    <div class="col-md-7">
                                                                                                        <asp:Label ID="lblFirm" runat="server" Style="margin-bottom: 10px;" Text='<%# Eval("firmName") %>'></asp:Label>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="row">
                                                                                                    <div class="col-md-5">
                                                                                                        <label>Address:</label>
                                                                                                    </div>
                                                                                                    <div class="col-md-7">
                                                                                                        <asp:Label ID="lblFirmAddress" runat="server" Style="margin-bottom: 10px;" Text='<%# Eval("address") %>'></asp:Label>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="row">
                                                                                                    <div class="col-md-5">
                                                                                                        <label>Gross Revenue:</label>
                                                                                                    </div>
                                                                                                    <div class="col-md-7">
                                                                                                        <asp:Label ID="lblGross" runat="server" Style="margin-bottom: 10px;" Text='<%# String.Format("{0:n0}", Eval("grossRevenue")) %>'></asp:Label>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="row">
                                                                                                    <div class="col-md-5">
                                                                                                        <label>Percentage Ownership:</label>
                                                                                                    </div>
                                                                                                    <div class="col-md-7">
                                                                                                        <asp:Label ID="lblPOwnership" runat="server" Style="margin-bottom: 10px;" Text='<%# Eval("ownershipPercentage") %>'></asp:Label>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </ItemTemplate>
                                                                        <FooterTemplate>
                                                                            </div>
                                                                        </FooterTemplate>
                                                                    </asp:Repeater>
                                                                </div>
                                                                <br />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-1"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </div>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingThree">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                <h4 class="panel-title">Firm Information   </h4>
                            </a>
                        </div>
                        <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Application Date: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblAppDate" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Current Ownership Date: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblCODate" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Registered Date: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblRegDate" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>HR Certificate: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblHRCert" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Method of Aquisition: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblMOA" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>No. Of Full-Time Employees: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblEmployee" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>MN Tax ID: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblMNTax" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Federal Tax ID: </label>
                                                </div>
                                                <div class="col-md-8">
                                                    <asp:Label ID="lblFedTax" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <asp:GridView ID="grdGross" runat="server" CssClass="grid" AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" Style="width: 100%; text-align: center; margin-bottom: 10px;" EmptyDataRowStyle-BorderColor="White">
                                                <Columns>
                                                    <asp:BoundField DataField="year" HeaderText="Year" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="grossRevenue" HeaderText="Gross Revenue" HeaderStyle-HorizontalAlign="Center" />
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <label style="color: red;">No Data Found</label>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingFour">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                <h4 class="panel-title">Business Structure </h4>
                            </a>
                        </div>
                        <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-6">
                                            <div class="row">
                                                <h5><b>Legal Structure</b></h5>
                                            </div>
                                            <div class="row">
                                                <asp:CheckBox ID="chkCorp" runat="server" Text="Corporation" CssClass="checkbox" />
                                            </div>
                                            <div class="row">
                                                <asp:CheckBox ID="chkPartnership" runat="server" Text="Partnership" CssClass="checkbox" />
                                            </div>
                                            <div class="row">
                                                <asp:CheckBox ID="chkProprietorship" runat="server" Text="Proprietorship" CssClass="checkbox" />
                                            </div>
                                            <div class="row">
                                                <asp:CheckBox ID="chkNonProfit" runat="server" Text="Non-Profit" CssClass="checkbox" />
                                            </div>
                                            <div class="row" style="margin-left: 10px">
                                                <asp:CheckBox ID="chkrehab" runat="server" Text="Rehabilitation" CssClass="checkbox" />
                                            </div>
                                            <div class="row">
                                                <asp:CheckBox ID="chkLLC" runat="server" Text="LLC" CssClass="checkbox" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="row">
                                                <h5><b>Other Certification</b></h5>
                                            </div>
                                            <div class="row">
                                                <asp:CheckBox ID="chkDBE" runat="server" Text="DBE" CssClass="checkbox" />
                                            </div>
                                            <div class="row">
                                                <asp:CheckBox ID="chkUSDVA" runat="server" Text="USDVA" CssClass="checkbox" />
                                            </div>
                                            <div class="row">
                                                <asp:CheckBox ID="chkWBENC" runat="server" Text="WBENC" CssClass="checkbox" />
                                            </div>
                                            <div class="row">
                                                <asp:CheckBox ID="chkNCMSDC" runat="server" Text="NCMSDC" CssClass="checkbox" />
                                            </div>
                                            <div class="row">
                                                <asp:CheckBox ID="chkNGLCC" runat="server" Text="NGLCC" CssClass="checkbox" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="margin-top: 20px; margin-bottom: 20px;">
            <div class="col-md-3"></div>
            <div class="col-md-2">
                <asp:Button ID="btnApprove" runat="server" Text="Accept Application" CssClass="btn btn-primary" OnClick="btnApprove_Click" />
            </div>
            <div class="col-md-2"></div>
            <div class="col-md-2">
                <asp:Button ID="btnReject" runat="server" Text="Reject Application" CssClass="btn btn-primary" OnClick="btnReject_Click" />
            </div>
            <div class="col-md-3"></div>
        </div>
        <div class="modal fade" id="myModal1" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirmation</h4>
                    </div>
                    <div class="modal-body">
                        <label>Are you sure you want to accept this application and move to VMP ?</label>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnAcceptYes" runat="server" Text="Accept" CssClass="btn btn-primary" OnClick="btnAcceptYes_Click" />
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModal2" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirmation</h4>
                    </div>
                    <div class="modal-body">
                        <label>Are you sure you want to reject and delete this application ?</label>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnRejectYes" runat="server" Text="Reject" CssClass="btn btn-primary" OnClick="btnRejectYes_Click" />
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
