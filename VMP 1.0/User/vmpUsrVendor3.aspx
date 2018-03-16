﻿<%@ Page Title="" Language="C#" MasterPageFile="~/User/vmpUsrMaster.Master" AutoEventWireup="true" CodeBehind="vmpUsrVendor3.aspx.cs" Inherits="VMP_1._0.User.vmpUsrVendor3" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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
            font-weight: bold;
        }

        .grid td, .grid th {
            text-align: center !important;
        }
    </style>
    <%--  <link href="../Content/bootstrap-theme.min.css" rel="stylesheet" />--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
    <div class="container" style="background-color: gainsboro; border-radius: 6px;">
        <asp:HiddenField ID="hdnFourthPageComplete" runat="server" Value="False" />
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6" style="text-align: center">
                <h3 id="heading" runat="server">New Vendor</h3>
            </div>
            <div class="col-md-3" style="text-align: right; margin-top: 20px;">
                <asp:LinkButton ID="lnkGoToStatus" runat="server" CssClass="btn-link" Text="Go To Status Page" OnClick="lnkGoToStatus_Click"></asp:LinkButton>
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
                        <asp:LinkButton ID="lnkStep3" runat="server" CssClass="bs-wizard-dot"></asp:LinkButton>
                    </div>

                    <div class="col-xs-3 bs-wizard-step disabled" id="divStep4" runat="server">
                        <%-- disabled--%>
                        <!-- active -->
                        <div class="text-center bs-wizard-stepnum">Business</div>
                        <div class="progress">
                            <div class="progress-bar"></div>
                        </div>
                        <asp:LinkButton ID="lnkStep4" runat="server" CssClass="bs-wizard-dot" OnClick="lnkStep4_Click"></asp:LinkButton>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>
        <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <asp:Label ID="Label1" runat="server" Text="Document Uploaded Successfully"></asp:Label>
        </div>
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6" style="text-align: center;">
                <h4 class="customheading">Owners</h4>
            </div>
            <div class="col-md-3"></div>
        </div>
        <hr />
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4" style="text-align: center;">
                <label style="text-decoration: underline;"><b>Owner Details</b></label>
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <label>Secondary Firms</label>
            </div>
            <div class="col-md-4"></div>
        </div>
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <div style="display: none; text-align: center" id="myMessage" runat="server" class="alert alert-success col-sm-12">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <asp:Label ID="lblError" runat="server" Text="Owner Information Updated Successfully"></asp:Label>
                </div>
                <asp:Repeater ID="rptSecOwners" runat="server" OnItemDataBound="rptSecOwners_ItemDataBound" OnItemCommand="rptSecOwners_ItemCommand">
                    <HeaderTemplate>
                        <div class="panel-group" id="accordion">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%# Container.ItemIndex %>">
                                    <h4 class="panel-title"><%# Eval("ownerFirstName")+" "+Eval("ownerMidName")+" "+Eval("ownerLastName") %><%#(!(bool)Eval("isActive"))?" <label style=\"color:red;\"> (Inactive)</label>":"" %></h4>
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
                                                                <label>Title</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <%--<asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" Text='<%# Eval("title")%>' MaxLength="50"></asp:TextBox>--%>
                                                                <asp:DropDownList ID="ddlTitle" runat="server" CssClass="form-control">
                                                                    <asp:ListItem Value=""></asp:ListItem>
                                                                    <asp:ListItem Value="Mr">Mr</asp:ListItem>
                                                                    <asp:ListItem Value="Ms">Ms</asp:ListItem>
                                                                    <asp:ListItem Value="Mrs">Mrs</asp:ListItem>
                                                                    <asp:ListItem Value="Dr">Dr</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4">
                                                                <label>First Name</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="txtFName" runat="server" CssClass="form-control" Text='<%# Eval("ownerFirstName") %>' MaxLength="250"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4">
                                                                <label>Middle Name</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="txtMName" runat="server" CssClass="form-control" Text='<%# Eval("ownerMidName") %>' MaxLength="250"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4">
                                                                <label>Last Name</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="txtLName" runat="server" CssClass="form-control" Text='<%# Eval("ownerLastName") %>' MaxLength="250"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4">
                                                                <label>Address</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Text='<%# Eval("address") %>' MaxLength="100"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4">
                                                                <label>City</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" Text='<%# Eval("city") %>' MaxLength="100"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4"></div>
                                                            <div class="col-md-8">
                                                                <div class="col-md-6">
                                                                    <div class="row" style="text-align: center">
                                                                        <label>State</label>
                                                                    </div>
                                                                    <div class="row" style="margin: 0 auto;">
                                                                        <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" Style="width: 100%">
                                                                            <asp:ListItem Value="AL">AL</asp:ListItem>
                                                                            <asp:ListItem Value="AK">AK</asp:ListItem>
                                                                            <asp:ListItem Value="AZ">AZ</asp:ListItem>
                                                                            <asp:ListItem Value="AR">AR</asp:ListItem>
                                                                            <asp:ListItem Value="CA">CA</asp:ListItem>
                                                                            <asp:ListItem Value="CO">CO</asp:ListItem>
                                                                            <asp:ListItem Value="CT">CT</asp:ListItem>
                                                                            <asp:ListItem Value="DC">DC</asp:ListItem>
                                                                            <asp:ListItem Value="DE">DE</asp:ListItem>
                                                                            <asp:ListItem Value="FL">FL</asp:ListItem>
                                                                            <asp:ListItem Value="GA">GA</asp:ListItem>
                                                                            <asp:ListItem Value="HI">HI</asp:ListItem>
                                                                            <asp:ListItem Value="ID">ID</asp:ListItem>
                                                                            <asp:ListItem Value="IL">IL</asp:ListItem>
                                                                            <asp:ListItem Value="IN">IN</asp:ListItem>
                                                                            <asp:ListItem Value="IA">IA</asp:ListItem>
                                                                            <asp:ListItem Value="KS">KS</asp:ListItem>
                                                                            <asp:ListItem Value="KY">KY</asp:ListItem>
                                                                            <asp:ListItem Value="LA">LA</asp:ListItem>
                                                                            <asp:ListItem Value="ME">ME</asp:ListItem>
                                                                            <asp:ListItem Value="MD">MD</asp:ListItem>
                                                                            <asp:ListItem Value="MA">MA</asp:ListItem>
                                                                            <asp:ListItem Value="MI">MI</asp:ListItem>
                                                                            <asp:ListItem Selected="True" Value="MN">MN</asp:ListItem>
                                                                            <asp:ListItem Value="MS">MS</asp:ListItem>
                                                                            <asp:ListItem Value="MO">MO</asp:ListItem>
                                                                            <asp:ListItem Value="MT">MT</asp:ListItem>
                                                                            <asp:ListItem Value="NE">NE</asp:ListItem>
                                                                            <asp:ListItem Value="NV">NV</asp:ListItem>
                                                                            <asp:ListItem Value="NH">NH</asp:ListItem>
                                                                            <asp:ListItem Value="NJ">NJ</asp:ListItem>
                                                                            <asp:ListItem Value="NM">NM</asp:ListItem>
                                                                            <asp:ListItem Value="NY">NY</asp:ListItem>
                                                                            <asp:ListItem Value="NC">NC</asp:ListItem>
                                                                            <asp:ListItem Value="ND">ND</asp:ListItem>
                                                                            <asp:ListItem Value="OH">OH</asp:ListItem>
                                                                            <asp:ListItem Value="OK">OK</asp:ListItem>
                                                                            <asp:ListItem Value="OR">OR</asp:ListItem>
                                                                            <asp:ListItem Value="PA">PA</asp:ListItem>
                                                                            <asp:ListItem Value="RI">RI</asp:ListItem>
                                                                            <asp:ListItem Value="SC">SC</asp:ListItem>
                                                                            <asp:ListItem Value="SD">SD</asp:ListItem>
                                                                            <asp:ListItem Value="TN">TN</asp:ListItem>
                                                                            <asp:ListItem Value="TX">TX</asp:ListItem>
                                                                            <asp:ListItem Value="UT">UT</asp:ListItem>
                                                                            <asp:ListItem Value="VT">VT</asp:ListItem>
                                                                            <asp:ListItem Value="VA">VA</asp:ListItem>
                                                                            <asp:ListItem Value="WA">WA</asp:ListItem>
                                                                            <asp:ListItem Value="WV">WV</asp:ListItem>
                                                                            <asp:ListItem Value="WI">WI</asp:ListItem>
                                                                            <asp:ListItem Value="WY">WY</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="row" style="text-align: center">
                                                                        <label>Zip</label>
                                                                    </div>
                                                                    <div class="row">
                                                                        <asp:TextBox ID="txtZip" runat="server" CssClass="form-control onlynumber" MaxLength="5" Text='<%# Eval("zipCode") %>'></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4"></div>
                                                            <div class="col-md-4">
                                                            </div>
                                                            <div class="col-md-4">
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4">
                                                                <label>Phone</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control bfh-phone" data-format=" (ddd) ddd-dddd" Text='<%# Eval("phone") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4">
                                                                <label>Cellphone</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="txtCellPhone" runat="server" CssClass="form-control bfh-phone" data-format=" (ddd) ddd-dddd" Text='<%# Eval("cellPhone") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4">
                                                                <label>Other Phone</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="txtOtherPhone" runat="server" CssClass="form-control bfh-phone" data-format=" (ddd) ddd-dddd" Text='<%# Eval("otherPhone") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4">
                                                                <label>Signed Shares?</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <div class="col-md-6">
                                                                    <asp:RadioButton ID="radbutSSYes" runat="server" GroupName="ss" CssClass="radio-inline" Text="Yes" />
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <asp:RadioButton ID="radbutSSNo" runat="server" GroupName="ss" Checked="true" CssClass="radio-inline" Text="No" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4">
                                                                <label>Signed App?</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <div class="col-md-6">
                                                                    <asp:RadioButton ID="radbutSAYes" runat="server" GroupName="sa" CssClass="radio-inline" Text="Yes" />
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <asp:RadioButton ID="radbutSANo" runat="server" GroupName="sa" Checked="true" CssClass="radio-inline" Text="No" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">

                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4">
                                                                <label>Percent Ownership</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="txtPOwnership" runat="server" CssClass="form-control pownership" Text='<%# String.IsNullOrEmpty(Eval("ownershipPercentage").ToString())?"0":Eval("ownershipPercentage") %>' MaxLength="5" onkeyup="this.value=fnc(this.value)"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-4">
                                                                <label>No. of Shares Owned</label>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="txtSharesOwned" runat="server" CssClass="form-control onlynumber" Text='<%# String.IsNullOrEmpty(Eval("noSharesOwned").ToString())?"0":Eval("noSharesOwned").ToString() %>' MaxLength="8"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                                                <div class="row" style="margin-bottom: 5px; border-bottom-style: ridge;">
                                                                    <div class="col-md-4">
                                                                    </div>
                                                                    <div class="col-md-8">
                                                                        <div class="col-md-12">
                                                                            <asp:CheckBox ID="chkCitizen" runat="server" CssClass="checkbox" OnCheckedChanged="chkCitizen_CheckedChanged" AutoPostBack="true" Text="Citizen/Permanent Resident" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row" style="margin-bottom: 5px;">
                                                                    <div class="col-md-4">
                                                                        <label>Targeted Group</label>
                                                                    </div>
                                                                    <div class="col-md-8">
                                                                        <div class="col-md-12">
                                                                            <asp:CheckBoxList ID="chkbxTargetGroup" runat="server" CssClass="checkbox" OnSelectedIndexChanged="chkbxTargetGroup_SelectedIndexChanged" AutoPostBack="true">
                                                                                <asp:ListItem Enabled="false">Asian/Pacific</asp:ListItem>
                                                                                <asp:ListItem Enabled="false">Black</asp:ListItem>
                                                                                <asp:ListItem Enabled="false">Hispanic</asp:ListItem>
                                                                                <asp:ListItem Enabled="false">Indigenous American</asp:ListItem>

                                                                            </asp:CheckBoxList>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row" style="margin-bottom: 5px;" runat="server" id="divIndiginess">
                                                                    <div class="col-md-4">
                                                                    </div>
                                                                    <div class="col-md-8">
                                                                        <div class="col-md-12">
                                                                            <asp:CheckBoxList ID="chkIndiginess" runat="server" CssClass="checkbox" OnSelectedIndexChanged="chkIndiginess_SelectedIndexChanged" AutoPostBack="true">
                                                                                <asp:ListItem Enabled="false">Aluets/Eskimos</asp:ListItem>
                                                                                <asp:ListItem Enabled="false">Native Hawaiians</asp:ListItem>
                                                                                <asp:ListItem Enabled="false">American Indian</asp:ListItem>
                                                                            </asp:CheckBoxList>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row" style="margin-bottom: 5px; display: none;" id="divTribal" runat="server">
                                                                    <div class="col-md-4">
                                                                        <label>Tribal ID</label>
                                                                    </div>
                                                                    <div class="col-md-7">
                                                                        <asp:TextBox ID="txtTribalID" runat="server" CssClass="form-control" MaxLength="16" Text='<%# Eval("tribalID") %>' Style="margin-left: 14px;"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="row" style="margin-bottom: 5px; border-bottom-style: ridge;">
                                                                    <div class="col-md-4">
                                                                    </div>
                                                                    <div class="col-md-8">
                                                                        <div class="col-md-12">
                                                                            <asp:CheckBoxList ID="chkTG1" runat="server" AutoPostBack="true" CssClass="checkbox">
                                                                                <asp:ListItem Enabled="false">Physical Disability</asp:ListItem>
                                                                                <asp:ListItem Enabled="false">Woman</asp:ListItem>
                                                                            </asp:CheckBoxList>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row" style="margin-bottom: 5px; border-bottom-style: ridge;">
                                                                    <div class="col-md-4">
                                                                        <label>Veteran</label>
                                                                    </div>
                                                                    <div class="col-md-8">
                                                                        <div class="col-md-12">
                                                                            <asp:RadioButtonList ID="radVeteran" runat="server" CssClass="radio">
                                                                                <asp:ListItem Enabled="false">Veteran</asp:ListItem>
                                                                                <asp:ListItem Enabled="false">Service Disabled Veteran</asp:ListItem>
                                                                                <asp:ListItem Enabled="false">None</asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                        <br />
                                                        <div class="row" style="margin-bottom: 5px;">
                                                            <div class="col-md-2">
                                                            </div>
                                                            <div class="col-md-8" id="divActive" runat="server" style="text-align: center; border-style: outset;">
                                                                <div class="col-md-12" style="margin: 10px 0px 10px 0px">
                                                                    <asp:CheckBox ID="chkbxActive" runat="server" Text="Active Owner" CssClass="checkbox" />
                                                                </div>
                                                            </div>
                                                            <div class="col-md-2"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <br />
                                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                    <ContentTemplate>
                                                        <asp:HiddenField ID="hdnFlag" runat="server" />
                                                        <div class="row">
                                                            <div class="col-md-3">
                                                                <h5><b>Personal Networth</b></h5>
                                                            </div>
                                                            <div class="col-md-3" style="margin-top: 5px;">
                                                                <asp:LinkButton ID="lnkHistory" runat="server" CommandArgument='<%# Eval("ownerID") %>' OnClick="lnkHistory_Click">History <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></asp:LinkButton>
                                                            </div>
                                                            <div class="col-md-6"></div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <div class="row" style="margin-bottom: 10px;">
                                                                        <div class="col-md-5">
                                                                            <label>Year</label>
                                                                        </div>
                                                                        <div class="col-md-7">
                                                                            <asp:TextBox ID="txtYear" runat="server" CssClass="form-control onlynumber" MaxLength="4"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-md-5">
                                                                            <label>Total Liabilities</label>
                                                                        </div>
                                                                        <div class="col-md-7">
                                                                            <asp:TextBox ID="txtTliabilities" runat="server" CssClass="form-control onlynumber txtTliabilities" Text="0" MaxLength="10" onkeyup="javascript:this.value=Comma(this.value);" AutoPostBack="true" onblur="txtTliabilities(this);" OnTextChanged="txtTliabilities_TextChanged"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="row" style="margin-bottom: 10px;">
                                                                        <div class="col-md-5">
                                                                            <label>Total Current Asset</label>
                                                                        </div>
                                                                        <div class="col-md-7">
                                                                            <asp:TextBox ID="txtCAsset" runat="server" CssClass="form-control onlynumber txtCAsset" MaxLength="10" Text="0" onkeyup="javascript:this.value=Comma(this.value);" AutoPostBack="true" onblur="txtCAsset(this);" OnTextChanged="txtCAsset_TextChanged"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-md-5">
                                                                            <label>Personal Networth</label>
                                                                        </div>
                                                                        <div class="col-md-7">
                                                                            <asp:TextBox ID="txtPNetWorth" runat="server" CssClass="form-control" onkeydown="return false" Text="0" onpaste="return false"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="modal fade" id="myModal<%# Eval("ownerID") %>" role="dialog" data-backdrop="static" data-keyboard="false">
                                                            <div class="modal-dialog modal-lg">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                        <h4 class="modal-title">Personal Networth History</h4>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <asp:GridView ID="grdPNHistory" runat="server" CssClass="grid" AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" Style="width: 100%; text-align: center; margin-bottom: 10px;" EmptyDataRowStyle-BorderColor="White">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="year" HeaderText="Year" HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="currentAsset" HeaderText="Current Asset" HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="totalLiabilities" HeaderText="Total Liabilities" HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="personalNetWorth" HeaderText="Personal Networth" HeaderStyle-HorizontalAlign="Center" />
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
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="panel-group" id="accordionOp">
                                                            <div class="panel panel-default">
                                                                <div class="accordion-heading">
                                                                    <h4 class="panel-title" style="background-color: lightgray;">
                                                                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionOp" href="#collapseOp<%# Eval("ownerID") %>" style="font-style: italic; text-decoration: underline; color: #428bca;">Operational Control</a>
                                                                    </h4>
                                                                </div>
                                                                <div id="collapseOp<%# Eval("ownerID") %>" class="panel-collapse collapse in">
                                                                    <div class="panel-body">
                                                                        <div class="row">
                                                                            <div class="row">
                                                                                <div class="col-md-6">
                                                                                    <div class="col-md-5">
                                                                                        <label>Current Salary</label>
                                                                                    </div>
                                                                                    <div class="col-md-7">
                                                                                        <asp:TextBox ID="txtCSalary" runat="server" CssClass="form-control onlynumber" onkeyup="javascript:this.value=Comma(this.value);" MaxLength="8"></asp:TextBox>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="col-md-8">
                                                                                        <label>Years of Relevant Education</label>
                                                                                    </div>
                                                                                    <div class="col-md-4">
                                                                                        <asp:TextBox ID="txtEducation" runat="server" CssClass="form-control" MaxLength="2" Text='<%# Eval("yearsEdu") %>'></asp:TextBox>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-12">
                                                                                <div class="col-md-12" style="margin-left: -15px;">
                                                                                    <label><b>Current Position</b></label>
                                                                                </div>
                                                                                <asp:UpdatePanel ID="updPnlOPosition" runat="server" UpdateMode="Conditional">
                                                                                    <ContentTemplate>
                                                                                        <div class="col-md-12">
                                                                                            <asp:CheckBox ID="chkbxCEO" runat="server" Text="CEO" CssClass="checkbox-inline" Style="padding-left: 30px;" />
                                                                                            <asp:CheckBox ID="chkbxChairman" runat="server" Text="Chairperson" CssClass="checkbox-inline" />
                                                                                            <asp:CheckBox ID="chkbxPresident" runat="server" Text="President" CssClass="checkbox-inline" />
                                                                                            <asp:CheckBox ID="chkbxVisePresident" runat="server" Text="Vice President" CssClass="checkbox-inline" />
                                                                                            <asp:CheckBox ID="chkbxKeyPersonnel" runat="server" Text="Key Personnel" CssClass="checkbox-inline" />
                                                                                            <asp:CheckBox ID="chkbxPartner" runat="server" Text="Partner" CssClass="checkbox-inline" />
                                                                                            <asp:CheckBox ID="chkbxOther" runat="server" Text="Other" CssClass="checkbox-inline" OnCheckedChanged="chkbxOther_CheckedChanged" AutoPostBack="true" />
                                                                                        </div>
                                                                                        <div id="divOtherPositionIT" runat="server" class="row" style="display: none;">
                                                                                            <div class="col-md-12">
                                                                                                <div class="col-md-3">
                                                                                                    <label style="margin-top: 5px; float: right">Other Position</label>
                                                                                                </div>
                                                                                                <div class="col-md-4">
                                                                                                    <asp:TextBox ID="txtOtherPositionIT" runat="server" CssClass="form-control col-md-4" placeholder="Enter Other Position" Style="margin-bottom: 5px;" Text='<%# Eval("otherPosition") %>' MaxLength="50"></asp:TextBox>
                                                                                                </div>
                                                                                                <div class="col-md-5"></div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </ContentTemplate>
                                                                                </asp:UpdatePanel>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-md-4">
                                                                                    <div class="col-md-12">
                                                                                        <label><b>Years of Experience</b></label>
                                                                                    </div>
                                                                                    <div class="col-md-12">
                                                                                        <asp:RadioButtonList ID="radbutYE" runat="server" CssClass="radio">
                                                                                            <asp:ListItem>0 to 1</asp:ListItem>
                                                                                            <asp:ListItem>1 to 2</asp:ListItem>
                                                                                            <asp:ListItem>2 to 3</asp:ListItem>
                                                                                            <asp:ListItem>3 to 5</asp:ListItem>
                                                                                            <asp:ListItem>5 to 10</asp:ListItem>
                                                                                            <asp:ListItem>10+</asp:ListItem>
                                                                                        </asp:RadioButtonList>
                                                                                    </div>

                                                                                </div>
                                                                                <div class="col-md-4">
                                                                                    <div class="col-md-12">
                                                                                        <label><b>Relevant Experience</b></label>
                                                                                    </div>
                                                                                    <div class="col-md-12">
                                                                                        <asp:CheckBoxList ID="chkbxRE" runat="server" CssClass="checkbox">
                                                                                            <asp:ListItem>Management</asp:ListItem>
                                                                                            <asp:ListItem>Marketing</asp:ListItem>
                                                                                            <asp:ListItem>Operations</asp:ListItem>
                                                                                            <asp:ListItem>Finance</asp:ListItem>
                                                                                            <asp:ListItem>Industry Skills</asp:ListItem>
                                                                                            <asp:ListItem>Industry Exposure</asp:ListItem>
                                                                                        </asp:CheckBoxList>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-4">
                                                                                    <div class="col-md-12">
                                                                                        <label><b>Current Responsibilities</b></label>
                                                                                    </div>
                                                                                    <div class="col-md-12">
                                                                                        <asp:CheckBoxList ID="chkbxCR" runat="server" CssClass="checkbox">
                                                                                            <asp:ListItem>Business Planning</asp:ListItem>
                                                                                            <asp:ListItem>Sales and Marketing</asp:ListItem>
                                                                                            <asp:ListItem>Financial</asp:ListItem>
                                                                                            <asp:ListItem>Personnel</asp:ListItem>
                                                                                            <asp:ListItem>Project Management</asp:ListItem>
                                                                                            <asp:ListItem>Holds Another Job</asp:ListItem>
                                                                                        </asp:CheckBoxList>
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
                                            </div>
                                            <br />
                                            <div class="row" style="text-align: center;">
                                                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CommandArgument='<%# Eval("ownerID") %>' CssClass="btn btn-primary" />
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
                        <div class="panel-group" id="accordion1">
                            <div class="panel panel-default" style="border-style: solid; border-color: deepskyblue;">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#accordion1" href="#collapseOneTwo" style="color: #428bca;">Add New Owner<span class="glyphicon glyphicon-plus" aria-hidden="true" style="padding-left: 5px;"></span></a>
                                    </h4>
                                </div>
                                <div id="collapseOneTwo" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-10">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>Title</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <%-- <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>--%>
                                                                    <asp:DropDownList ID="ddlTitle" runat="server" CssClass="form-control">
                                                                        <asp:ListItem Value=""></asp:ListItem>
                                                                        <asp:ListItem Value="Mr">Mr</asp:ListItem>
                                                                        <asp:ListItem Value="Ms">Ms</asp:ListItem>
                                                                        <asp:ListItem Value="Mrs">Mrs</asp:ListItem>
                                                                        <asp:ListItem Value="Dr">Dr</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>First Name</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox ID="txtFName" runat="server" CssClass="form-control"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>Middle Name</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox ID="txtMName" runat="server" CssClass="form-control"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>Last Name</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox ID="txtLName" runat="server" CssClass="form-control"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>Address</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>City</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4"></div>
                                                                <div class="col-md-8">
                                                                    <div class="col-md-6">
                                                                        <div class="row" style="text-align: center">
                                                                            <label>State</label>
                                                                        </div>
                                                                        <div class="row" style="margin: 0 auto;">
                                                                            <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" Style="width: 100%">
                                                                                <asp:ListItem Value="AL">AL</asp:ListItem>
                                                                                <asp:ListItem Value="AK">AK</asp:ListItem>
                                                                                <asp:ListItem Value="AZ">AZ</asp:ListItem>
                                                                                <asp:ListItem Value="AR">AR</asp:ListItem>
                                                                                <asp:ListItem Value="CA">CA</asp:ListItem>
                                                                                <asp:ListItem Value="CO">CO</asp:ListItem>
                                                                                <asp:ListItem Value="CT">CT</asp:ListItem>
                                                                                <asp:ListItem Value="DC">DC</asp:ListItem>
                                                                                <asp:ListItem Value="DE">DE</asp:ListItem>
                                                                                <asp:ListItem Value="FL">FL</asp:ListItem>
                                                                                <asp:ListItem Value="GA">GA</asp:ListItem>
                                                                                <asp:ListItem Value="HI">HI</asp:ListItem>
                                                                                <asp:ListItem Value="ID">ID</asp:ListItem>
                                                                                <asp:ListItem Value="IL">IL</asp:ListItem>
                                                                                <asp:ListItem Value="IN">IN</asp:ListItem>
                                                                                <asp:ListItem Value="IA">IA</asp:ListItem>
                                                                                <asp:ListItem Value="KS">KS</asp:ListItem>
                                                                                <asp:ListItem Value="KY">KY</asp:ListItem>
                                                                                <asp:ListItem Value="LA">LA</asp:ListItem>
                                                                                <asp:ListItem Value="ME">ME</asp:ListItem>
                                                                                <asp:ListItem Value="MD">MD</asp:ListItem>
                                                                                <asp:ListItem Value="MA">MA</asp:ListItem>
                                                                                <asp:ListItem Value="MI">MI</asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="MN">MN</asp:ListItem>
                                                                                <asp:ListItem Value="MS">MS</asp:ListItem>
                                                                                <asp:ListItem Value="MO">MO</asp:ListItem>
                                                                                <asp:ListItem Value="MT">MT</asp:ListItem>
                                                                                <asp:ListItem Value="NE">NE</asp:ListItem>
                                                                                <asp:ListItem Value="NV">NV</asp:ListItem>
                                                                                <asp:ListItem Value="NH">NH</asp:ListItem>
                                                                                <asp:ListItem Value="NJ">NJ</asp:ListItem>
                                                                                <asp:ListItem Value="NM">NM</asp:ListItem>
                                                                                <asp:ListItem Value="NY">NY</asp:ListItem>
                                                                                <asp:ListItem Value="NC">NC</asp:ListItem>
                                                                                <asp:ListItem Value="ND">ND</asp:ListItem>
                                                                                <asp:ListItem Value="OH">OH</asp:ListItem>
                                                                                <asp:ListItem Value="OK">OK</asp:ListItem>
                                                                                <asp:ListItem Value="OR">OR</asp:ListItem>
                                                                                <asp:ListItem Value="PA">PA</asp:ListItem>
                                                                                <asp:ListItem Value="RI">RI</asp:ListItem>
                                                                                <asp:ListItem Value="SC">SC</asp:ListItem>
                                                                                <asp:ListItem Value="SD">SD</asp:ListItem>
                                                                                <asp:ListItem Value="TN">TN</asp:ListItem>
                                                                                <asp:ListItem Value="TX">TX</asp:ListItem>
                                                                                <asp:ListItem Value="UT">UT</asp:ListItem>
                                                                                <asp:ListItem Value="VT">VT</asp:ListItem>
                                                                                <asp:ListItem Value="VA">VA</asp:ListItem>
                                                                                <asp:ListItem Value="WA">WA</asp:ListItem>
                                                                                <asp:ListItem Value="WV">WV</asp:ListItem>
                                                                                <asp:ListItem Value="WI">WI</asp:ListItem>
                                                                                <asp:ListItem Value="WY">WY</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="row" style="text-align: center">
                                                                            <label>Zip</label>
                                                                        </div>
                                                                        <div class="row">
                                                                            <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" MaxLength="5"></asp:TextBox>

                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4"></div>
                                                                <div class="col-md-4">
                                                                </div>

                                                                <div class="col-md-4">
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>Phone</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control bfh-phone" data-format=" (ddd) ddd-dddd"></asp:TextBox>

                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>Cellphone</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox ID="txtCellPhone" runat="server" CssClass="form-control bfh-phone" data-format=" (ddd) ddd-dddd"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>Other Phone</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox ID="txtOtherPhone" runat="server" CssClass="form-control bfh-phone" data-format=" (ddd) ddd-dddd"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>Signed Shares?</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <div class="col-md-6">
                                                                        <asp:RadioButton ID="radbutSSYes" runat="server" GroupName="ss" CssClass="radio-inline" Text="Yes" />
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <asp:RadioButton ID="radbutSSNo" runat="server" GroupName="ss" Checked="true" CssClass="radio-inline" Text="No" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>Signed Applicn?</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <div class="col-md-6">
                                                                        <asp:RadioButton ID="radbutSAYes" runat="server" GroupName="sa" CssClass="radio-inline" Text="Yes" />
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <asp:RadioButton ID="radbutSANo" runat="server" GroupName="sa" Checked="true" CssClass="radio-inline" Text="No" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>Percent Ownership</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox ID="txtPOwnership" runat="server" CssClass="form-control pownership" Text="0.0" onkeyup="this.value=fnc(this.value)" MaxLength="5"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin-bottom: 5px;">
                                                                <div class="col-md-4">
                                                                    <label>No. of Shares Owned</label>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox ID="txtSharesOwned" runat="server" CssClass="form-control onlynumber" Text="0" MaxLength="8"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                                <ContentTemplate>
                                                                    <div class="row" style="margin-bottom: 5px; border-bottom-style: ridge;">
                                                                        <div class="col-md-4">
                                                                        </div>
                                                                        <div class="col-md-8">
                                                                            <div class="col-md-12">
                                                                                <asp:CheckBox ID="chkCitizenFoot" CssClass="checkbox" runat="server" OnCheckedChanged="chkCitizenFoot_CheckedChanged" AutoPostBack="true" Text="Citizen/Permanent Resident" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row" style="margin-bottom: 5px;">
                                                                        <div class="col-md-4">
                                                                            <label>Target Group</label>
                                                                        </div>
                                                                        <div class="col-md-8">
                                                                            <div class="col-md-12">
                                                                                <asp:CheckBoxList ID="chkbxTargetGroupFoot" runat="server" OnSelectedIndexChanged="chkbxTargetGroupFoot_SelectedIndexChanged1" AutoPostBack="true" CssClass="checkbox">
                                                                                    <asp:ListItem Enabled="false">Asian/Pacific</asp:ListItem>
                                                                                    <asp:ListItem Enabled="false">Black</asp:ListItem>
                                                                                    <asp:ListItem Enabled="false">Hispanic</asp:ListItem>
                                                                                    <asp:ListItem Enabled="false">Indigenous American</asp:ListItem>
                                                                                </asp:CheckBoxList>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row" style="margin-bottom: 5px; display: none;" runat="server" id="divIndiginessFoot">
                                                                        <div class="col-md-4">
                                                                        </div>
                                                                        <div class="col-md-8">
                                                                            <div class="col-md-12">
                                                                                <asp:CheckBoxList ID="chkIndiginessFoot" runat="server" OnSelectedIndexChanged="chkIndiginessFoot_SelectedIndexChanged1" AutoPostBack="true" CssClass="checkbox">
                                                                                    <asp:ListItem Enabled="false">Aluets/Eskimos</asp:ListItem>
                                                                                    <asp:ListItem Enabled="false">Native Hawaiians</asp:ListItem>
                                                                                    <asp:ListItem Enabled="false">American Indian</asp:ListItem>
                                                                                </asp:CheckBoxList>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row" style="margin-bottom: 5px; display: none;" id="divTribalFoot" runat="server">
                                                                        <div class="col-md-4">
                                                                            <label>Tribal ID</label>
                                                                        </div>
                                                                        <div class="col-md-8">
                                                                            <asp:TextBox ID="txtTribalIDFoot" runat="server" CssClass="form-control" MaxLength="16" Text='<%# Eval("tribalID") %>'></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row" style="margin-bottom: 5px; border-bottom-style: ridge;">
                                                                        <div class="col-md-4">
                                                                        </div>
                                                                        <div class="col-md-8">
                                                                            <div class="col-md-12">
                                                                                <asp:CheckBoxList ID="chkTG1Foot" runat="server" AutoPostBack="true" CssClass="checkbox">
                                                                                    <asp:ListItem Enabled="false">Physical Disability</asp:ListItem>
                                                                                    <asp:ListItem Enabled="false">Woman</asp:ListItem>
                                                                                </asp:CheckBoxList>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row" style="margin-bottom: 5px; border-bottom-style: ridge;">
                                                                        <div class="col-md-4">
                                                                            <label>Veterans</label>
                                                                        </div>
                                                                        <div class="col-md-8">
                                                                            <div class="col-md-12">
                                                                                <asp:RadioButtonList ID="radVeteranFoot" runat="server" CssClass="radio">
                                                                                    <asp:ListItem Enabled="false">Veteran</asp:ListItem>
                                                                                    <asp:ListItem Enabled="false">Service Disabled Veteran</asp:ListItem>
                                                                                    <asp:ListItem Enabled="false" Selected="True">None</asp:ListItem>
                                                                                </asp:RadioButtonList>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </div>
                                                    </div>
                                                    <br />
                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                        <ContentTemplate>

                                                            <div class="row">
                                                                <div class="col-md-10">
                                                                    <h5><b>Personal Networth</b></h5>
                                                                </div>
                                                                <div class="col-md-2"></div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-6">
                                                                        <div class="row" style="margin-bottom: 10px;">
                                                                            <div class="col-md-5">
                                                                                <label>Year</label>
                                                                            </div>
                                                                            <div class="col-md-7">
                                                                                <asp:TextBox ID="txtYearFoot" runat="server" CssClass="form-control onlynumber" MaxLength="4"></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-md-5">
                                                                                <label>Total Liabilities</label>
                                                                            </div>
                                                                            <div class="col-md-7">
                                                                                <asp:TextBox ID="txtTliabilitiesFoot" runat="server" CssClass="form-control onlynumber txtTliabilitiesFoot" Text="0" MaxLength="10" onkeyup="javascript:this.value=Comma(this.value);" OnTextChanged="txtTliabilitiesFoot_TextChanged" AutoPostBack="true" onblur="txtTliabilitiesFoot(this);"></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="row" style="margin-bottom: 10px;">
                                                                            <div class="col-md-5">
                                                                                <label>Total Current Asset</label>
                                                                            </div>
                                                                            <div class="col-md-7">
                                                                                <asp:TextBox ID="txtCAssetFoot" runat="server" CssClass="form-control onlynumber txtCAssetFoot" MaxLength="10" Text="0" onkeyup="javascript:this.value=Comma(this.value);" OnTextChanged="txtCAssetFoot_TextChanged" AutoPostBack="true" onblur="txtCAssetFoot(this);"></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-md-5">
                                                                                <label>Personal Networth</label>
                                                                            </div>
                                                                            <div class="col-md-7">
                                                                                <asp:TextBox ID="txtPNetWorthFoot" runat="server" CssClass="form-control" Text="0" onkeydown="return false" onpaste="return false"></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    <br />
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="panel-group" id="accordionOp">
                                                                <div class="panel panel-default">
                                                                    <div class="accordion-heading">
                                                                        <h4 class="panel-title" style="background-color: lightgray;">
                                                                            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionOp" href="#collapseOpfooter" style="font-style: italic; text-decoration: underline; color: #428bca;">Operational Control</a>
                                                                        </h4>
                                                                    </div>
                                                                    <div id="collapseOpfooter" class="panel-collapse collapse in">
                                                                        <div class="panel-body">
                                                                            <div class="row">
                                                                                <div class="row">
                                                                                    <div class="col-md-6">
                                                                                        <div class="col-md-5">
                                                                                            <label>Current Salary</label>
                                                                                        </div>
                                                                                        <div class="col-md-7">
                                                                                            <asp:TextBox ID="txtCSalary" runat="server" CssClass="form-control onlynumber" onkeyup="javascript:this.value=Comma(this.value);"></asp:TextBox>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="col-md-6">
                                                                                        <div class="col-md-8">
                                                                                            <label>Years of Relevant Education</label>
                                                                                        </div>
                                                                                        <div class="col-md-4">
                                                                                            <asp:TextBox ID="txtEducation" runat="server" CssClass="form-control onlynumber" MaxLength="2"></asp:TextBox>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-12">
                                                                                    <div class="col-md-12" style="margin-left: -15px;">
                                                                                        <label><b>Current Position</b></label>
                                                                                    </div>
                                                                                    <asp:UpdatePanel ID="updPnlOPosition" runat="server" UpdateMode="Conditional">
                                                                                        <ContentTemplate>
                                                                                            <div class="col-md-12">
                                                                                                <asp:CheckBox ID="chkCEO" runat="server" Text="CEO" CssClass="checkbox-inline" Style="padding-left: 30px;" />
                                                                                                <asp:CheckBox ID="chkChairman" runat="server" Text="Chairperson" CssClass="checkbox-inline" />
                                                                                                <asp:CheckBox ID="chkPresident" runat="server" Text="President" CssClass="checkbox-inline" />
                                                                                                <asp:CheckBox ID="chkVisePresident" runat="server" Text="Vice President" CssClass="checkbox-inline" />
                                                                                                <asp:CheckBox ID="chkKeyPersonnel" runat="server" Text="Key Personnel" CssClass="checkbox-inline" />
                                                                                                <asp:CheckBox ID="chkPartner" runat="server" Text="Partner" CssClass="checkbox-inline" />
                                                                                                <asp:CheckBox ID="chkOther" runat="server" Text="Other" CssClass="checkbox-inline" OnCheckedChanged="chkOther_CheckedChanged" AutoPostBack="true" />
                                                                                            </div>
                                                                                            <div id="divOtherPosition" runat="server" class="row" style="display: none;">
                                                                                                <div class="col-md-12">
                                                                                                    <div class="col-md-3">
                                                                                                        <label style="margin-top: 5px; float: right">Other Position</label>
                                                                                                    </div>
                                                                                                    <div class="col-md-4">
                                                                                                        <asp:TextBox ID="txtOtherPosition" runat="server" CssClass="form-control col-md-4" placeholder="Enter Other Position" Style="margin-bottom: 5px;"></asp:TextBox>
                                                                                                    </div>
                                                                                                    <div class="col-md-5"></div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </ContentTemplate>
                                                                                    </asp:UpdatePanel>
                                                                                </div>
                                                                                <div class="row">
                                                                                    <div class="col-md-4">
                                                                                        <div class="col-md-12">
                                                                                            <label><b>Years of Experience</b></label>
                                                                                        </div>
                                                                                        <div class="col-md-12">
                                                                                            <asp:RadioButtonList ID="radbutYE" runat="server" CssClass="radio">
                                                                                                <asp:ListItem>0 to 1</asp:ListItem>
                                                                                                <asp:ListItem>1 to 2</asp:ListItem>
                                                                                                <asp:ListItem>2 to 3</asp:ListItem>
                                                                                                <asp:ListItem>3 to 5</asp:ListItem>
                                                                                                <asp:ListItem>5 to 10</asp:ListItem>
                                                                                                <asp:ListItem>10+</asp:ListItem>
                                                                                            </asp:RadioButtonList>
                                                                                        </div>

                                                                                    </div>
                                                                                    <div class="col-md-4">
                                                                                        <div class="col-md-12">
                                                                                            <label><b>Relevant Experience</b></label>
                                                                                        </div>
                                                                                        <div class="col-md-12">
                                                                                            <asp:CheckBoxList ID="chkbxRE" runat="server" CssClass="checkbox">
                                                                                                <asp:ListItem>Management</asp:ListItem>
                                                                                                <asp:ListItem>Marketing</asp:ListItem>
                                                                                                <asp:ListItem>Operations</asp:ListItem>
                                                                                                <asp:ListItem>Finance</asp:ListItem>
                                                                                                <asp:ListItem>Industry Skills</asp:ListItem>
                                                                                                <asp:ListItem>Industry Exposure</asp:ListItem>
                                                                                            </asp:CheckBoxList>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="col-md-4">
                                                                                        <div class="col-md-12">
                                                                                            <label><b>Current Responsibilities</b></label>
                                                                                        </div>
                                                                                        <div class="col-md-12">
                                                                                            <asp:CheckBoxList ID="chkbxCR" runat="server" CssClass="checkbox">
                                                                                                <asp:ListItem>Business Planning</asp:ListItem>
                                                                                                <asp:ListItem>Sales and Marketing</asp:ListItem>
                                                                                                <asp:ListItem>Financial</asp:ListItem>
                                                                                                <asp:ListItem>Personnel</asp:ListItem>
                                                                                                <asp:ListItem>Project Management</asp:ListItem>
                                                                                                <asp:ListItem>Holds Another Job</asp:ListItem>
                                                                                            </asp:CheckBoxList>
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
                                                </div>
                                                <br />
                                                <div class="row" style="text-align: center;">
                                                    <asp:Button ID="btnSave" runat="server" Text="Add" OnClick="btnSave_Click" CssClass="btn btn-primary" />
                                                </div>
                                            </div>
                                            <div class="col-md-1"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
            <div class="col-md-1"></div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-8">
                        <div class="col-md-6" style="text-align: center">
                            <asp:Button ID="btnBack" runat="server" Text="Back to Actions" CssClass="btn btn-primary" ValidationGroup="vd" OnClick="btnBack_Click" />
                        </div>
                        <div class="col-md-6" style="text-align: center">
                            <asp:Button ID="btnProceed" runat="server" Text="Add & Proceed" CssClass="col-md-12 btn btn-primary" ValidationGroup="vd" OnClick="btnProceed_Click" />
                        </div>
                    </div>
                    <div class="col-md-2"></div>
                </div>
            </div>
            <div class="col-md-3">
            </div>
        </div>
        <br />
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

    <script src="../js/bootstrap-formhelpers-phone.js"></script>

    <script>
        $(document).ready(function () {
            $("#navbar7 li").removeClass("active");//this will remove the active class from  
            $('#menu').addClass('active');

        });
    </script>
    <script type="text/javascript">
        function pageLoad(sender, args) {
            $('.pownership').keydown(function (e) {
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

            $('.onlynumber').keydown(function (e) {
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
          <%--  
                 $(".txtTliabilities").blur(function () {
                     //   alert("This input field has lost its focus.");
                     __doPostBack("<%= txtTliabilities.ClientID %>", "TextChanged");
            });
            
           
                $(".txtCAsset").blur(function () {
                    // alert("This input field has lost its focus.");
                    __doPostBack("<%= txtCAsset.ClientID %>", "TextChanged");
                });
            
            $(".txtTliabilitiesFoot").blur(function () {
                //   alert("This input field has lost its focus.");
                __doPostBack("<%= txtTliabilitiesFoot.ClientID %>", "TextChanged");
            });
            $(".txtCAssetFoot").blur(function () {
                //  alert("This input field has lost its focus.");
                __doPostBack("<%= txtCAssetFoot.ClientID %>", "TextChanged");
            });--%>
        }
    </script>
    <script type="text/javascript">
        function runEffect1() {
            $("#<%=myMessage.ClientID%>").show();
            setTimeout(function () {
                var selectedEffect = 'blind';
                var options = {};
                $("#<%=myMessage.ClientID%>").hide();
            }, 5000);
            return false;
        }
    </script>
    <script>
        function fnc(value) {
            //if (parseInt(value) < 0 || isNaN(value))
            //    return 0;
            //else
            if (parseInt(value) > 100) {
                alert("Number is greater than 100");
                return 100;
            }
            else return value;
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
        function showModal(id) {
            jQuery.noConflict();
            $("#myModal" + id).modal('show');
        }
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
    </script>
    <script>
        function txtTliabilities(element) {
            var elementId = $(element).attr('id');
            __doPostBack(elementId, "TextChanged");
            // alert(elementId);
        }
        function txtCAsset(element) {
            var elementId = $(element).attr('id');
            __doPostBack(elementId, "TextChanged");
            //  alert(elementId);
        }
        function txtTliabilitiesFoot(element) {
            var elementId = $(element).attr('id');
            __doPostBack(elementId, "TextChanged");
            // alert(elementId);
        }
        function txtCAssetFoot(element) {
            var elementId = $(element).attr('id');
            __doPostBack(elementId, "TextChanged");
            //  alert(elementId);
        }
    </script>
</asp:Content>
