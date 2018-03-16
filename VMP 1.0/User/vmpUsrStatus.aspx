﻿<%@ Page Title="" Language="C#" MasterPageFile="~/User/vmpUsrMaster.Master" AutoEventWireup="true" CodeBehind="vmpUsrStatus.aspx.cs" Inherits="VMP_1._0.User.vmpUsrStatus" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        label {
            font-weight: normal;
            margin-top: 5px;
        }

        #mceu_1 {
            display: none !important;
        }

        #mceu_7 {
            display: none !important;
        }

        #title {
            display: none !important;
        }
        /*.mce-statusbar{
            display:none !important;
        }
        .mce-last
        {
            display:none !important;
        }*/
        #mceu_23 {
            display: none !important;
        }

        .modal-lg {
            /* new custom width */
            width: 900px;
        }

        .loading {
            font-family: Arial;
            font-size: 10pt;
            border: 5px solid #67CFF5;
            width: 200px;
            height: 100px;
            display: none;
            position: fixed;
            background-color: White;
            z-index: 999;
        }

        #ctl00_ContentPlaceHolder1_grdAttachments th {
            text-align: center !important;
        }
    </style>
    <script>
        $(document).ready(function () {
            $("#navbar7 li").removeClass("active");//this will remove the active class from  
            $('#menu').addClass('active');
        });
    </script>
    <script type="text/javascript">
        function showModal() {
            jQuery.noConflict();
            $("#myModal").modal('show');
        }
    </script>
    <script type="text/javascript">
        //$(".mce-statusbar").hide();
        function showModalRulesView() {
            jQuery.noConflict();
            $("#ModalRulesView").modal('show');
        }
        function showModalAttachments() {
            jQuery.noConflict();
            $("#myModalAttachments").modal('show');
        }
    </script>
    <script type="text/javascript">
        function LetterPreview() {
            jQuery.noConflict();
            $("#ModalLetterPreview").modal('show');
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
    <script src="../tinymce/js/tinymce/tinymce.min.js"></script>
    <script>
        tinymce.init({
            mode: "specific_textareas",
            editor_selector: "myTextEditor",
            height: 500,
            menubar: false,
            height: "150",
            plugins: [
              'advlist autolink lists link image charmap print preview anchor textcolor',
              'searchreplace visualblocks code fullscreen',
              'insertdatetime media table contextmenu paste code help'
            ],
            toolbar: 'undo redo |  bold italic backcolor  | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat',
            content_css: [
              '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
              '//www.tinymce.com/css/codepen.min.css']
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <%--<asp:HiddenField ID="hdnLetterPath" runat="server" />--%>
    <div class="container" style="background-color: gainsboro; border-radius: 6px;">
        <div class="row" style="margin-top: 5px;">
            <div class="col-md-3"></div>
            <div class="col-md-6" style="text-align: center">
                <asp:Label ID="lblVendorHeading" runat="server" Style="font-weight: bold;"></asp:Label>
            </div>
            <div class="col-md-3" style="text-align: right; margin-top: 20px;">
                <asp:LinkButton ID="lnkAttachments" runat="server" CssClass="btn-link" Text="View/Upload Attachments" OnClick="lnkAttachments_Click"></asp:LinkButton>
            </div>
        </div>
        <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <asp:Label ID="Label3" runat="server" Text="Document Uploaded Successfully"></asp:Label>
        </div>
        <div class="row" style="text-align: center">
            <div class="col-md-4" style="margin-top: 10px; text-align: left;">
                <asp:Button ID="btnBack" runat="server" CssClass="btn btn-primary" Text="<< Go Back" OnClick="btnBack_Click" />
            </div>
            <div class="col-md-4">
                <h3>Certification Status</h3>
            </div>
            <div class="col-md-4"></div>
        </div>
        <div class="row">
            <div class="col-md-12" style="text-align: center">
                <h3>
                    <asp:Label ID="lblStatus" runat="server" Text="Pending" Style="color: red"></asp:Label></h3>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12" style="text-align: center">
            </div>
        </div>
        <div class="row" id="divAppType" runat="server">
            <div class="col-md-12" style="text-align: center">
                <asp:Label ID="Label2" runat="server" Text="Vendor Application Type: " Style="font-weight: bold"></asp:Label>
                <asp:Label ID="lblVendorAppType" runat="server" Style="font-size: 12pt;"></asp:Label>
                <asp:LinkButton ID="lnkRules" runat="server" OnClick="lnkRules_Click"> - Rules View <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></asp:LinkButton>
            </div>
            <div class="col-md-12" style="text-align: center">
                <asp:Label ID="Label1" runat="server" Text="Designation: " Style="font-weight: bold"></asp:Label>
                <asp:Label ID="lblDesignation" runat="server" Style="font-size: 12pt;"></asp:Label>
            </div>
            <div class="col-md-12" style="text-align: center">
                <asp:Label ID="Label4" runat="server" Text="Category: " Style="font-weight: bold"></asp:Label>
                <asp:Label ID="lblCategory" runat="server" Style="font-size: 12pt;"></asp:Label>
            </div>
        </div>
        <div class="row" style="margin-top: 5px;">
            <div id="divOtherAppType" class="col-md-12" style="display: none; text-align: center" runat="server">
                <asp:Label ID="lblAppType" runat="server" Style="color: black; text-align: center; color: chocolate;"></asp:Label>
            </div>
        </div>

        <hr />
        <div class="row" style="text-align: center">
            <h4>Recommendation</h4>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="col-md-3"></div>
            <div class="col-md-6" style="text-align: center">
                <div class="col-md-12">
                    <asp:Button ID="btnRecommend" runat="server" CssClass="btn btn-primary" Text="Recommendation" OnClick="btnRecommend_Click" />
                </div>
                <div class="col-md-12">
                    <label>(Click Recommendation to Override the Certification Status)</label>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

        <hr />
        <div class="row" style="text-align: center">
            <h4>Letters</h4>
        </div>
        <%--<br />--%>
        <div class="row">
            <div class="col-md-12">
                <div class="col-md-4">
                    <div class="col-md-8"></div>
                    <div class="col-md-4">
                        <label>Select Letter</label>
                    </div>
                </div>
                <div class="col-md-5">
                    <asp:DropDownList ID="ddlLetters" runat="server" CssClass="form-control">
                        <asp:ListItem>--Select--</asp:ListItem>
                        <asp:ListItem Value="ADDL INFO">ADDL INFO</asp:ListItem>
                        <asp:ListItem Value="CERT ED(Products&Services)">CERT ED(Products & Services)</asp:ListItem>
                        <asp:ListItem Value="CERT ED(Prof&Tech)">CERT ED (Prof Tech)</asp:ListItem>
                        <asp:ListItem Value="CERT TG(Products&Services)">CERT TG (Products Services)</asp:ListItem>
                        <asp:ListItem Value="CERT TG(Prof&Tech)">CERT TG (Prof Tech)</asp:ListItem>
                        <asp:ListItem Value="DENY">DENY</asp:ListItem>
                        <asp:ListItem Value="GRADUATE">GRADUATE</asp:ListItem>
                        <asp:ListItem Value="OUT70">OUT70</asp:ListItem>
                        <asp:ListItem Value="OUTLSA">OUTLSA</asp:ListItem>
                        <asp:ListItem Value="RECERT APPR">RECERT APPR</asp:ListItem>
                        <asp:ListItem Value="RECERT REQ">RECERT REQ</asp:ListItem>
                        <asp:ListItem Value="REMOVAL-Failure to Recert">REMOVAL - Failure to Recert</asp:ListItem>
                        <asp:ListItem Value="SD FED CERT(Products&Services)">SD FED CERT (Products  Services)</asp:ListItem>
                        <asp:ListItem Value="SD FED CERT(Prof&Tech)">SD FED CERT (Prof Tech)</asp:ListItem>
                        <asp:ListItem Value="SD FED REMOVAL">SD FED REMOVAL</asp:ListItem>
                        <asp:ListItem Value="SD MN CERT(Products&Services)">SD MN CERT (Products  Services)</asp:ListItem>
                        <asp:ListItem Value="SD MN CERT(Prof&Tech)">SD MN CERT (Prof Tech)</asp:ListItem>
                        <asp:ListItem Value="VO FED CERT(Products&Services)">VO FED CERT (Products Services)</asp:ListItem>
                        <asp:ListItem Value="VO FED CERT(Prof&Tech)">VO FED CERT (Prof Tech)</asp:ListItem>
                        <asp:ListItem Value="VO FED REMOVAL">VO FED REMOVAL</asp:ListItem>
                        <asp:ListItem Value="VO MN CERT(Products&Services)">VO MN CERT (Products Services)</asp:ListItem>
                        <asp:ListItem Value="VO MN CERT Template(Prof&Tech)">VO MN CERT Template (Prof Tech)</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3"></div>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="col-md-4"></div>
            <div class="col-md-4" style="text-align: center">
                <asp:Button ID="btnLoad" runat="server" CssClass="btn btn-primary" Text="Download/Edit Template" OnClick="btnLoad_Click" />
            </div>
            <div class="col-md-4"></div>
        </div>
        <div class="row" id="divFileUpload" runat="server" style="display: block; margin-top: 10px">
            <div class="col-md-12">
                <div class="col-md-4">
                    <div class="col-md-5"></div>
                    <div class="col-md-7" style="text-align: center">
                        <label>Upload Edited Template</label>
                    </div>
                </div>
                <div class="col-md-5">
                    <asp:FileUpload ID="fileUploader" runat="server" Style="margin-top: 5px;" />
                </div>
                <div class="col-md-3"></div>
            </div>
        </div>
        <div class="row" id="divError" runat="server" style="display: none">
            <div class="col-md-12" style="text-align: center;">
                <asp:Label ID="lblError" runat="server" Style="color: red"></asp:Label>
            </div>
        </div>
        <div class="row" style="margin-top: 20px; margin-bottom: 20px;">
            <div class="col-md-4"></div>
            <div class="col-md-4" style="text-align: center">
                <%--<div class="col-md-6" style="text-align:center">--%>
                <asp:Button ID="btnSavePreview" runat="server" CssClass="btn btn-primary" Text="Save & Preview Letter" OnClick="btnSavePreview_Click" Visible="true" />
                <%--</div>--%>
                <%-- <div class="col-md-6" style="text-align:center">
                <asp:Button ID="btnSendLetter" runat="server" CssClass="btn btn-primary" Text="Send Letter" />
                </div>--%>
            </div>
            <div class="col-md-4"></div>
        </div>

    </div>
    <%--Modal Letter Preview --%>
    <div class="modal fade" id="ModalLetterPreview" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="text-align: center;">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Letter Preview</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12" style="text-align: center">
                            <asp:Label ID="lblLetterMsg" runat="server" Style="color: green;">Letter Generated Successfully!!!</asp:Label>
                        </div>
                    </div>
                    <div class="row" style="text-align: center;">
                        <iframe runat="server" id="iframepdf" title="Letter" height="400" width="800" style="overflow-y: hidden;"></iframe>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-12">
                            <label>E-Mail Subject</label>
                        </div>
                        <div class="col-md-12">
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-12">
                            <label>E-Mail Body</label>
                        </div>
                        <div class="col-md-12">
                            <asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" CssClass="form-control myTextEditor" MaxLength="500"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="col-md-3"></div>
                            <div class="col-md-6" style="text-align: center;">
                                <asp:Button ID="btnSendLetter" runat="server" CssClass="btn btn-primary" Text="Send Letter" OnClick="btnSendLetter_Click" />
                            </div>
                            <div class="col-md-3"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--End Modal Letter Preview --%>

    <%--Modal Recommendataion Begin--%>
    <div class="modal fade" id="myModal" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Recommendation</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="col-md-3">
                                <asp:RadioButton ID="radbtnApprove" runat="server" Text="Approve" CssClass="radio radio-inline" GroupName="b" />
                            </div>
                            <div class="col-md-3">
                                <asp:RadioButton ID="radbtnDeny" runat="server" Text="Deny" CssClass="radio radio-inline" GroupName="b" />
                            </div>
                            <div class="col-md-3">
                                <asp:RadioButton ID="radbtnPending" runat="server" Text="Pending" CssClass="radio radio-inline" GroupName="b" />
                            </div>
                            <div class="col-md-3">
                                <asp:RadioButton ID="radbtnRemove" runat="server" Text="Remove" CssClass="radio radio-inline" GroupName="b" />
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-12">
                            <div class="col-md-3">
                                <label style="margin-top: 25%;">Override Reason</label>
                            </div>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtOverrideReason" runat="server" CssClass="form-control" TextMode="MultiLine" Style="width: 100%; border-top-right-radius: 4px; border-bottom-right-radius: 4px; height: 90px;"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-3"></div>
                            <div class="col-md-8">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Reason Cannont Be Blank" ValidationGroup="r" ControlToValidate="txtOverrideReason" Style="color: red;"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnOverRide" runat="server" Text="Override" CssClass="btn btn-primary" ValidationGroup="r" OnClick="btnOverRide_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <%--Modal Recommendataion End--%>

    <%--Modal Rules View--%>
    <div class="modal fade" id="ModalRulesView" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Rules View</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:GridView ID="grdRulesView" runat="server" AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White" Style="width: 100%; margin-bottom: 10px;" EmptyDataRowStyle-BorderColor="White">
                                <Columns>
                                    <asp:BoundField DataField="description" HeaderText="Rule Description" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="status" HeaderText="Activity" HeaderStyle-HorizontalAlign="Center" />
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
    <%--Modal Rules View End--%>

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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Style="color: red;" ErrorMessage="Please Select File To Upload !!" ControlToValidate="FileUploadAttachment" ValidationGroup="fileupload"></asp:RequiredFieldValidator>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>