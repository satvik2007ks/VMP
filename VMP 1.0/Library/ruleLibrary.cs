﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using VMP.Library;

namespace VMP_1._0.Library
{
    public class ruleLibrary
    {
        public static string executeRule(string VendorID, string UserID)
        {
            string appType = getApplicationType(VendorID);
            if (appType != string.Empty)
            {
                DataSet ds = getRules(appType);
                if (ds != null)
                {
                    executeRuleSet(ds, VendorID, UserID, appType);
                }
            }
            else
            {
                string noAppTypeQur = dbLibrary.idBuildQuery("[proc_insertRuleResult]", VendorID, string.Empty, string.Empty, "Denied", "Not applicable for any Application Type, No Rules executed", string.Empty);
                dbLibrary.idExecute(noAppTypeQur);
                string noAppTypefinalQur = dbLibrary.idBuildQuery("[proc_UpdateCertStatus]", VendorID, "Denied", "","", UserID);
                dbLibrary.idExecute(noAppTypefinalQur);
            }
            return appType;
        }

        private static void executeRuleSet(DataSet ds, string vendorID, string userID, string appType)
        {
            string qurDelete = "Delete from VendorRulesResult where vendorID=" + vendorID;
            dbLibrary.idExecute(qurDelete);
            bool isDeny = false;
            bool isPending = false;
            //Single Rules Execution
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                string status = string.Empty;
                if (dr["isHardcodedRule"].ToString() == "False")
                {
                    string value = string.Empty;
                    string qur = buildQuery(dr["columnName"].ToString(), dr["tableName"].ToString(), vendorID);
                    DataSet dsSuppliedValue = dbLibrary.idGetCustomResult(qur);
                    if (dsSuppliedValue.Tables[0].Rows.Count > 0)
                    {
                        value = dsSuppliedValue.Tables[0].Rows[0]["value"].ToString();
                    }
                    if (dr["condition"].ToString() == "=")
                    {
                        status = (value == dr["value"].ToString() ? "Approve" : dr["status"].ToString());
                    }
                    else if (dr["condition"].ToString() == "!=")
                    {
                        status = (value != dr["value"].ToString() ? "Approve" : dr["status"].ToString());
                    }
                    else if (dr["condition"].ToString() == ">")
                    {
                        status = (decimal.Parse(value) > decimal.Parse(dr["value"].ToString()) ? "Approve" : dr["status"].ToString());
                    }
                    else if (dr["condition"].ToString() == "<")
                    {
                        status = (decimal.Parse(value) < decimal.Parse(dr["value"].ToString()) ? "Approve" : dr["status"].ToString());
                    }
                    else if (dr["condition"].ToString() == "<=")
                    {
                        status = (decimal.Parse(value) <= decimal.Parse(dr["value"].ToString()) ? "Approve" : dr["status"].ToString());
                    }
                    else if (dr["condition"].ToString() == ">=")
                    {
                        status = (decimal.Parse(value) >= decimal.Parse(dr["value"].ToString()) ? "Approve" : dr["status"].ToString());
                    }
                    if (status == "Deny")
                    {
                        isDeny = true;
                    }
                    else if (status == "Pending")
                    {
                        isPending = true;
                    }
                    string qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, status, dr["description"].ToString(), value);
                    dbLibrary.idExecute(qry);
                }
                else
                {
                    //Hardcoded Rules Execution
                    bool noOfsharesOwnPercen = true;
                    bool hasCompleteOwnersPercentage = true;
                    string qry = string.Empty;
                    string qur = dbLibrary.idBuildQuery("[proc_getDataForHardRule]", vendorID);
                    DataSet dsHardRule = dbLibrary.idGetCustomResult(qur);
                    switch (dr["hardRuleId"].ToString())
                    {
                        case "1":
                            hasCompleteOwnersPercentage = checkOwnersPercentage(vendorID);
                            qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, hasCompleteOwnersPercentage ? "Approve" : dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                            dbLibrary.idExecute(qry);
                            status = (hasCompleteOwnersPercentage ? "Approve" : dr["status"].ToString());
                            break;
                        case "2":
                            noOfsharesOwnPercen = calculateShares(vendorID);
                            qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, noOfsharesOwnPercen ? "Approve" : dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                            dbLibrary.idExecute(qry);
                            status = (noOfsharesOwnPercen ? "Approve" : dr["status"].ToString());
                            break;
                        case "3":
                            if (dsHardRule.Tables[1].Rows.Count > 0 && dsHardRule.Tables[3].Rows.Count > 0)
                            {
                                if (dsHardRule.Tables[3].Rows[0]["corporation"].ToString() == "True")
                                {
                                    if (dsHardRule.Tables[1].Rows[0]["isCEO"].ToString() == "True" || dsHardRule.Tables[1].Rows[0]["isPresident"].ToString() == "True")
                                    {
                                        qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, "Approve", dr["description"].ToString(), string.Empty);
                                        dbLibrary.idExecute(qry);
                                        status = "Approve";
                                    }
                                    else
                                    {
                                        qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                                        dbLibrary.idExecute(qry);
                                        status = dr["status"].ToString();
                                    }
                                }
                            }
                            else
                            {
                                qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                                dbLibrary.idExecute(qry);
                                status = dr["status"].ToString();
                            }
                            break;
                        case "4":
                            if (dsHardRule.Tables[1].Rows.Count > 0)
                            {
                                if (dsHardRule.Tables[1].Rows[0]["busPlanning"].ToString() == "True" || dsHardRule.Tables[1].Rows[0]["salesMarket"].ToString() == "True" || dsHardRule.Tables[1].Rows[0]["financial"].ToString() == "True" || dsHardRule.Tables[1].Rows[0]["personnel"].ToString() == "True" || dsHardRule.Tables[1].Rows[0]["projManagement"].ToString() == "True")
                                {
                                    qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, "Approve", dr["description"].ToString(), string.Empty);
                                    dbLibrary.idExecute(qry);
                                    status = "Approve";
                                }
                                else
                                {
                                    qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                                    dbLibrary.idExecute(qry);
                                    status = dr["status"].ToString();
                                }
                            }
                            else
                            {
                                qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                                dbLibrary.idExecute(qry);
                                status = dr["status"].ToString();
                            }
                            break;
                        case "5":

