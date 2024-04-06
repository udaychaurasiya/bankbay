// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
  String? message;
  String? status;
  int? page;
  int? limit;
  int? allLeadecount;
  int? activeLeadecount;
  int? droppedLeadecount;
  UserDetailsData data;

  UserDetailsModel({
    this.message,
    this.status,
    this.page,
    this.limit,
    this.allLeadecount,
    this.activeLeadecount,
    this.droppedLeadecount,
    required this.data,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
    message: json["message"],
    status: json["status"],
    page: json["page"],
    limit: json["limit"],
    allLeadecount: json["allLeadecount"],
    activeLeadecount: json["activeLeadecount"],
    droppedLeadecount: json["droppedLeadecount"],
    data: UserDetailsData.fromJson(json["data"]??""),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "page": page,
    "limit": limit,
    "allLeadecount": allLeadecount,
    "activeLeadecount": activeLeadecount,
    "droppedLeadecount": droppedLeadecount,
    "data": data.toJson(),
  };
}

class UserDetailsData {
  UserDetails details;
  PartnerDetails partnerdetails;
  List<Remark> remarks;
  List<AllLeade> allLeade;
  PartnerAccess access;

  UserDetailsData({
    required this.details,
    required this.partnerdetails,
    required this.remarks,
    required this.allLeade,
    required this.access,
  });

  factory UserDetailsData.fromJson(Map<String, dynamic> json) => UserDetailsData(
    details: UserDetails.fromJson(json["details"]),
    partnerdetails: PartnerDetails.fromJson(json["partnerdetails"]),
    remarks: List<Remark>.from(json["Remarks"].map((x) => Remark.fromJson(x))),
    allLeade: List<AllLeade>.from(json["allLeade"].map((x) => AllLeade.fromJson(x))),
    access: PartnerAccess.fromJson(json["access"]),
  );

  Map<String, dynamic> toJson() => {
    "details": details.toJson(),
    "partnerdetails": partnerdetails.toJson(),
    "Remarks": List<dynamic>.from(remarks.map((x) => x.toJson())),
    "allLeade": List<dynamic>.from(allLeade.map((x) => x.toJson())),
    "access": access.toJson(),
  };
}

class Remark {
  dynamic id;
  dynamic pid;
  String? remark;
  String? remarkDateTime;
  String? remarkUpdateBy;
  String? updateByName;

  Remark({
    this.id,
    this.pid,
    this.remark,
    this.remarkDateTime,
    this.remarkUpdateBy,
    this.updateByName,
  });

  factory Remark.fromJson(Map<String, dynamic> json) => Remark(
    id: json["id"],
    pid: json["pid"],
    remark: json["remark"],
    remarkDateTime: json["remark_date_time"],
    remarkUpdateBy: json["remark_update_by"],
    updateByName: json["update_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pid": pid,
    "remark": remark,
    "remark_date_time": remarkDateTime,
    "remark_update_by": remarkUpdateBy,
    "update_by_name": updateByName,
  };
}


class PartnerAccess {
  dynamic id;
  dynamic userId;
  dynamic accessChangeCount;
  String? accessChangeBy;
  String? changeByName;
  String? accessChangeDateTime;
  String? isStatus;
  String? empViewAll;
  String? addEmp;
  String? updateEmp;
  String? empPushBack;
  String? empApprove;
  String? empPendingApproval;
  String? partnerViewAll;
  String? partnerAdd;
  String? partnerUpdate;
  String? partnerPushBack;
  String? partnerPendingApproval;
  String? unassignedLeads;
  String? assignAllLead;
  String? assignMyLead;
  String? assignMyteamLead;
  String? assignMypartnerLead;
  String? addLead;
  String? myLead;
  String? myteamLead;
  String? mypartnerLead;
  String? allCust;
  String? myCust;
  String? myteamCust;
  String? mypartnerCust;
  String? mySales;
  String? incentiveMgmtView;
  String? incentiveMgmtEdit;
  String? applySelfLoan;
  String? panelManageEmployee;
  String? panelManagePartner;
  String? panelManageCustomer;
  String? newLeadTab;
  String? verificationLeadTab;
  String? disbursedLeadTab;
  String? incentiveLeadTab;
  String? assignementChangeApproval;

  PartnerAccess({
    this.id,
    this.userId,
    this.accessChangeCount,
    this.accessChangeBy,
    this.changeByName,
    this.accessChangeDateTime,
    this.isStatus,
    this.empViewAll,
    this.addEmp,
    this.updateEmp,
    this.empPushBack,
    this.empApprove,
    this.empPendingApproval,
    this.partnerViewAll,
    this.partnerAdd,
    this.partnerUpdate,
    this.partnerPushBack,
    this.partnerPendingApproval,
    this.unassignedLeads,
    this.assignAllLead,
    this.assignMyLead,
    this.assignMyteamLead,
    this.assignMypartnerLead,
    this.addLead,
    this.myLead,
    this.myteamLead,
    this.mypartnerLead,
    this.allCust,
    this.myCust,
    this.myteamCust,
    this.mypartnerCust,
    this.mySales,
    this.incentiveMgmtView,
    this.incentiveMgmtEdit,
    this.applySelfLoan,
    this.panelManageEmployee,
    this.panelManagePartner,
    this.panelManageCustomer,
    this.newLeadTab,
    this.verificationLeadTab,
    this.disbursedLeadTab,
    this.incentiveLeadTab,
    this.assignementChangeApproval,
  });

