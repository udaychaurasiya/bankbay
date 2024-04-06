// To parse this JSON data, do
//
//     final employeeDetailsModel = employeeDetailsModelFromJson(jsonString);

import 'dart:convert';

EmployeeDetailsModel employeeDetailsModelFromJson(String str) => EmployeeDetailsModel.fromJson(json.decode(str));

String employeeDetailsModelToJson(EmployeeDetailsModel data) => json.encode(data.toJson());

class EmployeeDetailsModel {
  String? message;
  String? status;
  int? allLeadecount;
  int? activeLeadecount;
  int? droppedLeadecount;
  EmployeeDetailsData data;

  EmployeeDetailsModel({
    this.message,
    this.status,
    this.allLeadecount,
    this.activeLeadecount,
    this.droppedLeadecount,
    required this.data,
  });

  factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) => EmployeeDetailsModel(
    message: json["message"],
    status: json["status"],
    allLeadecount: json["allLeadecount"],
    activeLeadecount: json["activeLeadecount"],
    droppedLeadecount: json["droppedLeadecount"],
    data: EmployeeDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "allLeadecount": allLeadecount,
    "activeLeadecount": activeLeadecount,
    "droppedLeadecount": droppedLeadecount,
    "data": data.toJson(),
  };
}

class EmployeeDetailsData {
  BasicDetails basicDetails;
  List<Exprience> exprience;
  List<Education> education;
  List<Remark> remark;
  AccessDefault accessDefault;
  AccessSpecial accessSpecial;
  List<AllLeade> allLeade;

  EmployeeDetailsData({
    required this.basicDetails,
    required this.exprience,
    required this.education,
    required this.remark,
    required this.accessDefault,
    required this.accessSpecial,
    required this.allLeade,
  });