                            if (dsHardRule.Tables[4].Rows.Count > 0 && dsHardRule.Tables[1].Rows.Count > 0)
                            {
                                bool hasGreaterOtherOwnerExp = false;
                                int count = 0;
                                foreach (DataRow drhardRuleData in dsHardRule.Tables[4].Rows)
                                {
                                    if (dsHardRule.Tables[1].Rows[0]["ownerID"].ToString() != dsHardRule.Tables[4].Rows[count]["ownerID"].ToString())
                                    {
                                        if (int.Parse(dsHardRule.Tables[1].Rows[0]["expCode"].ToString()) < int.Parse(dsHardRule.Tables[4].Rows[count]["expCode"].ToString()))
                                        {
                                            hasGreaterOtherOwnerExp = true;
                                        }
                                    }
                                    count++;
                                }
                                qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, hasGreaterOtherOwnerExp ? dr["status"].ToString() : "Approve", dr["description"].ToString(), string.Empty);
                                dbLibrary.idExecute(qry);
                                status = "Approve";
                            }
                            else
                            {
                                qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                                dbLibrary.idExecute(qry);
                                status = dr["status"].ToString();
                            }
                            break;
                        case "6":
                            if (dsHardRule.Tables[2].Rows.Count > 0)
                            {
                                int count = 0;
                                foreach (DataRow drhardRuleData in dsHardRule.Tables[2].Rows)
                                {
                                    if (dsHardRule.Tables[2].Rows[count]["similarBusiness"].ToString() == "True")
                                    {
                                        if (dsHardRule.Tables[5].Rows.Count > 0)
                                        {
                                            Decimal limit = decimal.Parse(dsHardRule.Tables[5].Rows[0]["smallBusinessLimit"].ToString()) * 1000000;

                                            if (limit >= Decimal.Parse(dsHardRule.Tables[2].Rows[0]["grossRevenue"].ToString()))
                                            {
                                                qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, "Approve", dr["description"].ToString(), string.Empty);
                                                dbLibrary.idExecute(qry);
                                                status = "Approve";
                                            }
                                            else
                                            {
                                                qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                                                dbLibrary.idExecute(qry);
                                                status = dr["status"].ToString();
                                            }
                                        }
                                    }
                                    count++;
                                }
                            }
                            break;
                        case "7":
                            if (dsHardRule.Tables[6].Rows.Count > 0)
                            {
                                int count = 0;
                                bool hasMoreThan20Percentage = false;
                                foreach (DataRow drhardRuleData in dsHardRule.Tables[6].Rows)
                                {
                                    if (decimal.Parse(dsHardRule.Tables[6].Rows[count]["ownershipPercentage"].ToString()) > 20)
                                    {
                                        hasMoreThan20Percentage = true;
                                        break;
                                    }
                                    count++;
                                }
                                if (hasMoreThan20Percentage)
                                {
                                    qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                                    dbLibrary.idExecute(qry);
                                    status = dr["status"].ToString();
                                }
                                else
                                {
                                    qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, "Approve", dr["description"].ToString(), string.Empty);
                                    dbLibrary.idExecute(qry);
                                    status = "Approve";
                                }
                            }
                            break;
                        case "8":
                            if (dsHardRule.Tables[7].Rows.Count > 0 && dsHardRule.Tables[5].Rows.Count > 0)
                            {
                                if (decimal.Parse(dsHardRule.Tables[7].Rows[0]["grossRevenue"].ToString()) > decimal.Parse(dsHardRule.Tables[5].Rows[0]["smallBusinessLimit"].ToString()) * 1000000)
                                {
                                    qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                                    dbLibrary.idExecute(qry);
                                    status = dr["status"].ToString();
                                }
                                else
                                {
                                    qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, "Approve", dr["description"].ToString(), string.Empty);
                                    dbLibrary.idExecute(qry);
                                    status = "Approve";
                                }
                            }
                            else
                            {
                                qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, dr["status"].ToString(), "Gross Revenue and/or Primary NAICS code missing", string.Empty);
                                dbLibrary.idExecute(qry);
                                status = dr["status"].ToString();
                            }
                            break;
                        case "9":
                            if (dsHardRule.Tables[3].Rows.Count > 0)
                            {
                                if (dsHardRule.Tables[3].Rows[0]["otherCert"].ToString() == "True")
                                {
                                    if (dsHardRule.Tables[3].Rows[0]["DBE"].ToString() == "True" || dsHardRule.Tables[3].Rows[0]["USDVA"].ToString() == "True" || dsHardRule.Tables[3].Rows[0]["otherCertOther"].ToString() == "True")
                                    {
                                        qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, "Approve", dr["description"].ToString(), string.Empty);
                                        dbLibrary.idExecute(qry);
                                        status = "Approve";
                                    }
                                    else
                                    {
                                        qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                                        dbLibrary.idExecute(qry);
                                        status = dr["status"].ToString();
                                    }
                                }
                            }
                            break;
                        case "10":
                            if (dsHardRule.Tables[3].Rows.Count > 0)
                            {
                                if (dsHardRule.Tables[3].Rows[0]["otherCertOther"].ToString() == "True")
                                {
                                    if (dsHardRule.Tables[8].Rows.Count > 0)
                                    {
                                        int count = 0;
                                        bool hasDates = true;
                                        foreach (DataRow drhardRuleData in dsHardRule.Tables[8].Rows)
                                        {
                                            if (dsHardRule.Tables[8].Rows[0]["certificateDate"] == null || dsHardRule.Tables[8].Rows[0]["certificateDate"].ToString() == string.Empty)
                                            {
                                                hasDates = false;
                                                break;
                                            }
                                            count++;
                                        }
                                        if (hasDates)
                                        {
                                            qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, "Approve", dr["description"].ToString(), string.Empty);
                                            dbLibrary.idExecute(qry);
                                            status = "Approve";
                                        }
                                        else
                                        {
                                            qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                                            dbLibrary.idExecute(qry);
                                            status = dr["status"].ToString();
                                        }
                                    }
                                    else
                                    {
                                        qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, dr["ruleID"].ToString(), string.Empty, dr["status"].ToString(), dr["description"].ToString(), string.Empty);
                                        dbLibrary.idExecute(qry);
                                        status = dr["status"].ToString();
                                    }
                                }
                            }
                            break;
                    }

                    if (status == "Deny")
                    {
                        isDeny = true;
                    }
                    else if (status == "Pending")
                    {
                        isPending = true;
                    }
                }
            }

            //Combined Rules Execution
            DataTable dtCombinedRule = ds.Tables[1];
            foreach (DataRow dr in ds.Tables[2].Rows)
            {
                var results = from DataRow myRow in dtCombinedRule.Rows
                              where (int)myRow["combinedRuleID"] == int.Parse(dr["combinedRuleID"].ToString())
                              select myRow;

                DataTable dt = results.CopyToDataTable();
                DataSet dsRuleList = new DataSet();
                dsRuleList.Tables.Add(dt);

                DataSet dsRuleSet = new DataSet();
                dsRuleSet.Tables.Add();
                dsRuleSet.Tables[0].Columns.Add("RuleId", typeof(int));
                dsRuleSet.Tables[0].Columns.Add("Order", typeof(int));
                dsRuleSet.Tables[0].Columns.Add("Result", typeof(bool));
                int count = 0;
                foreach (DataRow drRule in dsRuleList.Tables[0].Rows)
                {
                    bool result = false;
                    // Define a new dataset and add columns as RuleId, order, isAnd, Result of that rule(True or False)
                    dsRuleSet.Tables[0].Rows.Add();
                    dsRuleSet.Tables[0].Rows[count]["RuleId"] = drRule["RuleID"].ToString();
                    dsRuleSet.Tables[0].Rows[count]["Order"] = drRule["order"].ToString();

                    string value = string.Empty;
                    string qur = buildQuery(drRule["columnName"].ToString(), drRule["tableName"].ToString(), vendorID);
                    DataSet dsSuppliedValue = dbLibrary.idGetCustomResult(qur);

                    if (dsSuppliedValue.Tables[0].Rows.Count > 0)
                    {
                        value = dsSuppliedValue.Tables[0].Rows[0]["value"].ToString();
                        if (drRule["condition"].ToString() == "=")
                        {
                            result = (value == drRule["value"].ToString() ? true : false);
                        }
                        else if (drRule["condition"].ToString() == "!=")
                        {
                            result = (value != drRule["value"].ToString() ? true : false);
                        }
                        else if (drRule["condition"].ToString() == ">")
                        {
                            result = (decimal.Parse(value) > decimal.Parse(drRule["value"].ToString()) ? true : false);
                        }
                        else if (drRule["condition"].ToString() == "<")
                        {
                            result = (decimal.Parse(value) < decimal.Parse(drRule["value"].ToString()) ? true : false);
                        }
                        else if (drRule["condition"].ToString() == "<=")
                        {
                            result = (decimal.Parse(value) <= decimal.Parse(drRule["value"].ToString()) ? true : false);
                        }
                        else if (drRule["condition"].ToString() == ">=")
                        {
                            result = (decimal.Parse(value) >= decimal.Parse(drRule["value"].ToString()) ? true : false);
                        }
                    }
                    else
                    {
                        result = false;
                    }
                    dsRuleSet.Tables[0].Rows[count]["Result"] = result;
                    count++;

                }

                int max = Convert.ToInt32(dsRuleSet.Tables[0].AsEnumerable()
                        .Max(row => row["Order"]));
                bool isAnd = bool.Parse(dsRuleList.Tables[0].Rows[0]["isAnd"].ToString());
                bool isLast = false;
                bool isCombinedResult = false;
                foreach (DataRow row in dsRuleSet.Tables[0].Rows)
                {
                    isCombinedResult = false;
                    if (int.Parse(row["order"].ToString()) == max)
                    {
                        //insert only when  it is a last rule
                        isLast = true;
                    }
                    if (isAnd)
                    {
                        //And Condition
                        if (!bool.Parse(row["Result"].ToString()))
                        {
                            break;
                        }
                        else
                        {
                            isCombinedResult = true;
                        }
                    }
                    else
                    {
                        //Or Condition
                        if (bool.Parse(row["Result"].ToString()))
                        {
                            isCombinedResult = true;
                        }
                    }
                }
                if (isLast)
                {
                    //Insert
                    string status = string.Empty;
                    if (isCombinedResult)
                    {
                        status = "Approve";
                    }
                    else
                    {
                        status = dsRuleList.Tables[0].Rows[0]["status"].ToString();
                        if (status == "Deny")
                        {
                            isDeny = true;
                        }
                        else if (status == "Pending")
                        {
                            isPending = true;
                        }
                    }
                    string qry = dbLibrary.idBuildQuery("[proc_insertRuleResult]", vendorID, string.Empty, dr["combinedRuleID"].ToString(), status, dsRuleList.Tables[0].Rows[0]["description"].ToString(), string.Empty);
                    dbLibrary.idExecute(qry);
                }
            }
            // Check for any deny or pending in the status in Vendor RulesResult table and insert the final result to the VendorcertStaus
            string Finalstatus = isDeny == true ? "Denied" : isPending == true ? "Pending" : "Approved";
            string[] apptypes = new string[3];
            if (!string.IsNullOrEmpty(appType))
            {
                if (appType.Contains(","))
                {
                    apptypes = appType.Split(',');
                }
                else
                {
                    apptypes[0] = appType;
                }
            }
            string finalQur;
            string USDVAExpirationDate = CheckUSDVA(vendorID).Item2.ToString();
            string USDVAVerifyDate = CheckUSDVA(vendorID).Item1.ToString();
            if (apptypes[0].ToString() == "Veteran" && USDVAExpirationDate != string.Empty)
            {
                finalQur = dbLibrary.idBuildQuery("[proc_UpdateCertStatus]", vendorID, Finalstatus, Finalstatus == "Approved" ? USDVAExpirationDate : "", Finalstatus == "Approved" ? USDVAVerifyDate : "", userID);
            }
            else
            {
                finalQur = dbLibrary.idBuildQuery("[proc_UpdateCertStatus]", vendorID, Finalstatus, Finalstatus == "Approved" ? DateTime.Now.AddYears(1).ToString() : "","", userID);
            }
            dbLibrary.idExecute(finalQur);
        }

        private static Tuple<string,string> CheckUSDVA(string vendorID)
        {
            string USDVAExpirationDate = string.Empty;
            string USDVAVerifyDate = string.Empty;
            string qur = "select USDVA,USDVAVerifyDate, USDVAExpDate from BusinessStructure where vendorID =" + vendorID;
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["USDVA"].ToString() == "True")
                {
                    USDVAExpirationDate = ds.Tables[0].Rows[0]["USDVAExpDate"].ToString();
                    USDVAVerifyDate = ds.Tables[0].Rows[0]["USDVAVerifyDate"].ToString();
                }
            }
            return Tuple.Create(USDVAVerifyDate, USDVAExpirationDate);
        }

        private static bool calculateShares(string vendorID)
        {
            string qur = "select ownerID,ownershipPercentage,noSharesOwned from owners where isActive='1' and vendorid =" + vendorID;
            DataSet dsOwnerPercentage = dbLibrary.idGetCustomResult(qur);
            DataTable ownerTable;
            if (dsOwnerPercentage.Tables[0].Rows.Count > 0)
            {
                ownerTable = dsOwnerPercentage.Tables[0];
                object sumObject;
                sumObject = ownerTable.Compute("Sum(ownershipPercentage)", "");
                if (decimal.Parse(sumObject.ToString()) == 100M)
                {
                    object totalNoOfShares;
                    totalNoOfShares = ownerTable.Compute("Sum(noSharesOwned)", "");
                    if (string.IsNullOrEmpty(totalNoOfShares.ToString()))
                    {
                        totalNoOfShares = 0;
                    }
                    bool isRatioMatch = true;
                    if (decimal.Parse(totalNoOfShares.ToString()) > 0)
                    {
                        foreach (DataRow dr in dsOwnerPercentage.Tables[0].Rows)
                        {
                            if (decimal.Parse(dr["noSharesOwned"].ToString()) > 0 && decimal.Parse(dr["ownershipPercentage"].ToString()) > 0)
                            {
                                decimal sharesCoEfficient = Math.Round(decimal.Parse(totalNoOfShares.ToString()) / decimal.Parse(dr["noSharesOwned"].ToString()));
                                decimal ownerPercenCoEfficient = Math.Round(100 / decimal.Parse(dr["ownershipPercentage"].ToString()));
                                if (sharesCoEfficient != ownerPercenCoEfficient)
                                {
                                    isRatioMatch = false;
                                    break;
                                }
                                else
                                    isRatioMatch = true;
                            }
                            else
                                isRatioMatch = false;
                        }
                    }
                    else
                    {
                        isRatioMatch = false;
                    }
                    return isRatioMatch;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        private static bool checkOwnersPercentage(string vendorID)
        {
            string qur = "select ownerID,ownershipPercentage,noSharesOwned from owners where isActive='1' and vendorid =" + vendorID;
            DataSet dsOwnerPercentage = dbLibrary.idGetCustomResult(qur);
            if (dsOwnerPercentage.Tables[0].Rows.Count > 0)
            {
                DataTable ownerTable;
                ownerTable = dsOwnerPercentage.Tables[0];
                object sumObject;
                sumObject = ownerTable.Compute("Sum(ownershipPercentage)", "");
                if (decimal.Parse(sumObject.ToString()) == 100M)
                {

                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        private static string buildQuery(string columnName, string tableName, string vendorID)
        {
            string qur = "Select " + columnName + " as value from " + tableName + " where vendorId='" + vendorID + "'";
            if (tableName == "Owners")
            {
                qur += " and isPrimaryOwner=1";
            }
            return qur;
        }

        private static DataSet getRules(string AppType)
        {
            if (!string.IsNullOrEmpty(AppType))
            {
                string[] apptypes = new string[3];
                if (AppType.Contains(","))
                {
                    apptypes = AppType.Split(',');
                }
                else
                {
                    apptypes[0] = AppType;
                }
                string qur = dbLibrary.idBuildQuery("[proc_getRuleList]", apptypes[0]);
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                return ds;
            }
            else
                return null;
        }

        public static string getApplicationType(string vendorID)
        {
            string qur = dbLibrary.idBuildQuery("[proc_getAppType]", vendorID);
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            string AppType = string.Empty;
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (bool.Parse(ds.Tables[0].Rows[0]["black"].ToString()) || bool.Parse(ds.Tables[0].Rows[0]["hispanic"].ToString()) || bool.Parse(ds.Tables[0].Rows[0]["asian"].ToString()) ||
                    bool.Parse(ds.Tables[0].Rows[0]["indiginessAmerican"].ToString()) || bool.Parse(ds.Tables[0].Rows[0]["woman"].ToString()) || bool.Parse(ds.Tables[0].Rows[0]["physicallyDisabled"].ToString()))
                {
                    AppType = "TargetGroup,";
                }
                if (bool.Parse(ds.Tables[0].Rows[0]["veteran"].ToString()) || bool.Parse(ds.Tables[0].Rows[0]["serviceDisabled"].ToString()))
                {
                    AppType += "Veteran,";
                }
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                if (ds.Tables[1].Rows[0]["classificationId"].ToString() != string.Empty)
                {
                    AppType += "ED,";
                }
            }
            AppType = AppType.TrimEnd(',');
            return AppType;
        }
    }
}