  factory PartnerAccess.fromJson(Map<String, dynamic> json) => PartnerAccess(
    id: json["id"],
    userId: json["user_id"],
    accessChangeCount: json["access_change_count"],
    accessChangeBy: json["access_change_by"],
    changeByName: json["change_by_name"],
    accessChangeDateTime: json["access_change_date_time"],
    isStatus: json["is_status"],
    empViewAll: json["emp_view_all"],
    addEmp: json["add_emp"],
    updateEmp: json["update_emp"],
    empPushBack: json["emp_push_back"],
    empApprove: json["emp_approve"],
    empPendingApproval: json["emp_pending_approval"],
    partnerViewAll: json["partner_view_all"],
    partnerAdd: json["partner_add"],
    partnerUpdate: json["partner_update"],
    partnerPushBack: json["partner_push_back"],
    partnerPendingApproval: json["partner_pending_approval"],
    unassignedLeads: json["unassigned_leads"],
    assignAllLead: json["assign_all_lead"],
    assignMyLead: json["assign_my_lead"],
    assignMyteamLead: json["assign_myteam_lead"],
    assignMypartnerLead: json["assign_mypartner_lead"],
    addLead: json["add_lead"],
    myLead: json["my_lead"],
    myteamLead: json["myteam_lead"],
    mypartnerLead: json["mypartner_lead"],
    allCust: json["all_cust"],
    myCust: json["my_cust"],
    myteamCust: json["myteam_cust"],
    mypartnerCust: json["mypartner_cust"],
    mySales: json["my_sales"],
    incentiveMgmtView: json["incentive_mgmt_view"],
    incentiveMgmtEdit: json["incentive_mgmt_edit"],
    applySelfLoan: json["apply_self_loan"],
    panelManageEmployee: json["panel_manage_employee"],
    panelManagePartner: json["panel_manage_partner"],
    panelManageCustomer: json["panel_manage_customer"],
    newLeadTab: json["new_lead_tab"],
    verificationLeadTab: json["verification_lead_tab"],
    disbursedLeadTab: json["disbursed_lead_tab"],
    incentiveLeadTab: json["incentive_lead_tab"],
    assignementChangeApproval: json["assignement_change_approval"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "access_change_count": accessChangeCount,
    "access_change_by": accessChangeBy,
    "change_by_name": changeByName,
    "access_change_date_time": accessChangeDateTime,
    "is_status": isStatus,
    "emp_view_all": empViewAll,
    "add_emp": addEmp,
    "update_emp": updateEmp,
    "emp_push_back": empPushBack,
    "emp_approve": empApprove,
    "emp_pending_approval": empPendingApproval,
    "partner_view_all": partnerViewAll,
    "partner_add": partnerAdd,
    "partner_update": partnerUpdate,
    "partner_push_back": partnerPushBack,
    "partner_pending_approval": partnerPendingApproval,
    "unassigned_leads": unassignedLeads,
    "assign_all_lead": assignAllLead,
    "assign_my_lead": assignMyLead,
    "assign_myteam_lead": assignMyteamLead,
    "assign_mypartner_lead": assignMypartnerLead,
    "add_lead": addLead,
    "my_lead": myLead,
    "myteam_lead": myteamLead,
    "mypartner_lead": mypartnerLead,
    "all_cust": allCust,
    "my_cust": myCust,
    "myteam_cust": myteamCust,
    "mypartner_cust": mypartnerCust,
    "my_sales": mySales,
    "incentive_mgmt_view": incentiveMgmtView,
    "incentive_mgmt_edit": incentiveMgmtEdit,
    "apply_self_loan": applySelfLoan,
    "panel_manage_employee": panelManageEmployee,
    "panel_manage_partner": panelManagePartner,
    "panel_manage_customer": panelManageCustomer,
    "new_lead_tab": newLeadTab,
    "verification_lead_tab": verificationLeadTab,
    "disbursed_lead_tab": disbursedLeadTab,
    "incentive_lead_tab": incentiveLeadTab,
    "assignement_change_approval": assignementChangeApproval,
  };
}

class AllLeade {
  dynamic id;
  dynamic leadId;
  dynamic custId;
  String? custName;
  String? leadType;
  String? leadDateTime;
  String? leadSource;
  int? loanAmount;
  int? loanTurner;
  int? leadAssignChangeCount;
  String? leadAssignHistory;
  String? leadAssignTele;
  String? leadAssignFos;
  String? leadAssignPartner;
  String? firstCallDateTime;
  String? lastCallDateTime;
  String? followupCreatedBy;
  int? followupCount;
  String? nextFollowupDate;
  dynamic nextFollowupTime;
  String? leadRemark;
  String? loginBankName;
  String? bankDocSubmitDate;
  String? bankLoginDate;
  String? loanAppId;
  String? loginAmount;
  String? loginTenure;
  String? applicationForm;
  String? leadStatus;
  String? leadDropCat;
  String? sancDate;
  int? sancAmt;
  String? sancRoi;
  String? syncTenure;
  String? syncLatter;
  int? sancDuration;
  int? disbAmt;
  String? disbRoi;
  int? disbDuration;
  String? disbTenure;
  String? disbBankName;
  String? disbBankAccountName;
  String? disbBankAccountNo;
  String? disbBankIfsc;
  String? disbMethod;
  dynamic disbDate;
  String? disbLatter;
  String? custGender;
  String? custPhone;
  String? custEmail;
  String? custPan;
  String? custAadhar;
  String? custPassport;
  String? custEducation;
  int? custIncome;
  int? custNetSalary;
  int? custEmi;
  int? custFoir;
  String? custCompany;
  String? custCompanyType;
  String? custCompanyAddress;
  String? custMaritalStatus;
  String? custRefContact;
  String? custLocIp;
  String? custPresentAddress;
  String? custPermanentAddress;
  String? custOhpAddress;
  String? propertyOwnerType;
  String? addressProofType;
  String? leadLockStatus;
  String? lockedBy;
  String? accTrxDate;
  String? accTrxId;
  String? docPan;
  String? docAadhar;
  String? docPassport;
  String? docSalaryslip;
  String? docBanking;
  String? docOhp;
  String? docRelationProof;
  String? docPresentAddress;
  String? docPermanentAddress;
  String? custLoanSelfie;
  String? docPanVerifyStatus;
  String? docAadharVerifyStatus;
  dynamic docPassportVerifyStatus;
  String? docSalaryslipVerifyStatus;
  String? docBankingVerifyStatus;
  String? docOhpVerifyStatus;
  String? docRelationProofVerifyStatus;
  dynamic docPresentAddressVerifyStatus;
  dynamic docPermanentAddressVerifyStatus;
  String? custLoanSelfieVerifyStatus;
  String? createdByName;
  String? teleAssignEmpId;
  String? teleAssignEmpName;
  String? teleAssignSupId;
  String? teleAssignEmpAddress;
  String? teleAssignEmpPincode;
  String? teleSupName;
  dynamic fosAssignEmpId;
  dynamic fosAssignEmpName;
  dynamic fosAssignSupId;
  dynamic fosAssignEmpAddress;
  dynamic fosAssignEmpPincode;
  dynamic fosSupName;
  // List<CustActiveLoan> custActiveLoan;
  List<History> history;

