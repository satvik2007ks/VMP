﻿<%@ Page Title="" Language="C#" MasterPageFile="~/User/vmpUsrMaster.Master" AutoEventWireup="true" CodeBehind="vmpUsrVendor3a.aspx.cs" Inherits="VMP_1._0.User.vmpUsrVendor3a" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Content/jquery-ui.css" rel="stylesheet" />
    <script src="../js/jquery-ui.js"></script>

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hdnFourthPageComplete" runat="server" Value="False" />
    <asp:HiddenField ID="hdnOwner" runat="server" />
    <div class="container" style="background-color: gainsboro; border-radius: 6px;">
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
                <label>Owner Details</label>
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <label style="text-decoration: underline;"><b>Secondary Firms</b></label>
            </div>
            <div class="col-md-4"></div>
        </div>
        <asp:UpdatePanel ID="updpnlPriOwner" runat="server">
            <ContentTemplate>
                <div class="row" id="divPOwner" runat="server" cssclass="col-md-12">
                    <div class="col-md-1"></div>
                    <div id="divselectowner" runat="server" class="col-md-10 alert alert-danger">
                        <div class="col-md-2"></div>
                        <div class="col-md-7">
                            <div class="col-md-4" style="margin-top: 5px;">
                                <label>Select Primary Owner</label>
                            </div>
                            <div class="col-md-8">
                                <asp:DropDownList ID="ddlPOwner" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlPOwner_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <h6 runat="server" id="h6alert" style="color: red;">Ownership % Conflict</h6>
                        </div>
                    </div>
                    <div class="col-md-1"></div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <h4 class="customheading">Primary Owner</h4>
                    </div>
                    <div class="col-md-3"></div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-8">
                        <div class="col-md-1"></div>
                        <div class="col-md-5">
                            <div class="row">
                                <div class="col-md-4">
                                    <label><b>First Name</b></label>
                                </div>
                                <div class="col-md-8" style="border-style: outset; height: 26px;">
                                    <asp:Label ID="lblFName" runat="server" Style="margin-bottom: 5px" Text="Sample"></asp:Label>
                                    <%--<asp:TextBox ID="txtFName" runat="server" CssClass="form-control" style="margin-bottom:5px"></asp:TextBox>--%>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-md-4">
                                    <label><b>Last Name</b></label>
                                </div>
                                <div class="col-md-8" style="border-style: outset; height: 26px;">
                                    <asp:Label ID="lblLName" runat="server" Style="margin-bottom: 5px" Text="Sample"></asp:Label>
                                    <%--<asp:TextBox ID="txtLName" runat="server" CssClass="form-control" style="margin-bottom:5px;"></asp:TextBox>--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="row">
                                <div class="col-md-6">
                                    <label><b>Middle Name</b></label>
                                </div>
                                <div class="col-md-6" style="border-style: outset; height: 26px;">
                                    <asp:Label ID="lblMName" runat="server" Style="margin-bottom: 5px" Text="Sample"></asp:Label>
                                    <%--<asp:TextBox ID="txtMName" runat="server" CssClass="form-control" style="margin-bottom:5px"></asp:TextBox>--%>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-md-6">
                                    <label><b>Percent Ownership</b></label>
                                </div>
                                <div class="col-md-6" style="border-style: outset; height: 26px;">
                                    <asp:Label ID="lblPOwnership" runat="server" Style="margin-bottom: 5px" Text="Sample"></asp:Label>
                                    <%--<asp:TextBox ID="txtPOwnership" runat="server" CssClass="form-control" style="margin-bottom:5px"></asp:TextBox>--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="col-md-2"></div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h4 class="customheading">Secondary Firms</h4>
            </div>
            <div class="col-md-3"></div>
        </div>
        <hr />
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <div style="display: none; text-align: center" id="myMessage" runat="server" class="alert alert-success col-sm-12">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <asp:Label ID="lblError" runat="server" Text="Secondary Firm Infromation Updated Successfully"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <asp:UpdatePanel ID="updpnlSecOwners" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Repeater ID="rptSecOwners" runat="server" OnItemDataBound="rptSecOwners_ItemDataBound">
                            <HeaderTemplate>
                                <div class="panel-group" id="accordion">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:HiddenField ID="hdnOwnerID" runat="server" Value='<%# Eval("ownerID") %>' />
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%# Container.ItemIndex %>">
                                            <h4 class="panel-title"><%# Eval("ownerFirstName")+" "+Eval("ownerMidName")+" "+Eval("ownerLastName") %><%#(!(bool)Eval("isActive"))?" <label style=\"color:red;\"> (Inactive)</label>":"" %></h4>
                                            <%--+" "+Eval("ownerMidName")==null ? "":Eval("ownerMidName")--%>
                                        </a>
                                    </div>
                                    <div id="collapse<%# Container.ItemIndex %>" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-md-1"></div>
                                                <div class="col-md-10">
                                                    <asp:Repeater ID="rptSecFirms" runat="server" OnItemDataBound="rptSecFirms_ItemDataBound">
                                                        <HeaderTemplate>
                                                            <div class="panel-group" id="accordionSec">
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <div class="panel panel-default">
                                                                <div class="panel-heading">
                                                                    <a data-toggle="collapse" data-parent="#accordionSec" href="#collapseSec<%# ((RepeaterItem)Container.Parent.Parent).ItemIndex %><%# Container.ItemIndex %>">
                                                                        <h4 class="panel-title"><%# Eval("firmName") %><%#(!(bool)Eval("isActive"))?" <label style=\"color:red;\"> (Inactive)</label>":"" %></h4>
                                                                    </a>
                                                                </div>
                                                                <div id="collapseSec<%# ((RepeaterItem)Container.Parent.Parent).ItemIndex %><%# Container.ItemIndex %>" class="panel-collapse collapse">
                                                                    <div class="panel-body">
                                                                        <asp:HiddenField ID="hdnSecFirmId" runat="server" Value='<%# Eval("secFirmId") %>' />
                                                                        <div class="row">
                                                                            <div class="col-md-1"></div>
                                                                            <div class="col-md-6">
                                                                                <div class="row">
                                                                                    <div class="col-md-5">
                                                                                        <label>Firm</label>
                                                                                    </div>
                                                                                    <div class="col-md-7">
                                                                                        <asp:TextBox ID="txtFirm" runat="server" CssClass="form-control" Style="margin-bottom: 10px;" Text='<%# Eval("firmName") %>'></asp:TextBox>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row">
                                                                                    <div class="col-md-5">
                                                                                        <label>Address</label>
                                                                                    </div>
                                                                                    <div class="col-md-7">
                                                                                        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" CssClass="form-control" Style="margin-bottom: 10px;" Text='<%# Eval("address") %>'></asp:TextBox>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row">
                                                                                    <div class="col-md-5">
                                                                                        <label>City</label>
                                                                                    </div>
                                                                                    <div class="col-md-7">
                                                                                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" Style="margin-bottom: 10px;" Text='<%# Eval("city") %>'></asp:TextBox>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row">
                                                                                    <div class="col-md-5">
                                                                                        <label>State</label>
                                                                                    </div>
                                                                                    <div class="col-md-7">
                                                                                        <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" Style="margin-bottom: 10px">
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
                                                                                <div class="row">
                                                                                    <div class="col-md-5">
                                                                                        <label>Gross Revenue</label>
                                                                                    </div>
                                                                                    <div class="col-md-7">
                                                                                        <asp:TextBox ID="txtGross" runat="server" CssClass="form-control" onkeyup="javascript:this.value=Comma(this.value);" Style="margin-bottom: 10px;" Text='<%# String.Format("{0:n0}", Eval("grossRevenue")) %>'></asp:TextBox>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-5">
                                                                                <div class="row">
                                                                                    <div class="col-md-10">
                                                                                        <div class="col-md-12">
                                                                                            <label>Percentage Ownership</label>
                                                                                        </div>
                                                                                        <div class="col-md-12">
                                                                                            <asp:TextBox ID="txtPOwnership" runat="server" CssClass="form-control pownership" Style="margin-bottom: 10px;" Text='<%# Eval("ownershipPercentage") %>' MaxLength="5" onkeyup="this.value=fnc(this.value)"></asp:TextBox>

                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="col-md-2">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row">
                                                                                    <div class="col-md-10">
                                                                                        <div class="col-md-12">
                                                                                            <h5><b>Primary NAIC Code</b></h5>
                                                                                        </div>
                                                                                        <div class="col-md-12">
                                                                                            <asp:DropDownList ID="ddlPNAIC" runat="server" CssClass="form-control">
                                                                                            </asp:DropDownList>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="col-md-2">
                                                                                    </div>
                                                                                </div>
                                                                                <br />
                                                                                <div class="row">
                                                                                    <div class="col-md-10">
                                                                                        <div class="col-md-12">
                                                                                            <h5><b>Similar Business?</b></h5>
                                                                                        </div>
                                                                                        <div class="col-md-12">
                                                                                            <asp:RadioButtonList ID="radbutBusiness" runat="server" CssClass="radio">
                                                                                                <asp:ListItem>Yes</asp:ListItem>
                                                                                                <asp:ListItem Selected="True">No</asp:ListItem>
                                                                                            </asp:RadioButtonList>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="col-md-2">
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <%-- <div class="col-md-1"></div>--%>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-md-1"></div>
                                                                            <div class="col-md-10">
                                                                                <div class="col-md-12">
                                                                                    <h5><b>Principal Products and Services</b></h5>
                                                                                </div>
                                                                                <div class="col-md-12">
                                                                                    <asp:TextBox ID="txtPS" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="3" Text='<%# Eval("productService") %>' MaxLength="8000"></asp:TextBox>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-1"></div>
                                                                        </div>
                                                                        <br />
                                                                        <div class="row" style="margin-bottom: 5px;">
                                                                            <div class="col-md-4">
                                                                            </div>
                                                                            <div class="col-md-4" id="divActive" runat="server" style="text-align: center; border-style: outset;">
                                                                                <div class="col-md-8" style="margin: 10px 0px 10px 30px;">
                                                                                    <asp:CheckBox ID="chkbxActive" runat="server" Text="Active Firm" CssClass="checkbox" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-4"></div>
                                                                        </div>
                                                                        <br />
                                                                        <div class="row">
                                                                            <div class="col-md-4"></div>
                                                                            <div class="col-md-4" style="text-align: center">
                                                                                <asp:Button ID="btnUpdateSFirm" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdateSFirm_Click" CommandArgument='<%# Eval("secFirmId") %>' />
                                                                            </div>
                                                                            <div class="col-md-4"></div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </div>
                                                    <div class="panel-group" id="accordionSecFooter">
                                                        <div class="panel panel-default">
                                                            <div class="panel-heading">
                                                                <h4 class="panel-title">
                                                                    <a data-toggle="collapse" data-parent="#accordionSecFooter" href="#collapseSecFooter<%# ((RepeaterItem)Container.Parent.Parent).ItemIndex %>" style="color: #428bca;">Add Secondary Firms<span class="glyphicon glyphicon-plus" aria-hidden="true" style="padding-left: 5px;"></span></a>
                                                                </h4>
                                                            </div>
                                                            <div id="collapseSecFooter<%# ((RepeaterItem)Container.Parent.Parent).ItemIndex %>" class="panel-collapse collapse">
                                                                <div class="panel-body">
                                                                    <div class="row">
                                                                        <div class="col-md-1"></div>
                                                                        <div class="col-md-6">
                                                                            <div class="row">
                                                                                <div class="col-md-5">
                                                                                    <label>Firm</label>
                                                                                </div>
                                                                                <div class="col-md-7">
                                                                                    <asp:TextBox ID="txtFirm" runat="server" CssClass="form-control" Style="margin-bottom: 10px;"></asp:TextBox>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-md-5">
                                                                                    <label>Address</label>
                                                                                </div>
                                                                                <div class="col-md-7">
                                                                                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" CssClass="form-control" Style="margin-bottom: 10px;"></asp:TextBox>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-md-5">
                                                                                    <label>City</label>
                                                                                </div>
                                                                                <div class="col-md-7">
                                                                                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" Style="margin-bottom: 10px;"></asp:TextBox>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-md-5">
                                                                                    <label>State</label>
                                                                                </div>
                                                                                <div class="col-md-7">
                                                                                    <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" Style="margin-bottom: 10px">
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
                                                                            <div class="row">
                                                                                <div class="col-md-5">
                                                                                    <label>Gross Revenue</label>
                                                                                </div>
                                                                                <div class="col-md-7">
                                                                                    <asp:TextBox ID="txtGross" runat="server" onkeyup="javascript:this.value=Comma(this.value);" CssClass="form-control" Style="margin-bottom: 10px;"></asp:TextBox>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-5">
                                                                            <div class="row">
                                                                                <div class="col-md-10">
                                                                                    <div class="col-md-12">
                                                                                        <label>Percentage Ownership</label>
                                                                                    </div>
                                                                                    <div class="col-md-12">
                                                                                        <asp:TextBox ID="txtPOwnership" runat="server" CssClass="form-control pownership" Style="margin-bottom: 10px;" MaxLength="5" onkeyup="this.value=fnc(this.value)"></asp:TextBox>

                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-2">
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-md-10">
                                                                                    <div class="col-md-12">
                                                                                        <h5><b>Primary NAIC Code</b></h5>
                                                                                    </div>
                                                                                    <div class="col-md-12">
                                                                                        <asp:DropDownList ID="ddlPNAIC" runat="server" CssClass="form-control" OnDataBound="ddlPNAIC_DataBound">
                                                                                        </asp:DropDownList>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-2">
                                                                                </div>
                                                                            </div>
                                                                            <br />
                                                                            <div class="row">
                                                                                <div class="col-md-10">
                                                                                    <div class="col-md-12">
                                                                                        <h5><b>Similar Business?</b></h5>
                                                                                    </div>
                                                                                    <div class="col-md-12">
                                                                                        <asp:RadioButtonList ID="radbutBusiness" runat="server">
                                                                                            <asp:ListItem>Yes</asp:ListItem>
                                                                                            <asp:ListItem Selected="True">No</asp:ListItem>
                                                                                        </asp:RadioButtonList>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-2">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <%-- <div class="col-md-1"></div>--%>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-md-1"></div>
                                                                        <div class="col-md-10">
                                                                            <div class="col-md-12">
                                                                                <h5><b>Principal Products and Services</b></h5>
                                                                            </div>
                                                                            <div class="col-md-12">
                                                                                <asp:TextBox ID="txtPS" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="3"></asp:TextBox>
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-1"></div>
                                                                    </div>
                                                                    <br />
                                                                    <div class="row">
                                                                        <div class="col-md-4"></div>
                                                                        <div class="col-md-4" style="text-align: center">
                                                                            <asp:Button ID="btnSaveSFirm" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSaveSFirm_Click" CommandArgument='<%# DataBinder.Eval(((RepeaterItem)Container.Parent.Parent).DataItem, "ownerID")%>' />
                                                                        </div>
                                                                        <div class="col-md-4"></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                        </FooterTemplate>
                                                    </asp:Repeater>
                                                    <div class="col-md-1"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                </div>
                                <div style="text-align: center;">
                                    <asp:Label ID="lblEmptyData" runat="server" Visible='<%# ((Repeater)Container.NamingContainer).Items.Count == 0 %>' Text="No Owners Found" Style="color: red; font-weight: bold;" />
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="col-md-1"></div>

        </div>
        <br />
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-8">
                        <div class="col-md-1"></div>
                        <div class="col-md-5" style="text-align: center">
                            <asp:Button ID="btnBack" runat="server" Text="Back to Owner Details" CssClass="btn btn-primary" ValidationGroup="vd" OnClick="btnBack_Click" Style="margin-bottom: 5px;" />
                        </div>
                        <div class="col-md-5" style="text-align: center">
                            <asp:Button ID="btnProceed" runat="server" Text="Save & Proceed" CssClass="col-md-12 btn btn-primary" ValidationGroup="vd" OnClick="btnProceed_Click" />
                        </div>
                    </div>
                    <div class="col-md-1"></div>
                </div>
            </div>
            <div class="col-md-2">
            </div>
        </div>
        <br />
        <div class="row" runat="server" id="divExecute">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-8">
                        <div class="col-md-3" style="text-align: center">
                        </div>
                        <div class="col-md-6" style="text-align: center">
                            <asp:Button ID="btnExecuteRules" runat="server" Text="Save & Execute Rules" CssClass="col-md-12 btn btn-primary" ValidationGroup="vd" OnClick="btnExecuteRules_Click" />
                        </div>
                        <div class="col-md-3" style="text-align: center">
                        </div>
                    </div>
                    <div class="col-md-2"></div>
                </div>
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
                            <asp:Button ID="btnUploadAttachment" runat="server" Text="Upload" CssClass="btn btn-primary" OnClick="btnUploadAttachment_Click" ValidationGroup="fileupload" />
                        </div>
                    </div>
                    <div class="row" style="text-align: center">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Style="color: red;" ErrorMessage="Please Select File To Upload !!" ControlToValidate="FileUploadAttachment" ValidationGroup="fileupload"></asp:RequiredFieldValidator>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <script src="../js/jquery.mask.js"></script>
    <script>
        $(document).ready(function () {
            $("#navbar7 li").removeClass("active");//this will remove the active class from  
            $('#menu').addClass('active');


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


        });
    </script>
    <script type="text/javascript">
        function showModalAttachments() {
               jQuery.noConflict();
            $("#myModalAttachments").modal('show');
        }
        function runEffect1() {
            $("#<%=myMessage.ClientID%>").show();
            setTimeout(function () {
                var selectedEffect = 'blind';
                var options = {};
                $("#<%=myMessage.ClientID%>").hide();
            }, 5000);
            return false;
        }
        function runEffect2() {
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
</asp:Content>