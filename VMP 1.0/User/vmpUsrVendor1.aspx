﻿<%@ Page Title="" Language="C#" MasterPageFile="~/User/vmpUsrMaster.Master" AutoEventWireup="true" CodeBehind="vmpUsrVendor1.aspx.cs" Inherits="VMP_1._0.User.vmpUsrVendor1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        label {
            font-weight: normal;
        }

        .customheading {
            font-style: italic;
            font-family: serif;
            margin: 0px 0px -10px 12px;
            text-decoration: underline;
            font-weight: bold;
        }

        #divlist {
            position: relative;
            overflow: hidden;
        }

        .userdef {
            clear: both;
            border-top: solid 1px #ddd;
            min-height: 22px;
            line-height: 22px;
            display: block;
            text-decoration: none;
            background: #fff;
            outline: 0;
            font-weight: normal;
            padding: 4px 9px;
            background-color: #5bc0de;
            border-radius: 18px;
        }

            .userdef:last-child {
                border-bottom: solid 1px #ddd;
            }

            .userdef:hover {
                color: #111;
                background: #FFF2BE;
                -moz-box-shadow: inset 0 0 1px #333;
                -webkit-box-shadow: inset 0 0 1px #333;
                box-shadow: inset 0 0 1px #333;
            }

        .custom {
            text-decoration: none;
            z-index: 33;
            color: white;
            margin-bottom: 0;
            display: inline-block;
            outline: 0;
            float: right;
        }

            .custom:after {
                position: absolute;
                line-height: 22px;
                font-size: 18px;
                text-align: right;
                padding-right: 8px;
                /*content: "×";*/
                width: 20px;
                height: 100%;
                right: 0;
                color: #999;
            }

        .scrollcustom {
            overflow: scroll;
            height: 140px;
            overflow-y: auto;
            overflow-x: hidden;
        }

            .scrollcustom::-webkit-scrollbar {
                width: 12px;
            }

            .scrollcustom::-webkit-scrollbar-track {
                -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
                border-radius: 10px;
            }

            .scrollcustom::-webkit-scrollbar-thumb {
                border-radius: 10px;
                -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
    <script type="text/javascript">
        function showModal() {
            jQuery.noConflict();
            $("#myModalSimilarName").modal('show');
        }
        function showModalAttachments() {
            jQuery.noConflict();
            $("#myModalAttachments").modal('show');
        }
    </script>
    <div class="container" style="background-color: gainsboro; border-radius: 6px;">
        <asp:HiddenField ID="hdnFieldVendorName" runat="server" />
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
                <div class="row bs-wizard" style="border-bottom: 0;">
                    <div class="col-xs-3 bs-wizard-step active" id="divStep1" runat="server">
                        <%-- complete--%>
                        <div class="text-center bs-wizard-stepnum">Basic</div>
                        <div class="progress">
                            <div class="progress-bar"></div>
                        </div>
                        <asp:LinkButton ID="lnkStep1" runat="server" CssClass="bs-wizard-dot"></asp:LinkButton>
                    </div>

                    <div class="col-xs-3 bs-wizard-step" id="divStep2" runat="server">
                        <%-- complete--%>
                        <!-- complete -->
                        <div class="text-center bs-wizard-stepnum">Actions</div>
                        <div class="progress">
                            <div class="progress-bar"></div>
                        </div>
                        <asp:LinkButton ID="lnkStep2" runat="server" CssClass="bs-wizard-dot" OnClick="lnkStep2_Click"></asp:LinkButton>
                    </div>

                    <div class="col-xs-3 bs-wizard-step" id="divStep3" runat="server">
                        <%-- active--%>
                        <!-- complete -->
                        <div class="text-center bs-wizard-stepnum">Owners</div>
                        <div class="progress">
                            <div class="progress-bar"></div>
                        </div>
                        <asp:LinkButton ID="lnkStep3" runat="server" CssClass="bs-wizard-dot" OnClick="lnkStep3_Click"></asp:LinkButton>
                    </div>

                    <div class="col-xs-3 bs-wizard-step" id="divStep4" runat="server">
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
            <asp:Label ID="lblError" runat="server" Text="Document Uploaded Successfully"></asp:Label>
        </div>
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h4 class="customheading">Vendor Details</h4>
            </div>
            <div class="col-md-3"></div>
        </div>
        <hr />
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="lblVName" class="col-sm-3 control-label" style="margin-top: 5px">Vendor / DBA Name</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtVName" runat="server" CssClass="form-control" placeholder="Vendor / DBA Name" MaxLength="100"></asp:TextBox>

                </div>
            </div>
            <div class="col-md-3">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Vendor Name cannot be empty" Style="color: red; margin-left: 15px;" ControlToValidate="txtVName" ValidationGroup="vd"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="lblBName" class="col-sm-3 control-label" style="margin-top: 5px">Business Name</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtBName" runat="server" CssClass="form-control" placeholder="Business Name" MaxLength="100"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="lblSpecialist" class="col-sm-3 control-label" style="margin-top: 5px">Specialist</label>
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddlSpecialist" runat="server" CssClass="form-control" data-live-search="true"></asp:DropDownList>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="lblSwift" class="col-sm-3 control-label" style="margin-top: 5px">SWIFT</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtSwift" runat="server" CssClass="form-control" placeholder="SWIFT" MaxLength="10" Text="0000"></asp:TextBox>

                </div>
            </div>
            <div class="col-md-3">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ControlToValidate="txtSwift" runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+" Style="color: red; margin-left: 15px;"></asp:RegularExpressionValidator>
            </div>
        </div>
        <asp:UpdatePanel ID="updatePnlNAIC" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="row" style="margin-bottom: 15px;">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <label for="lblPNAIC" class="col-sm-3 control-label" style="margin-top: 5px">Primary NAICS Code</label>
                        <div class="col-sm-9">
                            <asp:DropDownList ID="ddlPNAIC" runat="server" CssClass="form-control" AutoPostBack="true" EnableViewState="true" OnSelectedIndexChanged="ddlPNAIC_SelectedIndexChanged1"></asp:DropDownList>

                        </div>
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </ContentTemplate>
            <%-- <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlPNAIC" EventName="SelectedIndexChanged" />
            </Triggers>--%>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="updatePnnSNAIC" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="row" style="margin-bottom: 15px; display: none;" id="divSNaic" runat="server">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <label for="lblSNAIC" class="col-sm-3 control-label" style="margin-top: 5px">Secondary NAICS Codes</label>
                        <div class="col-sm-9">
                            <fieldset>
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" onkeyup="SearchEmployees();" placeholder="Search NAICS Codes">
                                </asp:TextBox>
                                <span id="spnCount"></span>
                                <div class="scrollcustom">
                                    <asp:CheckBoxList ID="chkbxSNaic" runat="server" RepeatColumns="1" CssClass="checkbox"
                                        RepeatDirection="Vertical" ClientIDMode="Static" OnSelectedIndexChanged="chkbxSNaic_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:CheckBoxList>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div style="text-align: center">
                            <asp:Panel ID="pnldivlist" runat="server"></asp:Panel>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlPNAIC" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="PDesc" class="col-sm-3 control-label" style="margin-top: 5px">Business Description</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtPDesc" Rows="5" runat="server" CssClass="form-control desc" TextMode="MultiLine" MaxLength="8000"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-3" style="margin-top: 50px;">
                <label style="color: grey">Max 8000 Characters Only</label>
            </div>
        </div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="Neoserra" class="col-sm-3 control-label" style="margin-top: 10px">Neoserra</label>
                <div class="col-sm-9">
                    <asp:CheckBox ID="chkNEOSERRA" runat="server" Text="Check if Vendor is Registered in Neoserra" CssClass="checkbox" />
                </div>
            </div>

            <div class="col-md-3"></div>
        </div>
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h4 class="customheading">Vendor Contact Details</h4>
            </div>
            <div class="col-md-3"></div>
        </div>
        <hr />
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="Address" class="col-sm-3 control-label" style="margin-top: 5px">Address</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtPAddress" runat="server" CssClass="form-control" TextMode="MultiLine" MaxLength="100"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="City" class="col-sm-3 control-label" style="margin-top: 5px">City</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-9">
                        <div class="row">
                            <div class="col-md-5">
                                <label for="State" class="col-sm-4 control-label" style="margin-top: 5px">State</label>
                                <div class="col-sm-8">
                                    <%--<asp:TextBox ID="txtState" runat="server" CssClass="form-control" MaxLength="2"></asp:TextBox>--%>
                                    <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control">
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
                                        <asp:ListItem Value="MN">MN</asp:ListItem>
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
                            <div class="col-md-7">
                                <label for="Zip" class="col-sm-2 control-label" style="margin-top: 5px">Zip</label>
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtZip" runat="server" CssClass="form-control onlynumber" MaxLength="5"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
            </div>
        </div>
        <asp:UpdatePanel ID="updatePnlCounty" runat="server">
            <ContentTemplate>
                <div class="row" style="margin-bottom: 15px;">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <label for="County" class="col-sm-3 control-label" style="margin-top: 5px">County</label>
                        <div class="col-sm-9">
                            <asp:DropDownList ID="ddlCounty" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCounty_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="col-md-3"></div>
                </div>
                <div class="row" id="divEdr" runat="server" style="margin-bottom: 15px; display: none;">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-3"></div>
                            <div class="col-md-9">
                                <label for="County" class="col-sm-12 control-label" style="margin-top: 5px">Economically Disadvantaged Region</label>
                                <div class="col-sm-12">
                                    <asp:CheckBoxList ID="chkEDR" CssClass="checkbox" runat="server"></asp:CheckBoxList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="Telephone" class="col-sm-3 control-label" style="margin-top: 5px">Telephone</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtTelephone" runat="server" CssClass="form-control bfh-phone" data-format=" (ddd) ddd-dddd" placeholder=" Telephone"></asp:TextBox>

                </div>
            </div>
            <div class="col-md-3">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Invalid Telephone #" ControlToValidate="txtTelephone" Style="color: red; margin-left: 15px;" ValidationGroup="vd" ValidationExpression="^\s+(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="Cell Phone" class="col-sm-3 control-label" style="margin-top: 5px">Cell Phone</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtCellphone" runat="server" CssClass="form-control bfh-phone" data-format=" (ddd) ddd-dddd" placeholder=" Cell Phone"></asp:TextBox>

                </div>
            </div>
            <div class="col-md-3">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Cell Phone #" ControlToValidate="txtCellphone" Style="color: red; margin-left: 15px;" ValidationGroup="vd" ValidationExpression="^\s+(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="Cellphone" class="col-sm-3 control-label" style="margin-top: 5px">Other Phone</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtOtherPhone" runat="server" CssClass="form-control bfh-phone" data-format=" (ddd) ddd-dddd" placeholder=" Other Phone"></asp:TextBox>

                </div>
            </div>
            <div class="col-md-3">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Invalid Phone #" ControlToValidate="txtOtherPhone" Style="color: red; margin-left: 15px;" ValidationGroup="vd" ValidationExpression="^\s+(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="Cellphone" class="col-sm-3 control-label" style="margin-top: 5px">Fax</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtFax" runat="server" CssClass="form-control bfh-phone" data-format=" (ddd) ddd-dddd" placeholder=" FAX"></asp:TextBox>

                </div>
            </div>
            <div class="col-md-3">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Invalid Fax #" ControlToValidate="txtFax" Style="color: red; margin-left: 15px;" ValidationGroup="vd" ValidationExpression="^\s+(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="Email" class="col-sm-3 control-label" style="margin-top: 5px">E-Mail</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder=" E-Mail" ValidationGroup="vd" MaxLength="100"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-3">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid E-Mail ID" ControlToValidate="txtEmail" Style="color: red; margin-left: 15px;" ValidationGroup="vd" ValidationExpression="^[a-zA-Z0-9._+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <label for="webAddress" class="col-sm-3 control-label" style="margin-top: 5px">Web Address</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtWebAddress" runat="server" CssClass="form-control" placeholder="Web Address" ValidationGroup="vd" MaxLength="50"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-3">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ErrorMessage="Invalid Web Address" ControlToValidate="txtWebAddress" Style="color: red; margin-left: 15px;" ValidationGroup="vd" ValidationExpression="^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="modal fade" id="myModalSimilarName" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <%--<button type="button" class="close" data-dismiss="modal">&times;</button>--%>
                        <h5 class="modal-title">Vendor name looks similar to these Vendors, Do you wish to continue?</h5>
                    </div>
                    <div class="modal-body">
                        <asp:GridView ID="grdSimilarVendor" runat="server" CssClass="table1" AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" Style="width: 100%;">
                            <Columns>
                                <asp:BoundField DataField="vendorName" HeaderText="Vendor" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Name" HeaderText="Primary Owner Name" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="address" HeaderText="Vendor Address" HeaderStyle-HorizontalAlign="Center" />
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnModalSaveProceed" runat="server" Text="Save & Proceed" CssClass="btn btn-primary" ValidationGroup="cp" OnClick="btnModalSaveProceed_Click" />
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
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
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="row">
                    <div class="col-md-5"></div>
                    <div class="col-md-4">
                        <asp:Button ID="btnSave" runat="server" Text="Save & Proceed" OnClick="btnSave_Click" CssClass="col-md-12 btn btn-primary" ValidationGroup="vd" />
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </div>
            <div class="col-md-3">
            </div>
        </div>
        <br />
        <div class="row" id="divExecute" runat="server">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="row">
                    <div class="col-md-5"></div>
                    <div class="col-md-4">
                        <asp:Button ID="btnNext1" runat="server" Text="Save & Execute Rules" OnClick="btnNext1_Click" CssClass="col-md-12 btn btn-primary" ValidationGroup="vd" />
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </div>
            <div class="col-md-3">
            </div>
        </div>
        <br />
    </div>
    <script src="../js/bootstrap-tooltip.js"></script>
    <script src="../js/bootstrap-formhelpers-phone.js"></script>
    <script type="text/javascript">
        function pageLoad(sender, args) {
            $('.tooltips').tooltip();

            $(".desc").keyup(function () {
                //   alert("This input field has lost its focus.");
                var elem = document.getElementById('<%= txtPDesc.ClientID %>');
                elem.value = elem.value.substring(0, 7985);
            });
        }
    </script>
    <script>
        $(document).ready(function () {
            $("#navbar7 li").removeClass("active");//this will remove the active class from  
            $('#menu').addClass('active');
            $('#<%=txtSwift.ClientID%>').keydown(function (e) {
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
        });
    </script>
    <script type="text/javascript">
        function SearchEmployees() {
            // alert("Coming");
            if ($(<%=txtSearch.ClientID%>).val() != "") {
                var count = 0;
                $(<%=chkbxSNaic.ClientID%>).children('tbody').children('tr').each(function () {
                    var match = false;
                    $(this).children('td').children('span').children('label').each(function () {
                        if ($(this).text().toUpperCase().indexOf($(<%=txtSearch.ClientID%>).val().toUpperCase()) > -1)
                            match = true;
                    });
                    if (match) {
                        $(this).show();
                        count++;
                    }
                    else { $(this).hide(); }
                });
                $('#spnCount').html((count) + ' match');
            }
            else {
                $(<%=chkbxSNaic.ClientID%>).children('tbody').children('tr').each(function () {
                    $(this).show();
                });
                $('#spnCount').html('');
            }
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
</asp:Content>