  AllLeade({
    this.id,
    this.leadId,
    this.custId,
    this.custName,
    this.leadType,
    this.leadDateTime,
    this.leadSource,
    this.loanAmount,
    this.loanTurner,
    this.leadAssignChangeCount,
    this.leadAssignHistory,
    this.leadAssignTele,
    this.leadAssignFos,
    this.leadAssignPartner,
    this.firstCallDateTime,
    this.lastCallDateTime,
    this.followupCreatedBy,
    this.followupCount,
    this.nextFollowupDate,
    this.nextFollowupTime,
    this.leadRemark,
    this.loginBankName,
    this.bankDocSubmitDate,
    this.bankLoginDate,
    this.loanAppId,
    this.loginAmount,
    this.loginTenure,
    this.applicationForm,
    this.leadStatus,
    this.leadDropCat,
    this.sancDate,
    this.sancAmt,
    this.sancRoi,
    this.syncTenure,
    this.syncLatter,
    this.sancDuration,
    this.disbAmt,
    this.disbRoi,
    this.disbDuration,
    this.disbTenure,
    this.disbBankName,
    this.disbBankAccountName,
    this.disbBankAccountNo,
    this.disbBankIfsc,
    this.disbMethod,
    this.disbDate,
    this.disbLatter,
    this.custGender,
    this.custPhone,
    this.custEmail,
    this.custPan,
    this.custAadhar,
    this.custPassport,
    this.custEducation,
    this.custIncome,
    this.custNetSalary,
    this.custEmi,
    this.custFoir,
    this.custCompany,
    this.custCompanyType,
    this.custCompanyAddress,
    this.custMaritalStatus,
    this.custRefContact,
    this.custLocIp,
    this.custPresentAddress,
    this.custPermanentAddress,
    this.custOhpAddress,
    this.propertyOwnerType,
    this.addressProofType,
    this.leadLockStatus,
    this.lockedBy,
    this.accTrxDate,
    this.accTrxId,
    this.docPan,
    this.docAadhar,
    this.docPassport,
    this.docSalaryslip,
    this.docBanking,
    this.docOhp,
    this.docRelationProof,
    this.docPresentAddress,
    this.docPermanentAddress,
    this.custLoanSelfie,
    this.docPanVerifyStatus,
    this.docAadharVerifyStatus,
    this.docPassportVerifyStatus,
    this.docSalaryslipVerifyStatus,
    this.docBankingVerifyStatus,
    this.docOhpVerifyStatus,
    this.docRelationProofVerifyStatus,
    this.docPresentAddressVerifyStatus,
    this.docPermanentAddressVerifyStatus,
    this.custLoanSelfieVerifyStatus,
    this.createdByName,
    this.teleAssignEmpId,
    this.teleAssignEmpName,
    this.teleAssignSupId,
    this.teleAssignEmpAddress,
    this.teleAssignEmpPincode,
    this.teleSupName,
    this.fosAssignEmpId,
    this.fosAssignEmpName,
    this.fosAssignSupId,
    this.fosAssignEmpAddress,
    this.fosAssignEmpPincode,
    this.fosSupName,
    // required this.custActiveLoan,
    required this.history,
  });

