﻿<%@ Page Title="" Language="C#" MasterPageFile="~/User/vmpUsrMaster.Master" AutoEventWireup="true" CodeBehind="vmpUsrReport.aspx.cs" Inherits="VMP_1._0.User.vmpUsrReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../js/jquery-ui.js"></script>
    <link href="../Content/jquery-ui.css" rel="stylesheet" />
    <style>
        label {
            font-weight: normal;
        }

        .scrollcustom {
            overflow: scroll;
            /*height: 110px;*/
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

        .grid td, .grid th {
            text-align: center !important;
        }
    </style>
    <script>
        //function pageLoad(sender, args) {
        $(document).ready(function () {
            //     jQuery.noConflict();
            $("#navbar7 li").removeClass("active");//this will remove the active class from  
            $('#menu').addClass('active');
            $('.Otherdatepicker').datepicker();
            // }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <h2 style="text-align: center">Report</h2>
        <asp:UpdatePanel ID="updPnlReport" runat="server">
            <Triggers>
                <asp:PostBackTrigger ControlID="lnkExport" />
            </Triggers>
            <ContentTemplate>
                <div class="row" style="margin-top: 40px;">
                    <div class="col-md-2"></div>
                    <div class="col-md-2">
                        <div class="col-md-4"></div>
                        <div class="col-md-8">
                            <label style="margin-top: 5px;">Report Type</label>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <asp:HiddenField ID="hdnReportType" runat="server" />
                        <asp:DropDownList ID="ddlReportType" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlReportType_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="-1">--Select--</asp:ListItem>
                            <asp:ListItem Value="1">Vendors based on Category</asp:ListItem>
                            <asp:ListItem Value="2">Vendors due to be re-certified</asp:ListItem>
                            <asp:ListItem Value="3">Application in Progress</asp:ListItem>
                            <asp:ListItem Value="4">Vendors in Approved Status</asp:ListItem>
                            <asp:ListItem Value="5">Vendors in Removed Status</asp:ListItem>
                            <asp:ListItem Value="6">Vendors based on Primary NAICS Code</asp:ListItem>
                            <asp:ListItem Value="7">Vendors based on County</asp:ListItem>
                            <asp:ListItem Value="8">Vendors based on Specialist</asp:ListItem>
                            <asp:ListItem Value="9">Vendors based on different Gross Sales Range</asp:ListItem>
                            <asp:ListItem Value="10">Vendors based on Designation</asp:ListItem>
                            <asp:ListItem Value="11">Vendors based on Application Type</asp:ListItem>
                            <asp:ListItem Value="12">Vendors based on Key Words</asp:ListItem>
                            <asp:ListItem Value="13">Vendors based on Secondary NAICS Code</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="updPnlSubMenu" runat="server">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlReportType" EventName="SelectedIndexChanged" />
            </Triggers>
            <ContentTemplate>
                <div class="row" style="margin-top: 10px; display: none;" id="divStatus" runat="server">
                    <div class="col-md-2"></div>
                    <div class="col-md-2">
                        <div class="col-md-4"></div>
                        <div class="col-md-8">
                            <label style="margin-top: 5px;">Status</label>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <asp:CheckBox ID="chkApprove" runat="server" Checked="true" Text="Approved" CssClass="checkbox" />
                    </div>
                    <div class="col-md-3"></div>
                </div>
                <div class="row" style="margin-top: 10px; display: none;" id="divSubMenu" runat="server">
                    <div class="col-md-2"></div>
                    <div class="col-md-2">
                        <div class="col-md-4"></div>
                        <div class="col-md-8" style="margin-top: 5px;">
                            <asp:Label ID="lblSubMenu" runat="server" Text="Sub Menu"></asp:Label>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <fieldset>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" onkeyup="SearchEmployees();" placeholder="Search">
                            </asp:TextBox>
                            <span id="spnCount"></span>
                            <div class="scrollcustom" runat="server" id="divchkSubMenu">
                                <asp:CheckBoxList runat="server" ID="chkSubMenu" CssClass="checkbox" RepeatDirection="Vertical" ClientIDMode="Static">
                                </asp:CheckBoxList>
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-md-3"></div>
                </div>
                <div class="row" style="margin-top: 10px; display: none;" id="divGross" runat="server">
                    <div class="col-md-2"></div>
                    <div class="col-md-2">
                        <div class="col-md-4"></div>
                        <div class="col-md-8">
                            <label style="margin-top: 5px;">Range:</label>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <asp:DropDownList ID="ddlRangeFrom" runat="server" CssClass="form-control">
                            <asp:ListItem>< 100K</asp:ListItem>
                            <asp:ListItem>100,000 - 250,000</asp:ListItem>
                            <asp:ListItem>250,000 - 500,000</asp:ListItem>
                            <asp:ListItem>500,000 - 1,000,000</asp:ListItem>
                            <asp:ListItem>1,000,000 - 5,000,000</asp:ListItem>
                            <asp:ListItem>> 5M</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3"></div>
                </div>
                <div class="row" id="divDesignation" runat="server" style="display: none; margin-top: 10px;">
                    <div class="row" style="margin-top: 5px;">
                        <div class="col-md-2"></div>
                        <div class="col-md-2">
                            <div class="col-md-4"></div>
                            <div class="col-md-8">
                                <label style="margin-top: 15px;">Targeted Group</label>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="col-md-12">
                                <asp:CheckBoxList ID="chkbxTargetGroup" runat="server" CssClass="checkbox">
                                    <asp:ListItem>Asian/Pacific</asp:ListItem>
                                    <asp:ListItem>Black</asp:ListItem>
                                    <asp:ListItem>Hispanic</asp:ListItem>
                                    <asp:ListItem>Indigenous American</asp:ListItem>
                                    <asp:ListItem>Physical Disability</asp:ListItem>
                                    <asp:ListItem>Woman</asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                        </div>
                        <div class="col-md-2"></div>
                    </div>
                    <div class="row" style="margin-bottom: 5px;">
                        <div class="col-md-2"></div>
                        <div class="col-md-2">
                            <div class="col-md-3"></div>
                            <div class="col-md-9">
                                <label style="margin-top: 15px;">Veterans</label>
                            </div>
                        </div>
                        <div class="col-md-5" style="border-top-style: ridge;">
                            <div class="col-md-12">
                                <asp:CheckBoxList ID="chkVeteran" runat="server" CssClass="checkbox">
                                    <asp:ListItem>Veteran</asp:ListItem>
                                    <asp:ListItem>Service Disabled Veteran</asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                        </div>
                        <div class="col-md-2"></div>
                    </div>
                    <div class="row" style="margin-bottom: 5px;">
                        <div class="col-md-2"></div>
                        <div class="col-md-2">
                            <div class="col-md-4"></div>
                            <div class="col-md-8">
                                <label style="margin-top: 10px;">Non-Profit</label>
                            </div>
                        </div>
                        <div class="col-md-5" style="border-top-style: ridge;">
                            <div class="col-md-12">
                                <asp:CheckBox ID="chkRehabilitation" runat="server" Text="Rehabilitation Facilities"  CssClass="checkbox"/>
                            </div>
                        </div>
                        <div class="col-md-2"></div>
                    </div>
                    <div class="row" style="margin-bottom: 5px;">
                        <div class="col-md-2"></div>
                        <div class="col-md-2">
                            <div class="col-md-3"></div>
                            <div class="col-md-9">
                                <label style="margin-top: 15px;">Economically Disadvantaged Region</label>
                            </div>
                        </div>
                        <div class="col-md-5" style="border-top-style: ridge;">
                            <div class="col-md-12">
                                <asp:CheckBoxList ID="chkEDR" runat="server" CssClass="checkbox">
                                </asp:CheckBoxList>
                            </div>
                        </div>
                        <div class="col-md-2"></div>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px; display: none;" id="divKeyword" runat="server">
                    <div class="col-md-2"></div>
                    <div class="col-md-2">
                        <div class="col-md-4"></div>
                        <div class="col-md-8" style="margin-top: 5px;">
                            <asp:Label ID="lblKeyword" runat="server" Text="Key Word"></asp:Label>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <asp:TextBox ID="txtKeyword" runat="server" CssClass="form-control" placeholder="Key word">
                        </asp:TextBox>
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="row" style="margin-top: 10px;">
            <div class="col-md-2"></div>
            <asp:UpdatePanel ID="updpnlDate" runat="server">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlReportType" EventName="SelectedIndexChanged" />
                </Triggers>
                <ContentTemplate>
                    <div class="col-md-2">
                        <div class="col-md-12" style="margin-top: 5px;">
                            <asp:Label ID="lblDateFrom" runat="server" Text="Created Date From:"></asp:Label>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="col-md-2">
                <asp:TextBox ID="txtFrom" runat="server" CssClass="form-control Otherdatepicker"></asp:TextBox>
            </div>
            <div class="col-md-3">
                <div class="col-md-4" style="margin-top: 5px;">
                    <asp:Label ID="lblDateTo" runat="server" Text="To:"></asp:Label>
                </div>
                <div class="col-md-8" style="padding: 0px;">
                    <asp:TextBox ID="txtTo" runat="server" CssClass="form-control Otherdatepicker"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="row" style="margin-top: 10px; display: none;" id="divSpecialist" runat="server">
                    <div class="col-md-2"></div>
                    <div class="col-md-2">
                        <div class="col-md-4"></div>
                        <div class="col-md-8" style="margin-top: 5px;">
                            <asp:Label ID="Label1" runat="server" Text="Specialist"></asp:Label>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="scrollcustom">
                            <asp:CheckBoxList runat="server" ID="chkSpecialist" CssClass="checkbox" RepeatDirection="Vertical" ClientIDMode="Static">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <div class="col-md-3"></div>
                </div>
                <div class="row" style="display: none;" id="divCategory" runat="server">
                    <div class="col-md-2"></div>
                    <div class="col-md-2">
                        <div class="col-md-4"></div>
                        <div class="col-md-8" style="margin-top: 5px;">
                            <asp:Label ID="Label2" runat="server" Text="Category"></asp:Label>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="scrollcustom">
                            <asp:CheckBoxList runat="server" ID="chkCategory" CssClass="checkbox" RepeatDirection="Vertical" ClientIDMode="Static">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="row" style="margin-top: 20px;">
            <div class="col-md-12" style="text-align: center">
                <asp:Label ID="lblError" runat="server" Style="color: red; display: none;"></asp:Label>
            </div>
        </div>
        <div class="row" style="margin-top: 20px;">
            <div class="col-md-12" style="text-align: center">
                <asp:Button ID="btnGetReport" runat="server" CssClass="btn btn-primary" Text="Generate Report" OnClick="btnGetReport_Click" />
            </div>
        </div>

        <asp:UpdatePanel ID="updPnlExport" runat="server">
            <ContentTemplate>
                <div class="row" style="margin-top: 20px">
                    <div class="col-md-12" style="text-align: right">
                        <asp:LinkButton ID="lnkExport" runat="server" OnClick="lnkExport_Click" Visible="false">Export to Excel<span class="glyphicon glyphicon-download-alt" aria-hidden="true" ></span></asp:LinkButton>
                    </div>
                    <div class="col-md-12">

                        <asp:GridView ID="grdReport" runat="server" AutoGenerateColumns="false" AllowPaging="true" PageSize="50" OnPageIndexChanging="grdReport_PageIndexChanging" CssClass="grid" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" Style="width: 100%; text-align: center; margin-bottom: 10px;" EmptyDataRowStyle-BorderColor="White" PagerStyle-BorderColor="White">
                            <Columns>
                                <asp:BoundField HeaderText="Vendor Name" DataField="vendorName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="VendorId" DataField="vendorid" Visible="false" />
                                <asp:BoundField HeaderText="Specialist Name" DataField="Specialist Name" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Designation" DataField="Designation" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Primary Owner Name" DataField="Primary Owner Name" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Primary NAICS Code" DataField="Primary NAICS Code" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Secondary NAICS Code" DataField="Secondary NAICS Code" HeaderStyle-HorizontalAlign="Center" Visible="false" />
                                <asp:BoundField HeaderText="Category" DataField="Category" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="County" DataField="region" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Created Date" DataField="Vendor Created date" DataFormatString="{0:MM/dd/yyyy}" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Recertified Date" DataField="Vendor Recertified Date" DataFormatString="{0:MM/dd/yyyy}" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Original Certification Date" DataField="Vendor Orginal Certified Date" DataFormatString="{0:MM/dd/yyyy}" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Next Certification Date" DataField="Vendor Next Certification date" DataFormatString="{0:MM/dd/yyyy}" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Gross Revenue" DataField="grossRevenue" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Mfr Rep" DataField="mfgRep" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="DBE" DataField="DBE" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="USDVA" DataField="USDVA" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Status" DataField="status" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Application Complete" DataField="Application Complete" HeaderStyle-HorizontalAlign="Center" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <div class="col-md-12" style="text-align: center;">
                    <asp:Label ID="lblNoResult" runat="server" Style="color: red;" Visible="false">No Results Found to Display</asp:Label>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlReportType" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <script type="text/javascript">
        function SearchEmployees() {
           // alert("Coming");
            if ($(<%=ddlReportType.ClientID%>).val() == "6") {
                if ($(<%=txtSearch.ClientID%>).val() != "") {
                    var count = 0;
                    $(<%=chkSubMenu.ClientID%>).children('tbody').children('tr').each(function () {
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
                    $(<%=chkSubMenu.ClientID%>).children('tbody').children('tr').each(function () {
                        $(this).show();
                    });
                    $('#spnCount').html('');
                }
            }
            else {
                
                if ($(<%=txtSearch.ClientID%>).val() != "") {
                    var count = 0;
                    $(<%=chkSubMenu.ClientID%>).children('tbody').children('tr').each(function () {
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
                    $(<%=chkSubMenu.ClientID%>).children('tbody').children('tr').each(function () {
                        $(this).show();
                    });
                    $('#spnCount').html('');
                }
            }
        }
    </script>
    <script src="../js/bootstrap-tooltip.js"></script>
    <script type="text/javascript">
        function pageLoad(sender, args) {
            $('.tooltips').tooltip();
        }
    </script>
</asp:Content>