  factory EmployeeDetailsData.fromJson(Map<String, dynamic> json) => EmployeeDetailsData(
    basicDetails: BasicDetails.fromJson(json["BasicDetails"]),
    exprience: List<Exprience>.from(json["Exprience"].map((x) => Exprience.fromJson(x))),
    education: List<Education>.from(json["Education"].map((x) => Education.fromJson(x))),
    remark: List<Remark>.from(json["Remark"].map((x) => Remark.fromJson(x))),
    accessDefault: AccessDefault.fromJson(json["Access_default"]),
    accessSpecial: AccessSpecial.fromJson(json["Access_special"]),
    allLeade: List<AllLeade>.from(json["allLeade"].map((x) => AllLeade.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "BasicDetails": basicDetails.toJson(),
    "Exprience": List<dynamic>.from(exprience.map((x) => x.toJson())),
    "Education": List<dynamic>.from(education.map((x) => x.toJson())),
    "Remark": List<dynamic>.from(remark.map((x) => x.toJson())),
    "Access_default": accessDefault.toJson(),
    "Access_special": accessSpecial.toJson(),
    "allLeade": List<dynamic>.from(allLeade.map((x) => x.toJson())),
  };
}

class AccessDefault {
  int? id;
  String? userType;
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
  String? panelManageEmployee;
  String? panelManagePartner;
  String? panelManageCustomer;
  String? assignementChangeApproval;
  String? newLeadTab;
  String? verificationLeadTab;
  String? disbursedLeadTab;
  String? incentiveLeadTab;
  dynamic accessChangeCount;
  String? accessChangeBy;
  String? accessChangeDateTime;
  String? changeByName;
  String? applySelfLoan;

  AccessDefault({
    this.id,
    this.userType,
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
    this.panelManageEmployee,
    this.panelManagePartner,
    this.panelManageCustomer,
    this.assignementChangeApproval,
    this.newLeadTab,
    this.verificationLeadTab,
    this.disbursedLeadTab,
    this.incentiveLeadTab,
    this.accessChangeCount,
    this.accessChangeBy,
    this.accessChangeDateTime,
    this.changeByName,
    this.applySelfLoan,
  });

  factory AccessDefault.fromJson(Map<String, dynamic> json) => AccessDefault(
    id: json["id"],
    userType: json["user_type"],
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
    panelManageEmployee: json["panel_manage_employee"],
    panelManagePartner: json["panel_manage_partner"],
    panelManageCustomer: json["panel_manage_customer"],
    assignementChangeApproval: json["assignement_change_approval"],
    newLeadTab: json["new_lead_tab"],
    verificationLeadTab: json["verification_lead_tab"],
    disbursedLeadTab: json["disbursed_lead_tab"],
    incentiveLeadTab: json["incentive_lead_tab"],
    accessChangeCount: json["access_change_count"],
    accessChangeBy: json["access_change_by"],
    accessChangeDateTime: json["access_change_date_time"],
    changeByName: json["change_by_name"],
    applySelfLoan: json["apply_self_loan"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_type": userType,
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
    "panel_manage_employee": panelManageEmployee,
    "panel_manage_partner": panelManagePartner,
    "panel_manage_customer": panelManageCustomer,
    "assignement_change_approval": assignementChangeApproval,
    "new_lead_tab": newLeadTab,
    "verification_lead_tab": verificationLeadTab,
    "disbursed_lead_tab": disbursedLeadTab,
    "incentive_lead_tab": incentiveLeadTab,
    "access_change_count": accessChangeCount,
    "access_change_by": accessChangeBy,
    "access_change_date_time": accessChangeDateTime!,
    "change_by_name": changeByName,
    "apply_self_loan": applySelfLoan,
  };
}

class AccessSpecial {
  int? id;
  dynamic userId;
  dynamic accessChangeCount;
  String? accessChangeBy;
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
  String? assignementChangeApproval;
  String? changeByName;

  AccessSpecial({
    this.id,
    this.userId,
    this.accessChangeCount,
    this.accessChangeBy,
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
    this.assignementChangeApproval,
    this.changeByName,
  });

  factory AccessSpecial.fromJson(Map<String, dynamic> json) => AccessSpecial(
    id: json["id"],
    userId: json["user_id"],
    accessChangeCount: json["access_change_count"],
    accessChangeBy: json["access_change_by"],
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
    assignementChangeApproval: json["assignement_change_approval"],
    changeByName: json["change_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "access_change_count": accessChangeCount,
    "access_change_by": accessChangeBy,
    "access_change_date_time": accessChangeDateTime!,
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
    "assignement_change_approval": assignementChangeApproval,
    "change_by_name": changeByName,
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
  dynamic leadAssignTele;
  dynamic leadAssignFos;
  dynamic leadAssignPartner;
  dynamic firstCallDateTime;
  dynamic lastCallDateTime;
  dynamic followupCreatedBy;
  int? followupCount;
  String? nextFollowupDate;
  String? nextFollowupTime;
  String? leadRemark;
  dynamic loginBankName;
  dynamic bankDocSubmitDate;
  dynamic bankLoginDate;
  dynamic loanAppId;
  String? loginAmount;
  String? loginTenure;
  String? applicationForm;
  String? leadStatus;
  dynamic leadDropCat;
  dynamic sancDate;
  int? sancAmt;
  String? sancRoi;
  dynamic syncTenure;
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
  String? disbDate;
  String? disbLatter;
  String? custGender;
  String? custPhone;
  String? custEmail;
  String? custPan;
  String? custAadhar;
  dynamic custPassport;
  String? custEducation;
  int? custIncome;
  int? custNetSalary;
  int? custEmi;
  int? custFoir;
  String? custCompany;
  String? custCompanyType;
  dynamic custCompanyAddress;
  String? custMaritalStatus;
  List<CustActiveLoan> custActiveLoan;
  dynamic custRefContact;
  dynamic custLocIp;
  dynamic custPresentAddress;
  dynamic custPermanentAddress;
  dynamic custOhpAddress;
  String? propertyOwnerType;
  String? addressProofType;
  String? leadLockStatus;
  String? lockedBy;
  String? accTrxDate;
  String? accTrxId;
  String? docPan;
  String? docAadhar;
  dynamic docPassport;
  String? docSalaryslip;
  String? docBanking;
  String? docOhp;
  String? docRelationProof;
  dynamic docPresentAddress;
  dynamic docPermanentAddress;
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
  dynamic teleAssignEmpId;
  dynamic teleAssignEmpFunction;
  dynamic teleAssignEmpName;
  dynamic teleAssignSupId;
  dynamic teleAssignEmpAddress;
  dynamic teleAssignEmpPincode;
  dynamic teleSupName;
  dynamic fosAssignEmpId;
  dynamic fosAssignEmpName;
  dynamic fosAssignEmpFunction;
  dynamic fosAssignSupId;
  dynamic fosAssignEmpAddress;
  dynamic fosAssignEmpPincode;
  dynamic fosSupName;
  int? fosIncDue;
  int? teleIncDue;
  int? partnerIncDue;
  List<dynamic> history;
  HoldHistory holdHistory;
  EdHistory rejectedHistory;
  EdHistory verifiedHistory;
  String? verifiedName;
  String? verifiedId;
  List<IncAttachment> incAttachment;
  List<IncHistory> incHistory;
  List<dynamic> assignAuth;
  String? leadSourceBy;

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
    required this.custActiveLoan,
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
    this.teleAssignEmpFunction,
    this.teleAssignEmpName,
    this.teleAssignSupId,
    this.teleAssignEmpAddress,
    this.teleAssignEmpPincode,
    this.teleSupName,
    this.fosAssignEmpId,
    this.fosAssignEmpName,
    this.fosAssignEmpFunction,
    this.fosAssignSupId,
    this.fosAssignEmpAddress,
    this.fosAssignEmpPincode,
    this.fosSupName,
    this.fosIncDue,
    this.teleIncDue,
    this.partnerIncDue,
    required this.history,
    required this.holdHistory,
    required this.rejectedHistory,
    required this.verifiedHistory,
    this.verifiedName,
    this.verifiedId,
    required this.incAttachment,
    required this.incHistory,
    required this.assignAuth,
    this.leadSourceBy,
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
    custActiveLoan: List<CustActiveLoan>.from(json["cust_active_loan"].map((x) => CustActiveLoan.fromJson(x))),
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
    teleAssignEmpFunction: json["tele_assign_emp_function"],
    teleAssignEmpName: json["tele_assign_emp_name"],
    teleAssignSupId: json["tele_assign_sup_id"],
    teleAssignEmpAddress: json["tele_assign_emp_address"],
    teleAssignEmpPincode: json["tele_assign_emp_pincode"],
    teleSupName: json["tele_sup_name"],
    fosAssignEmpId: json["fos_assign_emp_id"],
    fosAssignEmpName: json["fos_assign_emp_name"],
    fosAssignEmpFunction: json["fos_assign_emp_function"],
    fosAssignSupId: json["fos_assign_sup_id"],
    fosAssignEmpAddress: json["fos_assign_emp_address"],
    fosAssignEmpPincode: json["fos_assign_emp_pincode"],
    fosSupName: json["fos_sup_name"],
    fosIncDue: json["fos_inc_due"],
    teleIncDue: json["tele_inc_due"],
    partnerIncDue: json["partner_inc_due"],
    history: List<dynamic>.from(json["history"].map((x) => x)),
    holdHistory: HoldHistory.fromJson(json["hold_history"]),
    rejectedHistory: EdHistory.fromJson(json["rejected_history"]),
    verifiedHistory: EdHistory.fromJson(json["verified_history"]),
    verifiedName: json["verified_name"],
    verifiedId: json["verified_id"],
    incAttachment: List<IncAttachment>.from(json["inc_attachment"].map((x) => IncAttachment.fromJson(x))),
    incHistory: List<IncHistory>.from(json["inc_history"].map((x) => IncHistory.fromJson(x))),
    assignAuth: List<dynamic>.from(json["assign_auth"].map((x) => x)),
    leadSourceBy: json["lead_source_by"],
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
    "cust_active_loan": List<dynamic>.from(custActiveLoan.map((x) => x.toJson())),
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
    "tele_assign_emp_function": teleAssignEmpFunction,
    "tele_assign_emp_name": teleAssignEmpName,
    "tele_assign_sup_id": teleAssignSupId,
    "tele_assign_emp_address": teleAssignEmpAddress,
    "tele_assign_emp_pincode": teleAssignEmpPincode,
    "tele_sup_name": teleSupName,
    "fos_assign_emp_id": fosAssignEmpId,
    "fos_assign_emp_name": fosAssignEmpName,
    "fos_assign_emp_function": fosAssignEmpFunction,
    "fos_assign_sup_id": fosAssignSupId,
    "fos_assign_emp_address": fosAssignEmpAddress,
    "fos_assign_emp_pincode": fosAssignEmpPincode,
    "fos_sup_name": fosSupName,
    "fos_inc_due": fosIncDue,
    "tele_inc_due": teleIncDue,
    "partner_inc_due": partnerIncDue,
    "history": List<dynamic>.from(history.map((x) => x)),
    "hold_history": holdHistory.toJson(),
    "rejected_history": rejectedHistory.toJson(),
    "verified_history": verifiedHistory.toJson(),
    "verified_name": verifiedName,
    "verified_id": verifiedId,
    "inc_attachment": List<dynamic>.from(incAttachment.map((x) => x.toJson())),
    "inc_history": List<dynamic>.from(incHistory.map((x) => x.toJson())),
    "assign_auth": List<dynamic>.from(assignAuth.map((x) => x)),
    "lead_source_by": leadSourceBy,
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

class HoldHistory {
  dynamic id;
  dynamic leadId;
  String? leadStatus;
  List<RemarkElement> remarks;
  String? notes;
  String? updatedBy;
  String? datetime;
  String? updateByName;

  HoldHistory({
    this.id,
    this.leadId,
    this.leadStatus,
    required this.remarks,
    this.notes,
    this.updatedBy,
    this.datetime,
    this.updateByName,
  });

  factory HoldHistory.fromJson(Map<String, dynamic> json) => HoldHistory(
    id: json["id"],
    leadId: json["lead_id"],
    leadStatus: json["lead_status"],
    remarks: json["remarks"]==null?[]:List<RemarkElement>.from(json["remarks"].map((x) => RemarkElement.fromJson(x))),
    notes: json["notes"],
    updatedBy: json["updated_by"],
    datetime: json["datetime"],
    updateByName: json["update_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "lead_status": leadStatus,
    "remarks": List<dynamic>.from(remarks.map((x) => x.toJson())),
    "notes": notes,
    "updated_by": updatedBy,
    "datetime": datetime,
    "update_by_name": updateByName,
  };
}

class RemarkElement {
  String? reason;

  RemarkElement({
    this.reason,
  });

  factory RemarkElement.fromJson(Map<String, dynamic> json) => RemarkElement(
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "reason": reason,
  };
}

class IncAttachment {
  String? filename;

  IncAttachment({
    this.filename,
  });

  factory IncAttachment.fromJson(Map<String, dynamic> json) => IncAttachment(
    filename: json["filename"],
  );

  Map<String, dynamic> toJson() => {
    "filename": filename,
  };
}

class IncHistory {
  dynamic id;
  dynamic leadId;
  dynamic empId;
  String? remark;
  String? assignDecision;
  List<IncAttachment> incAttachment;
  String? remarkDateTime;
  String? remarkUpdateBy;
  String? updateByName;

  IncHistory({
    this.id,
    this.leadId,
    this.empId,
    this.remark,
    this.assignDecision,
    required this.incAttachment,
    this.remarkDateTime,
    this.remarkUpdateBy,
    this.updateByName,
  });

  factory IncHistory.fromJson(Map<String, dynamic> json) => IncHistory(
    id: json["id"],
    leadId: json["lead_id"],
    empId: json["emp_id"],
    remark: json["remark"],
    assignDecision: json["assign_decision"],
    incAttachment: List<IncAttachment>.from(json["inc_attachment"].map((x) => IncAttachment.fromJson(x))),
    remarkDateTime: json["remark_date_time"],
    remarkUpdateBy: json["remark_update_by"],
    updateByName: json["update_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "emp_id": empId,
    "remark": remark,
    "assign_decision": assignDecision,
    "inc_attachment": List<dynamic>.from(incAttachment.map((x) => x.toJson())),
    "remark_date_time": remarkDateTime,
    "remark_update_by": remarkUpdateBy,
    "update_by_name": updateByName,
  };
}

class EdHistory {
  EdHistory();

  factory EdHistory.fromJson(Map<String, dynamic> json) => EdHistory(
  );

  Map<String, dynamic> toJson() => {
  };
}

class BasicDetails {
  dynamic id;
  dynamic eid;
  dynamic supId;
  dynamic empSourceId;
  String? empFname;
  String? empLname;
  String? empDob;
  String? empGender;
  String? empPan;
  String? empAadhar;
  String? panVerifyStatus;
  String? aadhaarVerifyStatus;
  dynamic empPassport;
  dynamic empDl;
  String? empSocial;
  String? empPhone;
  String? empEmail;
  dynamic empCountryId;
  dynamic empStateId;
  String? empPresentAddress;
  String? empPresentAddressPin;
  dynamic empPermanentAddress;
  dynamic empPermanentAddressPin;
  String? empFunction;
  String? empDesignation;
  String? empBand;
  int? empJoinSalary;
  int? empPresentSalary;
  int? empSalaryRevisionCount;
  int? empDesignationRevisionCount;
  dynamic empBankDetail;
  dynamic empRelative;
  dynamic empReference;
  String? empStatus;
  String? pushbackCount;
  String? empJoinDate;
  String? empResignDate;
  String? empLastWorkingDate;
  String? empCreateBy;
  String? empApprovedBy;
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
  String? docPresentAddress;
  String? docPermanentAddress;
  String? doc10ThProof;
  String? doc12ThProof;
  String? docGraduationProof;
  String? docMastersProof;
  String? docPhdProof;
  String? docCertificationProof;
  String? docRentAgreement;
  String? empMaritalStatus;
  String? empEducation;
  String? empCreateDatetime;
  dynamic empSaveType;
  String? empRelivingDate;
  String? empRelivingLetter;
  String? empPassword;
  String? empWallet;
  String? empPhoneOtp;
  String? empFpOtpStatus;
  String? propertyOwnerType;
  String? addressProofType;
  String? fringerprintLock;
  String? approverSupId;

  BasicDetails({
    this.id,
    this.eid,
    this.supId,
    this.empSourceId,
    this.empFname,
    this.empLname,
    this.empDob,
    this.empGender,
    this.empPan,
    this.empAadhar,
    this.panVerifyStatus,
    this.aadhaarVerifyStatus,
    this.empPassport,
    this.empDl,
    this.empSocial,
    this.empPhone,
    this.empEmail,
    this.empCountryId,
    this.empStateId,
    this.empPresentAddress,
    this.empPresentAddressPin,
    this.empPermanentAddress,
    this.empPermanentAddressPin,
    this.empFunction,
    this.empDesignation,
    this.empBand,
    this.empJoinSalary,
    this.empPresentSalary,
    this.empSalaryRevisionCount,
    this.empDesignationRevisionCount,
    this.empBankDetail,
    this.empRelative,
    this.empReference,
    this.empStatus,
    this.pushbackCount,
    this.empJoinDate,
    this.empResignDate,
    this.empLastWorkingDate,
    this.empCreateBy,
    this.empApprovedBy,
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
    this.empMaritalStatus,
    this.empEducation,
    this.empCreateDatetime,
    this.empSaveType,
    this.empRelivingDate,
    this.empRelivingLetter,
    this.empPassword,
    this.empWallet,
    this.empPhoneOtp,
    this.empFpOtpStatus,
    this.propertyOwnerType,
    this.addressProofType,
    this.fringerprintLock,
    this.approverSupId,
  });

  factory BasicDetails.fromJson(Map<String, dynamic> json) => BasicDetails(
    id: json["id"],
    eid: json["eid"],
    supId: json["sup_id"],
    empSourceId: json["emp_source_id"],
    empFname: json["emp_fname"],
    empLname: json["emp_lname"],
    empDob: json["emp_dob"],
    empGender: json["emp_gender"],
    empPan: json["emp_pan"],
    empAadhar: json["emp_aadhar"],
    panVerifyStatus: json["pan_verify_status"],
    aadhaarVerifyStatus: json["adhar_verify_status"],
    empPassport: json["emp_passport"],
    empDl: json["emp_dl"],
    empSocial: json["emp_social"],
    empPhone: json["emp_phone"],
    empEmail: json["emp_email"],
    empCountryId: json["emp_country_id"],
    empStateId: json["emp_state_id"],
    empPresentAddress: json["emp_present_address"],
    empPresentAddressPin: json["emp_present_address_pin"],
    empPermanentAddress: json["emp_permanent_address"],
    empPermanentAddressPin: json["emp_permanent_address_pin"],
    empFunction: json["emp_function"],
    empDesignation: json["emp_designation"],
    empBand: json["emp_band"],
    empJoinSalary: json["emp_join_salary"],
    empPresentSalary: json["emp_present_salary"],
    empSalaryRevisionCount: json["emp_salary_revision_count"],
    empDesignationRevisionCount: json["emp_designation_revision_count"],
    empBankDetail: json["emp_bank_detail"],
    empRelative: json["emp_relative"],
    empReference: json["emp_reference"],
    empStatus: json["emp_status"],
    pushbackCount: json["pushback_count"],
    empJoinDate: json["emp_join_date"],
    empResignDate: json["emp_resign_date"],
    empLastWorkingDate: json["emp_last_working_date"],
    empCreateBy: json["emp_create_by"],
    empApprovedBy: json["emp_approved_by"],
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
    empMaritalStatus: json["emp_marital_status"],
    empEducation: json["emp_education"],
    empCreateDatetime: json["emp_create_datetime"],
    empSaveType: json["emp_save_type"],
    empRelivingDate: json["emp_reliving_date"],
    empRelivingLetter: json["emp_reliving_letter"],
    empPassword: json["emp_password"],
    empWallet: json["emp_wallet"],
    empPhoneOtp: json["emp_phone_otp"],
    empFpOtpStatus: json["emp_fp_otp_status"],
    propertyOwnerType: json["property_owner_type"],
    addressProofType: json["address_proof_type"],
    fringerprintLock: json["fringerprint_lock"],
    approverSupId: json["approver_sup_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "eid": eid,
    "sup_id": supId,
    "emp_source_id": empSourceId,
    "emp_fname": empFname,
    "emp_lname": empLname,
    "emp_dob": empDob,
    "emp_gender": empGender,
    "emp_pan": empPan,
    "emp_aadhar": empAadhar,
    "pan_verify_status": panVerifyStatus,
    "adhar_verify_status": aadhaarVerifyStatus,
    "emp_passport": empPassport,
    "emp_dl": empDl,
    "emp_social": empSocial,
    "emp_phone": empPhone,
    "emp_email": empEmail,
    "emp_country_id": empCountryId,
    "emp_state_id": empStateId,
    "emp_present_address": empPresentAddress,
    "emp_present_address_pin": empPresentAddressPin,
    "emp_permanent_address": empPermanentAddress,
    "emp_permanent_address_pin": empPermanentAddressPin,
    "emp_function": empFunction,
    "emp_designation": empDesignation,
    "emp_band": empBand,
    "emp_join_salary": empJoinSalary,
    "emp_present_salary": empPresentSalary,
    "emp_salary_revision_count": empSalaryRevisionCount,
    "emp_designation_revision_count": empDesignationRevisionCount,
    "emp_bank_detail": empBankDetail,
    "emp_relative": empRelative,
    "emp_reference": empReference,
    "emp_status": empStatus,
    "pushback_count": pushbackCount,
    "emp_join_date": empJoinDate,
    "emp_resign_date": empResignDate,
    "emp_last_working_date": empLastWorkingDate,
    "emp_create_by": empCreateBy,
    "emp_approved_by": empApprovedBy,
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
    "emp_marital_status": empMaritalStatus,
    "emp_education": empEducation,
    "emp_create_datetime": empCreateDatetime,
    "emp_save_type": empSaveType,
    "emp_reliving_date": empRelivingDate,
    "emp_reliving_letter": empRelivingLetter,
    "emp_password": empPassword,
    "emp_wallet": empWallet,
    "emp_phone_otp": empPhoneOtp,
    "emp_fp_otp_status": empFpOtpStatus,
    "property_owner_type": propertyOwnerType,
    "address_proof_type": addressProofType,
    "fringerprint_lock": fringerprintLock,
    "approver_sup_id": approverSupId,
  };
}

class Education {
  dynamic id;
  dynamic eid;
  String? empInstituteName;
  String? empCourseName;
  String? empCourseType;
  String? empCourseStart;
  String? empCourseEnd;
  String? empCourseGrade;
  String? empSkills;

  Education({
    this.id,
    this.eid,
    this.empInstituteName,
    this.empCourseName,
    this.empCourseType,
    this.empCourseStart,
    this.empCourseEnd,
    this.empCourseGrade,
    this.empSkills,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    id: json["id"],
    eid: json["eid"],
    empInstituteName: json["emp_institute_name"],
    empCourseName: json["emp_course_name"],
    empCourseType: json["emp_course_type"],
    empCourseStart: json["emp_course_start"],
    empCourseEnd: json["emp_course_end"],
    empCourseGrade: json["emp_course_grade"],
    empSkills: json["emp_skills"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "eid": eid,
    "emp_institute_name": empInstituteName,
    "emp_course_name": empCourseName,
    "emp_course_type": empCourseType,
    "emp_course_start": empCourseStart,
    "emp_course_end": empCourseEnd,
    "emp_course_grade": empCourseGrade,
    "emp_skills": empSkills,
  };
}

class Exprience {
  dynamic id;
  dynamic eid;
  String? empDesignation;
  String? empCompany;
  String? empFunction;
  String? empIndustry;
  String? empCompanySize;
  String? empJobStartDate;
  String? empJobEndDate;
  int? empLastSalary;
  int? empJoiningSalary;

  Exprience({
    this.id,
    this.eid,
    this.empDesignation,
    this.empCompany,
    this.empFunction,
    this.empIndustry,
    this.empCompanySize,
    this.empJobStartDate,
    this.empJobEndDate,
    this.empLastSalary,
    this.empJoiningSalary,
  });

  factory Exprience.fromJson(Map<String, dynamic> json) => Exprience(
    id: json["id"],
    eid: json["eid"],
    empDesignation: json["emp_designation"],
    empCompany: json["emp_company"],
    empFunction: json["emp_function"],
    empIndustry: json["emp_industry"],
    empCompanySize: json["emp_company_size"],
    empJobStartDate: json["emp_job_start_date"],
    empJobEndDate: json["emp_job_end_date"],
    empLastSalary: json["emp_last_salary"],
    empJoiningSalary: json["emp_joining_salary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "eid": eid,
    "emp_designation": empDesignation,
    "emp_company": empCompany,
    "emp_function": empFunction,
    "emp_industry": empIndustry,
    "emp_company_size": empCompanySize,
    "emp_job_start_date": empJobStartDate,
    "emp_job_end_date": empJobEndDate,
    "emp_last_salary": empLastSalary,
    "emp_joining_salary": empJoiningSalary,
  };
}

class Remark {
  dynamic id;
  dynamic empId;
  String? remark;
  String? remarkDateTime;
  String? remarkUpdateBy;
  dynamic updateByName;

  Remark({
    this.id,
    this.empId,
    this.remark,
    this.remarkDateTime,
    this.remarkUpdateBy,
    this.updateByName,
  });

  factory Remark.fromJson(Map<String, dynamic> json) => Remark(
    id: json["id"],
    empId: json["emp_id"],
    remark: json["remark"],
    remarkDateTime: json["remark_date_time"],
    remarkUpdateBy: json["remark_update_by"],
    updateByName: json["update_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "remark": remark,
    "remark_date_time": remarkDateTime,
    "remark_update_by": remarkUpdateBy,
    "update_by_name": updateByName,
  };
}