  factory AllLeade.fromJson(Map<String, dynamic> json) => AllLeade(
    id: json["id"],
    leadId: json["lead_id"],
    custId: json["cust_id"],
    custName: json["cust_name"],
    leadType: json["lead_type"],
    leadDateTime: json["lead_date_time"],
    leadSource: json["lead_source"],
    loanAmount: json["loan_amount"],
    loanTurner: json["loan_turner"],
    leadAssignChangeCount: json["lead_assign_change_count"],
    leadAssignHistory: json["lead_assign_history"],
    leadAssignTele: json["lead_assign_tele"],
    leadAssignFos: json["lead_assign_fos"],
    leadAssignPartner: json["lead_assign_partner"],
    firstCallDateTime: json["first_call_date_time"],
    lastCallDateTime: json["last_call_date_time"],
    followupCreatedBy: json["followup_created_by"],
    followupCount: json["followup_count"],
    nextFollowupDate: json["next_followup_date"],
    nextFollowupTime: json["next_followup_time"],
    leadRemark: json["lead_remark"],
    loginBankName: json["login_bank_name"],
    bankDocSubmitDate: json["bank_doc_submit_date"],
    bankLoginDate: json["bank_login_date"],
    loanAppId: json["loan_app_id"],
    loginAmount: json["login_amount"],
    loginTenure: json["login_tenure"],
    applicationForm: json["application_form"],
    leadStatus: json["lead_status"],
    leadDropCat: json["lead_drop_cat"],
    sancDate: json["sanc_date"],
    sancAmt: json["sanc_amt"],
    sancRoi: json["sanc_roi"],
    syncTenure: json["sync_tenure"],
    syncLatter: json["sync_latter"],
    sancDuration: json["sanc_duration"],
    disbAmt: json["disb_amt"],
    disbRoi: json["disb_roi"],
    disbDuration: json["disb_duration"],
    disbTenure: json["disb_tenure"],
    disbBankName: json["disb_bank_name"],
    disbBankAccountName: json["disb_bank_account_name"],
    disbBankAccountNo: json["disb_bank_account_no"],
    disbBankIfsc: json["disb_bank_ifsc"],
    disbMethod: json["disb_method"],
    disbDate: json["disb_date"],
    disbLatter: json["disb_latter"],
    custGender: json["cust_gender"],
    custPhone: json["cust_phone"],
    custEmail: json["cust_email"],
    custPan: json["cust_pan"],
    custAadhar: json["cust_aadhar"],
    custPassport: json["cust_passport"],
    custEducation: json["cust_education"],
    custIncome: json["cust_income"],
    custNetSalary: json["cust_net_salary"],
    custEmi: json["cust_EMI"],
    custFoir: json["cust_foir"],
    custCompany: json["cust_company"],
    custCompanyType: json["cust_company_type"],
    custCompanyAddress: json["cust_company_address"],
    custMaritalStatus: json["cust_marital_status"],
    custRefContact: json["cust_ref_contact"],
    custLocIp: json["cust_loc_ip"],
    custPresentAddress: json["cust_present_address"],
    custPermanentAddress: json["cust_permanent_address"],
    custOhpAddress: json["cust_ohp_address"],
    propertyOwnerType: json["property_owner_type"],
    addressProofType: json["address_proof_type"],
    leadLockStatus: json["lead_lock_status"],
    lockedBy: json["locked_by"],
    accTrxDate: json["acc_trx_date"],
    accTrxId: json["acc_trx_id"],
    docPan: json["doc_pan"],
    docAadhar: json["doc_aadhar"],
    docPassport: json["doc_passport"],
    docSalaryslip: json["doc_salaryslip"],
    docBanking: json["doc_banking"],
    docOhp: json["doc_ohp"],
    docRelationProof: json["doc_relation_proof"],
    docPresentAddress: json["doc_present_address"],
    docPermanentAddress: json["doc_permanent_address"],
    custLoanSelfie: json["cust_loan_selfie"],
    docPanVerifyStatus: json["doc_pan_verify_status"],
    docAadharVerifyStatus: json["doc_aadhar_verify_status"],
    docPassportVerifyStatus: json["doc_passport_verify_status"],
    docSalaryslipVerifyStatus: json["doc_salaryslip_verify_status"],
    docBankingVerifyStatus: json["doc_banking_verify_status"],
    docOhpVerifyStatus: json["doc_ohp_verify_status"],
    docRelationProofVerifyStatus: json["doc_relation_proof_verify_status"],
    docPresentAddressVerifyStatus: json["doc_present_address_verify_status"],
    docPermanentAddressVerifyStatus: json["doc_permanent_address_verify_status"],
    custLoanSelfieVerifyStatus: json["cust_loan_selfie_verify_status"],
    createdByName: json["created_by_name"],
    teleAssignEmpId: json["tele_assign_emp_id"],
    teleAssignEmpName: json["tele_assign_emp_name"],
    teleAssignSupId: json["tele_assign_sup_id"],
    teleAssignEmpAddress: json["tele_assign_emp_address"],
    teleAssignEmpPincode: json["tele_assign_emp_pincode"],
    teleSupName: json["tele_sup_name"],
    fosAssignEmpId: json["fos_assign_emp_id"],
    fosAssignEmpName: json["fos_assign_emp_name"],
    fosAssignSupId: json["fos_assign_sup_id"],
    fosAssignEmpAddress: json["fos_assign_emp_address"],
    fosAssignEmpPincode: json["fos_assign_emp_pincode"],
    fosSupName: json["fos_sup_name"],
    // custActiveLoan: List<CustActiveLoan>.from(json["cust_active_loan"]==null?[]:json["cust_active_loan"].map((x) => CustActiveLoan.fromJson(x))),
    history: List<History>.from(json["history"].map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "cust_id": custId,
    "cust_name": custName,
    "lead_type": leadType,
    "lead_date_time": leadDateTime,
    "lead_source": leadSource,
    "loan_amount": loanAmount,
    "loan_turner": loanTurner,
    "lead_assign_change_count": leadAssignChangeCount,
    "lead_assign_history": leadAssignHistory,
    "lead_assign_tele": leadAssignTele,
    "lead_assign_fos": leadAssignFos,
    "lead_assign_partner": leadAssignPartner,
    "first_call_date_time": firstCallDateTime,
    "last_call_date_time": lastCallDateTime,
    "followup_created_by": followupCreatedBy,
    "followup_count": followupCount,
    "next_followup_date": nextFollowupDate,
    "next_followup_time": nextFollowupTime,
    "lead_remark": leadRemark,
    "login_bank_name": loginBankName,
    "bank_doc_submit_date": bankDocSubmitDate,
    "bank_login_date": bankLoginDate,
    "loan_app_id": loanAppId,
    "login_amount": loginAmount,
    "login_tenure": loginTenure,
    "application_form": applicationForm,
    "lead_status": leadStatus,
    "lead_drop_cat": leadDropCat,
    "sanc_date": sancDate,
    "sanc_amt": sancAmt,
    "sanc_roi": sancRoi,
    "sync_tenure": syncTenure,
    "sync_latter": syncLatter,
    "sanc_duration": sancDuration,
    "disb_amt": disbAmt,
    "disb_roi": disbRoi,
    "disb_duration": disbDuration,
    "disb_tenure": disbTenure,
    "disb_bank_name": disbBankName,
    "disb_bank_account_name": disbBankAccountName,
    "disb_bank_account_no": disbBankAccountNo,
    "disb_bank_ifsc": disbBankIfsc,
    "disb_method": disbMethod,
    "disb_date": disbDate,
    "disb_latter": disbLatter,
    "cust_gender": custGender,
    "cust_phone": custPhone,
    "cust_email": custEmail,
    "cust_pan": custPan,
    "cust_aadhar": custAadhar,
    "cust_passport": custPassport,
    "cust_education": custEducation,
    "cust_income": custIncome,
    "cust_net_salary": custNetSalary,
    "cust_EMI": custEmi,
    "cust_foir": custFoir,
    "cust_company": custCompany,
    "cust_company_type": custCompanyType,
    "cust_company_address": custCompanyAddress,
    "cust_marital_status": custMaritalStatus,
    "cust_ref_contact": custRefContact,
    "cust_loc_ip": custLocIp,
    "cust_present_address": custPresentAddress,
    "cust_permanent_address": custPermanentAddress,
    "cust_ohp_address": custOhpAddress,
    "property_owner_type": propertyOwnerType,
    "address_proof_type": addressProofType,
    "lead_lock_status": leadLockStatus,
    "locked_by": lockedBy,
    "acc_trx_date": accTrxDate,
    "acc_trx_id": accTrxId,
    "doc_pan": docPan,
    "doc_aadhar": docAadhar,
    "doc_passport": docPassport,
    "doc_salaryslip": docSalaryslip,
    "doc_banking": docBanking,
    "doc_ohp": docOhp,
    "doc_relation_proof": docRelationProof,
    "doc_present_address": docPresentAddress,
    "doc_permanent_address": docPermanentAddress,
    "cust_loan_selfie": custLoanSelfie,
    "doc_pan_verify_status": docPanVerifyStatus,
    "doc_aadhar_verify_status": docAadharVerifyStatus,
    "doc_passport_verify_status": docPassportVerifyStatus,
    "doc_salaryslip_verify_status": docSalaryslipVerifyStatus,
    "doc_banking_verify_status": docBankingVerifyStatus,
    "doc_ohp_verify_status": docOhpVerifyStatus,
    "doc_relation_proof_verify_status": docRelationProofVerifyStatus,
    "doc_present_address_verify_status": docPresentAddressVerifyStatus,
    "doc_permanent_address_verify_status": docPermanentAddressVerifyStatus,
    "cust_loan_selfie_verify_status": custLoanSelfieVerifyStatus,
    "created_by_name": createdByName,
    "tele_assign_emp_id": teleAssignEmpId,
    "tele_assign_emp_name": teleAssignEmpName,
    "tele_assign_sup_id": teleAssignSupId,
    "tele_assign_emp_address": teleAssignEmpAddress,
    "tele_assign_emp_pincode": teleAssignEmpPincode,
    "tele_sup_name": teleSupName,
    "fos_assign_emp_id": fosAssignEmpId,
    "fos_assign_emp_name": fosAssignEmpName,
    "fos_assign_sup_id": fosAssignSupId,
    "fos_assign_emp_address": fosAssignEmpAddress,
    "fos_assign_emp_pincode": fosAssignEmpPincode,
    "fos_sup_name": fosSupName,
    // "cust_active_loan": List<dynamic>.from(custActiveLoan.map((x) => x.toJson())),
    "history": List<dynamic>.from(history.map((x) => x.toJson())),
  };
}

class CustActiveLoan {
  String? loanType;
  String? loanAmt;
  String? tenure;
  String? month;
  String? roi;

