﻿using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VMP.Library;

namespace VMP_1._0.Admin
{
    public partial class portalAdmView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDataForPreview();
            }
        }

        private void LoadDataForPreview()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getVendorDataForPreview]", Request.QueryString["appId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResultPortal(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //Basic Details
                lblVendorName.Text = ds.Tables[0].Rows[0]["vendorName"].ToString();
                lblBusName.Text = ds.Tables[0].Rows[0]["businessName"].ToString();
                lblAddress.Text = ds.Tables[0].Rows[0]["address"].ToString();
                lblCity.Text = ds.Tables[0].Rows[0]["city"].ToString();
                lblState.Text = ds.Tables[0].Rows[0]["state"].ToString();
                lblZipcode.Text = ds.Tables[0].Rows[0]["zipCode"].ToString();
                lblCounty.Text = ds.Tables[0].Rows[0]["region"].ToString();
                lblDesc.Text = ds.Tables[0].Rows[0]["productDesc"].ToString();
                //lblDate.Text= string.Format(ds.Tables[0].Rows[0]["addedDateTime"].ToString(),"MM/dd/yyyy");
                lblDate.Text = DateTime.Parse(ds.Tables[0].Rows[0]["addedDateTime"].ToString()).ToShortDateString();
                lblEmail.Text = ds.Tables[0].Rows[0]["emailId"].ToString();
                lblFax.Text = ds.Tables[0].Rows[0]["fax"].ToString();
                lblTelephone.Text = ds.Tables[0].Rows[0]["telephone"].ToString();
                lblWebAddress.Text = ds.Tables[0].Rows[0]["webAddress"].ToString();

                //Firm Information
                lblAppDate.Text = ds.Tables[0].Rows[0]["applicationDate"].ToString() == string.Empty ? "" : DateTime.Parse(ds.Tables[0].Rows[0]["applicationDate"].ToString()).ToShortDateString();
                lblCODate.Text = ds.Tables[0].Rows[0]["dateCurrentOwnership"].ToString() == string.Empty ? "" : DateTime.Parse(ds.Tables[0].Rows[0]["dateCurrentOwnership"].ToString()).ToShortDateString();
                lblRegDate.Text = ds.Tables[0].Rows[0]["dateRegistered"].ToString() == string.Empty ? "" : DateTime.Parse(ds.Tables[0].Rows[0]["dateRegistered"].ToString()).ToShortDateString();
                lblHRCert.Text = ds.Tables[0].Rows[0]["hrCertificate"].ToString();
                lblMOA.Text = ds.Tables[0].Rows[0]["methodAcquis"].ToString();
                lblEmployee.Text = ds.Tables[0].Rows[0]["fullTimeEmp"].ToString();
                lblMNTax.Text = ds.Tables[0].Rows[0]["mnTaxId"].ToString();
                lblFedTax.Text = ds.Tables[0].Rows[0]["federalTaxId"].ToString();
                grdGross.DataSource = ds.Tables[1];
                grdGross.DataBind();

                //Business Structure
                chkCorp.Checked = bool.Parse(ds.Tables[0].Rows[0]["corporation"].ToString());
                chkDBE.Checked = bool.Parse(ds.Tables[0].Rows[0]["DBE"].ToString());
                chkUSDVA.Checked = bool.Parse(ds.Tables[0].Rows[0]["USDVA"].ToString());
                chkLLC.Checked = bool.Parse(ds.Tables[0].Rows[0]["llc"].ToString());
                chkNCMSDC.Checked = bool.Parse(ds.Tables[0].Rows[0]["NCMSDC"].ToString());
                chkNGLCC.Checked = bool.Parse(ds.Tables[0].Rows[0]["NGLCC"].ToString());
                chkNonProfit.Checked = bool.Parse(ds.Tables[0].Rows[0]["nonProfit"].ToString());
                chkPartnership.Checked = bool.Parse(ds.Tables[0].Rows[0]["partnership"].ToString());
                chkProprietorship.Checked = bool.Parse(ds.Tables[0].Rows[0]["proprietorship"].ToString());
                chkrehab.Checked = bool.Parse(ds.Tables[0].Rows[0]["rehabFacilities"].ToString());
                chkWBENC.Checked = bool.Parse(ds.Tables[0].Rows[0]["WBENC"].ToString());

                chkCorp.Enabled = false;
                chkDBE.Enabled = false;
                chkUSDVA.Enabled = false;
                chkLLC.Enabled = false;
                chkNCMSDC.Enabled = false;
                chkNGLCC.Enabled = false;
                chkNonProfit.Enabled = false;
                chkPartnership.Enabled = false;
                chkProprietorship.Enabled = false;
                chkrehab.Enabled = false;
                chkWBENC.Enabled = false;

                //Secondary Firms
                // if (ds.Tables[3].Rows.Count > 0)
                //  {
                ViewState["secFirms"] = ds.Tables[3];
                // }
                //Owners
                if (ds.Tables[2].Rows.Count > 0)
                {
                    rptOwners.DataSource = ds.Tables[2];
                    rptOwners.DataBind();
                }
            }
        }

        protected void rptOwners_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;
                CheckBox chkCitizen = (CheckBox)e.Item.FindControl("chkCitizen");
                CheckBoxList chkbxTargetGroup = (CheckBoxList)e.Item.FindControl("chkbxTargetGroup");
                RadioButtonList radVeteran = (RadioButtonList)e.Item.FindControl("radVeteran");
                CheckBoxList chkIndiginess = (CheckBoxList)e.Item.FindControl("chkIndiginess");
                CheckBoxList chkTG1 = (CheckBoxList)e.Item.FindControl("chkTG1");
                HtmlGenericControl divIndiginess = (HtmlGenericControl)e.Item.FindControl("divIndiginess");
                CheckBox chkBusinessPlanning = (CheckBox)e.Item.FindControl("chkBusinessPlanning");
                CheckBox chkSalesMarketing = (CheckBox)e.Item.FindControl("chkSalesMarketing");
                CheckBox chkFinancial = (CheckBox)e.Item.FindControl("chkFinancial");
                CheckBox chkPersonnel = (CheckBox)e.Item.FindControl("chkPersonnel");
                CheckBox chkProjManagement = (CheckBox)e.Item.FindControl("chkProjManagement");
                Label lblPNWYear = (Label)e.Item.FindControl("lblPNWYear");
                lblPNWYear.Text = drv.Row["ApplicationYear"].ToString();
                chkCitizen.Checked = (bool)drv.Row["citizen"];
                chkbxTargetGroup.Items[0].Selected = (bool)drv.Row["asian"];
                chkbxTargetGroup.Items[1].Selected = (bool)drv.Row["black"];
                chkbxTargetGroup.Items[2].Selected = (bool)drv.Row["hispanic"];
                chkbxTargetGroup.Items[3].Selected = (bool)drv.Row["indiginessAmerican"];

                if (chkbxTargetGroup.Items[3].Selected)
                {
                    divIndiginess.Attributes.Add("style", "display:block");
                }
                else
                {
                    divIndiginess.Attributes.Add("style", "display:none");
                }
                //chkIndiginess.Items[0].Selected = (bool)drv.Row["alaskan"];
                //chkIndiginess.Items[1].Selected = (bool)drv.Row["hawaiinNative"];
                chkIndiginess.Items[0].Selected = (bool)drv.Row["americanIndian"];


                chkTG1.Items[0].Selected = (bool)drv.Row["physicallyDisabled"];
                chkTG1.Items[1].Selected = (bool)drv.Row["woman"];

                radVeteran.Items[0].Selected = (bool)drv.Row["veteran"];
                radVeteran.Items[1].Selected = (bool)drv.Row["serviceDisabled"];
                //if (!radVeteran.Items[0].Selected && !radVeteran.Items[1].Selected)
                //{
                //    radVeteran.Items[2].Selected = true;
                //}
                if (chkIndiginess.Items[0].Selected)
                {
                    HtmlGenericControl div = (HtmlGenericControl)e.Item.FindControl("divTribal");
                    div.Attributes.Add("style", "display:block");
                    Label lblTribalID = (Label)e.Item.FindControl("lblTribalID");
                    lblTribalID.Text = drv.Row["tribalID"].ToString();
                }
                chkBusinessPlanning.Checked = (bool)drv.Row["busPlanning"];
                chkSalesMarketing.Checked = (bool)drv.Row["salesMarket"];
                chkFinancial.Checked = (bool)drv.Row["financial"];
                chkPersonnel.Checked = (bool)drv.Row["personnel"];
                chkProjManagement.Checked = (bool)drv.Row["projManagement"];

                DataTable dtSecFirms = (DataTable)ViewState["secFirms"];
                HtmlGenericControl divSecFirms = (HtmlGenericControl)e.Item.FindControl("divSecFirms");
                if (dtSecFirms.Rows.Count > 0)
                {
                    divSecFirms.Attributes.Add("style", "display:block");

                    var secFirms = from DataRow myRow in dtSecFirms.Rows
                                   where (Int32)myRow["ownerId"] == Int32.Parse(drv.Row["ownerID"].ToString())
                                   select myRow;
                    if (secFirms.Any())
                    {
                        DataTable dt = secFirms.CopyToDataTable();
                        Repeater rptSecFirms = (Repeater)e.Item.FindControl("rptSecFirms");
                        rptSecFirms.DataSource = dt;
                        rptSecFirms.DataBind();
                    }
                    else
                    {
                        divSecFirms.Attributes.Add("style", "display:none");
                    }
                }
                else
                {
                    divSecFirms.Attributes.Add("style", "display:none");
                }
                chkCitizen.Enabled = false;
                chkbxTargetGroup.Enabled = false;
                chkIndiginess.Enabled = false;
                chkTG1.Enabled = false;
                radVeteran.Enabled = false;

                chkBusinessPlanning.Enabled = false;
                chkFinancial.Enabled = false;
                chkProjManagement.Enabled = false;
                chkPersonnel.Enabled = false;
                chkSalesMarketing.Enabled = false;
            }
        }

        protected void btnAcceptYes_Click(object sender, EventArgs e)
        {
            string qur = dbLibrary.idBuildQuery("[proc_MoveApplicationToVMP]", Request.QueryString["appId"]);
            DataSet ds = dbLibrary.idGetCustomResultPortal(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                MoveAttachments(Request.QueryString["appId"], ds.Tables[0].Rows[0]["vendorid"].ToString(), ds.Tables[0].Rows[0]["vendorName"].ToString());
            }
            Response.Redirect("vmpAdmHome.aspx?Response=Approve");
        }

        private void MoveAttachments(string appId, string vendorid, string vendorname)
        {
            string portalAttachmentPath = WebConfigurationManager.AppSettings["AttachmentPath"] + appId;

            vendorname = vendorname.Replace('.', ' ').ToString().Replace(',', ' ').ToString();
            vendorname = Regex.Replace(vendorname, @"[^0-9a-zA-Z\s]+", "");
            if (vendorname.Length > 20)
            {
                vendorname = vendorname.Substring(0, 20);
            }
            vendorname = vendorname.Trim();
            if (!(Directory.Exists(WebConfigurationManager.AppSettings["VendorAttachmentPath"])))
            {
                Directory.CreateDirectory(WebConfigurationManager.AppSettings["VendorAttachmentPath"]);
            }
            if (!(Directory.Exists(WebConfigurationManager.AppSettings["VendorAttachmentPath"] + vendorname + "-" + vendorid)))
            {
                Directory.CreateDirectory(WebConfigurationManager.AppSettings["VendorAttachmentPath"] + vendorname + "-" + vendorid);
            }
            string vendorAttachmentPath = WebConfigurationManager.AppSettings["VendorAttachmentPath"] + vendorname + "-" + vendorid + "\\" + "Attachments";
            try
            {
                if (!Directory.Exists(vendorAttachmentPath))
                {
                    Directory.CreateDirectory(vendorAttachmentPath);
                }
                string[] files = Directory.GetFiles(portalAttachmentPath);
                foreach (string file in files)
                {
                    string filename = Path.GetFileName(file);
                    File.Move(file, vendorAttachmentPath+"\\"+filename);
                }
               Directory.Delete(portalAttachmentPath);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            if (Directory.EnumerateFiles(vendorAttachmentPath+"\\").Any())
            {
                string[] movedfiles = Directory.GetFiles(vendorAttachmentPath);
                foreach (string fileName in movedfiles)
                {
                    dbLibrary.idInsertInto("AttachmentInfo",
                        "vendorId",vendorid,
                        "attachmentPath", fileName);
                }
            }
        }

        protected void btnRejectYes_Click(object sender, EventArgs e)
        {
            string path = WebConfigurationManager.AppSettings["AttachmentPath"] + Request.QueryString["appId"];
            if (Directory.Exists(path))
            {
                Directory.Delete(path);
            }
            dbLibrary.idUpdateTableStage("VendorDetails",
                "applicationId='" + Request.QueryString["appId"].ToString() + "'",
                "isDeleted", "1");
            Response.Redirect("vmpAdmHome.aspx?Response=Reject");
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModalConfirmation();", true);
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModalReject();", true);
        }
    }
}