﻿<%@ Page Title="" Language="C#" MasterPageFile="~/User/vmpUsrMaster.Master" AutoEventWireup="true" CodeBehind="vmpUsrVendor4.aspx.cs" Inherits="VMP_1._0.User.vmpUsrVendor4" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Content/jquery-ui.css" rel="stylesheet" />
     <script src="../js/jquery.mask.js"></script>
    <script src="../js/jquery-ui.js"></script>
    <script>
        function pageLoad(sender, args) {
            jQuery.noConflict();
            $("#<%=txtDate.ClientID%>").datepicker();
            $("#<%=txtDBECertDate.ClientID%>").datepicker();
            $("#<%=txtVerifyDate.ClientID%>").datepicker();
            $("#<%=txtExpDate.ClientID%>").datepicker();
            $('.Otherdatepicker').datepicker();
            $('.dateformat').mask('00/00/0000');
        }
    </script>
    <script>
        $(function () {
            jQuery.noConflict();
            $("#<%=txtAppDate.ClientID%>").datepicker();
            $("#<%=txtCurrentDate.ClientID%>").datepicker();
            $("#<%=txtRegDate.ClientID%>").datepicker();
        });
    </script>
    <style>
        label {
            font-weight: normal;
            /*margin-top: 5px;*/
        }

        .customheading {
            font-style: italic;
            font-family: serif;
            /*margin: 0px 0px -10px 12px;*/
            text-decoration: underline;
            text-align: center;
            font-weight: bold;
        }

        .grid td, .grid th {
            text-align: center !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <%--<asp:HiddenField ID="hdnFourthPageComplete" runat="server" Value="False"/>--%>
    <asp:HiddenField ID="hdnbsId" runat="server" />
    <asp:HiddenField ID="hdFirmId" runat="server" />
    <div class="container" style="background-color: gainsboro; border-radius: 6px;">
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6" style="text-align: center">
                <h3 id="heading" runat="server">New Vendor</h3>
            </div>
            <div class="col-md-3" style="text-align: right; margin-top: 20px;">
                <asp:LinkButton ID="lnkGoToStatus" runat="server" CssClass="btn-link" Text="Go To Status Page" OnClick="lnkGoToStatus_Click" Style="display: block;"></asp:LinkButton>
                <asp:LinkButton ID="lnkAttachments" runat="server" CssClass="btn-link" Text="View/Upload Attachments" OnClick="lnkAttachments_Click"></asp:LinkButton>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6" style="text-align: center">
                <asp:Label ID="lblVendorHeading" runat="server" Style="font-weight: bold;"></asp:Label>
            </div>
            <div class="col-md-3">
            </div>
        </div>
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6" style="text-align: center">
                <div class="row bs-wizard" style="border-bottom: 0;">
                    <div class="col-xs-3 bs-wizard-step complete" id="divStep1" runat="server">
                        <%-- complete--%>
                        <div class="text-center bs-wizard-stepnum">Basic</div>
                        <div class="progress">
                            <div class="progress-bar"></div>
                        </div>
                        <%--<a href="#" class="bs-wizard-dot"></a>--%>
                        <asp:LinkButton ID="lnkStep1" runat="server" CssClass="bs-wizard-dot" OnClick="lnkStep1_Click"></asp:LinkButton>
                        <%--<asp:HyperLink ID="hyStep1" runat="server" CssClass="bs-wizard-dot" ></asp:HyperLink>--%>
                    </div>

                    <div class="col-xs-3 bs-wizard-step active" id="divStep2" runat="server">
                        <%-- complete--%>
                        <!-- complete -->
                        <div class="text-center bs-wizard-stepnum">Actions</div>
                        <div class="progress">
                            <div class="progress-bar"></div>
                        </div>
                        <asp:LinkButton ID="lnkStep2" runat="server" CssClass="bs-wizard-dot" OnClick="lnkStep2_Click"></asp:LinkButton>
                    </div>

                    <div class="col-xs-3 bs-wizard-step disabled" id="divStep3" runat="server">
                        <%-- active--%>
                        <!-- complete -->
                        <div class="text-center bs-wizard-stepnum">Owners</div>
                        <div class="progress">
                            <div class="progress-bar"></div>
                        </div>
                        <asp:LinkButton ID="lnkStep3" runat="server" CssClass="bs-wizard-dot" OnClick="lnkStep3_Click"></asp:LinkButton>
                    </div>

                    <div class="col-xs-3 bs-wizard-step disabled" id="divStep4" runat="server">
                        <%-- disabled--%>
                        <!-- active -->
                        <div class="text-center bs-wizard-stepnum">Business</div>
                        <div class="progress">
                            <div class="progress-bar"></div>
                        </div>
                        <asp:LinkButton ID="lnkStep4" runat="server" CssClass="bs-wizard-dot"></asp:LinkButton>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>
        <div style="display: none; text-align: center" id="myMessage2" runat="server" class="alert alert-success col-sm-12">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <asp:Label ID="Label1" runat="server" Text="Document Uploaded Successfully"></asp:Label>
        </div>
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h4 class="customheading">Firm Information</h4>
            </div>
            <div class="col-md-3"></div>
        </div>
        <hr />
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-3">
                <div class="row">
                    <div class="col-md-12">
                        <h5><b>Dates</b></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <label>Application Date</label>
                    </div>
                    <div class="col-md-12">
                        <asp:TextBox ID="txtAppDate" runat="server" CssClass="form-control dateformat" Width="50%"></asp:TextBox>
                        <%--<input type="text" id="datepicker"/>--%>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-12">
                        <label>Date Current Ownership Est.</label>
                    </div>
                    <div class="col-md-12">
                        <asp:TextBox ID="txtCurrentDate" runat="server" CssClass="form-control dateformat" Width="50%"></asp:TextBox>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-12">
                        <label>Registered Date w/Sec of State</label>
                    </div>
                    <div class="col-md-12">
                        <asp:TextBox ID="txtRegDate" runat="server" CssClass="form-control dateformat" Width="50%"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="row">
                    <div class="col-md-12">
                        <h5><b>HR Certificate?</b></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <asp:RadioButtonList ID="radbutCertificate" runat="server" CssClass="radio">
                            <asp:ListItem Selected="True">No</asp:ListItem>
                            <asp:ListItem>Applied</asp:ListItem>
                            <asp:ListItem>Yes</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h5><b>Method of Acquisition</b></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <asp:RadioButtonList ID="radbutAquisition" runat="server" CssClass="radio">
                            <asp:ListItem>Purchased Existing</asp:ListItem>
                            <asp:ListItem>Franchise</asp:ListItem>
                            <asp:ListItem Selected="True">Founded</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="row">
                    <div class="col-md-12">
                        <label>No. of Fulltime Employees</label>
                    </div>
                    <div class="col-md-12">
                        <asp:TextBox ID="txtFTE" runat="server" CssClass="form-control" Width="50%" MaxLength="8"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h5><b>Revenue</b></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <label>MN Tax ID</label>
                    </div>
                    <div class="col-md-12">
                        <asp:TextBox ID="txtMNax" runat="server" CssClass="form-control" Width="50%" MaxLength="9"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <label>Federal Tax ID</label>
                    </div>
                    <div class="col-md-12">
                        <asp:TextBox ID="txtFedTax" runat="server" CssClass="form-control" Width="50%" MaxLength="10"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-12">
                                <label>Gross Revenue</label>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:TextBox ID="txtGross" runat="server" CssClass="form-control" onkeyup="javascript:this.value=Comma(this.value);"></asp:TextBox>

                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-12">
                                <label>Year</label>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlGrossRevYear"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4" style="margin-top: 5px;">
                        <asp:LinkButton ID="lnkGrossHistory" runat="server" OnClick="lnkGrossHistory_Click">History <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myGRModal" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Gross Revenue History</h4>
                    </div>
                    <div class="modal-body">
                        <asp:GridView ID="grdGRHistory" runat="server" CssClass="grid" AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" Style="width: 100%; text-align: center; margin-bottom: 10px;" EmptyDataRowStyle-BorderColor="White">
                            <Columns>
                                <asp:BoundField DataField="year" HeaderText="Year" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="grossRevenue" HeaderText="Gross Revenue" HeaderStyle-HorizontalAlign="Center" />
                            </Columns>
                            <EmptyDataTemplate>
                                <label style="color: red;">No Data Found</label>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6" style="text-align: center;">
                <h4 class="customheading">Business Structure</h4>
            </div>
            <div class="col-md-3"></div>
        </div>
        <hr />
        <asp:UpdatePanel ID="updpnl1" runat="server">
            <ContentTemplate>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <h5><b><u>Legal Structure</u></b></h5>
                        </div>
                        <div class="col-md-4"></div>
                        <div class="col-md-4"></div>

                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-md-12">
                        <asp:RadioButton ID="radButLSNone" runat="server" Text="None" GroupName="ls" CssClass="radio" OnCheckedChanged="radButLSNone_CheckedChanged" AutoPostBack="true" />
                    </div>
                </div>
                <div class="row">
                    <%--<div class="col-md-1"></div>--%>
                    <div class="col-md-12" style="border-style: groove;">
                        <div class="row">
                            <div class="col-md-2">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:RadioButton ID="radCorp" runat="server" Text="Corporation" OnCheckedChanged="radCorp_CheckedChanged" AutoPostBack="true" GroupName="ls" CssClass="radio" />
                                    </div>
                                    <div class="row" id="divArticles" runat="server" style="display: none;">
                                        <div class="col-md-12">
                                            <label>Articles?</label>
                                        </div>
                                        <div class="col-md-12">
                                            <asp:RadioButtonList ID="radArticles" runat="server" OnSelectedIndexChanged="radArticles_SelectedIndexChanged" AutoPostBack="true" CssClass="radio">
                                                <asp:ListItem>Yes</asp:ListItem>
                                                <asp:ListItem Selected="True">No</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:RadioButton ID="radPartnership" runat="server" Text="Partnership" OnCheckedChanged="radPartnership_CheckedChanged" AutoPostBack="true" GroupName="ls" CssClass="radio" />
                                    </div>
                                    <div class="row" id="divPartnership" runat="server" style="display: none;">
                                        <asp:CheckBoxList ID="chkPartnershipList" runat="server" CssClass="checkbox">
                                            <asp:ListItem>Partnership Agreement</asp:ListItem>
                                        </asp:CheckBoxList>
                                        <asp:RadioButtonList ID="radPartnershipList" runat="server" CssClass="radio" Style="margin-top: -10px;" OnSelectedIndexChanged="radPartnershipList_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem>Certificate of Assumed Name</asp:ListItem>
                                            <asp:ListItem>Personal Name</asp:ListItem>
                                            <asp:ListItem>None</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:RadioButton ID="radProprietorship" runat="server" Text="Proprietorship" OnCheckedChanged="radProprietorship_CheckedChanged" AutoPostBack="true" GroupName="ls" CssClass="radio" />
                                    </div>
                                    <div class="row" id="divProprietorship" runat="server" style="display: none;">
                                        <asp:RadioButtonList ID="radProprietorshipList" runat="server" CssClass="radio">
                                            <asp:ListItem>Certificate of Assumed Name</asp:ListItem>
                                            <asp:ListItem>Personal Name</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:RadioButton ID="radNonProfit" runat="server" Text="Non-Profit" OnCheckedChanged="radNonProfit_CheckedChanged" AutoPostBack="true" GroupName="ls" CssClass="radio" />
                                    </div>
                                    <div class="row" id="divNonProfit" runat="server" style="display: none;">
                                        <asp:CheckBox ID="ChkRehabFac" runat="server" Text="Rehabilitation Facilities" CssClass="checkbox" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:RadioButton ID="radLLC" runat="server" Text="LLC/LLP" OnCheckedChanged="radLLC_CheckedChanged" AutoPostBack="true" GroupName="ls" CssClass="radio" />
                                    </div>
                                    <div class="row" id="divLLC" runat="server" style="display: none;">
                                        <div class="col-md-12" style="text-align: left;">
                                            <label>Is Signed?</label>
                                        </div>
                                        <div class="col-md-12">
                                            <asp:RadioButtonList ID="radLLCSign" runat="server" AutoPostBack="true" CssClass="radio">
                                                <asp:ListItem>Yes</asp:ListItem>
                                                <asp:ListItem Selected="True">No</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="row" id="divLLCFile" runat="server" style="display: none;">
                                        <div class="col-md-12" style="text-align: left;">
                                            <label>File Numbers?</label>
                                        </div>
                                        <div class="col-md-12">
                                            <asp:RadioButtonList ID="radLLCFile" runat="server" AutoPostBack="true" CssClass="radio">
                                                <asp:ListItem>Yes</asp:ListItem>
                                                <asp:ListItem Selected="True">No</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="row" id="divLLCAgg" runat="server" style="display: none;">
                                        <div class="col-md-12" style="text-align: left;">
                                            <label>Comp Op Agreement Copy?</label>
                                        </div>
                                        <div class="col-md-12">
                                            <asp:RadioButtonList ID="radLLCCAgree" runat="server" AutoPostBack="true" CssClass="radio">
                                                <asp:ListItem>Yes</asp:ListItem>
                                                <asp:ListItem Selected="True">No</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="divCD" runat="server" style="display: none;">
                            <div class="col-md-8 col-md-offset-2">
                                <div class="panel-group" id="accordionCD" style="border-style: ridge;">
                                    <div class="panel panel-default">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionCD" href="#collapse1" style="font-style: italic; text-decoration: underline; color: #428bca;">
                                                <h6 class="panel-title" style="background-color: lightgray;">Corporate Documents</h6>
                                            </a>
                                        </div>
                                        <div id="collapse1" class="panel-collapse collapse in">
                                            <div class="panel-body" style="background-color: #DCDCDC;">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="col-md-12">
                                                            <label><b>Application Signator</b></label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-6">
                                                            <asp:RadioButton ID="radAS" runat="server" Text="Application Signed" GroupName="cd" CssClass="radio" />
                                                        </div>
                                                        <div class="col-md-6">
                                                            <asp:RadioButton ID="radNS" runat="server" Text="Not Signed" GroupName="cd" CssClass="radio" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-4">
                                                            <label>First Name</label>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" Style="margin-bottom: 10px;"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-4">
                                                            <label>Last Name</label>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="col-md-4">
                                                            <label><b>Incorporator</b></label>
                                                        </div>
                                                        <div class="col-md-8">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="col-md-4">
                                                            <label>Incorporator Name</label>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:DropDownList ID="ddlOwners" runat="server" CssClass="form-control" onchange="ddlChange(this)">
                                                            </asp:DropDownList>
                                                        </div>

                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="col-md-4">
                                                        </div>
                                                        <div class="col-md-8" id="divOther" runat="server" hidden="hidden">
                                                            <asp:TextBox ID="txtOther" runat="server" CssClass="form-control" placeholder="Enter Incorporator Name" Style="margin-top: 10px;"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12" style="margin-top: 10px;">
                                                        <div class="col-md-4">
                                                            <label>Incorporation Date</label>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control dateformat"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12" style="margin-top: 10px;">
                                                        <div class="col-md-4">
                                                            <label>No. of Issued Shares</label>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:TextBox ID="txtShares" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12" style="margin-top: 10px;">
                                                        <div class="col-md-4">
                                                            <label>File Numbers</label>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <asp:RadioButton ID="radFileYes" runat="server" Text="Yes" GroupName="In" CssClass="radio" />
                                                        </div>
                                                        <div class="col-md-4">
                                                            <asp:RadioButton ID="radFileNo" runat="server" Text="No" GroupName="In" Checked="true" CssClass="radio" />

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"></div>
                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <h5><b><u>Type of Business</u></b></h5>
                        </div>
                        <div class="col-md-4"></div>
                        <div class="col-md-4"></div>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-md-12" style="border-style: groove;">
                        <div class="row">
                            <div class="col-md-2">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:RadioButton ID="radBrokerage" runat="server" Text="Brokerage" OnCheckedChanged="radBrokerage_CheckedChanged" GroupName="b" AutoPostBack="true" CssClass="radio" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:RadioButton ID="rad3rdParty" runat="server" Text="3rd Party Lessor" OnCheckedChanged="rad3rdParty_CheckedChanged" GroupName="b" AutoPostBack="true" CssClass="radio" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:RadioButton ID="radMfg" runat="server" Text="Manufacturer Representative" OnCheckedChanged="radMfg_CheckedChanged" GroupName="b" AutoPostBack="true" CssClass="radio" />
                                    </div>
                                    <div class="row" id="divOtherBusiness" runat="server" style="display: none;">
                                        <div class="col-md-12">
                                            <label>Agreement?</label>
                                        </div>
                                        <div class="col-md-12">
                                            <asp:RadioButtonList ID="radmfgArticles" runat="server" CssClass="radio">
                                                <asp:ListItem>Yes</asp:ListItem>
                                                <asp:ListItem Selected="True">No</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:RadioButton ID="radFranchise" runat="server" Text="Franchise " OnCheckedChanged="radFranchise_CheckedChanged" GroupName="b" AutoPostBack="true" CssClass="radio" />
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="col-md-12">
                                    <div class="row">
                                        <asp:RadioButton ID="radOtherBusiness" runat="server" Text="Other" OnCheckedChanged="radOtherBusiness_CheckedChanged" GroupName="b" AutoPostBack="true" CssClass="radio" />
                                    </div>
                                    <div class="row" id="divOtherBus" runat="server" style="display: none;">
                                        <div class="col-md-12" style="margin-bottom: 20px">
                                            <div>
                                                <asp:TextBox ID="txtOtherBusiness" runat="server" CssClass="form-control" placeholder="Enter Other Business"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <h5><b><u>Other Certification</u></b></h5>
                        </div>
                        <div class="col-md-4"></div>
                        <div class="col-md-4"></div>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-md-12" style="border-style: groove;">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="col-md-12">
                                    <%-- <div class="row">
                                        <asp:RadioButton ID="radOtherCert" runat="server" Text="Other Certification" OnCheckedChanged="radOtherCert_CheckedChanged" GroupName="b" AutoPostBack="true" CssClass="radio" />
                                    </div>--%>
                                    <div class="row" id="divOtherCert" runat="server">
                                        <div class="col-md-12">
                                            <asp:CheckBox ID="chkDBE" runat="server" Text="DBE" OnCheckedChanged="chkDBE_CheckedChanged" AutoPostBack="true" CssClass="checkbox" />
                                        </div>
                                        <%-- <div class="row" >--%>
                                        <div class="col-md-12" id="divDBECertDate" runat="server" style="display: none;">
                                            <div>
                                                <label>DBE Certification Date</label>
                                            </div>
                                            <div>
                                                <asp:TextBox ID="txtDBECertDate" runat="server" CssClass="form-control dateformat"></asp:TextBox>
                                            </div>
                                        </div>

                                        <%-- </div>--%>
                                        <div class="col-md-12">
                                            <asp:CheckBox ID="chkUSDVA" runat="server" Text="USDVA" OnCheckedChanged="chkUSDVA_CheckedChanged" AutoPostBack="true" CssClass="checkbox" />
                                        </div>
                                        <div class="col-md-12" id="divUSDVADates" runat="server" style="display: none;">
                                            <%--<div class="row">--%>
                                            <div>
                                                <label>USDVA Verification Date</label>
                                            </div>
                                            <div>
                                                <asp:TextBox ID="txtVerifyDate" runat="server" CssClass="form-control dateformat"></asp:TextBox>
                                            </div>
                                            <%-- </div>--%>
                                            <%--<div class="row">--%>
                                            <div>
                                                <label>USDVA Expiration Date</label>
                                            </div>
                                            <div>
                                                <asp:TextBox ID="txtExpDate" runat="server" CssClass="form-control dateformat"></asp:TextBox>
                                            </div>
                                            <%-- </div>--%>
                                        </div>
                                        <div class="col-md-12">
                                            <asp:CheckBox ID="chkOther" runat="server" Text="Other" OnCheckedChanged="chkOther_CheckedChanged" AutoPostBack="true" CssClass="checkbox" />
                                        </div>
                                        <div class="col-md-12" id="divOtherDBECert" runat="server" style="display: none;">
                                            <asp:Repeater ID="rptOther" runat="server" OnItemDataBound="rptOther_ItemDataBound">
                                                <ItemTemplate>
                                                    <div class="col-md-12">
                                                        <asp:CheckBox ID="chkOtherList" runat="server" Text='<%# Eval("OtherDBEType") %>' AccessKey='<%# Eval("OtherDBETypeID") %>' OnCheckedChanged="chkOtherList_CheckedChanged" AutoPostBack="true" CssClass="checkbox" />
                                                    </div>
                                                    <div class="col-md-12" id="divOtherCertDate" runat="server" style="display: none;">
                                                        <asp:TextBox ID="txtOtherDate" runat="server" CssClass="form-control Otherdatepicker dateformat" placeholder="Certificate Date"></asp:TextBox>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-9"></div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-5"></div>
                    <div class="col-md-2">
                        <asp:CheckBox ID="chkAppComplete" runat="server" Text=" Application Complete" AutoPostBack="true" CssClass="checkbox" />
                    </div>
                    <div class="col-md-5"></div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <br />
        <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <asp:Label ID="lblError" runat="server" Text="Saved Successfully"></asp:Label>
        </div>
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <div class="col-md-6" style="text-align: center; margin-bottom: 5px;">
                            <asp:Button ID="btnBack" runat="server" Text="Back to Owners" CssClass="btn btn-primary" ValidationGroup="vd2" OnClick="btnBack_Click" />
                        </div>
                        <div class="col-md-6" style="text-align: center">
                            <asp:Button ID="btnSaveProceed" runat="server" Text="Save" CssClass="btn btn-primary" ValidationGroup="vd2" Width="100px" OnClick="btnSaveProceed_Click" />
                        </div>
                    </div>
                    <div class="col-md-3"></div>
                </div>
                <br />
            </div>
            <div class="col-md-3"></div>
        </div>
        <div class="row" id="divExecute" runat="server">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-8">
                        <div class="col-md-3" style="text-align: center; margin-bottom: 5px;">
                        </div>
                        <div class="col-md-6" style="text-align: center">
                            <asp:Button ID="btnExecute" runat="server" Text="Save & Execute Rules" CssClass="btn btn-primary" ValidationGroup="vd2" OnClick="btnExecute_Click" />
                        </div>
                        <div class="col-md-3" style="text-align: center; margin-bottom: 5px;">
                        </div>
                    </div>
                    <div class="col-md-2"></div>
                </div>
                <br />
            </div>
            <div class="col-md-3"></div>
        </div>
    </div>
    <div class="modal fade" id="myModalAttachments" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Attachments</h4>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="row" style="text-align: center">
                                <asp:GridView ID="grdAttachments" runat="server" AllowPaging="true" OnPageIndexChanging="grdAttachments_PageIndexChanging" PageSize="10" OnRowDataBound="grdAttachments_RowDataBound" CssClass="grid" AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" Style="width: 100%; text-align: center; margin: 0 auto; margin-bottom: 10px;" EmptyDataRowStyle-BorderColor="White" PagerStyle-BorderColor="White">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Attachments">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="lnkAttachment" runat="server" Target="_blank"></asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="createdDateTime" HeaderText="Created Date" HeaderStyle-HorizontalAlign="Center" />
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <label style="color: red;">No Data Found</label>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <h4 style="text-align: center">Upload Attachment</h4>

                    <div class="row">
                        <div class="col-md-8">
                            <asp:FileUpload ID="FileUploadAttachment" runat="server" />
                        </div>
                        <div class="col-md-4">
                            <asp:Button ID="btnUploadAttachment" runat="server" Text="Upload" CssClass="btn btn-primary" OnClick="btnUploadAttachment_Click" ValidationGroup="fileupload"/>
                        </div>
                    </div>
                    <div class="row" style="text-align: center">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" style="color:red;" ErrorMessage="Please Select File To Upload !!" ControlToValidate="FileUploadAttachment" ValidationGroup="fileupload"></asp:RequiredFieldValidator>
                    </div>

                </div>
            </div>
        </div>
    </div>
   
    
    <script>
        $(document).ready(function () {
           //jQuery.noConflict();
            $("#navbar7 li").removeClass("active");//this will remove the active class from  
            $('#menu').addClass('active');
            //   $('#<%=txtDate.ClientID%>').mask('00/00/0000');

            $(document).on('blur', '#<%=txtDate.ClientID%>', function () {
                var text = $.trim($(this).val());
                //alert(text);
                if (text != '') {
                    var comp = text.split('/');
                    var m = parseInt(comp[0], 10);
                    var d = parseInt(comp[1], 10);
                    var y = parseInt(comp[2], 10);
                    var date = new Date(y, m - 1, d);
                    if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
                        //alert('Valid date');
                    } else {
                        alert('Invalid date');
                        $('#<%=txtDate.ClientID%>').val("");
                    }
                }
            });
            $(document).on('blur', '#<%=txtDBECertDate.ClientID%>', function () {
                var text = $.trim($(this).val());
                //alert(text);
                if (text != '') {
                    var comp = text.split('/');
                    var m = parseInt(comp[0], 10);
                    var d = parseInt(comp[1], 10);
                    var y = parseInt(comp[2], 10);
                    var date = new Date(y, m - 1, d);
                    if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
                        //alert('Valid date');
                    } else {
                        alert('Invalid DBE Certification Date');
                        $('#<%=txtDBECertDate.ClientID%>').val("");
                    }
                }
            });
            $(document).on('blur', '#<%=txtVerifyDate.ClientID%>', function () {
                var text = $.trim($(this).val());
                //alert(text);
                if (text != '') {
                    var comp = text.split('/');
                    var m = parseInt(comp[0], 10);
                    var d = parseInt(comp[1], 10);
                    var y = parseInt(comp[2], 10);
                    var date = new Date(y, m - 1, d);
                    if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
                        //alert('Valid date');
                    } else {
                        alert('Invalid USDVA Verification Date');
                        $('#<%=txtVerifyDate.ClientID%>').val("");
                    }
                }
            });
            $(document).on('blur', '#<%=txtExpDate.ClientID%>', function () {
                var text = $.trim($(this).val());
                //alert(text);
                if (text != '') {
                    var comp = text.split('/');
                    var m = parseInt(comp[0], 10);
                    var d = parseInt(comp[1], 10);
                    var y = parseInt(comp[2], 10);
                    var date = new Date(y, m - 1, d);
                    if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
                        //alert('Valid date');
                    } else {
                        alert('Invalid USDVA Expiration Date');
                        $('#<%=txtExpDate.ClientID%>').val("");
                    }
                }
            });
            $(document).on('blur', '.Otherdatepicker', function () {
                var text = $.trim($(this).val());
                //alert(text);
                if (text != '') {
                    var comp = text.split('/');
                    var m = parseInt(comp[0], 10);
                    var d = parseInt(comp[1], 10);
                    var y = parseInt(comp[2], 10);
                    var date = new Date(y, m - 1, d);
                    if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
                        //alert('Valid date');
                    } else {
                        alert('Invalid Certificate Date');
                        $('.Otherdatepicker').val("");
                    }
                }
            });
           
            //$('.dateformat').mask('00/00/0000');
            //  $('#<%=txtCurrentDate.ClientID%>').mask('00/00/0000');
            //  $('#<%=txtRegDate.ClientID%>').mask('00/00/0000');

            $('#<%=txtGross.ClientID%>').keydown(function (e) {
                // Allow: backspace, delete, tab, escape, enter and .
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
                    // Allow: Ctrl+A
                   (e.keyCode == 65 && e.ctrlKey === true) ||
                    // Allow: home, end, left, right
                   (e.keyCode >= 35 && e.keyCode <= 39)) {
                    // let it happen, don't do anything
                    return;
                }
                // Ensure that it is a number and stop the keypress
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault();
                }
            });
            $('#<%=txtFedTax.ClientID%>').keyup(function () {
                var foo = $(this).val()
                if (foo.length == 2) {
                    foo = foo + "-";
                }
                $(this).val(foo);
            });

            $('#<%=txtFedTax.ClientID%>').keydown(function (e) {
                // Allow: backspace, delete, tab, escape, enter and .
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 189, 109]) !== -1 ||
                    // Allow: Ctrl+A
                    (e.keyCode == 65 && e.ctrlKey === true) ||
                    // Allow: home, end, left, right
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                    // let it happen, don't do anything
                    return;
                }
                // Ensure that it is a number and stop the keypress
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault();
                }
            });

            $('#<%=txtMNax.ClientID%>').keydown(function (e) {
                // Allow: backspace, delete, tab, escape, enter and .
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 189, 109]) !== -1 ||
                    // Allow: Ctrl+A
                    (e.keyCode == 65 && e.ctrlKey === true) ||
                    // Allow: home, end, left, right
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                    // let it happen, don't do anything
                    return;
                }
                // Ensure that it is a number and stop the keypress
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault();
                }
            });

            $('#<%=txtFTE.ClientID%>').keydown(function (e) {
                // Allow: backspace, delete, tab, escape, enter and .
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
                    // Allow: Ctrl+A
                    (e.keyCode == 65 && e.ctrlKey === true) ||
                    // Allow: home, end, left, right
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                    // let it happen, don't do anything
                    return;
                }
                // Ensure that it is a number and stop the keypress
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault();
                }
            });

            $(document).on('blur', '#<%=txtAppDate.ClientID%>', function () {
                var text = $.trim($(this).val());
                //alert(text);
                if (text != '') {
                    var comp = text.split('/');
                    var m = parseInt(comp[0], 10);
                    var d = parseInt(comp[1], 10);
                    var y = parseInt(comp[2], 10);
                    var date = new Date(y, m - 1, d);
                    if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
                        //alert('Valid date');
                    } else {
                        alert('Invalid date');
                        $('#<%=txtAppDate.ClientID%>').val("");
                    }
                }
            });
            $(document).on('blur', '#<%=txtCurrentDate.ClientID%>', function () {
                var text = $.trim($(this).val());
                //alert(text);
                if (text != '') {
                    var comp = text.split('/');
                    var m = parseInt(comp[0], 10);
                    var d = parseInt(comp[1], 10);
                    var y = parseInt(comp[2], 10);
                    var date = new Date(y, m - 1, d);
                    if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
                        //alert('Valid date');
                    } else {
                        alert('Invalid date');
                        $('#<%=txtCurrentDate.ClientID%>').val("");
                    }
                }
            });
            $(document).on('blur', '#<%=txtRegDate.ClientID%>', function () {
                var text = $.trim($(this).val());
                //alert(text);
                if (text != '') {
                    var comp = text.split('/');
                    var m = parseInt(comp[0], 10);
                    var d = parseInt(comp[1], 10);
                    var y = parseInt(comp[2], 10);
                    var date = new Date(y, m - 1, d);
                    if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
                        //alert('Valid date');
                    } else {
                        alert('Invalid date');
                        $('#<%=txtRegDate.ClientID%>').val("");
                    }
                }
            });
        });
    </script>
    <script>
        function ddlChange(ddl) {
            if ($('#<%=ddlOwners.ClientID%>').val() == 'Other') {
                $('#<%=divOther.ClientID%>').show();
            }
            else {
                $('#<%=divOther.ClientID%>').hide();
            }
        }

        function dateFormat(val) {
            //  $('#your-id').bind('keyup', 'keydown', function (event) {
            var inputLength = val.length;
            if (inputLength === 2 || inputLength === 5) {
                var thisVal = event.target.value;
                thisVal += '/';
                $(event.target).val(thisVal);
            }
            //  })
        }
    </script>

    <script type="text/javascript">
        function preventSave() {
            alert('USDVA Verification Date & USDVA Expiration Date is mandatory for USDVA. Please provide the dates.');
        }
    </script>
    <%-- <script type="text/javascript">
        function showCertStatus() {
            //jQuery.noConflict();
            $("#ModalRulesView").modal('show');
        }
    </script>--%>
    <script type="text/javascript">
        function showModal(id) {
            jQuery.noConflict();
            $("#myGRModal").modal('show');
        }
    </script>
    <script>
        function Comma(Num) { //function to add commas to textboxes
            Num += '';
            Num = Num.replace(',', ''); Num = Num.replace(',', ''); Num = Num.replace(',', '');
            Num = Num.replace(',', ''); Num = Num.replace(',', ''); Num = Num.replace(',', '');
            x = Num.split('.');
            x1 = x[0];
            x2 = x.length > 1 ? '.' + x[1] : '';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1))
                x1 = x1.replace(rgx, '$1' + ',' + '$2');
            return x1 + x2;
        }
    </script>
    <script type="text/javascript">
        function showModalAttachments() {
             jQuery.noConflict();
            $("#myModalAttachments").modal('show');
        }
        function runEffect1() {
            $("#<%=myMessage1.ClientID%>").show();
            setTimeout(function () {
                var selectedEffect = 'blind';
                var options = {};
                $("#<%=myMessage1.ClientID%>").hide();
            }, 5000);
            return false;
        }
        function runEffect2() {
            $("#<%=myMessage2.ClientID%>").show();
            setTimeout(function () {
                var selectedEffect = 'blind';
                var options = {};
                $("#<%=myMessage2.ClientID%>").hide();
            }, 5000);
            return false;
        }
    </script>
</asp:Content>