  CustActiveLoan({
    this.loanType,
    this.loanAmt,
    this.tenure,
    this.month,
    this.roi,
  });

  factory CustActiveLoan.fromJson(Map<String, dynamic> json) => CustActiveLoan(
    loanType: json["loan_type"],
    loanAmt: json["loan_amt"],
    tenure: json["tenure"],
    month: json["month"],
    roi: json["roi"],
  );

  Map<String, dynamic> toJson() => {
    "loan_type": loanType,
    "loan_amt": loanAmt,
    "tenure": tenure,
    "month": month,
    "roi": roi,
  };
}

class History {
  dynamic id;
  dynamic leadId;
  dynamic empId;
  String? remark;
  String? assignDecision;
  List<dynamic>? incAttachment;
  String? remarkDateTime;
  String? remarkUpdateBy;

  History({
    this.id,
    this.leadId,
    this.empId,
    this.remark,
    this.assignDecision,
    this.incAttachment,
    this.remarkDateTime,
    this.remarkUpdateBy,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json["id"],
    leadId: json["lead_id"],
    empId: json["emp_id"],
    remark: json["remark"],
    assignDecision: json["assign_decision"],
    incAttachment: json["inc_attachment"]==null?[]:List<dynamic>.from(json["inc_attachment"].map((x) => x)),
    remarkDateTime: json["remark_date_time"],
    remarkUpdateBy: json["remark_update_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "emp_id": empId,
    "remark": remark,
    "assign_decision": List<dynamic>.from(incAttachment!.map((x) => x)),
    "inc_attachment": incAttachment,
    "remark_date_time": remarkDateTime,
    "remark_update_by": remarkUpdateBy,
  };
}

class UserDetails {
  dynamic id;
  dynamic custId;
  String? custCreateDatetime;
  String? custSource;
  String? custName;
  String? custPhone;
  String? custEmail;
  String? custSocial;
  String? custDob;
  int? custAge;
  String? custGender;
  String? custAadhar;
  String? custPan;
  String? custPassport;
  String? custLocIp;
  String? custPincode;
  String? custAddress;
  String? custMaritalStatus;
  String? custOccupation;
  String? custCompany;
  String? custEducation;
  int? custIncome;
  int? custLeadCount;
  String? custProfilePic;
  int? custAssignCount;
  String? custFirstAssignTo;
  String? custLastAssignTo;
  int? custServiceCount;
  int? custWalletAmt;
  int? otpPhone;
  String? otpPhoneStatus;
  int? otpEmail;
  String? otpEmailStatus;
  String? custStatus;
  String? custCompanyType;
  String? custPassword;
  String? loginPin;
  String? fringerprintLock;
  String? otpStatusLoginpin;
  String? isUser;
  String? custCountry;
  String? custState;
  dynamic countryId;
  dynamic stateId;

  UserDetails({
    this.id,
    this.custId,
    this.custCreateDatetime,
    this.custSource,
    this.custName,
    this.custPhone,
    this.custEmail,
    this.custSocial,
    this.custDob,
    this.custAge,
    this.custGender,
    this.custAadhar,
    this.custPan,
    this.custPassport,
    this.custLocIp,
    this.custPincode,
    this.custAddress,
    this.custMaritalStatus,
    this.custOccupation,
    this.custCompany,
    this.custEducation,
    this.custIncome,
    this.custLeadCount,
    this.custProfilePic,
    this.custAssignCount,
    this.custFirstAssignTo,
    this.custLastAssignTo,
    this.custServiceCount,
    this.custWalletAmt,
    this.otpPhone,
    this.otpPhoneStatus,
    this.otpEmail,
    this.otpEmailStatus,
    this.custStatus,
    this.custCompanyType,
    this.custPassword,
    this.loginPin,
    this.fringerprintLock,
    this.otpStatusLoginpin,
    this.isUser,
    this.custCountry,
    this.custState,
    this.countryId,
    this.stateId,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"],
    custId: json["cust_id"],
    custCreateDatetime: json["cust_create_datetime"],
    custSource: json["cust_source"],
    custName: json["cust_name"],
    custPhone: json["cust_phone"],
    custEmail: json["cust_email"],
    custSocial: json["cust_social"],
    custDob: json["cust_dob"],
    custAge: json["cust_age"],
    custGender: json["cust_gender"],
    custAadhar: json["cust_aadhar"],
    custPan: json["cust_pan"],
    custPassport: json["cust_passport"],
    custLocIp: json["cust_loc_ip"],
    custPincode: json["cust_pincode"],
    custAddress: json["cust_address"],
    custMaritalStatus: json["cust_marital_status"],
    custOccupation: json["cust_occupation"],
    custCompany: json["cust_company"],
    custEducation: json["cust_education"],
    custIncome: json["cust_income"],
    custLeadCount: json["cust_lead_count"],
    custProfilePic: json["cust_profile_pic"],
    custAssignCount: json["cust_assign_count"],
    custFirstAssignTo: json["cust_first_assign_to"],
    custLastAssignTo: json["cust_last_assign_to"],
    custServiceCount: json["cust_service_count"],
    custWalletAmt: json["cust_wallet_amt"],
    otpPhone: json["otp_phone"],
    otpPhoneStatus: json["otp_phone_status"],
    otpEmail: json["otp_email"],
    otpEmailStatus: json["otp_email_status"],
    custStatus: json["cust_status"],
    custCompanyType: json["cust_company_type"],
    custPassword: json["cust_password"],
    loginPin: json["login_pin"],
    fringerprintLock: json["fringerprint_lock"],
    otpStatusLoginpin: json["otp_status_loginpin"],
    isUser: json["is_user"],
    custCountry: json["cust_country"],
    custState: json["cust_state"],
    countryId: json["country_id"],
    stateId: json["state_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cust_id": custId,
    "cust_create_datetime": custCreateDatetime,
    "cust_source": custSource,
    "cust_name": custName,
    "cust_phone": custPhone,
    "cust_email": custEmail,
    "cust_social": custSocial,
    "cust_dob": custDob,
    "cust_age": custAge,
    "cust_gender": custGender,
    "cust_aadhar": custAadhar,
    "cust_pan": custPan,
    "cust_passport": custPassport,
    "cust_loc_ip": custLocIp,
    "cust_pincode": custPincode,
    "cust_address": custAddress,
    "cust_marital_status": custMaritalStatus,
    "cust_occupation": custOccupation,
    "cust_company": custCompany,
    "cust_education": custEducation,
    "cust_income": custIncome,
    "cust_lead_count": custLeadCount,
    "cust_profile_pic": custProfilePic,
    "cust_assign_count": custAssignCount,
    "cust_first_assign_to": custFirstAssignTo,
    "cust_last_assign_to": custLastAssignTo,
    "cust_service_count": custServiceCount,
    "cust_wallet_amt": custWalletAmt,
    "otp_phone": otpPhone,
    "otp_phone_status": otpPhoneStatus,
    "otp_email": otpEmail,
    "otp_email_status": otpEmailStatus,
    "cust_status": custStatus,
    "cust_company_type": custCompanyType,
    "cust_password": custPassword,
    "login_pin": loginPin,
    "fringerprint_lock": fringerprintLock,
    "otp_status_loginpin": otpStatusLoginpin,
    "is_user": isUser,
    "cust_country": custCountry,
    "cust_state": custState,
    "country_id": countryId,
    "state_id": stateId,
  };
}

class PartnerDetails {
  dynamic id;
  dynamic pid;
  dynamic custId;
  dynamic supId;
  dynamic approverSupId;
  dynamic partnerPresentAddress;
  dynamic partnerPresentAddressPin;
  dynamic partnerPermanentAddress;
  dynamic partnerPermanentAddressPin;
  dynamic empBankDetail;
  dynamic partnerReference;
  String? partnerStatus;
  dynamic partnerJoinDate;
  String? partnerApprovedDate;
  dynamic partnerLastWorkingDate;
  dynamic partnerCreateBy;
  String? partnerApprovedBy;
  String? addressProofType;
  String? propertyOwnerType;
  String? partnerBand;
  String? approveStatus;
  String? reqApproverId;
  String? docPan;
  String? docAadhar;
  String? docPassport;
  String? docProfilePic;
  String? docSalaryslip;
  String? docBanking;
  String? docOhp;
  String? docRelationProof;
  dynamic docPresentAddress;
  dynamic docPermanentAddress;
  dynamic doc10ThProof;
  dynamic doc12ThProof;
  dynamic docGraduationProof;
  dynamic docMastersProof;
  dynamic docPhdProof;
  dynamic docCertificationProof;
  String? docRentAgreement;

  PartnerDetails({
    this.id,
    this.pid,
    this.custId,
    this.supId,
    this.approverSupId,
    this.partnerPresentAddress,
    this.partnerPresentAddressPin,
    this.partnerPermanentAddress,
    this.partnerPermanentAddressPin,
    this.empBankDetail,
    this.partnerReference,
    this.partnerStatus,
    this.partnerJoinDate,
    this.partnerApprovedDate,
    this.partnerLastWorkingDate,
    this.partnerCreateBy,
    this.partnerApprovedBy,
    this.addressProofType,
    this.propertyOwnerType,
    this.partnerBand,
    this.approveStatus,
    this.reqApproverId,
    this.docPan,
    this.docAadhar,
    this.docPassport,
    this.docProfilePic,
    this.docSalaryslip,
    this.docBanking,
    this.docOhp,
    this.docRelationProof,
    this.docPresentAddress,
    this.docPermanentAddress,
    this.doc10ThProof,
    this.doc12ThProof,
    this.docGraduationProof,
    this.docMastersProof,
    this.docPhdProof,
    this.docCertificationProof,
    this.docRentAgreement,
  });

  factory PartnerDetails.fromJson(Map<String, dynamic> json) => PartnerDetails(
    id: json["id"],
    pid: json["pid"],
    custId: json["cust_id"],
    supId: json["sup_id"],
    approverSupId: json["approver_sup_id"],
    partnerPresentAddress: json["partner_present_address"],
    partnerPresentAddressPin: json["partner_present_address_pin"],
    partnerPermanentAddress: json["partner_permanent_address"],
    partnerPermanentAddressPin: json["partner_permanent_address_pin"],
    empBankDetail: json["emp_bank_detail"],
    partnerReference: json["partner_reference"],
    partnerStatus: json["partner_status"],
    partnerJoinDate: json["partner_join_date"],
    partnerApprovedDate: json["partner_approved_date"],
    partnerLastWorkingDate: json["partner_last_working_date"],
    partnerCreateBy: json["partner_create_by"],
    partnerApprovedBy: json["partner_approved_by"],
    addressProofType: json["address_proof_type"],
    propertyOwnerType: json["property_owner_type"],
    partnerBand: json["partner_band"],
    approveStatus: json["approve_status"],
    reqApproverId: json["req_approver_id"],
    docPan: json["doc_pan"],
    docAadhar: json["doc_aadhar"],
    docPassport: json["doc_passport"],
    docProfilePic: json["doc_profile_pic"],
    docSalaryslip: json["doc_salaryslip"],
    docBanking: json["doc_banking"],
    docOhp: json["doc_ohp"],
    docRelationProof: json["doc_relation_proof"],
    docPresentAddress: json["doc_present_address"],
    docPermanentAddress: json["doc_permanent_address"],
    doc10ThProof: json["doc_10th_proof"],
    doc12ThProof: json["doc_12th_proof"],
    docGraduationProof: json["doc_graduation_proof"],
    docMastersProof: json["doc_masters_proof"],
    docPhdProof: json["doc_phd_proof"],
    docCertificationProof: json["doc_certification_proof"],
    docRentAgreement: json["doc_rent_agreement"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pid": pid,
    "cust_id": custId,
    "sup_id": supId,
    "approver_sup_id": approverSupId,
    "partner_present_address": partnerPresentAddress,
    "partner_present_address_pin": partnerPresentAddressPin,
    "partner_permanent_address": partnerPermanentAddress,
    "partner_permanent_address_pin": partnerPermanentAddressPin,
    "emp_bank_detail": empBankDetail,
    "partner_reference": partnerReference,
    "partner_status": partnerStatus,
    "partner_join_date": partnerJoinDate,
    "partner_approved_date": partnerApprovedDate,
    "partner_last_working_date": partnerLastWorkingDate,
    "partner_create_by": partnerCreateBy,
    "partner_approved_by": partnerApprovedBy,
    "address_proof_type": addressProofType,
    "property_owner_type": propertyOwnerType,
    "partner_band": partnerBand,
    "approve_status": approveStatus,
    "req_approver_id": reqApproverId,
    "doc_pan": docPan,
    "doc_aadhar": docAadhar,
    "doc_passport": docPassport,
    "doc_profile_pic": docProfilePic,
    "doc_salaryslip": docSalaryslip,
    "doc_banking": docBanking,
    "doc_ohp": docOhp,
    "doc_relation_proof": docRelationProof,
    "doc_present_address": docPresentAddress,
    "doc_permanent_address": docPermanentAddress,
    "doc_10th_proof": doc10ThProof,
    "doc_12th_proof": doc12ThProof,
    "doc_graduation_proof": docGraduationProof,
    "doc_masters_proof": docMastersProof,
    "doc_phd_proof": docPhdProof,
    "doc_certification_proof": docCertificationProof,
    "doc_rent_agreement": docRentAgreement,
  };
}
