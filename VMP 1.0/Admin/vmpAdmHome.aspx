﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/vmpAdmMaster.Master" AutoEventWireup="true" CodeBehind="vmpAdmHome.aspx.cs" Inherits="VMP_1._0.Admin.vmpAdmHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .chart {
            width: 100%;
            min-height: 270px;
            margin: -5px;
        }

        .borderleft {
            border-left: 1px;
            border-left-color: gainsboro;
            border-left-style: outset;
        }

        .grid td, .grid th {
            text-align: center !important;
            font-weight: normal !important;
        }

        label {
            font-weight: normal !important;
        }

        .customgrid {
            border-color: antiquewhite;
            border-style: solid;
            border-width: 1px;
            background-color: #ECF4FE;
            color: gray;
        }

        .customgridvalue {
            height: 27px;
        }

        .customstyleRow {
            margin-top: 10px;
            margin-bottom: 20px;
        }
    </style>
      
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <asp:Label ID="lblError" runat="server" Text="Saved Successfully"></asp:Label>
        </div>
        <div class="row">
            <h2><b>Dashboard</b></h2>
        </div>
        <div class="row" style="border-radius: 6px; border: 1px solid; border-color: gainsboro; margin-bottom: 30px">
            <div class="row" style="margin-top: 20px;">
                <div class="col-md-6">
                    <div id="chart_div1" class="chart">
                        <div class="col-md-12">
                            <h4 style="text-align: center; color: #6794CE; margin-top: 15px;"><b>Vendors In Progress By Specialist</b></h4>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <asp:GridView ID="grdProgress" runat="server" CssClass="grid" HeaderStyle-BackColor="#6794ce" PagerStyle-BackColor="#ECF4FE" PagerStyle-ForeColor="Gray" AlternatingRowStyle-BackColor="White" BorderColor="AntiqueWhite" RowStyle-BackColor="#ECF4FE" HeaderStyle-ForeColor="White" RowStyle-ForeColor="Gray" AllowSorting="true" AllowPaging="true" PageSize="8" AutoGenerateColumns="false" ShowHeader="true" Style="width: 100%; text-align: center; margin-bottom: 10px;" BackColor="White" EmptyDataRowStyle-BorderColor="White" OnPageIndexChanging="grdProgress_PageIndexChanging">
                                    <Columns>
                                        <asp:BoundField DataField="SpecialistName" HeaderText="Specialist Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />
                                        <asp:BoundField DataField="VendorCount" HeaderText="Application Count" HeaderStyle-HorizontalAlign="Center" />
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <label style="color: red;">No Data Found</label>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 borderleft">
                    <div id="chart_div2" class="chart">
                        <div class="col-md-12">
                            <h4 style="text-align: center; color: #6794CE;"><b>Vendors By Designation</b></h4>
                        </div>
                        <div class="col-md-12" style="margin-top: 20px">
                            <div class="row" style="margin-top: 10px">
                                <div class="col-md-3"></div>
                                <div class="col-md-5 customgrid">
                                    <label>Minority</label>
                                    <asp:LinkButton ID="lnkMinorityDetails" runat="server" Text="(+)" CssClass="btn-link" OnClick="lnkMinorityDetails_Click"></asp:LinkButton>
                                </div>
                                <div class="col-md-2 customgrid customgridvalue">
                                    <asp:Label ID="lblMinority" runat="server" Text="--"></asp:Label>
                                </div>
                                <div class="col-md-2"></div>
                            </div>
                            <div class="row" style="margin-top: 10px">
                                <div class="col-md-3"></div>
                                <div class="col-md-5 customgrid">
                                    <label>Women</label>
                                </div>
                                <div class="col-md-2 customgrid customgridvalue">
                                    <asp:Label ID="lblWomen" runat="server" Text="--"></asp:Label>
                                </div>
                                <div class="col-md-2"></div>
                            </div>
                            <div class="row" style="margin-top: 10px">
                                <div class="col-md-3"></div>
                                <div class="col-md-5 customgrid">
                                    <label>Disabled</label>
                                </div>
                                <div class="col-md-2 customgrid customgridvalue">
                                    <asp:Label ID="lblDisabled" runat="server" Text="--"></asp:Label>
                                </div>
                                <div class="col-md-2"></div>
                            </div>
                            <div class="row" style="margin-top: 10px">
                                <div class="col-md-3"></div>
                                <div class="col-md-5 customgrid">
                                    <label>Economically Disadvantaged</label>
                                    <asp:LinkButton ID="lnkEDRDetails" runat="server" Text="(+)" CssClass="btn-link" OnClick="lnkEDRDetails_Click"></asp:LinkButton>

                                </div>
                                <div class="col-md-2 customgrid customgridvalue">
                                    <asp:Label ID="lblEDR" runat="server" Text="--"></asp:Label>
                                </div>
                                <div class="col-md-2"></div>
                            </div>
                            <div class="row" style="margin-top: 10px">
                                <div class="col-md-3"></div>
                                <div class="col-md-5 customgrid">
                                    <label>Veteran</label>
                                    <asp:LinkButton ID="lnkbtnVeteranDetails" runat="server" Text="(+)" CssClass="btn-link" OnClick="lnkbtnVeteranDetails_Click"></asp:LinkButton>
                                </div>
                                <div class="col-md-2 customgrid customgridvalue">
                                    <asp:Label ID="lblVeteran" runat="server" Text="--"></asp:Label>
                                </div>
                                <div class="col-md-2"></div>
                            </div>
                            <div class="row" style="margin-top: 10px">
                                <div class="col-md-3"></div>
                                <div class="col-md-5 customgrid">
                                    <label style="color: black">Total</label>
                                </div>
                                <div class="col-md-2 customgrid customgridvalue">
                                    <asp:Label ID="lblTotal" runat="server" Style="color: black;" Text="--"></asp:Label>
                                </div>
                                <div class="col-md-2"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row customstyleRow" id="divLastPortal" runat="server">
                <div class="col-md-1"></div>
                <div class="col-md-10">
                    <h4 style="text-align: center; color: #6794CE; margin-top: 15px;"><b>
                        Last Portal Application Received On : <asp:Label ID="lblLastPortalApp" runat="server"></asp:Label></b></h4>
                </div>
                <div class="col-md-1"></div>
            </div>
            <div class="row customstyleRow" id="divPortal" runat="server">
                <div class="col-md-1"></div>
                <div class="col-md-10">
                    <div id="chart_div3" class="chart">
                        <div class="col-md-12">
                            <h4 style="text-align: center; color: #6794CE; margin-top: 15px;"><b>
                                <asp:Label ID="lblPortalAppsCount" runat="server"></asp:Label>
                                New Application(s) From Portal</b></h4>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <asp:GridView ID="grdPortalApps" runat="server" CssClass="grid" HeaderStyle-BackColor="#6794ce" PagerStyle-BackColor="#ECF4FE" PagerStyle-ForeColor="Gray" AlternatingRowStyle-BackColor="White" BorderColor="AntiqueWhite" RowStyle-BackColor="#ECF4FE" HeaderStyle-ForeColor="White" RowStyle-ForeColor="Gray" AllowSorting="true" AllowPaging="true" PageSize="20" AutoGenerateColumns="false" ShowHeader="true" Style="width: 100%; text-align: center; margin-bottom: 10px;" BackColor="White" EmptyDataRowStyle-BorderColor="White" OnPageIndexChanging="grdPortalApps_PageIndexChanging">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Vendor Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="link" runat="server" Text='<%# Eval("vendorName") %>' NavigateUrl='<%# string.Format("portalAdmView?uuid={0}&appId={1}",Eval("uuid"),Eval("applicationId")) %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="isNewApplication" HeaderText="Is New Application?" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="addedDateTime" HeaderText="Received Date" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="DaysSinceArrived" HeaderText="Days Since Application Arrived" HeaderStyle-HorizontalAlign="Center" />
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <label style="color: red;">No Data Found</label>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-1"></div>
            </div>
        </div>
        <div class="modal fade" id="ModalViewDetails" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">
                            <asp:Label ID="lblModalHeading" runat="server" Text="Modal Heading" Style="text-align: center; color: #6794CE;"></asp:Label></h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12" style="margin-top: 20px">
                                <div class="row" style="margin-top: 10px; display: none;" id="divBlack" runat="server">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5">
                                        <asp:Label ID="lblblack" runat="server" Text="Black"></asp:Label>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Label ID="lblBlackCount" runat="server" Text="--"></asp:Label>
                                    </div>
                                    <div class="col-md-2"></div>
                                </div>
                                <div class="row" style="margin-top: 10px; display: none;" id="divHispanic" runat="server">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5">
                                        <asp:Label ID="lblHispanic" runat="server" Text="Hispanic"></asp:Label>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Label ID="lblHispanicCount" runat="server" Text="--"></asp:Label>
                                    </div>
                                    <div class="col-md-2"></div>
                                </div>
                                <div class="row" style="margin-top: 10px; display: none;" id="divAsian" runat="server">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5">
                                        <asp:Label ID="lblAsian" runat="server" Text="Asian"></asp:Label>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Label ID="lblAsianCount" runat="server" Text="--"></asp:Label>
                                    </div>
                                    <div class="col-md-2"></div>
                                </div>
                                <div class="row" style="margin-top: 10px; display: none;" id="divIndiginessAmerican" runat="server">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5">
                                        <asp:Label ID="lblIndiginessAmerican" runat="server" Text="Indiginess American"></asp:Label>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Label ID="lblIndiginessAmericanCount" runat="server" Text="--"></asp:Label>
                                    </div>
                                    <div class="col-md-2"></div>
                                </div>
                                <div class="row" style="margin-top: 10px; display: none;" id="divVeteran" runat="server">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5">
                                        <asp:Label ID="lblVeteranModal" runat="server" Text="Veteran"></asp:Label>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Label ID="lblVeteranCount" runat="server" Text="--"></asp:Label>
                                    </div>
                                    <div class="col-md-2"></div>
                                </div>
                                <div class="row" style="margin-top: 10px; display: none;" id="divServiceDisabled" runat="server">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5">
                                        <asp:Label ID="lblServiceDisabled" runat="server" Text="Service Disabled"></asp:Label>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Label ID="lblServiceDisabledCount" runat="server" Text="--"></asp:Label>
                                    </div>
                                    <div class="col-md-2"></div>
                                </div>
                                <div class="row" style="margin-top: 10px; display: none;" id="divRehab" runat="server">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5">
                                        <asp:Label ID="lblRehab" runat="server" Text="Rehabilitation Facilities"></asp:Label>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Label ID="lblRehabCount" runat="server" Text="--"></asp:Label>
                                    </div>
                                    <div class="col-md-2"></div>
                                </div>
                                <div class="row" style="margin-top: 10px; display: none;" id="divLaborSurplus" runat="server">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5">
                                        <asp:Label ID="lblLaborSurplus" runat="server" Text="Labor Surplus County"></asp:Label>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Label ID="lblLaborSurplusCount" runat="server" Text="--"></asp:Label>
                                    </div>
                                    <div class="col-md-2"></div>
                                </div>
                                <div class="row" style="margin-top: 10px; display: none;" id="divMedianIncome" runat="server">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5">
                                        <asp:Label ID="lblMedianIncome" runat="server" Text="70% Median Income County"></asp:Label>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Label ID="lblMedianIncomeCount" runat="server" Text="--"></asp:Label>
                                    </div>
                                    <div class="col-md-2"></div>
                                </div>
                                <div class="row" style="margin-top: 10px; display: none;" id="divTargetedNeighbor" runat="server">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5">
                                        <asp:Label ID="lblTargetedNeighbor" runat="server" Text="Targeted Neighborhood"></asp:Label>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Label ID="lblTargetedNeighborCount" runat="server" Text="--"></asp:Label>
                                    </div>
                                    <div class="col-md-2"></div>
                                </div>
                                <div class="row" style="margin-top: 10px; display: none;" id="divEnterpriseZone" runat="server">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5">
                                        <asp:Label ID="lblEnterpriseZone" runat="server" Text="Enterprise Zone"></asp:Label>
                                    </div>
                                    <div class="col-md-2">
                                        <asp:Label ID="lblEnterpriseZoneCount" runat="server" Text="--"></asp:Label>
                                    </div>
                                    <div class="col-md-2"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function showModal() {
            //   jQuery.noConflict();
            $("#ModalViewDetails").modal('show');
        }
        function showMessage() {
           // alert("Test");
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
