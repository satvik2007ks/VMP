﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VMP.Library;
using VMP_1._0.Library;
using System.IO;
using System.Web.Configuration;
using System.Text.RegularExpressions;

namespace VMP_1._0.User
{
    public partial class vmpUsrVendor4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            if (!IsPostBack)
            {
                if (Request.QueryString["VId"] != null)
                {
                    if (Request.QueryString["VId"].ToString().Contains("'"))
                    {
                        Response.Redirect("vmpUsrVendor1.aspx");
                    }
                    else if (!dbLibrary.isValidVendor(Request.QueryString["VId"]))
                    {
                        Response.Redirect("vmpUsrVendor1.aspx");
                    }
                    loadStepsProgress();
                    getPrimaryOwner();
                    loadAllValues();
                    loadFirmInfo();
                    loadAppCompletion();
                }
                else
                {
                    radAS.Enabled = false;
                    radNS.Enabled = false;
                    txtFirstName.Enabled = false;
                    txtLastName.Enabled = false;
                }
                if (Request.QueryString["EditMode"] != null)
                {
                    heading.InnerText = "Edit Vendor";
                }
            }
        }

        private void loadAppCompletion()
        {
            string qur = "Select applicationComplete from VendorDetails where vendorId=" + Request.QueryString["VId"];
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                chkAppComplete.Checked = (bool)ds.Tables[0].Rows[0]["applicationComplete"];
            }
        }

        // This method loads the firm info from the db.
        private void loadFirmInfo()
        {
            string qur = "Select * from Firms where vendorId=" + Request.QueryString["VId"];
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            ddlGrossRevYear.Items.Add(DateTime.Now.Year.ToString());
            ddlGrossRevYear.Items.Add((DateTime.Now.Year - 1).ToString());
            ddlGrossRevYear.Items.Add((DateTime.Now.Year - 2).ToString());
            ddlGrossRevYear.Items.Add((DateTime.Now.Year - 3).ToString());
            ddlGrossRevYear.SelectedValue = (DateTime.Now.Year - 1).ToString();
            if (ds.Tables[0].Rows.Count > 0)
            {
                hdFirmId.Value = ds.Tables[0].Rows[0]["firmId"].ToString();
                txtAppDate.Text = ds.Tables[0].Rows[0]["applicationDate"].ToString() != "" ? DateTime.Parse(ds.Tables[0].Rows[0]["applicationDate"].ToString()).ToString("MM/dd/yyyy") : "";
                txtCurrentDate.Text = ds.Tables[0].Rows[0]["dateCurrentOwnership"].ToString() != "" ? DateTime.Parse(ds.Tables[0].Rows[0]["dateCurrentOwnership"].ToString()).ToString("MM/dd/yyyy") : "";
                txtRegDate.Text = ds.Tables[0].Rows[0]["dateRegistered"].ToString() != "" ? DateTime.Parse(ds.Tables[0].Rows[0]["dateRegistered"].ToString()).ToString("MM/dd/yyyy") : "";
                radbutCertificate.SelectedValue = ds.Tables[0].Rows[0]["hrCertificate"].ToString();
                radbutAquisition.SelectedValue = ds.Tables[0].Rows[0]["methodAcquis"].ToString();
                txtFedTax.Text = ds.Tables[0].Rows[0]["federalTaxId"].ToString();
                txtFTE.Text = ds.Tables[0].Rows[0]["fullTimeEmp"].ToString();
                txtMNax.Text = ds.Tables[0].Rows[0]["mnTaxId"].ToString();
                loadGrossRev(ds.Tables[0].Rows[0]["firmId"].ToString());
            }
        }

        private void loadGrossRev(string firmID)
        {
            string qur = "Select top 1 * from GrossRevenue where firmId =" + firmID  + " order by year desc";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtGross.Text = string.Format("{0:n0}", ds.Tables[0].Rows[0]["grossRevenue"]);
                ddlGrossRevYear.SelectedValue = ds.Tables[0].Rows[0]["Year"].ToString();
            }
                
        }

        //This method gets the primary owner information of the vendor

        private void getPrimaryOwner()
        {
            string qur = dbLibrary.idBuildQuery("proc_getOwners", Request.QueryString["VId"]);
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if ((bool)ds.Tables[0].Rows[0]["applicationSigned"])
                {
                    radAS.Checked = true;
                    radNS.Checked = false;
                }
                else
                {
                    radAS.Checked = false;
                    radNS.Checked = true;
                }
                txtFirstName.Text = ds.Tables[0].Rows[0]["ownerFirstName"].ToString();
                txtLastName.Text = ds.Tables[0].Rows[0]["ownerLastName"].ToString();
            }
            radAS.Enabled = false;
            radNS.Enabled = false;
            txtFirstName.Enabled = false;
            txtLastName.Enabled = false;

            //Load DropDown
            if (ds.Tables[1].Rows.Count > 0)
            {
                ddlOwners.DataTextField = "Name";
                ddlOwners.DataValueField = "Name";
                ddlOwners.DataSource = ds.Tables[1];
                ddlOwners.DataBind();
            }
            ddlOwners.Items.Insert(ddlOwners.Items.Count, new ListItem("Other", "Other"));
        }

        //This method loads all the field values from the db.
        private void loadAllValues()
        {
            string qur = "select * from BusinessStructure where vendorID=" + Request.QueryString["VId"];
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //Corporation 
                hdnbsId.Value = ds.Tables[0].Rows[0]["bsID"].ToString();
                radCorp.Checked = (bool)ds.Tables[0].Rows[0]["corporation"];
                if (radCorp.Checked)
                {
                    radCorp_CheckedChanged(radCorp.Checked, EventArgs.Empty);
                }
                if ((bool)ds.Tables[0].Rows[0]["corporationArticleYes"])
                {
                    radArticles.Items[0].Selected = true;
                    radArticles.Items[1].Selected = false;
                    radArticles_SelectedIndexChanged(radArticles.SelectedIndex, EventArgs.Empty);
                }
                else
                {
                    radArticles.Items[1].Selected = true;
                    radArticles.Items[0].Selected = false;
                }
                //Corporate Documents
                ddlOwners.SelectedValue = ds.Tables[0].Rows[0]["incorporator"].ToString();
                if (ddlOwners.SelectedValue == "Other")
                {
                    divOther.Attributes.Add("style", "display:block;");
                    txtOther.Text = ds.Tables[0].Rows[0]["incorporatorOther"].ToString();
                }
                else
                {
                    divOther.Attributes.Add("style", "display:none;");
                }
                txtDate.Text = ds.Tables[0].Rows[0]["incorporationDate"].ToString() != "" ? DateTime.Parse(ds.Tables[0].Rows[0]["incorporationDate"].ToString()).ToString("MM/dd/yyyy") : "";
                txtShares.Text = ds.Tables[0].Rows[0]["noOfShares"].ToString();
                if ((bool)ds.Tables[0].Rows[0]["fileNumbers"])
                {
                    radFileYes.Checked = true;
                    radFileNo.Checked = false;
                }
                else
                {
                    radFileNo.Checked = true;
                    radFileYes.Checked = false;
                }

                //Partnership
                radPartnership.Checked = (bool)ds.Tables[0].Rows[0]["partnership"];
                if (radPartnership.Checked)
                {
                    radPartnership_CheckedChanged(radPartnership.Checked, EventArgs.Empty);
                }
                if ((bool)ds.Tables[0].Rows[0]["partnershipAgreement"])
                {
                    chkPartnershipList.Items[0].Selected = true;
                }
                else
                {
                    chkPartnershipList.Items[0].Selected = false;
                }
                if ((bool)ds.Tables[0].Rows[0]["partCertAssumedName"])
                {
                    radPartnershipList.Items[0].Selected = true;
                }
                else
                {
                    radPartnershipList.Items[0].Selected = false;
                }
                if ((bool)ds.Tables[0].Rows[0]["partPersonalName"])
                {
                    radPartnershipList.Items[1].Selected = true;
                }
                else
                {
                    radPartnershipList.Items[1].Selected = false;
                }
                radProprietorship.Checked = (bool)ds.Tables[0].Rows[0]["proprietorship"];
                if (radProprietorship.Checked)
                {
                    radProprietorship_CheckedChanged(radProprietorship.Checked, EventArgs.Empty);
                }
                if ((bool)ds.Tables[0].Rows[0]["propCertAssumedName"])
                {
                    radProprietorshipList.Items[0].Selected = true;
                }
                else
                {
                    radProprietorshipList.Items[0].Selected = false;
                }

                if ((bool)ds.Tables[0].Rows[0]["propPersonalName"])
                {
                    radProprietorshipList.Items[1].Selected = true;
                }
                else
                {
                    radProprietorshipList.Items[1].Selected = false;
                }
                radNonProfit.Checked = (bool)ds.Tables[0].Rows[0]["nonProfit"];
                if (radNonProfit.Checked)
                    divNonProfit.Attributes.Add("style", "display:block");
                ChkRehabFac.Checked = (bool)ds.Tables[0].Rows[0]["rehabFacilities"];
                radLLC.Checked = (bool)ds.Tables[0].Rows[0]["llc"];
                if (radLLC.Checked)
                {
                    divLLC.Attributes.Add("style", "display:block");
                    divLLCFile.Attributes.Add("style", "display:block");
                    divLLCAgg.Attributes.Add("style", "display:block");
                }
                if ((bool)ds.Tables[0].Rows[0]["isLLCSigned"])
                {
                    radLLCSign.Items[0].Selected = true;
                    radLLCSign.Items[1].Selected = false;
                }
                else
                {
                    radLLCSign.Items[0].Selected = false;
                    radLLCSign.Items[1].Selected = true;
                }
                if ((bool)ds.Tables[0].Rows[0]["isLLCFileNo"])
                {
                    radLLCFile.Items[0].Selected = true;
                    radLLCFile.Items[1].Selected = false;
                }
                else
                {
                    radLLCFile.Items[0].Selected = false;
                    radLLCFile.Items[1].Selected = true;
                }
                if ((bool)ds.Tables[0].Rows[0]["isLLCCompOp"])
                {
                    radLLCCAgree.Items[0].Selected = true;
                    radLLCCAgree.Items[1].Selected = false;
                }
                else
                {
                    radLLCCAgree.Items[0].Selected = false;
                    radLLCCAgree.Items[1].Selected = true;
                }
                radBrokerage.Checked = (bool)ds.Tables[0].Rows[0]["brokerage"];
                rad3rdParty.Checked = (bool)ds.Tables[0].Rows[0]["thirdPartyLessor"];
                radMfg.Checked = (bool)ds.Tables[0].Rows[0]["mfgRep"];
                if ((bool)ds.Tables[0].Rows[0]["mfgRepArticleYes"])
                {
                    radmfgArticles.Items[0].Selected = true;
                    radmfgArticles.Items[1].Selected = false;
                    radMfg_CheckedChanged(radMfg.Checked, EventArgs.Empty);
                }
                else
                {
                    radmfgArticles.Items[1].Selected = true;
                    radmfgArticles.Items[0].Selected = false;
                }
                radFranchise.Checked = (bool)ds.Tables[0].Rows[0]["Franchise"];
                if(!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["otherBusiness"].ToString()))
                {
                    radOtherBusiness.Checked = true;
                    divOtherBus.Attributes.Add("style", "display:block");
                    txtOtherBusiness.Text = ds.Tables[0].Rows[0]["otherBusiness"].ToString();
                }
                else
                {
                    radOtherBusiness.Checked = false;
                    divOtherBus.Attributes.Add("style", "display:none");
                }
              //  bool otherCert= (bool)ds.Tables[0].Rows[0]["otherCert"];
             //   radOtherCert.Checked = (bool)ds.Tables[0].Rows[0]["otherCert"];
                //if (otherCert)
                //{
                   // divOtherCert.Attributes.Add("style", "display:block");
                    chkDBE.Checked = (bool)ds.Tables[0].Rows[0]["DBE"];
                    chkUSDVA.Checked = (bool)ds.Tables[0].Rows[0]["USDVA"];
                    chkOther.Checked = (bool)ds.Tables[0].Rows[0]["otherCertOther"];
                    if (chkDBE.Checked)
                    {
                        divDBECertDate.Attributes.Add("style", "display:block");
                        txtDBECertDate.Text = ds.Tables[0].Rows[0]["DBEDate"].ToString() != "" ? DateTime.Parse(ds.Tables[0].Rows[0]["DBEDate"].ToString()).ToString("MM/dd/yyyy") : "";
                    }
                    if (chkUSDVA.Checked)
                    {
                        divUSDVADates.Attributes.Add("style", "display:block");
                        txtVerifyDate.Text = ds.Tables[0].Rows[0]["USDVAVerifyDate"].ToString() != "" ? DateTime.Parse(ds.Tables[0].Rows[0]["USDVAVerifyDate"].ToString()).ToString("MM/dd/yyyy") : "";
                        txtExpDate.Text = ds.Tables[0].Rows[0]["USDVAExpDate"].ToString() != "" ? DateTime.Parse(ds.Tables[0].Rows[0]["USDVAExpDate"].ToString()).ToString("MM/dd/yyyy") : "";
                    }
                    if (chkOther.Checked)
                    {
                        divOtherDBECert.Attributes.Add("style", "display:block");
                    }
             //   }
                
            }
            LoadOtherDBEChkBoxes(hdnbsId.Value);
        }
        /*
         * LoadOtherDBEChkBoxes method loads the checkboxes from Database when other business option is chosen
         */
        private void LoadOtherDBEChkBoxes(string bdID)
        {
            string qur = "select OtherDBETypeID,OtherDBEType from OtherDBECert";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            rptOther.DataSource = ds;
            rptOther.DataBind();
            if (ds != null && bdID != string.Empty)
            {
                qur = "select OtherDBETypeID,certificateDate from BusOtherDBE where  bsID = " + bdID;
                ds = dbLibrary.idGetCustomResult(qur);
                if (ds != null)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        foreach (RepeaterItem item in rptOther.Items)
                        {

                            CheckBox chkbox = (CheckBox)item.FindControl("chkOtherList");
                            if (chkbox.AccessKey == dr[0].ToString())
                            {
                                chkbox.Checked = true;
                                chkOtherList_CheckedChanged(chkbox, EventArgs.Empty);
                                TextBox txtbox = (TextBox)item.FindControl("txtOtherDate");
                                txtbox.Text = dr[1].ToString();
                                if (txtbox.Text != string.Empty)
                                {
                                    HtmlGenericControl divOtherCertDate = (HtmlGenericControl)item.FindControl("divOtherCertDate");
                                    divOtherCertDate.Attributes.Add("style", "display:block");
                                    txtbox.Text = DateTime.Parse(txtbox.Text).ToString("MM/dd/yyyy");
                                }
                                break;
                            }
                        }
                    }
                }
            }
        }

        private void loadStepsProgress()
        {
            divStep1.Attributes.Add("class", "col-xs-3 bs-wizard-step complete");
            divStep2.Attributes.Add("class", "col-xs-3 bs-wizard-step complete");
            divStep3.Attributes.Add("class", "col-xs-3 bs-wizard-step complete");
            divStep4.Attributes.Add("class", "col-xs-3 bs-wizard-step active");
            string qur = dbLibrary.idBuildQuery("proc_getNewVendorProgress", Request.QueryString["VId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[1].Rows.Count > 0)
            {
                lblVendorHeading.Text = ds.Tables[1].Rows[0]["vendorName"].ToString();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["EditMode"] == null)
            {
                Response.Redirect("vmpUsrVendor3a.aspx?VId=" + Request.QueryString["VId"]);
            }
            else
            {
                Response.Redirect("vmpUsrVendor3a.aspx?VId=" + Request.QueryString["VId"] + "&EditMode=True");
            }
        }

        protected void lnkStep1_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["EditMode"] == null)
            {
                Response.Redirect("vmpUsrVendor1.aspx?VId=" + Request.QueryString["VId"]);
            }
            else
            {
                Response.Redirect("vmpUsrVendor1.aspx?VId=" + Request.QueryString["VId"] + "&EditMode=True");
            }
        }

        protected void lnkStep2_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["EditMode"] == null)
            {
                Response.Redirect("vmpUsrVendor2.aspx?VId=" + Request.QueryString["VId"]);
            }
            else
            {
                Response.Redirect("vmpUsrVendor2.aspx?VId=" + Request.QueryString["VId"] + "&EditMode=True");
            }
        }

        protected void lnkStep3_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["EditMode"] == null)
            {
                Response.Redirect("vmpUsrVendor3.aspx?VId=" + Request.QueryString["VId"]);
            }
            else
            {
                Response.Redirect("vmpUsrVendor3.aspx?VId=" + Request.QueryString["VId"] + "&EditMode=True");
            }
        }

        protected void radCorp_CheckedChanged(object sender, EventArgs e)
        {
            loadDiv();
        }

        protected void radPartnership_CheckedChanged(object sender, EventArgs e)
        {
            loadDiv();
        }

        protected void radProprietorship_CheckedChanged(object sender, EventArgs e)
        {
            loadDiv();
        }

        protected void radNonProfit_CheckedChanged(object sender, EventArgs e)
        {
            loadDiv();
        }

        protected void radLLC_CheckedChanged(object sender, EventArgs e)
        {
            loadDiv();
        }

        //This method hides and displays the respective div's based  on user selected fields.
        private void loadDiv()
        {
            if (radCorp.Checked == true)
            {
                divArticles.Attributes.Add("style", "display:block");
                radArticles.ClearSelection();
                ddlOwners.SelectedIndex = 0;
            }
            else
            {
                txtDate.Text = string.Empty;
                radArticles.SelectedIndex = -1;
                divArticles.Attributes.Add("style", "display:none");
                divCD.Attributes.Add("style", "display:none");
                radFileNo.Checked = true;
                txtOther.Text = string.Empty;

            }
            if (radPartnership.Checked == true)
            {
                divPartnership.Attributes.Add("style", "display:block");
                divCD.Attributes.Add("style", "display:none");
                chkPartnershipList.ClearSelection();
                radPartnershipList.ClearSelection();
            }
            else
            {
                divPartnership.Attributes.Add("style", "display:none");
            }
            if (radProprietorship.Checked == true)
            {
                divProprietorship.Attributes.Add("style", "display:block");
                divCD.Attributes.Add("style", "display:none");
                radProprietorshipList.ClearSelection();
            }
            else
            {
                divProprietorship.Attributes.Add("style", "display:none");

            }
            if (radNonProfit.Checked)
            {
                divNonProfit.Attributes.Add("style", "display:block");
                ChkRehabFac.Checked = false;
            }
            else
            {
                divNonProfit.Attributes.Add("style", "display:none");

            }
            if (radLLC.Checked)
            {
                divLLC.Attributes.Add("style", "display:block");
                divLLCFile.Attributes.Add("style", "display:block");
                divLLCAgg.Attributes.Add("style", "display:block");
                radLLCSign.SelectedIndex = 1;
                radLLCFile.SelectedIndex = 1;
                radLLCCAgree.SelectedIndex = 1;
                ChkRehabFac.Checked = false;
                radProprietorshipList.ClearSelection();
                chkPartnershipList.ClearSelection();
                radPartnershipList.ClearSelection();
                radArticles.ClearSelection();
            }
            else
            {
                divLLC.Attributes.Add("style", "display:none");
                divLLCFile.Attributes.Add("style", "display:none");
                divLLCAgg.Attributes.Add("style", "display:none");
                radLLCSign.ClearSelection();
                radLLCFile.ClearSelection();
                radLLCCAgree.ClearSelection();
            }
        }

        protected void radArticles_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (radArticles.Items[0].Selected)
            {
                divCD.Attributes.Add("style", "display:block");
            }
            else
            {
                divCD.Attributes.Add("style", "display:none");
            }
        }

        private void loadBusinessdiv()
        {
            if (radMfg.Checked == true)
            {
                divOtherBusiness.Attributes.Add("style", "display:block");
                radmfgArticles.Items[1].Selected = true;

            }
            else
            {
                radmfgArticles.SelectedIndex = -1;
                divOtherBusiness.Attributes.Add("style", "display:none");
            }
            if(radOtherBusiness.Checked)
            {
                divOtherBus.Attributes.Add("style", "display:block");
            }
            else
            {
                divOtherBus.Attributes.Add("style", "display:none");
            }
            //if (radOtherCert.Checked)
            //{
            //    divOtherCert.Attributes.Add("style", "display:block");
            //}
            //else
            //{
            //    divOtherCert.Attributes.Add("style", "display:none");
            //}
            if (chkDBE.Checked)
            {
                divDBECertDate.Attributes.Add("style", "display:block");
            }
            else
            {
                divDBECertDate.Attributes.Add("style", "display:none");
            }

            if (chkUSDVA.Checked)
            {
                divUSDVADates.Attributes.Add("style", "display:block");
            }
            else
            {
                divUSDVADates.Attributes.Add("style", "display:none");
            }
            //if (!radOtherCert.Checked)
            //{
            //    chkUSDVA.Checked = false;
            //    chkDBE.Checked = false;
            //}
            if (!chkUSDVA.Checked)
            {
                txtVerifyDate.Text = string.Empty;
                txtExpDate.Text = string.Empty;
            }
            if (!chkDBE.Checked)
                txtDBECertDate.Text = string.Empty;
            if (chkOther.Checked)
            {
                divOtherDBECert.Attributes.Add("style", "display:block");
            }
            else
            {
                divOtherDBECert.Attributes.Add("style", "display:none");
                foreach (RepeaterItem item in rptOther.Items)
                {
                    CheckBox chkOtherList = (CheckBox)item.FindControl("chkOtherList");
                    chkOtherList.Checked = false;
                    chkOtherList_CheckedChanged(chkOtherList, EventArgs.Empty);
                }
            }
        }

        protected void radMfg_CheckedChanged(object sender, EventArgs e)
        {
            loadBusinessdiv();
        }

        protected void rad3rdParty_CheckedChanged(object sender, EventArgs e)
        {
            loadBusinessdiv();
        }

        protected void radBrokerage_CheckedChanged(object sender, EventArgs e)
        {
            loadBusinessdiv();
        }

        //This method is for save and proceed button click. This method will save all the values entered in the fields.
        protected void btnSaveProceed_Click(object sender, EventArgs e)
        {
            string qur = string.Empty;
            string busID = string.Empty;
            DataTable dtOtherDBE = new DataTable();
            dtOtherDBE.Columns.Add("bsID");
            dtOtherDBE.Columns.Add("OtherDBETypeID");
            dtOtherDBE.Columns.Add("certificateDate");
            if (chkUSDVA.Checked && (txtVerifyDate.Text.Trim() == string.Empty || txtExpDate.Text.Trim() == string.Empty))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "preventSave()", true);
                return;
            }
            else
            {
                bool otherCert = false;
                if (chkDBE.Checked || chkUSDVA.Checked || chkOther.Checked)
                {
                    otherCert = true;
                }
                if (hdnbsId.Value != string.Empty)
                {
                    //Update Business Structure
                 
                   qur = dbLibrary.idBuildQuery("[proc_VendorDetails4]", "Update", hdnbsId.Value, Request.QueryString["VId"], radCorp.Checked.ToString(), radArticles.SelectedValue == "Yes" ? "1" : "0", ddlOwners.SelectedValue != "Other" ? ddlOwners.SelectedValue : "Other", ddlOwners.SelectedValue == "Other" ? txtOther.Text.Trim() : string.Empty, txtDate.Text, txtShares.Text.Trim(), radFileYes.Checked == true ? "1" : "0", radPartnership.Checked.ToString(), chkPartnershipList.Items[0].Selected.ToString(), radPartnershipList.Items[0].Selected.ToString(), radPartnershipList.Items[1].Selected.ToString(), radProprietorship.Checked.ToString(), radProprietorshipList.Items[0].Selected.ToString(), radProprietorshipList.Items[1].Selected.ToString(), radNonProfit.Checked.ToString(), ChkRehabFac.Checked.ToString(), radLLC.Checked.ToString(), radLLCSign.Items[0].Selected.ToString(), radLLCFile.Items[0].Selected.ToString(), radLLCCAgree.Items[0].Selected.ToString(), radBrokerage.Checked.ToString(), rad3rdParty.Checked.ToString(), radMfg.Checked.ToString(), radmfgArticles.SelectedValue == "Yes" ? "1" : "0", radFranchise.Checked.ToString(), txtOtherBusiness.Text, otherCert.ToString(), chkDBE.Checked.ToString(), txtDBECertDate.Text, chkUSDVA.Checked.ToString(), txtVerifyDate.Text, txtExpDate.Text, chkOther.Checked.ToString(), hdFirmId.Value, txtAppDate.Text, txtCurrentDate.Text, txtRegDate.Text, radbutCertificate.SelectedValue, radbutAquisition.SelectedValue, txtFTE.Text, txtMNax.Text, txtFedTax.Text, txtGross.Text.Replace(",", "").Trim() == string.Empty ? "0" : txtGross.Text.Replace(",", "").Trim(), ddlGrossRevYear.SelectedItem.Text, chkAppComplete.Checked.ToString(), Session["UserId"].ToString());
                }
                else
                {
                    //Insert Business Structure
                    qur = dbLibrary.idBuildQuery("[proc_VendorDetails4]", "Insert", "", Request.QueryString["VId"], radCorp.Checked.ToString(), radArticles.SelectedValue == "Yes" ? "1" : "0", ddlOwners.SelectedValue != "Other" ? ddlOwners.SelectedValue : "Other", ddlOwners.SelectedValue == "Other" ? txtOther.Text.Trim() : string.Empty, txtDate.Text, txtShares.Text.Trim(), radFileYes.Checked == true ? "1" : "0", radPartnership.Checked.ToString(), chkPartnershipList.Items[0].Selected.ToString(), radPartnershipList.Items[0].Selected.ToString(), radPartnershipList.Items[1].Selected.ToString(), radProprietorship.Checked.ToString(), radProprietorshipList.Items[0].Selected.ToString(), radProprietorshipList.Items[1].Selected.ToString(), radNonProfit.Checked.ToString(), ChkRehabFac.Checked.ToString(), radLLC.Checked.ToString(), radLLCSign.Items[0].Selected.ToString(), radLLCFile.Items[0].Selected.ToString(), radLLCCAgree.Items[0].Selected.ToString(), radBrokerage.Checked.ToString(), rad3rdParty.Checked.ToString(), radMfg.Checked.ToString(), radmfgArticles.SelectedValue == "Yes" ? "1" : "0", radFranchise.Checked.ToString(), txtOtherBusiness.Text, otherCert.ToString(), chkDBE.Checked.ToString(), txtDBECertDate.Text, chkUSDVA.Checked.ToString(), txtVerifyDate.Text, txtExpDate.Text, chkOther.Checked.ToString(), "", txtAppDate.Text, txtCurrentDate.Text, txtRegDate.Text, radbutCertificate.SelectedValue, radbutAquisition.SelectedValue, txtFTE.Text, txtMNax.Text, txtFedTax.Text, txtGross.Text.Replace(",", "").Trim() == string.Empty ? "0": txtGross.Text.Replace(",", "").Trim(), ddlGrossRevYear.SelectedItem.Text, chkAppComplete.Checked.ToString(), Session["UserId"].ToString());
                }
                busID = dbLibrary.idGetAFieldByQuery(qur);
                if (chkOther.Checked)
                {
                    foreach (RepeaterItem item in rptOther.Items)
                    {
                        if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                        {
                            CheckBox checkBox = (CheckBox)item.FindControl("chkOtherList");

                            if (checkBox.Checked)
                            {
                                TextBox txtbox = (TextBox)item.FindControl("txtOtherDate");
                                if (txtbox.Text == string.Empty)
                                    dtOtherDBE.Rows.Add(busID, checkBox.AccessKey);
                                else
                                    dtOtherDBE.Rows.Add(busID, checkBox.AccessKey, txtbox.Text);
                            }
                        }
                    }
                    if (dtOtherDBE.Rows.Count > 0)
                    {
                        dbLibrary.idInsertDataTable("[proc_BusOtherDBECert]", "@OtherBusArray", dtOtherDBE);
                    }
                }
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }

        private string getStatus(string vendorID)
        {
            string qur = "select TOP 1 status from VendorCertStatus where vendorId='" + vendorID + "' ORDER BY certLogID DESC ";
            vendorID = dbLibrary.idGetAFieldByQuery(qur);
            return vendorID;
        }

        protected void radFranchise_CheckedChanged(object sender, EventArgs e)
        {
            loadBusinessdiv();
        }

        protected void chkDBE_CheckedChanged(object sender, EventArgs e)
        {
            loadBusinessdiv();
        }

        protected void chkUSDVA_CheckedChanged(object sender, EventArgs e)
        {
            loadBusinessdiv();
        }

        protected void chkOther_CheckedChanged(object sender, EventArgs e)
        {
            loadBusinessdiv();
        }

        protected void rptOther_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void chkOtherList_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            HtmlGenericControl divOtherCertDate = ((Control)sender).Parent.FindControl("divOtherCertDate") as HtmlGenericControl;
            TextBox txtOtherDate = ((Control)sender).Parent.FindControl("txtOtherDate") as TextBox;
            if (checkBox.Checked)
            {
                divOtherCertDate.Attributes.Add("style", "display:block");
                txtOtherDate.Text = string.Empty;
            }
            else
            {
                divOtherCertDate.Attributes.Add("style", "display:none");

            }
        }

        protected void lnkGrossHistory_Click(object sender, EventArgs e)
        {
            GridView grdGRHistory = ((Control)sender).Parent.FindControl("grdGRHistory") as GridView;
            if(hdFirmId.Value != string.Empty)
            { 
                string qur = "Select top 3 year, Format(grossRevenue, '##,##0') as grossRevenue  from GrossRevenue where firmId=" + hdFirmId.Value + " and year<>" + ddlGrossRevYear.SelectedItem.Text + " order by year desc";
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                grdGRHistory.DataSource = ds;
            }
            else
            { 
                grdGRHistory.DataSource = null;
            }
            grdGRHistory.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModal(" + hdnbsId.Value + ");", true);
        }

        protected void radButLSNone_CheckedChanged(object sender, EventArgs e)
        {
            loadDiv();
        }

        protected void radOtherBusiness_CheckedChanged(object sender, EventArgs e)
        {
            loadBusinessdiv();
        }

        protected void radPartnershipList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(radPartnershipList.Items[2].Selected)
            {
                chkPartnershipList.ClearSelection();
            }
        }

        protected void btnExecute_Click(object sender, EventArgs e)
        {
            string qur = string.Empty;
            string busID = string.Empty;
            DataTable dtOtherDBE = new DataTable();
            dtOtherDBE.Columns.Add("bsID");
            dtOtherDBE.Columns.Add("OtherDBETypeID");
            dtOtherDBE.Columns.Add("certificateDate");
            if (chkUSDVA.Checked && (txtVerifyDate.Text.Trim() == string.Empty || txtExpDate.Text.Trim() == string.Empty))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "preventSave()", true);
            }
            else
            {
                bool otherCert = false;
                if (chkDBE.Checked || chkUSDVA.Checked || chkOther.Checked)
                {
                    otherCert = true;
                }
                if (hdnbsId.Value != string.Empty)
                {
                    //Update Business Structure

                    qur = dbLibrary.idBuildQuery("[proc_VendorDetails4]", "Update", hdnbsId.Value, Request.QueryString["VId"], radCorp.Checked.ToString(), radArticles.SelectedValue == "Yes" ? "1" : "0", ddlOwners.SelectedValue != "Other" ? ddlOwners.SelectedValue : "Other", ddlOwners.SelectedValue == "Other" ? txtOther.Text.Trim() : string.Empty, txtDate.Text, txtShares.Text.Trim(), radFileYes.Checked == true ? "1" : "0", radPartnership.Checked.ToString(), chkPartnershipList.Items[0].Selected.ToString(), radPartnershipList.Items[0].Selected.ToString(), radPartnershipList.Items[1].Selected.ToString(), radProprietorship.Checked.ToString(), radProprietorshipList.Items[0].Selected.ToString(), radProprietorshipList.Items[1].Selected.ToString(), radNonProfit.Checked.ToString(), ChkRehabFac.Checked.ToString(), radLLC.Checked.ToString(), radLLCSign.Items[0].Selected.ToString(), radLLCFile.Items[0].Selected.ToString(), radLLCCAgree.Items[0].Selected.ToString(), radBrokerage.Checked.ToString(), rad3rdParty.Checked.ToString(), radMfg.Checked.ToString(), radmfgArticles.SelectedValue == "Yes" ? "1" : "0", radFranchise.Checked.ToString(), txtOtherBusiness.Text, otherCert.ToString(), chkDBE.Checked.ToString(), txtDBECertDate.Text, chkUSDVA.Checked.ToString(), txtVerifyDate.Text, txtExpDate.Text, chkOther.Checked.ToString(), hdFirmId.Value, txtAppDate.Text, txtCurrentDate.Text, txtRegDate.Text, radbutCertificate.SelectedValue, radbutAquisition.SelectedValue, txtFTE.Text, txtMNax.Text, txtFedTax.Text, txtGross.Text.Replace(",", "").Trim(), ddlGrossRevYear.SelectedItem.Text, chkAppComplete.Checked.ToString(), Session["UserId"].ToString());
                    // busID = dbLibrary.idGetAFieldByQuery(qur);
                }
                else
                {
                    //Insert Business Structure
                    qur = dbLibrary.idBuildQuery("[proc_VendorDetails4]", "Insert", "", Request.QueryString["VId"], radCorp.Checked.ToString(), radArticles.SelectedValue == "Yes" ? "1" : "0", ddlOwners.SelectedValue != "Other" ? ddlOwners.SelectedValue : "Other", ddlOwners.SelectedValue == "Other" ? txtOther.Text.Trim() : string.Empty, txtDate.Text, txtShares.Text.Trim(), radFileYes.Checked == true ? "1" : "0", radPartnership.Checked.ToString(), chkPartnershipList.Items[0].Selected.ToString(), radPartnershipList.Items[0].Selected.ToString(), radPartnershipList.Items[1].Selected.ToString(), radProprietorship.Checked.ToString(), radProprietorshipList.Items[0].Selected.ToString(), radProprietorshipList.Items[1].Selected.ToString(), radNonProfit.Checked.ToString(), ChkRehabFac.Checked.ToString(), radLLC.Checked.ToString(), radLLCSign.Items[0].Selected.ToString(), radLLCFile.Items[0].Selected.ToString(), radLLCCAgree.Items[0].Selected.ToString(), radBrokerage.Checked.ToString(), rad3rdParty.Checked.ToString(), radMfg.Checked.ToString(), radmfgArticles.SelectedValue == "Yes" ? "1" : "0", radFranchise.Checked.ToString(), txtOtherBusiness.Text, otherCert.ToString(), chkDBE.Checked.ToString(), txtDBECertDate.Text, chkUSDVA.Checked.ToString(), txtVerifyDate.Text, txtExpDate.Text, chkOther.Checked.ToString(), "", txtAppDate.Text, txtCurrentDate.Text, txtRegDate.Text, radbutCertificate.SelectedValue, radbutAquisition.SelectedValue, txtFTE.Text, txtMNax.Text, txtFedTax.Text, txtGross.Text.Replace(",", "").Trim(), ddlGrossRevYear.SelectedItem.Text, chkAppComplete.Checked.ToString(), Session["UserId"].ToString());
                }
                busID = dbLibrary.idGetAFieldByQuery(qur);
                if (chkOther.Checked)
                {
                    foreach (RepeaterItem item in rptOther.Items)
                    {
                        if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                        {
                            CheckBox checkBox = (CheckBox)item.FindControl("chkOtherList");

                            if (checkBox.Checked)
                            {
                                TextBox txtbox = (TextBox)item.FindControl("txtOtherDate");
                                if (txtbox.Text == string.Empty)
                                    dtOtherDBE.Rows.Add(busID, checkBox.AccessKey);
                                else
                                    dtOtherDBE.Rows.Add(busID, checkBox.AccessKey, txtbox.Text);
                            }
                        }
                    }
                    if (dtOtherDBE.Rows.Count > 0)
                    {
                        dbLibrary.idInsertDataTable("[proc_BusOtherDBECert]", "@OtherBusArray", dtOtherDBE);
                    }
                }
                //** Below line for Rule execution **
                ruleLibrary.executeRule(Request.QueryString["VId"], Session["UserId"].ToString());
              
                Response.Redirect("vmpUsrStatus.aspx?VId=" + Request.QueryString["VId"]);
               
            }
        }

        protected void lnkGoToStatus_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["VId"] != null)
            {
                Response.Redirect("vmpUsrStatus.aspx?VId=" + Request.QueryString["VId"]);
            }
        }

        protected void lnkAttachments_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["VId"] != null)
            {
                string qur = "Select * from AttachmentInfo where vendorId=" + Request.QueryString["VId"];
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ViewState["gridAttachments"] = ds;
                grdAttachments.DataSource = ds;
                grdAttachments.DataBind();
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModalAttachments();", true);
        }

        protected void btnUploadAttachment_Click(object sender, EventArgs e)
        {
            string qur = "select vendorName from vendorDetails where vendorId=" + Request.QueryString["VId"].ToString();
            string vendorname = dbLibrary.idGetAFieldByQuery(qur);
            string vendorid = Request.QueryString["VId"].ToString();
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
                if (FileUploadAttachment.HasFile)
                {
                    FileUploadAttachment.SaveAs(vendorAttachmentPath + "\\" + FileUploadAttachment.FileName);
                    dbLibrary.idInsertInto("AttachmentInfo",
                       "vendorId", vendorid,
                       "attachmentPath", vendorAttachmentPath + "\\" + FileUploadAttachment.FileName);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect2()", true);
        }

        protected void grdAttachments_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                HyperLink lnkAttachment = e.Row.FindControl("lnkAttachment") as HyperLink;
                int n = drv["attachmentPath"].ToString().Split('\\').Length;
                string url = drv["attachmentPath"].ToString().Split('\\')[n - 4] + "/" + drv["attachmentPath"].ToString().Split('\\')[n - 3] + "/" + drv["attachmentPath"].ToString().Split('\\')[n - 2] + "/" + drv["attachmentPath"].ToString().Split('\\')[n - 1];
                //string url = drv["filePath"].ToString();
                lnkAttachment.Text = Path.GetFileNameWithoutExtension(drv["attachmentPath"].ToString());
                lnkAttachment.NavigateUrl = url;
            }
        }

        protected void grdAttachments_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdAttachments.PageIndex = e.NewPageIndex;
            grdAttachments.DataSource = (DataSet)ViewState["gridAttachments"];
            grdAttachments.DataBind();
        }
    }
}