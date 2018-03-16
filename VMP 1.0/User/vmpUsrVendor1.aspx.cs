﻿using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using VMP.Library;
using VMP_1._0.Library;

namespace VMP_1._0.User
{
    public partial class vmpUsrVendor1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            if (!IsPostBack)
            {
                loadAllDDL();
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
                    loadAllValues();
                    loadStepsProgress();

                }
                else
                {
                    divStep1.Attributes.Add("class", "col-xs-3 bs-wizard-step active");
                    divStep2.Attributes.Add("class", "col-xs-3 bs-wizard-step disabled");
                    divStep3.Attributes.Add("class", "col-xs-3 bs-wizard-step disabled");
                    divStep4.Attributes.Add("class", "col-xs-3 bs-wizard-step disabled");
                }
                if (hdnFourthPageComplete.Value == "True")
                {
                    divExecute.Attributes.Add("Style", "display:block");
                    lnkGoToStatus.Attributes.Add("style", "display:block");
                    lnkAttachments.Attributes.Add("style", "display:block");
                }
                else
                {
                    divExecute.Attributes.Add("Style", "display:none");
                    lnkGoToStatus.Attributes.Add("style", "display:none");
                    lnkAttachments.Attributes.Add("style", "display:none");
                }
                if (Request.QueryString["EditMode"] != null)
                {
                    heading.InnerText = "Edit Vendor";
                }
            }
            else
            {
                loadSecNaicCodes();
            }

        }

        // Set Step 1, 2, 3 & 4 CSS Classes based on completion 
        private void loadStepsProgress()
        {
            string qur = dbLibrary.idBuildQuery("proc_getNewVendorProgress", Request.QueryString["VId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if ((bool)ds.Tables[0].Rows[0]["step4"] == true)
                {
                    divStep4.Attributes.Add("class", "col-xs-3 bs-wizard-step complete");
                    divStep3.Attributes.Add("class", "col-xs-3 bs-wizard-step complete");
                    divStep2.Attributes.Add("class", "col-xs-3 bs-wizard-step complete");
                    divStep1.Attributes.Add("class", "col-xs-3 bs-wizard-step active activecomplete");
                    hdnFourthPageComplete.Value = "True";

                }
                else
                {
                    divStep4.Attributes.Add("class", "col-xs-3 bs-wizard-step disabled");
                    if ((bool)ds.Tables[0].Rows[0]["step3"] == true)
                    {
                        divStep2.Attributes.Add("class", "col-xs-3 bs-wizard-step complete");
                        divStep3.Attributes.Add("class", "col-xs-3 bs-wizard-step complete lastcomplete");
                        divStep1.Attributes.Add("class", "col-xs-3 bs-wizard-step active activecomplete");
                    }
                    else
                    {
                        divStep3.Attributes.Add("class", "col-xs-3 bs-wizard-step disabled");
                        if ((bool)ds.Tables[0].Rows[0]["step2"] == true)
                        {
                            divStep2.Attributes.Add("class", "col-xs-3 bs-wizard-step complete lastcomplete");
                            divStep1.Attributes.Add("class", "col-xs-3 bs-wizard-step active activecomplete");
                        }
                        else
                        {
                            divStep2.Attributes.Add("class", "col-xs-3 bs-wizard-step disabled");
                            divStep1.Attributes.Add("class", "col-xs-3 bs-wizard-step active");
                        }
                    }
                }
            }
            else
            {
                //This will be executed only once for the old data (From Old System) to update the steps progress bar 
                dbLibrary.idInsertInto("AddVendorProgress",
                    "vendorId", Request.QueryString["VId"],
                    "step1", "True",
                    "step2", "True",
                    "step3", "True",
                    "step4", "True");
                loadStepsProgress();
            }
        }


        // Loading all the values to the fields if it is present in the database
        private void loadAllValues()
        {
            string qur = "Select * from VendorDetails where vendorId=" + Request.QueryString["VId"];
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count != 0)
            {
                txtVName.Text = ds.Tables[0].Rows[0]["vendorName"].ToString();
                //Assign hidden field to compare whether vendor has been changed or not
                hdnFieldVendorName.Value = ds.Tables[0].Rows[0]["vendorName"].ToString();
                txtBName.Text = ds.Tables[0].Rows[0]["businessName"].ToString();
                ddlSpecialist.SelectedValue = ds.Tables[0].Rows[0]["specialistId"].ToString();
                txtSwift.Text = ds.Tables[0].Rows[0]["swiftNumber"].ToString();
                ddlPNAIC.SelectedValue = ds.Tables[0].Rows[0]["primaryNaicId"].ToString();
                ddlPNAIC_SelectedIndexChanged1(ddlPNAIC.SelectedValue, EventArgs.Empty);
                if (ddlPNAIC.SelectedValue != "-1")
                {
                    divSNaic.Attributes.Add("style", "display:block");
                    string qur1 = "Select * from VendorSNAICCodes where vendorId=" + Request.QueryString["VId"];
                    DataSet dsSec = dbLibrary.idGetCustomResult(qur1);
                    int count = dsSec.Tables[0].Rows.Count;
                    int checkedcount = 0;
                    foreach (DataRow dr in dsSec.Tables[0].Rows)
                    {
                        foreach (ListItem li in chkbxSNaic.Items)
                        {
                            if (dr["secNaicId"].ToString() == li.Value)
                            {
                                li.Selected = true;
                                chkbxSNaic_SelectedIndexChanged(li, EventArgs.Empty);
                                checkedcount++;
                                if (checkedcount == count)
                                {
                                    goto End;
                                }
                                else
                                {
                                    break;
                                }
                            }
                        }
                    }
                    End:;
                }
                else
                {
                    divSNaic.Attributes.Add("style", "display:none");
                }
                txtPDesc.Text = ds.Tables[0].Rows[0]["productDesc"].ToString();
                if (ds.Tables[0].Rows[0]["NEOSERRA"].ToString() == "True")
                {
                    chkNEOSERRA.Checked = true;
                }
                else
                {
                    chkNEOSERRA.Checked = false;
                }
                txtPAddress.Text = ds.Tables[0].Rows[0]["address"].ToString();
                txtCity.Text = ds.Tables[0].Rows[0]["city"].ToString();
                ddlState.SelectedValue = ds.Tables[0].Rows[0]["state"].ToString();
                ddlCounty.SelectedValue = ds.Tables[0].Rows[0]["regionId"].ToString();
                ddlCounty_SelectedIndexChanged(this, EventArgs.Empty);
                txtZip.Text = ds.Tables[0].Rows[0]["zipCode"].ToString();
                txtTelephone.Text = ds.Tables[0].Rows[0]["telephone"].ToString();
                txtCellphone.Text = ds.Tables[0].Rows[0]["cellphone"].ToString();
                txtOtherPhone.Text = ds.Tables[0].Rows[0]["otherPhone"].ToString();
                txtFax.Text = ds.Tables[0].Rows[0]["fax"].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0]["emailId"].ToString();
                txtWebAddress.Text = ds.Tables[0].Rows[0]["webAddress"].ToString();
            }
        }

        //Methods to load all dropdowns
        private void loadAllDDL()
        {
            loadspecialist();
            loadNaicCodes();
            loadCounty();
            ddlState.SelectedValue = "MN";
        }

        //Load dropdown County and checkboxlist EDR
        private void loadCounty()
        {
            string qur = "EXEC [proc_getCounty]";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds != null)
            {
                ddlCounty.DataValueField = "regionId";
                ddlCounty.DataTextField = "region";
                ddlCounty.DataSource = ds;
                ddlCounty.DataBind();
                ddlCounty.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlCounty.SelectedValue = "-1";

            }

            qur = "EXEC [proc_getEDR]";
            DataSet dsEDR = dbLibrary.idGetCustomResult(qur);
            if (dsEDR != null)
            {
                chkEDR.DataValueField = "ClassificationId";
                chkEDR.DataTextField = "ClassificationDesc";
                chkEDR.DataSource = dsEDR;
                chkEDR.DataBind();
            }
            qur = "EXEC [proc_getCountyEDR]";
            DataSet dsCountyEDR = dbLibrary.idGetCustomResult(qur);
            if (dsCountyEDR != null)
            {
                ViewState["county"] = dsCountyEDR;
            }

        }

        //Loading all primary NAIC Codes to the dropdown
        private void loadNaicCodes()
        {
            string qur = "EXEC [proc_getNAICCode]";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds != null)
            {
                //Primary NAIC Code
                ddlPNAIC.DataValueField = "naicId";
                ddlPNAIC.DataTextField = "naicCode";
                ddlPNAIC.DataSource = ds;
                ddlPNAIC.DataBind();
                ddlPNAIC.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlPNAIC.SelectedValue = "-1";
                LoadPrimarytooltip();

                //Secondary NAIC Codes
                //chkbxSNaic.DataValueField = "naicId";
                //chkbxSNaic.DataTextField = "naicCode";
                //chkbxSNaic.DataSource = ds;
                //chkbxSNaic.DataBind();
                //LoadSecondaryTooltip();
            }
        }

        //Loading all secondary NAIC Codes to the checkboxlist
        private void loadSecondaryNaicChkBox()
        {
            string qur = "EXEC [proc_getNAICCode]";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds != null)
            {
                chkbxSNaic.DataValueField = "naicId";
                chkbxSNaic.DataTextField = "naicCode";
                chkbxSNaic.DataSource = ds;
                chkbxSNaic.DataBind();
                LoadSecondaryTooltip();
            }
        }

        //Load the specialist dropdown
        private void loadspecialist()
        {
            string qur = "EXEC [proc_getUserList]";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds != null)
            {
                ddlSpecialist.DataValueField = "userId";
                ddlSpecialist.DataTextField = "Name";
                ddlSpecialist.DataSource = ds;
                ddlSpecialist.DataBind();
                ddlSpecialist.SelectedValue = Session["UserId"].ToString();
            }
        }

        //Adding tooltip to the Secondary NAIC codes                    
        private void LoadSecondaryTooltip()
        {
            string qur = "EXEC [proc_getNAICCode]";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds != null)
            {
                foreach (ListItem li in chkbxSNaic.Items)
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

        //Adding tooltip to the Primary NAIC codes
        private void LoadPrimarytooltip()
        {
            string qur = "EXEC [proc_getNAICCode]";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds != null)
            {
                foreach (ListItem li in ddlPNAIC.Items)
                {
                    if (li.Value == "-1")
                    {
                        continue;
                    }
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        if (li.Value == dr.ItemArray[0].ToString())
                        {
                            //li.Attributes.Add("data-placement", "right");
                            //li.Attributes.Add("class", "tooltips");
                            li.Attributes.Add("title", dr.ItemArray[2].ToString());
                            continue;
                        }
                    }
                }
            }
        }

        //Load Secondary NAIC Codes
        private void loadSecNaicCodes()
        {
            pnldivlist.Controls.Clear();
            foreach (ListItem li in chkbxSNaic.Items)
            {
                if (li.Selected == true)
                {
                    string text = li.Text;
                    HtmlGenericControl div = new HtmlGenericControl();
                    div.TagName = "div";
                    div.Style.Add("width", "105px");
                    div.Style.Add("display", "inline-block");
                    div.ID = "div" + li.Value;
                    div.Attributes.Add("runat", "server");
                    HtmlGenericControl span = new HtmlGenericControl();
                    span.TagName = "span";
                    span.Attributes.Add("class", "userdef");
                    HtmlGenericControl span1 = new HtmlGenericControl();
                    span1.TagName = "span";
                    span1.InnerText = text;
                    LinkButton lnk = new LinkButton();
                    lnk.ID = "lnk" + li.Value;
                    lnk.CommandArgument = li.Value;
                    lnk.CssClass = "custom";
                    lnk.Text = "x";
                    lnk.Click += new EventHandler(lnk_Click);
                    span.Controls.Add(span1);
                    span.Controls.Add(lnk);
                    div.Controls.Add(span);
                    pnldivlist.Controls.Add(div);
                }
                else
                {
                    string id = "div" + li.Value;
                    Control myControl1 = pnldivlist.FindControl(id);
                    if (myControl1 != null)
                    {
                        pnldivlist.Controls.Remove(myControl1);
                    }
                }
            }
        }

        //Button proceed : Save all the details and go to next page
        protected void btnNext1_Click(object sender, EventArgs e)
        {
            string ResultVendorID;
            //Condition to validate whether a new vendor or updating is being done.
            if (Request.QueryString["VId"] == null)
            {
                if (CheckVendorSimilarity(txtVName.Text).Tables[0].Rows.Count <= 0)
                {
                    ResultVendorID = SaveAllValues();
                    if (hdnFourthPageComplete.Value == "True")
                    {
                        ruleLibrary.executeRule(Request.QueryString["VId"], Session["UserId"].ToString());
                    }
                    Response.Redirect("vmpUsrVendor2.aspx?VId=" + ResultVendorID);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModal();", true);
                }
            }
            else
            {
                if (hdnFieldVendorName.Value == txtVName.Text)
                {
                    ResultVendorID = SaveAllValues();
                    if (hdnFourthPageComplete.Value == "True")
                    {
                        ruleLibrary.executeRule(Request.QueryString["VId"], Session["UserId"].ToString());
                    }
                    if (Request.QueryString["EditMode"] == null)
                    {
                        Response.Redirect("vmpUsrVendor2.aspx?VId=" + ResultVendorID);
                    }
                    else
                    {
                        Response.Redirect("vmpUsrVendor2.aspx?VId=" + ResultVendorID + "&EditMode=True");
                    }
                }
                else
                {
                    if (CheckVendorSimilarity(txtVName.Text).Tables[0].Rows.Count <= 0)
                    {
                        ResultVendorID = SaveAllValues();
                        if (hdnFourthPageComplete.Value == "True")
                        {
                            ruleLibrary.executeRule(Request.QueryString["VId"], Session["UserId"].ToString());
                        }
                        if (Request.QueryString["EditMode"] == null)
                        {
                            Response.Redirect("vmpUsrVendor2.aspx?VId=" + ResultVendorID);
                        }
                        else
                        {
                            Response.Redirect("vmpUsrVendor2.aspx?VId=" + ResultVendorID + "&EditMode=True");
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModal();", true);
                    }
                }
            }
        }
        /*
         * CheckVendorSimilarity is created to verify whether there are any similar vendors already in database
         * This method will return the string if there are matching records else a empty string will be returned
         * As per ther requirment alert message should show the matching records as well
         * */
        private DataSet CheckVendorSimilarity(string vendorName)
        {
            string vendorNameForQur;
            string qur = string.Empty;
            vendorNameForQur = vendorName.Replace("'", "''").Trim();
            if (vendorNameForQur.Contains(" "))
            {
                string[] vendorstrArray = vendorNameForQur.Split(' ');
                vendorNameForQur = vendorstrArray[0] + " " + vendorstrArray[1];
                qur = "SELECT top 10 vendorName,ownerFirstName + ' ' + ownerLastName as Name,VendorDetails.address FROM VendorDetails left outer join Owners on Owners.vendorID  = VendorDetails.vendorId and Owners.isPrimaryOwner ='1' where VendorDetails.vendorName like '%" + vendorNameForQur + "%'";
            }
            else
            {
                qur = "SELECT top 10 vendorName,ownerFirstName + ' ' + ownerLastName as Name,VendorDetails.address FROM VendorDetails left outer join Owners on Owners.vendorID  = VendorDetails.vendorId and Owners.isPrimaryOwner ='1' where VendorDetails.vendorName like '" + vendorNameForQur + "'";
            }
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds != null)
            {

                grdSimilarVendor.DataSource = ds;
                grdSimilarVendor.DataBind();
            }
            return ds;
        }

        //This method is used to save and update all the values entered in the page.
        private string SaveAllValues()
        {
            string ResultVendorID = "";
            string qur = string.Empty;
            if (Request.QueryString["VId"] != null)
            {
                qur = dbLibrary.idBuildQuery("[proc_VendorDetails1]", "Update", Request.QueryString["VId"], txtVName.Text.Trim(), txtBName.Text != "" ? txtBName.Text.Trim() : "", ddlSpecialist.SelectedValue, txtSwift.Text != "" ? txtSwift.Text.Trim() : "", ddlPNAIC.SelectedValue, txtPDesc.Text != "" ? txtPDesc.Text.Trim() : "", txtPAddress.Text != "" ? txtPAddress.Text.Trim() : "", txtCity.Text != "" ? txtCity.Text.Trim() : "", ddlState.SelectedValue, ddlCounty.SelectedValue, txtZip.Text != "" ? txtZip.Text.Trim() : "", txtTelephone.Text != "" ? txtTelephone.Text.Trim() : "", txtCellphone.Text != "" ? txtCellphone.Text.Trim() : "", txtOtherPhone.Text != "" ? txtOtherPhone.Text.Trim() : "", txtFax.Text != "" ? txtFax.Text.Trim() : "", txtEmail.Text != "" ? txtEmail.Text.Trim() : "", txtWebAddress.Text != "" ? txtWebAddress.Text.Trim() : "", chkNEOSERRA.Checked.ToString(), Session["UserId"].ToString());
            }
            else
            {
                qur = dbLibrary.idBuildQuery("[proc_VendorDetails1]", "Insert", "", txtVName.Text.Trim(), txtBName.Text != "" ? txtBName.Text.Trim() : "", ddlSpecialist.SelectedValue, txtSwift.Text != "" ? txtSwift.Text.Trim() : "", ddlPNAIC.SelectedValue, txtPDesc.Text != "" ? txtPDesc.Text.Trim() : "", txtPAddress.Text != "" ? txtPAddress.Text.Trim() : "", txtCity.Text != "" ? txtCity.Text.Trim() : "", ddlState.SelectedValue, ddlCounty.SelectedValue, txtZip.Text != "" ? txtZip.Text.Trim() : "", txtTelephone.Text != "" ? txtTelephone.Text.Trim() : "", txtCellphone.Text != "" ? txtCellphone.Text.Trim() : "", txtOtherPhone.Text != "" ? txtOtherPhone.Text.Trim() : "", txtFax.Text != "" ? txtFax.Text.Trim() : "", txtEmail.Text != "" ? txtEmail.Text.Trim() : "", txtWebAddress.Text != "" ? txtWebAddress.Text.Trim() : "", chkNEOSERRA.Checked.ToString(), Session["UserId"].ToString());
            }

            ResultVendorID = dbLibrary.idGetAFieldByQuery(qur);

            DataTable dtSecondary = new DataTable();
            dtSecondary.Columns.Add("vendorId");
            dtSecondary.Columns.Add("secNaicId");

            if (ddlPNAIC.SelectedValue != "-1")
            {
                foreach (ListItem li in chkbxSNaic.Items)
                {
                    if (li.Selected == true)
                    {
                        dtSecondary.Rows.Add(ResultVendorID, li.Value);
                    }
                }
            }
            if (dtSecondary.Rows.Count != 0)
            {
                qur = "Delete from VendorSNAICCodes where vendorId=" + ResultVendorID;
                dbLibrary.idExecute(qur);
                dbLibrary.idInsertDataTable("[proc_VendorSecNAICCodes]", "@SecArray", dtSecondary);
            }

            return ResultVendorID;
        }


        protected void chkbxSNaic_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadSecNaicCodes();
            LoadSecondaryTooltip();
        }

        protected void lnk_Click(object sender, EventArgs e)
        {
            LinkButton lnk = sender as LinkButton;
            foreach (ListItem li in chkbxSNaic.Items)
            {
                if (li.Value == lnk.CommandArgument)
                {
                    li.Selected = false;
                }
            }
            loadSecNaicCodes();
        }

        protected void ddlPNAIC_SelectedIndexChanged1(object sender, EventArgs e)
        {
            if (ddlPNAIC.SelectedIndex != 0)
            {
                divSNaic.Attributes.Add("style", "display:block");
            }
            else
            {
                divSNaic.Attributes.Add("style", "display:none");
            }
            LoadPrimarytooltip();
            loadSecondaryNaicChkBox();
            LoadSecondaryTooltip();
            chkbxSNaic.Items.Remove(ddlPNAIC.SelectedItem);
            updatePnnSNAIC.Update();
        }

        protected void ddlCounty_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCounty.SelectedIndex != 0)
            {
                divEdr.Attributes.Add("style", "display:block");
            }
            else
            {
                divEdr.Attributes.Add("style", "display:none");
            }
            DataSet ds = (DataSet)ViewState["county"];

            DataTable dtEDR = ds.Tables[0];

            var results = from DataRow myRow in dtEDR.Rows
                          where (int)myRow["regionId"] == int.Parse(ddlCounty.SelectedValue)
                          select myRow["classificationId"];
            foreach (ListItem li in chkEDR.Items)
            {
                li.Enabled = true;
                li.Selected = false;
            }
            int hasValues = 0;
            foreach (var m in results)
            {
                hasValues = 1;
                foreach (ListItem li in chkEDR.Items)
                {
                    if (li.Value == m.ToString())
                    {
                        li.Enabled = true;
                        li.Selected = true;
                    }
                    li.Enabled = false;
                }
            }
            if (hasValues == 0)
            {
                foreach (ListItem li in chkEDR.Items)
                {
                    li.Enabled = false;
                    li.Selected = false;
                }
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

        protected void lnkStep4_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["EditMode"] == null)
            {
                Response.Redirect("vmpUsrVendor4.aspx?VId=" + Request.QueryString["VId"]);
            }
            else
            {
                Response.Redirect("vmpUsrVendor4.aspx?VId=" + Request.QueryString["VId"] + "&EditMode=True");
            }
        }

        protected void btnModalSaveProceed_Click(object sender, EventArgs e)
        {
            string ResultVendorID = SaveAllValues();
            if (hdnFourthPageComplete.Value == "True")
            {
                ruleLibrary.executeRule(Request.QueryString["VId"], Session["UserId"].ToString());
            }
            if (Request.QueryString["EditMode"] == null)
            {
                Response.Redirect("vmpUsrVendor2.aspx?VId=" + ResultVendorID);
            }
            else
            {
                Response.Redirect("vmpUsrVendor2.aspx?VId=" + ResultVendorID + "&EditMode=True");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string ResultVendorID = SaveAllValues();
            if (Request.QueryString["EditMode"] == null)
            {
                Response.Redirect("vmpUsrVendor2.aspx?VId=" + ResultVendorID);
            }
            else
            {
                Response.Redirect("vmpUsrVendor2.aspx?VId=" + ResultVendorID + "&EditMode=True");
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
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }

        protected void grdAttachments_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdAttachments.PageIndex = e.NewPageIndex;
            grdAttachments.DataSource = (DataSet)ViewState["gridAttachments"];
            grdAttachments.DataBind();
        }
    }
}