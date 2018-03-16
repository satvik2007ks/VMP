﻿using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using VMP.Library;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;

namespace VMP_1._0.User
{
    public partial class vmpUsrReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //clearAll();
        }

        private void clearAll()
        {
            lnkExport.Visible = false;
            lblNoResult.Visible = false;
            grdReport.DataSource = null;
            grdReport.DataBind();
            lblError.Attributes.Add("style", "display:none");
            chkApprove.Checked = true;
            txtKeyword.Text = string.Empty;
            foreach (System.Web.UI.WebControls.ListItem li in chkEDR.Items)
            {
                if (li.Selected == true)
                    li.Selected = false;
            }
            foreach (System.Web.UI.WebControls.ListItem li in chkSubMenu.Items)
            {
                if (li.Selected == true)
                    li.Selected = false;
            }
            foreach (System.Web.UI.WebControls.ListItem li in chkCategory.Items)
            {
                if (li.Selected == true)
                    li.Selected = false;
            }
            foreach (System.Web.UI.WebControls.ListItem li in chkSpecialist.Items)
            {
                if (li.Selected == true)
                    li.Selected = false;
            }
            foreach (System.Web.UI.WebControls.ListItem li in chkbxTargetGroup.Items)
            {
                if (li.Selected == true)
                    li.Selected = false;
            }
            foreach (System.Web.UI.WebControls.ListItem li in chkVeteran.Items)
            {
                if (li.Selected == true)
                    li.Selected = false;
            }
        }

        protected void ddlReportType_SelectedIndexChanged(object sender, EventArgs e)
        {
            clearAll();
            lblDateFrom.Text = "Created Date From:";
            divSubMenu.Attributes.Add("style", "display:none;margin-top:10px");
            divGross.Attributes.Add("style", "display:none;margin-top:10px");
            divDesignation.Attributes.Add("style", "display:none;margin-top:10px");
            divSpecialist.Attributes.Add("style", "display:none;margin-top:10px");
            divCategory.Attributes.Add("style", "display:none;margin-top:10px");
            divStatus.Attributes.Add("style", "display:none;margin-top:10px");
            divKeyword.Attributes.Add("style", "display:none;margin-top:10px");
            grdReport.Columns[6].Visible = false;
            switch (ddlReportType.SelectedValue)
            {
                case "-1":
                    break;

                case "1":
                    hdnReportType.Value = "Category";
                    divSubMenu.Attributes.Add("style", "display:block;margin-top:10px");
                    divStatus.Attributes.Add("style", "display:block;margin-top:10px");
                    chkSubMenu.Items.Clear();
                    lblSubMenu.Text = "Category";
                    chkSubMenu.Items.Add(new System.Web.UI.WebControls.ListItem("Goods", "1"));
                    chkSubMenu.Items.Add(new System.Web.UI.WebControls.ListItem("Services", "2"));
                    chkSubMenu.Items.Add(new System.Web.UI.WebControls.ListItem("Professional & Technical", "3"));
                    chkSubMenu.Items.Add(new System.Web.UI.WebControls.ListItem("Construction", "4"));
                    break;

                case "2":
                    hdnReportType.Value = "ToBeReCertified";
                    lblDateFrom.Text = "Expiry Date From:";
                    divSpecialist.Attributes.Add("style", "display:block;margin-top:10px");
                    divCategory.Attributes.Add("style", "display:block;margin-top:10px");
                    chkCategory.Items.Clear();
                    chkSpecialist.Items.Clear();
                    string qurS= "EXEC [proc_getUserList]";
                    DataSet dsS= dbLibrary.idGetCustomResult(qurS);
                    if (dsS != null)
                    {
                        chkSpecialist.DataValueField = "userId";
                        chkSpecialist.DataTextField = "Name";
                        chkSpecialist.DataSource = dsS;
                        chkSpecialist.DataBind();
                        chkSpecialist.SelectedValue = Session["UserId"].ToString();
                    }
                    foreach (System.Web.UI.WebControls.ListItem item in chkSpecialist.Items)
                    {
                        item.Selected = true;
                    }
                    chkCategory.Items.Add(new System.Web.UI.WebControls.ListItem("Goods", "1"));
                    chkCategory.Items.Add(new System.Web.UI.WebControls.ListItem("Services", "2"));
                    chkCategory.Items.Add(new System.Web.UI.WebControls.ListItem("Professional & Technical", "3"));
                    chkCategory.Items.Add(new System.Web.UI.WebControls.ListItem("Construction", "4"));
                    foreach (System.Web.UI.WebControls.ListItem item in chkCategory.Items)
                    {
                        item.Selected = true;
                    }
                    break;

                case "3":
                    hdnReportType.Value = "InProgress";
                    break;

                case "4":
                    hdnReportType.Value = "Approved";
                    break;

                case "5":
                    hdnReportType.Value = "Removed";
                    break;

                case "6":
                case "13":
                    if(ddlReportType.SelectedValue =="13")
                    {
                        hdnReportType.Value = "Secondary NAICCode";
                    }
                    else
                    {
                        hdnReportType.Value = "Primary NAICCode";
                    }
                    
                    divSubMenu.Attributes.Add("style", "display:block;margin-top:10px");
                    divStatus.Attributes.Add("style", "display:block;margin-top:10px");
                    chkSubMenu.Items.Clear();
                    lblSubMenu.Text = "NAICS Code";
                    string qur = "EXEC [proc_getNAICCode]";
                    DataSet ds = dbLibrary.idGetCustomResult(qur);
                    if (ds != null)
                    {
                        chkSubMenu.DataValueField = "naicId";
                        chkSubMenu.DataTextField = "naicCode";
                        chkSubMenu.DataSource = ds;
                        chkSubMenu.DataBind();
                        LoadSecondaryTooltip();
                    }
                    divchkSubMenu.Attributes.Add("style", "height:110px;");
                    break;

                case "7":
                    hdnReportType.Value = "County";
                    divSubMenu.Attributes.Add("style", "display:block;margin-top:10px");
                    divStatus.Attributes.Add("style", "display:block;margin-top:10px");
                    chkSubMenu.Items.Clear();
                    lblSubMenu.Text = "County";
                    string qurCounty = "EXEC [proc_getCounty]";
                    DataSet dsCounty = dbLibrary.idGetCustomResult(qurCounty);
                    if (dsCounty != null)
                    {
                        chkSubMenu.DataValueField = "regionId";
                        chkSubMenu.DataTextField = "region";
                        chkSubMenu.DataSource = dsCounty;
                        chkSubMenu.DataBind();
                    }
                    divchkSubMenu.Attributes.Add("style", "height:110px;");
                    break;

                case "8":
                    hdnReportType.Value = "Specialist";
                    divSubMenu.Attributes.Add("style", "display:block;margin-top:10px");
                    divStatus.Attributes.Add("style", "display:block;margin-top:10px");
                    lblDateFrom.Text = "Updated Date From:";
                    chkSubMenu.Items.Clear();
                    lblSubMenu.Text = "Specialist";
                    string qurSpecialist = "EXEC [proc_getUserList]";
                    DataSet dsSpecialist = dbLibrary.idGetCustomResult(qurSpecialist);
                    if (dsSpecialist != null)
                    {
                        chkSubMenu.DataValueField = "userId";
                        chkSubMenu.DataTextField = "Name";
                        chkSubMenu.DataSource = dsSpecialist;
                        chkSubMenu.DataBind();
                        chkSubMenu.SelectedValue = Session["UserId"].ToString();
                    }
                    break;

                case "9":
                    hdnReportType.Value = "GrossSales";
                    divGross.Attributes.Add("style", "display:block;margin-top:10px");
                    divStatus.Attributes.Add("style", "display:block;margin-top:10px");
                    break;

                case "10":
                    hdnReportType.Value = "Designation";
                    divStatus.Attributes.Add("style", "display:block;margin-top:10px");
                    divDesignation.Attributes.Add("style", "display:block;margin-top:10px");
                    string qurEDR = "EXEC [proc_getEDR]";
                    DataSet dsEDR = dbLibrary.idGetCustomResult(qurEDR);
                    if (dsEDR != null)
                    {
                        chkEDR.DataValueField = "ClassificationId";
                        chkEDR.DataTextField = "ClassificationDesc";
                        chkEDR.DataSource = dsEDR;
                        chkEDR.DataBind();
                    }
                    break;

                case "11":
                    hdnReportType.Value = "ApplicationType";
                    divStatus.Attributes.Add("style", "display:block;margin-top:10px");
                    divSubMenu.Attributes.Add("style", "display:block;margin-top:10px");
                    chkSubMenu.Items.Clear();
                    lblSubMenu.Text = "Application Type";
                    chkSubMenu.Items.Add(new System.Web.UI.WebControls.ListItem("Targeted Group", "1"));
                    chkSubMenu.Items.Add(new System.Web.UI.WebControls.ListItem("Veteran", "2"));
                    chkSubMenu.Items.Add(new System.Web.UI.WebControls.ListItem("Economically Disadvantaged Area", "3"));
                    break;
                case "12":
                    hdnReportType.Value = "KeyWord";
                    divKeyword.Attributes.Add("style", "display:block;margin-top:10px");
                    divStatus.Attributes.Add("style", "display:block;margin-top:10px");
                    break;
            }

            lnkExport.Visible = false;
            grdReport.DataSource = null;
            grdReport.DataBind();
            lblNoResult.Visible = false;
        }
        private void LoadSecondaryTooltip()
        {
            string qur = "EXEC [proc_getNAICCode]";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds != null)
            {
                foreach (System.Web.UI.WebControls.ListItem li in chkSubMenu.Items)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        if (li.Value == dr.ItemArray[0].ToString())
                        {
                            li.Attributes.Add("data-placement", "right");
                            li.Attributes.Add("class", "tooltips");
                            li.Attributes.Add("title", dr.ItemArray[2].ToString());
                            continue;
                        }
                    }
                }
            }
        }

        protected void btnGetReport_Click(object sender, EventArgs e)
        {
            lblNoResult.Visible = false;
            lblError.Attributes.Add("style", "display:none");

            switch (ddlReportType.SelectedValue)
            {
                case "-1":
                    lblError.Text = "Select Report Type";
                    lblError.Attributes.Add("style", "display:block;color:red;");
                    break;
                case "1":
                    string qur = dbLibrary.idBuildQuery("[proc_getReportCategory]", txtFrom.Text.Trim(), txtTo.Text.Trim(), chkSubMenu.Items[0].Selected == true ? "Goods" : "Not Goods", chkSubMenu.Items[1].Selected == true ? "Service" : "Not Services", chkSubMenu.Items[2].Selected == true ? "Professional/Technical" : "Not PT", chkSubMenu.Items[3].Selected == true ? "Construction" : "Not Construction", chkApprove.Checked.ToString());
                    DataSet dsCat = dbLibrary.idGetCustomResult(qur);
                    if (dsCat.Tables[0].Rows.Count > 0)
                    {
                        ViewState["Report"] = dsCat;
                        DataTable dtCategory = dsCat.Tables[0];
                        grdReport.DataSource = dsCat;
                        grdReport.DataBind();
                        lnkExport.Visible = true;
                    }
                    else
                    {
                        lblNoResult.Visible = true;
                        grdReport.DataSource = null;
                        grdReport.DataBind();
                    }
                    break;
                case "6":
                case "13":
                    DataSet ds;
                    if (ddlReportType.SelectedValue == "13")
                    {
                        DataTable NAICCodes = new DataTable();
                        NAICCodes.Columns.Add("NAICCode", typeof(string));
                        foreach (System.Web.UI.WebControls.ListItem li in chkSubMenu.Items)
                        {
                            if (li.Selected == true)
                            {
                                DataRow row = NAICCodes.NewRow();
                                row.SetField<string>("NAICCode", li.Value.ToString());
                                NAICCodes.Rows.Add(row);
                            }
                        }
                        ds = dbLibrary.idGetReportForTable("[proc_getReportSecNAICCodes]", NAICCodes, "@NAICCode", txtFrom.Text.Trim() == string.Empty ? "01/01/1900" : txtFrom.Text.Trim(), txtTo.Text.Trim() == string.Empty ? DateTime.Now.ToString("MM/dd/yyyy") : txtTo.Text.Trim(), chkApprove.Checked.ToString() == "True" ? "Approved" : "None");
                        grdReport.Columns[6].Visible = true;
                    }
                    else
                    {
                        DataTable NAICCodes = new DataTable();
                        NAICCodes.Columns.Add("NAICCode", typeof(string));
                        foreach (System.Web.UI.WebControls.ListItem li in chkSubMenu.Items)
                        {
                            if (li.Selected == true)
                            {
                                DataRow row = NAICCodes.NewRow();
                                row.SetField<string>("NAICCode", li.Text.ToString());
                                NAICCodes.Rows.Add(row);
                            }
                        }
                        ds = dbLibrary.idGetReportForTable("[proc_getReportNAICCodes]", NAICCodes, "@NAICCode", txtFrom.Text.Trim() == string.Empty ? "01/01/1900" : txtFrom.Text.Trim(), txtTo.Text.Trim() == string.Empty ? DateTime.Now.ToString("MM/dd/yyyy") : txtTo.Text.Trim(), chkApprove.Checked.ToString() == "True" ? "Approved" : "None");
                    }
                    
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ViewState["Report"] = ds;
                        DataTable dtCategory = ds.Tables[0];
                        grdReport.DataSource = ds;
                        grdReport.DataBind();
                        lnkExport.Visible = true;
                    }
                    else
                    {
                        lblNoResult.Visible = true;
                        grdReport.DataSource = null;
                        grdReport.DataBind();
                        lnkExport.Visible = false;
                    }
                    LoadSecondaryTooltip();
                    break;
                case "2":
                    DataTable specialistID = new DataTable();
                    specialistID.Columns.Add("SpecialistID", typeof(int));
                    DataTable category = new DataTable();
                    category.Columns.Add("category", typeof(string));
                    bool isSpecialistSelected = false;
                    bool isCategorySelected = false;
                    foreach (System.Web.UI.WebControls.ListItem li in chkSpecialist.Items)
                    {
                        if (li.Selected == true)
                        {
                            DataRow row = specialistID.NewRow();
                            row.SetField<int>("SpecialistID", int.Parse(li.Value));
                            specialistID.Rows.Add(row);
                            isSpecialistSelected = true;
                        }
                    }
                    foreach (System.Web.UI.WebControls.ListItem li in chkCategory.Items)
                    {
                        if (li.Selected == true)
                        {
                            DataRow row = category.NewRow();
                            row.SetField<string>("Category", li.Text.ToString());
                            category.Rows.Add(row);
                            isCategorySelected = true;
                        }
                    }
                    if(txtFrom.Text.Trim() != string.Empty && txtTo.Text.Trim() != string.Empty && isSpecialistSelected && isCategorySelected)
                    {
                        DataSet dsReCertify = dbLibrary.idGetReportForTwoTable("[proc_getReportReCertify]", specialistID, "@SpecialistID", category, "@Category", txtFrom.Text.Trim(), txtTo.Text.Trim());
                        if (dsReCertify.Tables[0].Rows.Count > 0)
                        {
                            ViewState["Report"] = dsReCertify;
                            DataTable dtCategory = dsReCertify.Tables[0];
                            grdReport.DataSource = dsReCertify;
                            grdReport.DataBind();
                            lnkExport.Visible = true;
                        }
                        else
                        {
                            lblNoResult.Visible = true;
                            grdReport.DataSource = null;
                            grdReport.DataBind();
                        }
                    }
                    else
                    {
                        lblError.Text = "Expiry From Date and To Date is mandatory, Also atleast one should to be selected in Specialist and Category.";
                        lblError.Attributes.Add("style", "display:block;color:red;");
                        lnkExport.Visible = false;
                        grdReport.DataSource = null;
                        grdReport.DataBind();
                    }
                    break;
                case "3":
                case "4":
                case "5":
                    string Status = string.Empty;
                    if (ddlReportType.SelectedValue == "3")
                    {
                        Status = "Pending";
                    }
                    else if(ddlReportType.SelectedValue == "4")
                    {
                        Status = "Approved";
                    }
                    else if(ddlReportType.SelectedValue == "5")
                    {
                        Status = "Removed";
                    }
                    string qurStatus = dbLibrary.idBuildQuery("[proc_getReportStatus]", txtFrom.Text.Trim(), txtTo.Text.Trim(), Status);
                    DataSet dsStatus = dbLibrary.idGetCustomResult(qurStatus);
                    if (dsStatus.Tables[0].Rows.Count > 0)
                    {
                        ViewState["Report"] = dsStatus;
                        DataTable dtCategory = dsStatus.Tables[0];
                        grdReport.DataSource = dsStatus;
                        grdReport.DataBind();
                        lnkExport.Visible = true;
                    }
                    else
                    {
                        lblNoResult.Visible = true;
                        grdReport.DataSource = null;
                        grdReport.DataBind();
                    }
                    break;
                case "7":
                    DataTable county = new DataTable();
                    county.Columns.Add("County", typeof(string));
                    foreach (System.Web.UI.WebControls.ListItem li in chkSubMenu.Items)
                    {
                        if (li.Selected == true)
                        {
                            DataRow row = county.NewRow();
                            row.SetField<string>("County", li.Text.ToString());
                            county.Rows.Add(row);
                        }
                    }
                    DataSet dsCounty = dbLibrary.idGetReportForTable("[proc_getReportCounty]", county, "@County", txtFrom.Text.Trim() == string.Empty ? "01/01/1900" : txtFrom.Text.Trim(), txtTo.Text.Trim() == string.Empty ? DateTime.Now.ToString("MM/dd/yyyy") : txtTo.Text.Trim(), chkApprove.Checked.ToString() == "True" ? "Approved" : "None");
                    if (dsCounty.Tables[0].Rows.Count > 0)
                    {
                        ViewState["Report"] = dsCounty;
                        DataTable dtCategory = dsCounty.Tables[0];
                        grdReport.DataSource = dsCounty;
                        grdReport.DataBind();
                        lnkExport.Visible = true;
                    }
                    else
                    {
                        lblNoResult.Visible = true;
                        grdReport.DataSource = null;
                        grdReport.DataBind();
                    }
                    break;
                case "8":
                    DataTable specialist = new DataTable();
                    specialist.Columns.Add("Specialist", typeof(string));
                    foreach (System.Web.UI.WebControls.ListItem li in chkSubMenu.Items)
                    {
                        if (li.Selected == true)
                        {
                            DataRow row = specialist.NewRow();
                            row.SetField<int>("Specialist", int.Parse(li.Value));
                            specialist.Rows.Add(row);
                        }
                    }
                    DataSet dsSpecialist = dbLibrary.idGetReportForTable("[proc_getReportSpecialist]", specialist, "@Specialist", txtFrom.Text.Trim() == string.Empty ? "01/01/1900" : txtFrom.Text.Trim(), txtTo.Text.Trim() == string.Empty ? DateTime.Now.ToString("MM/dd/yyyy") : txtTo.Text.Trim(), chkApprove.Checked.ToString() == "True" ? "Approved" : "None");
                    if (dsSpecialist.Tables[0].Rows.Count > 0)
                    {
                        ViewState["Report"] = dsSpecialist;
                        DataTable dtCategory = dsSpecialist.Tables[0];
                        grdReport.DataSource = dsSpecialist;
                        grdReport.DataBind();
                        lnkExport.Visible = true;
                    }
                    else
                    {
                        lblNoResult.Visible = true;
                        grdReport.DataSource = null;
                        grdReport.DataBind();
                    }
                    break;
                case "9":
                    int lowerLimit = 0;
                    int upperLimit = 0;
                    if (ddlRangeFrom.Text == "< 100K")
                    {
                        upperLimit = 100000;
                    }
                    else if(ddlRangeFrom.Text == "100,000 - 250,000")
                    {
                        lowerLimit = 100000;
                        upperLimit = 250000;
                    }
                    else if (ddlRangeFrom.Text == "250,000 - 500,000")
                    {
                        lowerLimit = 250000;
                        upperLimit = 500000;
                    }
                    else if (ddlRangeFrom.Text == "500,000 - 1,000,000")
                    {
                        lowerLimit = 500000;
                        upperLimit = 1000000;
                    }
                    else if (ddlRangeFrom.Text == "1,000,000 - 5,000,000")
                    {
                        lowerLimit = 1000000;
                        upperLimit = 5000000;
                    }
                    else if (ddlRangeFrom.Text == "> 5M")
                    {
                        lowerLimit = 5000000;
                        upperLimit = 99999999;
                    }
                    string qurGrossRev = dbLibrary.idBuildQuery("[proc_getReportGrossSalesRange]", txtFrom.Text.Trim(), txtTo.Text.Trim(), lowerLimit.ToString(),upperLimit.ToString(),chkApprove.Checked.ToString());
                    DataSet dsGR = dbLibrary.idGetCustomResult(qurGrossRev);
                    if (dsGR.Tables[0].Rows.Count > 0)
                    {
                        ViewState["Report"] = dsGR;
                        DataTable dtCategory = dsGR.Tables[0];
                        grdReport.DataSource = dsGR;
                        grdReport.DataBind();
                        lnkExport.Visible = true;
                    }
                    else
                    {
                        lblNoResult.Visible = true;
                        grdReport.DataSource = null;
                        grdReport.DataBind();
                    }
                    break;
                case "10":
                    int EDRCheckedCount = 0;
                    int unSelectedEDRCount = 0;
                    foreach (System.Web.UI.WebControls.ListItem li in chkEDR.Items)
                    {
                        if (li.Selected == true)
                            EDRCheckedCount++;
                        else
                            unSelectedEDRCount++;
                    }
                    if (chkbxTargetGroup.Items[0].Selected || chkbxTargetGroup.Items[1].Selected || chkbxTargetGroup.Items[2].Selected || chkbxTargetGroup.Items[3].Selected ||
                        chkbxTargetGroup.Items[4].Selected || chkbxTargetGroup.Items[5].Selected || chkVeteran.Items[0].Selected || chkVeteran.Items[1].Selected ||
                        EDRCheckedCount > 0)
                    {
                        string qurDesignation = "SELECT distinct VendorDetails.vendorid,vendorName,businessName,swiftNumber,productDesc,Case When neoserra = '0' Then 'No' Else 'Yes' END as Neoserra,";
                        qurDesignation = qurDesignation + "VendorDetails.address,VendorDetails.city,VendorDetails.state,VendorDetails.zipCode,VendorDetails.telephone,VendorDetails.cellphone as 'Cell Phone',VendorDetails.otherPhone,VendorDetails.fax,VendorDetails.emailId,VendorDetails.webAddress,VendorDetails.applicationType ";
                        qurDesignation = qurDesignation + ",NAICCodes.naicCode as 'Primary NAICS Code',finalClassification as Designation,[Login].firstName + ' ' + [Login].lastName as 'Specialist Name' "
                        + ",Owners.ownerFirstName + ' ' + Owners.ownerLastName as 'Primary Owner Name',Region.region,case when VendorDetails.applicationComplete='1' THEN 'Yes' ELSE 'No' end as 'Application Complete',VendorDetails.addedDateTime as 'Vendor Created date',VendorCertStatus.certDate as 'Vendor Recertified Date',VendorCertStatus.orginalCertDate as 'Vendor Orginal Certified Date' "
                        + ",VendorCertStatus.nextCertDate as 'Vendor Next Certification Date',case when BusinessStructure.mfgRep='1' and BusinessStructure.mfgRepArticleYes='0' THEN 'No' when BusinessStructure.mfgRepArticleYes='1' THEN 'Yes' ELSE '' END as mfgRep ";
                        qurDesignation = qurDesignation + ",case when BusinessStructure.DBE='1' THEN 'Yes' ELSE 'No' end as DBE,Format(Firms.grossRevenue, '##,##0') as grossRevenue,VendorCertStatus.status,BusinessStructure.USDVA "
                        + ",Firms.applicationDate as 'FirmAppliationdate',Firms.dateCurrentOwnership,Firms.dateRegistered,Firms.hrCertificate,Firms.methodAcquis,Firms.fullTimeEmp,Firms.mnTaxId,Firms.federalTaxId,NAICCodes.supplierClassification as Category ";
                        qurDesignation = qurDesignation + " FROM VendorDetails with(nolock) ";
                        qurDesignation = qurDesignation + "join[Login] with(nolock) on VendorDetails.specialistId = [Login].userId left join NAICCodes with (nolock) on VendorDetails.primaryNaicId = NAICCodes.naicId ";
                        qurDesignation = qurDesignation + "left join Region with (nolock) on VendorDetails.regionId = Region.regionId left join RegionClassification with (nolock) on VendorDetails.regionId = RegionClassification.regionId ";
                        qurDesignation = qurDesignation + "left join BusinessStructure with (nolock) on VendorDetails.vendorId = BusinessStructure.vendorID ";
                        qurDesignation = qurDesignation + "left join Owners with (nolock) on VendorDetails.vendorId = Owners.vendorID and Owners.isPrimaryOwner = '1' ";

                        if (chkApprove.Checked)
                        {
                            qurDesignation = qurDesignation + "join VendorCertStatus with (nolock) on VendorDetails.vendorId = VendorCertStatus.vendorID and VendorCertStatus.isRecent = '1' and VendorCertStatus.status = 'Approved' ";
                        }
                        else
                        {
                            qurDesignation = qurDesignation + "left join VendorCertStatus with (nolock) on VendorDetails.vendorId = VendorCertStatus.vendorID and VendorCertStatus.isRecent = '1' ";
                        }
                        qurDesignation = qurDesignation + "left join Firms with (nolock) on VendorDetails.vendorId = Firms.vendorID where VendorDetails.addedDateTime >= '";
                        if (txtFrom.Text.Trim() == string.Empty)
                        {
                            qurDesignation += "01/01/1900'";
                        }
                        else
                        {
                            qurDesignation += txtFrom.Text.Trim() + "'";
                        }
                        qurDesignation = qurDesignation + "and VendorDetails.addedDateTime<='";
                        if (txtTo.Text.Trim() == string.Empty)
                        {
                            qurDesignation += DateTime.Now.ToString() + "' and ";
                        }
                        else
                        {
                            qurDesignation += txtTo.Text.Trim() + "' and ";
                        }
                        if (chkbxTargetGroup.Items[0].Selected == true)
                        {
                            qurDesignation = qurDesignation + "Owners.asian = '1' or ";
                        }
                        if (chkbxTargetGroup.Items[1].Selected == true)
                        {
                            qurDesignation = qurDesignation + "Owners.black = '1' or ";
                        }
                        if (chkbxTargetGroup.Items[2].Selected == true)
                        {
                            qurDesignation = qurDesignation + "Owners.hispanic = '1' or ";
                        }
                        if (chkbxTargetGroup.Items[3].Selected == true)
                        {
                            qurDesignation = qurDesignation + "Owners.indiginessAmerican = '1' or ";
                        }
                        if (chkbxTargetGroup.Items[4].Selected == true)
                        {
                            qurDesignation = qurDesignation + "Owners.physicallyDisabled = '1' or ";
                        }
                        if (chkbxTargetGroup.Items[5].Selected == true)
                        {
                            qurDesignation = qurDesignation + "Owners.woman = '1' or ";
                        }
                        if (chkVeteran.Items[0].Selected == true)
                        {
                            qurDesignation = qurDesignation + "Owners.veteran = '1' or ";
                        }
                        if (chkVeteran.Items[1].Selected == true)
                        {
                            qurDesignation = qurDesignation + "Owners.serviceDisabled = '1' or ";
                        }
                        if(chkRehabilitation.Checked == true)
                        {
                            qurDesignation = qurDesignation + "BusinessStructure.rehabFacilities ='1' or ";
                        }
                        if (EDRCheckedCount > 0)
                        {
                            qurDesignation = qurDesignation + " RegionClassification.regionId in (select regionId from RegionClassification where classificationId not in (";
                            foreach (System.Web.UI.WebControls.ListItem li in chkEDR.Items)
                            {
                                if (li.Selected == false)
                                {
                                    qurDesignation = qurDesignation + li.Value + ",";
                                }
                            }
                            if(unSelectedEDRCount == 0)
                            {
                                qurDesignation = qurDesignation + "0) group by regionId having count(classificationId)=" + EDRCheckedCount +") ";
                            }
                            else
                            {
                                qurDesignation = qurDesignation.Substring(0, qurDesignation.Length - 1);
                                qurDesignation = qurDesignation + ") group by regionId having count(classificationId)= " +EDRCheckedCount + ") ";
                            }
                        }
                        else
                        {
                            qurDesignation = qurDesignation.Substring(0, qurDesignation.Length - 4);
                        }
                        qurDesignation = qurDesignation + "order by vendorID desc";
                        DataSet dsDesignation = dbLibrary.idGetCustomResult(qurDesignation);
                        if (dsDesignation.Tables[0].Rows.Count > 0)
                        {
                            ViewState["Report"] = dsDesignation;
                            DataTable dtCategory = dsDesignation.Tables[0];
                            grdReport.DataSource = dsDesignation;
                            grdReport.DataBind();
                            lnkExport.Visible = true;
                        }
                        else
                        {
                            lblNoResult.Visible = true;
                            grdReport.DataSource = null;
                            grdReport.DataBind();
                        }
                    }
                    else
                    {
                        lblError.Text = "Atleast one item need to be checked.";
                        lblError.Attributes.Add("style", "display:block;color:red;");
                        grdReport.DataSource = null;
                        grdReport.DataBind();
                        lnkExport.Visible = false;
                    }
                    break;
                case "11":
                    if(chkSubMenu.Items[0].Selected || chkSubMenu.Items[1].Selected || chkSubMenu.Items[2].Selected)
                    {
                        string qurAppType = dbLibrary.idBuildQuery("[proc_getReportAppType]", txtFrom.Text.Trim(), txtTo.Text.Trim(), chkSubMenu.Items[0].Selected == true ? chkSubMenu.Items[0].Text.ToString() : "Not", chkSubMenu.Items[1].Selected == true ? chkSubMenu.Items[1].Text.ToString() : "Not", chkSubMenu.Items[2].Selected == true ? chkSubMenu.Items[2].Text.ToString() : "Not", chkApprove.Checked.ToString());
                        DataSet dsAppType = dbLibrary.idGetCustomResult(qurAppType);
                        if (dsAppType.Tables[0].Rows.Count > 0)
                        {
                            ViewState["Report"] = dsAppType;
                            DataTable dtCategory = dsAppType.Tables[0];
                            grdReport.DataSource = dsAppType;
                            grdReport.DataBind();
                            lnkExport.Visible = true;
                        }
                        else
                        {
                            lblNoResult.Visible = true;
                            grdReport.DataSource = null;
                            grdReport.DataBind();
                        }

                    }
                    else
                    {
                        lblError.Attributes.Add("style", "display:block;color:red;");
                        lblError.Text = "Atleast one item need to be checked.";
                        grdReport.DataSource = null;
                        grdReport.DataBind();
                        lnkExport.Visible = false;
                    }
                    break;
                case "12":
                    if (txtKeyword.Text.Trim() != string.Empty)
                    {
                        string qurKeyword = dbLibrary.idBuildQuery("[proc_getReportKeyword]", txtFrom.Text.Trim(), txtTo.Text.Trim(), txtKeyword.Text.ToString(),chkApprove.Checked.ToString());
                        DataSet dsKeyword = dbLibrary.idGetCustomResult(qurKeyword);
                        if (dsKeyword.Tables[0].Rows.Count > 0)
                        {
                            ViewState["Report"] = dsKeyword;
                            DataTable dtCategory = dsKeyword.Tables[0];
                            grdReport.DataSource = dsKeyword;
                            grdReport.DataBind();
                            lnkExport.Visible = true;
                        }
                        else
                        {
                            lblNoResult.Visible = true;
                            grdReport.DataSource = null;
                            grdReport.DataBind();
                        }

                    }
                    else
                    {
                        lblError.Attributes.Add("style", "display:block;color:red;");
                        lblError.Text = "Please provide key word.";
                        grdReport.DataSource = null;
                        grdReport.DataBind();
                        lnkExport.Visible = false;
                    }
                    break;
            }

        }

        private void ShowNAICCodeReport()
        {
            throw new NotImplementedException();
        }

        protected void grdReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdReport.PageIndex = e.NewPageIndex;
            grdReport.DataSource = (DataSet)ViewState["Report"];
            grdReport.DataBind();
        }

        protected void lnkExport_Click(object sender, EventArgs e)
        {
            //Create a dummy GridView
            GridView GridView1 = new GridView();
            GridView1.AllowPaging = false;
            DataSet report = (DataSet)ViewState["Report"];
            report.Tables[0].Columns.Remove("vendorid");
            report.AcceptChanges();
            GridView1.DataSource = report;
            GridView1.DataBind();
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition",
             "attachment;filename=Report_"+hdnReportType.Value+"_"+DateTime.Today.ToString("MM.dd.yy")+".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                //Apply text style to each Row
                GridView1.Rows[i].Attributes.Add("class", "textmode");
            }
            GridView1.RenderControl(hw);

            //style to format numbers to string
            string style = @"<style> .textmode { mso-number-format:\@; } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }
}