﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/vmpAdmMaster.Master" AutoEventWireup="true" CodeBehind="vmpAdmRules.aspx.cs" Inherits="VMP_1._0.Admin.vmpAdmRules" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(document).ready(function () {
            $("#navbar7 li").removeClass("active");//this will remove the active class from  
            //previously active menu item 
            $('#menu').addClass('active');
        });
    </script>
    <style>
        label {
            font-weight: normal;
            margin-top: 8px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <asp:Label ID="lblSave" runat="server" Text="Rule Added Successfully"></asp:Label>
        </div>
        <div style="display: none; text-align: center" id="myMessage2" runat="server" class="alert alert-success col-sm-12">
            <asp:Label ID="lblCSave" runat="server" Text="Combine Rule Added Successfully"></asp:Label>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <ul class="nav nav-tabs">
                    <li role="presentation" id="liAddRules" runat="server" class="active">
                        <asp:LinkButton ID="lnkbtnAddRules" runat="server" OnClick="lnkbtnAddRules_Click">Add Rules</asp:LinkButton></li>
                    <li role="presentation" id="liCombinedRules" runat="server">
                        <asp:LinkButton ID="lnkbtnCombinedRules" runat="server" OnClick="lnkbtnCombinedRules_Click">Combine Rules</asp:LinkButton></li>
                    <li role="presentation" id="liViewRules" runat="server">
                        <asp:LinkButton ID="lnkbtnViewRules" runat="server" OnClick="lnkbtnViewRules_Click">View Rules</asp:LinkButton></li>
                </ul>
            </div>
            <div class="col-md-4"></div>
        </div>
    </div>
    <asp:MultiView ID="MultiViewRules" runat="server">
        <asp:View ID="ViewAddRules" runat="server">
            <div class="container" style="background-color: gainsboro; border-radius: 10px; margin-top: 20px;">
                <div class="row">
                    <div class="col-md-4"></div>
                    <div class="col-md-4" style="text-align: center">
                        <h4>Add New Rule</h4>
                    </div>
                    <div class="col-md-4"></div>
                </div>
                <div class="row" style="margin-top: 10px;">
                    <div class="col-md-12">
                        <div class="col-md-3"></div>
                        <div class="col-md-2">
                            <label><b>Rule Name</b></label>
                        </div>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtRuleName" runat="server" CssClass="form-control" Placeholder="Enter Rule Name" MaxLength="50" ValidationGroup="vd"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Rule Name empty" Style="color: red; margin-left: 15px;" ControlToValidate="txtRuleName" ValidationGroup="vd"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <asp:UpdatePanel ID="updRule" runat="server">
                    <ContentTemplate>
                        <div class="row" style="margin-top: 10px;">
                            <div class="col-md-12">
                                <div class="col-md-3"></div>
                                <div class="col-md-2">
                                    <label><b>Select Table</b></label>
                                </div>
                                <div class="col-md-3">
                                    <asp:DropDownList ID="ddlTable" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlTable_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Value="VendorDetails">VendorDetails</asp:ListItem>
                                        <asp:ListItem Value="BusinessStructure">BusinessStructure</asp:ListItem>
                                        <asp:ListItem Value="Firms">Firms</asp:ListItem>
                                        <asp:ListItem Value="Owners">Owners</asp:ListItem>
                                        <asp:ListItem Value="SecondaryFirms">SecondaryFirms</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px;">
                            <div class="col-md-12">
                                <div class="col-md-3"></div>
                                <div class="col-md-2">
                                    <label><b>Select Column</b></label>
                                </div>
                                <div class="col-md-3">
                                    <asp:DropDownList ID="ddlColumn" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlColumn_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px;">
                            <div class="col-md-12">
                                <div class="col-md-3"></div>
                                <div class="col-md-2">
                                    <label><b>Select Condition</b></label>
                                </div>
                                <div class="col-md-3">
                                    <asp:DropDownList ID="ddlCondition" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="=">Equal</asp:ListItem>
                                        <asp:ListItem Value="<">Less Than</asp:ListItem>
                                        <asp:ListItem Value=">">Greater Than</asp:ListItem>
                                        <asp:ListItem Value="<=">Less Than or Equal To</asp:ListItem>
                                        <asp:ListItem Value=">=">Greater Than or Equal To</asp:ListItem>
                                        <asp:ListItem Value="!=">Not Equal To</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px;" id="divValue" runat="server">
                            <div class="col-md-12">
                                <div class="col-md-3"></div>
                                <div class="col-md-2">
                                    <label><b>Value</b></label>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtValue" runat="server" CssClass="form-control" Placeholder="Enter Value" MaxLength="100"></asp:TextBox>
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px; display: none;" id="divBit" runat="server">
                            <div class="col-md-12">
                                <div class="col-md-3"></div>
                                <div class="col-md-2">
                                    <label><b>Value</b></label>
                                </div>
                                <div class="col-md-3">
                                    <asp:DropDownList ID="ddlConditionValue" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="1">True</asp:ListItem>
                                        <asp:ListItem Value="0">False</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="row" style="margin-top: 10px;">
                    <div class="col-md-12">
                        <div class="col-md-3"></div>
                        <div class="col-md-2">
                            <label><b>Select Status</b></label>
                        </div>
                        <div class="col-md-3">
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Value="-1">--Select Status--</asp:ListItem>
                                <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                <asp:ListItem Value="Deny">Deny</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4" style="text-align: right;">
                            <label style="border: solid 1px; color: coral">Note*: Applicable for Individual Rule when condition fails</label>
                        </div>
                    </div>
                </div>
                <div id="divIndRules" runat="server" style="display: none">
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-12">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label><b>Type</b></label>
                            </div>
                            <div class="col-md-2">
                                <asp:CheckBox ID="chkTarget" runat="server" Text="Target Group" />
                            </div>
                            <div class="col-md-2">
                                <asp:CheckBox ID="chkVeteran" runat="server" Text="Veteran" />
                            </div>
                            <div class="col-md-3">
                                <asp:CheckBox ID="chkEDR" runat="server" Text="Economically Disadvantaged Region" />
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-12">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label><b>Description</b></label>
                            </div>
                            <div class="col-md-3">
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
                            </div>
                            <div class="col-md-4"></div>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 15px">
                    <div class="col-md-4"></div>
                    <div class="col-md-4" style="text-align: center;">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" ValidationGroup="vd" OnClick="btnSave_Click" />
                    </div>
                    <div class="col-md-4"></div>
                </div>
            </div>
        </asp:View>
        <asp:View ID="ViewCombinedRules" runat="server">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnCSave" />
                </Triggers>
                <ContentTemplate>
                    <div class="container" style="background-color: gainsboro; border-radius: 10px; margin-top: 20px;">
                        <div class="row">
                            <div class="col-md-6" style="text-align: center; border-right: 1px ridge;">
                                <h4>Rules</h4>
                            </div>
                            <div class="col-md-6" style="text-align: center">
                                <h4>Combine Rules</h4>
                            </div>
                        </div>
                        <div class="row" style="border-bottom: 1px solid; border-bottom-color: white;"></div>
                        <div class="row" style="margin-top: 20px;">
                            <div class="col-md-6" style="border-right: 1px ridge;">
                                <asp:Repeater ID="rptRules" runat="server">
                                    <ItemTemplate>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <asp:CheckBox ID="chkRule" runat="server" CssClass="checkbox" Text='<%# Eval("ruleName")%>' OnCheckedChanged="chkRule_CheckedChanged" AutoPostBack="true" />
                                                <asp:HiddenField ID="hdnRuleId" runat="server" Value='<%# Eval("ruleID")%>' />
                                            </div>
                                            <div class="col-md-5" style="margin-top: 10px;">
                                                <asp:Label ID="lblCondition" runat="server" Text='<%# Eval("Rule")%>'></asp:Label>
                                            </div>
                                            <div class="col-md-3" style="margin-top: 10px; display: none;" id="divRuleOrder" runat="server">
                                                <asp:TextBox ID="txtOrder" runat="server" CssClass="form-control" placeholder="Fire Order"></asp:TextBox>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-2">
                                        <label>Rule Name</label>
                                    </div>
                                    <div class="col-md-7">
                                        <asp:TextBox ID="txtCRuleName" runat="server" CssClass="form-control" ValidationGroup="cvd"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3" id="divCRuleName" runat="server" style="display: none;"></div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <label>Type of Join</label>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:RadioButton ID="radbtnAnd" runat="server" CssClass="radio" Text="And" GroupName="join" Checked="true"></asp:RadioButton>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:RadioButton ID="radbtnOr" runat="server" CssClass="radio" Text="Or" GroupName="join"></asp:RadioButton>
                                    </div>
                                    <div class="col-md-4"></div>
                                </div>
                                <div class="row">
                                    <div class="col-md-2">
                                        <label>Status</label>
                                    </div>
                                    <div class="col-md-7">
                                        <asp:DropDownList ID="ddlCStatus" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCStatus_SelectedIndexChanged">
                                            <asp:ListItem Value="-1">--Select Status--</asp:ListItem>
                                            <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                            <asp:ListItem Value="Deny">Deny</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3" id="divErrStatus" runat="server" style="display: none;"></div>
                                </div>
                                <div class="row">
                                    <div class="col-md-2">
                                        <label>Type</label>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:CheckBox ID="chkCTG" runat="server" Text="Target Group" />
                                    </div>
                                    <div class="col-md-2">
                                        <asp:CheckBox ID="chkCVeteran" runat="server" Text="Veteran" />
                                    </div>
                                    <div class="col-md-4">
                                        <asp:CheckBox ID="chkCEDR" runat="server" Text="EDR" />
                                    </div>
                                    <div class="col-md-1"></div>
                                </div>
                                <div class="row">
                                    <div class="col-md-2">
                                        <label>Description</label>
                                    </div>
                                    <div class="col-md-7">
                                        <asp:TextBox ID="txtCDescription" runat="server" CssClass="form-control" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3" id="divCRuleDesc" runat="server" style="display: none;"></div>
                                </div>
                                <div class="row" style="text-align: center; margin-top: 10px; margin-bottom: 10px;">
                                    <asp:Label ID="lblCRuleValidate" Style="color: red;" runat="server" />
                                </div>
                                <div class="row" style="text-align: center; margin-top: 10px; margin-bottom: 10px;">
                                    <asp:Button ID="btnCSave" runat="server" CssClass="btn btn-primary" Text="Save" Visible="false" ValidationGroup="cvd" OnClick="btnCSave_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <br />
        </asp:View>
        <asp:View ID="ViewRules" runat="server">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="container" style="background-color: gainsboro; border-radius: 10px; margin-top: 20px;">
                        <div class="row" style="margin-top:20px;margin-left:20px;margin-right:20px">
                            <div class="panel-group" id="accordion1">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <a data-toggle="collapse" data-parent="#accordion1" href="#collapse1">
                                            <h4 class="panel-title">Hardcoded Rules</h4>
                                        </a>
                                    </div>
                                    <div id="collapse1" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <asp:Repeater ID="rptHardcoded" runat="server">
                                                <HeaderTemplate>
                                                    <div class="row">
                                                        <div class="col-md-3" style="text-align:center;">
                                                            <label ><b>Rule Name</b></label>
                                                        </div>
                                                        <div class="col-md-5" style="text-align:center;">
                                                            <label><b>Rule Description</b></label>
                                                        </div>
                                                        <div class="col-md-2" style="text-align:center;" >
                                                            <label style="color: grey; font-size: 12px;">(Check/uncheck to make the rule Active/Inactive)</label>
                                                        </div>
                                                        <div class="col-md-2"></div>
                                                    </div>
                                                    <hr />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <div class="row">
                                                        <div class="col-md-3">
                                                            <asp:TextBox ID="txtHRuleName" runat="server" CssClass="form-control" Text='<%# Eval("ruleName") %>'></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <asp:TextBox ID="txtHDescription" runat="server" Rows="4"  TextMode="MultiLine" MaxLength="500" CssClass="form-control" Text='<%# Eval("description") %>'></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-2" style="text-align: center;">
                                                            <asp:CheckBox ID="chkHActive" runat="server" Text="Active" Checked='<%# Bind("isActive") %>'/>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <asp:Button ID="btnHUpdate" runat="server" CssClass="btn btn-primary" Text="Update" CommandArgument='<%# Eval("ruleID") %>' OnClick="btnHUpdate_Click" />
                                                        </div>
                                                    </div>
                                                    <hr />
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-left:20px;margin-right:20px;">
                            <div class="panel-group" id="accordion2">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <a data-toggle="collapse" data-parent="#accordion2" href="#collapse2">
                                            <h4 class="panel-title">Individual Rules</h4>
                                        </a>
                                    </div>
                                    <div id="collapse2" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <asp:Repeater ID="rptIndividual" runat="server">
                                                <HeaderTemplate>
                                                    <div class="row">
                                                        <div class="col-md-3" style="text-align:center;">
                                                            <label><b>Rule Name</b></label>
                                                        </div>
                                                        <div class="col-md-5" style="text-align:center;">
                                                            <label><b>Rule Description</b></label>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <label style="color: grey; font-size: 12px;">(Check/uncheck to make the rule Active/Inactive)</label>
                                                        </div>
                                                        <div class="col-md-2"></div>
                                                    </div>
                                                    <hr />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <div class="row">
                                                        <div class="col-md-3">
                                                            <asp:TextBox ID="txtIRuleName" runat="server" CssClass="form-control" Text='<%# Eval("ruleName") %>'></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <asp:TextBox ID="txtIDescription" runat="server" Rows="4" TextMode="MultiLine" MaxLength="500" CssClass="form-control" Text='<%# Eval("description") %>'></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-2"  style="text-align: center;">
                                                            <asp:CheckBox ID="chkIActive" runat="server" Text="Active" Checked='<%# Bind("isActive") %>' />
                                                        </div>
                                                        <div class="col-md-2">
                                                            <asp:Button ID="btnIUpdate" runat="server" CssClass="btn btn-primary" Text="Update" CommandArgument='<%# Eval("ruleID") %>' OnClick="btnIUpdate_Click" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3">
                                                            <label><b>Condition: </b></label>
                                                            <asp:Label ID="lblICondition" runat="server" Text='<%# Eval("Rule") %>'></asp:Label>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label><b>Type: </b></label>
                                                            <asp:Label ID="lblIType" runat="server" Text='<%# Eval("Type").ToString().Substring(0,Eval("Type").ToString().Length -2) %>'></asp:Label>
                                                        </div>
                                                        <div class="col-md-4">
                                                        </div>
                                                    </div>
                                                    <hr />
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-left:20px;margin-right:20px; margin-bottom:20px;">
                            <div class="panel-group" id="accordion3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <a data-toggle="collapse" data-parent="#accordion3" href="#collapse3">
                                            <h4 class="panel-title">Combined Rules</h4>
                                        </a>
                                    </div>
                                    <div id="collapse3" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <asp:Repeater ID="rptCombined" runat="server" >
                                                <HeaderTemplate>
                                                    <div class="row">
                                                        <div class="col-md-3" style="text-align:center;">
                                                            <label><b>Rule Name</b></label>
                                                        </div>
                                                        <div class="col-md-5" style="text-align:center;">
                                                            <label><b>Rule Description</b></label>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <label style="color: grey; font-size: 12px;">(Check/uncheck to make the rule Active/Inactive)</label>
                                                        </div>
                                                        <div class="col-md-2"></div>
                                                    </div>
                                                    <hr />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <div class="row">
                                                        <div class="col-md-3">
                                                            <asp:TextBox ID="txtCRuleName" runat="server" CssClass="form-control" Text='<%# Eval("ruleName") %>'></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <asp:TextBox ID="txtCDescription" runat="server" TextMode="MultiLine" Rows="4" MaxLength="500" CssClass="form-control" Text='<%# Eval("description") %>'></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-2" style="text-align: center;">
                                                            <asp:CheckBox ID="chkCActive" runat="server" Text="Active" Checked='<%# Bind("isActive") %>' />
                                                        </div>
                                                        <div class="col-md-2">
                                                            <asp:Button ID="btnCUpdate" runat="server" CssClass="btn btn-primary" Text="Update" CommandArgument='<%# Eval("combinedRuleID") %>' OnClick="btnCUpdate_Click" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-8">
                                                            <label><b>Type: </b></label>
                                                            <asp:Label ID="lblCType" runat="server" Text='<%# Eval("Type").ToString().Substring(0,Eval("Type").ToString().Length -2) %>'></asp:Label>
                                                        </div>
                                                        <div class="col-md-2">
                                                        </div>
                                                        <div class="col-md-2">
                                                        </div>
                                                    </div>
                                                    <hr />
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <br />
        </asp:View>
    </asp:MultiView>
    <script type="text/javascript">
        function preventSave() {
            alert('Rule type & description is mandatory when status is selected');
        }
    </script>
    <script type="text/javascript">
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
    <script type="text/javascript">
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
