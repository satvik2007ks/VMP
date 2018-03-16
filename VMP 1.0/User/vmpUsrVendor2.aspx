﻿<%@ Page Title="" Language="C#" MasterPageFile="~/User/vmpUsrMaster.Master" AutoEventWireup="true" CodeBehind="vmpUsrVendor2.aspx.cs" Inherits="VMP_1._0.User.vmpUsrVendor2" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        label {
            font-weight: normal;
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
    <asp:HiddenField ID="hdnFourthPageComplete" runat="server" Value="False" />
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
            <div class="col-md-3"></div>
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
                        <asp:LinkButton ID="lnkStep2" runat="server" CssClass="bs-wizard-dot"></asp:LinkButton>
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
            <div class="col-md-6" style="text-align: center;">
                <h4 class="customheading">Log Actions/ Notes</h4>
            </div>
            <div class="col-md-3"></div>
        </div>
        <hr />
        <asp:UpdatePanel ID="updPanelLA" runat="server">
            <ContentTemplate>
                <asp:HiddenField ID="hdnFieldLogActionId" runat="server" />

                <div class="row">
                    <div class="col-md-3">
                        <div class="col-md-12" style="text-align: center;">
                            <h4>
                                <label>Action Dates</label></h4>
                        </div>
                        <hr />
                        <div class="col-md-12">
                            <asp:GridView ID="grdActionDates" CssClass="grid" runat="server" OnSelectedIndexChanged="grdActionDates_SelectedIndexChanged" OnRowDataBound="grdActionDates_RowDataBound" AutoGenerateColumns="false" DataKeyNames="logActionId" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" Style="width: 100%; text-align: center; margin-bottom: 10px;">
                                <Columns>
                                    <asp:BoundField DataField="actionDateTime" HeaderText="Date" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="logActionId" HeaderText="Id" HeaderStyle-HorizontalAlign="Center" Visible="false" />
                                </Columns>
                            </asp:GridView>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-6" style="text-align: center; margin-bottom: 5px;">
                                <asp:Button ID="btnNew" runat="server" CssClass="btn btn-primary" Text="New" OnClick="btnNew_Click" />
                            </div>
                            <div class="col-md-6" style="text-align: center;">
                                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSave_Click" />
                            </div>
                        </div>
                        <%--  <div class="col-md-12">
                            <asp:Label ID="lblError" runat="server" Text="Please Click New to Add New Log Action and then Save" style="color:red;" Visible="false"></asp:Label>
                        </div>--%>
                    </div>
                    <div class="col-md-9" style="border-left-style: outset;">
                        <div class="col-md-12" style="border-style: ridge;">
                            <div class="col-md-12">
                                <h4>
                                    <label>Vendor Actions</label></h4>
                            </div>
                            <hr />
                            <div class="col-md-12" style="margin-bottom: 10px">
                                <div class="row">
                                    <div class="col-md-8">
                                        <asp:CheckBoxList ID="chkbxVendorActions" CssClass="customchkhorizontal checkbox" runat="server" OnSelectedIndexChanged="chkbxVendorActions_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Phoned Response to Request for Information"></asp:ListItem>
                                            <asp:ListItem Text="Written Response to Request for Information"></asp:ListItem>
                                            <asp:ListItem Text="Appeal Denial"></asp:ListItem>
                                            <asp:ListItem Text="Failed to Attend Appeal Hearing"></asp:ListItem>
                                            <asp:ListItem Text="Re-application Attempt"></asp:ListItem>
                                            <asp:ListItem Text="Other Response"></asp:ListItem>
                                        </asp:CheckBoxList>
                                    </div>
                                    <div class="col-md-4"></div>
                                </div>
                                <div class="row" id="divVANotes" runat="server" style="display: none;">
                                    <div class="col-md-12">
                                        <h5 class="customheading">Vendor Action Notes</h5>
                                    </div>
                                    <div class="col-md-12">
                                        <asp:TextBox ID="txtVANotes" runat="server" Rows="5" CssClass="form-control descv" TextMode="MultiLine" MaxLength="8000"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12" style="margin-top: 30px; border-style: ridge;">
                            <div class="col-md-12">
                                <h4>
                                    <label>OEP Actions</label></h4>
                            </div>
                            <hr />
                            <div class="col-md-12" style="margin-bottom: 10px">
                                <div class="row">
                                    <div class="col-md-4">
                                        <asp:CheckBoxList ID="chkbxOspActions" runat="server" OnSelectedIndexChanged="chkbxOspActions_SelectedIndexChanged" AutoPostBack="true" CssClass="checkbox">
                                            <asp:ListItem Text="Telephone Interview"></asp:ListItem>
                                            <asp:ListItem Text="Site Visit"></asp:ListItem>
                                            <asp:ListItem Text="Complaint Investigation"></asp:ListItem>
                                            <asp:ListItem Text="Hearing Rescheduled"></asp:ListItem>
                                            <asp:ListItem Text="OEP Action Notes"></asp:ListItem>
                                        </asp:CheckBoxList>
                                    </div>
                                    <div class="col-md-4">
                                        <asp:RadioButtonList ID="radbutAppeal" runat="server" CssClass="radio">
                                            <asp:ListItem Text="Appeal Upheld"></asp:ListItem>
                                            <asp:ListItem Text="Appeal Overturned"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                    <div class="col-md-4">
                                        <asp:RadioButtonList ID="radbutStatus" runat="server" CssClass="radio">
                                            <asp:ListItem Text="Debarred"></asp:ListItem>
                                            <asp:ListItem Text="Suspended"></asp:ListItem>
                                            <asp:ListItem Text="Probation"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                                <div class="row" id="divOSPNotes" runat="server" style="display: none;">
                                    <div class="col-md-12">
                                        <h5 class="customheading">OEP Action Notes</h5>
                                    </div>
                                    <div class="col-md-12">
                                        <asp:TextBox ID="txtOSPNotes" runat="server" Rows="5" CssClass="form-control descoep" TextMode="MultiLine" MaxLength="8000"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-9">
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <div class="col-md-6" style="text-align: center; margin-bottom: 5px;">
                            <asp:Button ID="btnBack" runat="server" Text="Back to Basic" CssClass="btn btn-primary" ValidationGroup="vd2" OnClick="btnBack_Click" />
                        </div>
                        <div class="col-md-6" style="text-align: center">
                            <asp:Button ID="btnSaveProceed" runat="server" Text="Save & Proceed" CssClass="btn btn-primary" ValidationGroup="vd2" OnClick="btnSaveProceed_Click" />
                        </div>
                    </div>
                    <div class="col-md-3"></div>
                </div>
                <br />
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
    </div>
    <script>
        $(document).ready(function () {
            $("#navbar7 li").removeClass("active");//this will remove the active class from  
            $('#menu').addClass('active');
        });

    </script>
    <script type="text/javascript">
        function pageLoad(sender, args) {
            $(".descv").keyup(function () {
                //   alert("This input field has lost its focus.");
                var elem = document.getElementById('<%= txtVANotes.ClientID %>');
                elem.value = elem.value.substring(0, 7985);
            });
            $(".descoep").keyup(function () {
                //   alert("This input field has lost its focus.");
                var elem = document.getElementById('<%= txtOSPNotes.ClientID %>');
                elem.value = elem.value.substring(0, 7985);
            });
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
        function showModalAttachments() {
              jQuery.noConflict();
            $("#myModalAttachments").modal('show');
        }
    </script>
</asp:Content>
