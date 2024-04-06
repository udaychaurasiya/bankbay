import 'dart:convert';

ApproveAssignModel approveAssignModelFromJson(String str) => ApproveAssignModel.fromJson(json.decode(str));

String approveAssignModelToJson(ApproveAssignModel data) => json.encode(data.toJson());

class ApproveAssignModel {
  String? message;
  String? status;
  ApproveAssignData data;

  ApproveAssignModel({
    this.message,
    this.status,
    required this.data,
  });

  factory ApproveAssignModel.fromJson(Map<String, dynamic> json) => ApproveAssignModel(
    message: json["message"],
    status: json["status"],
    data: ApproveAssignData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class ApproveAssignData {
  int? limit;
  int? page;
  List<Lead> leads;

  ApproveAssignData({
    this.limit,
    this.page,
    required this.leads,
  });

  factory ApproveAssignData.fromJson(Map<String, dynamic> json) => ApproveAssignData(
    limit: json["limit"],
    page: json["page"],
    leads: List<Lead>.from(json["Leads"].map((x) => Lead.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "page": page,
    "Leads": List<dynamic>.from(leads.map((x) => x.toJson())),
  };
}

class Lead {
  dynamic id;
  dynamic leadId;
  dynamic custId;
  String? custName;
  String? leadType;
  String? leadDateTime;
  String? leadSource;
  dynamic loanAmount;
  dynamic loanTurner;
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
  // String? custActiveLoan;
  String? custRefContact;
  String? custLocIp;
  String? custPresentAddress;
  String? custPermanentAddress;
  String? custOhpAddress;
  String? propertyOwnerType;
  String? addressProofType;
  String? leadLockStatus;
  String? lockedBy;
  dynamic accTrxDate;
  dynamic accTrxId;
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
  dynamic docPanVerifyStatus;
  dynamic docAadharVerifyStatus;
  dynamic docPassportVerifyStatus;
  dynamic docSalaryslipVerifyStatus;
  dynamic docBankingVerifyStatus;
  dynamic docOhpVerifyStatus;
  dynamic docRelationProofVerifyStatus;
  dynamic docPresentAddressVerifyStatus;
  dynamic docPermanentAddressVerifyStatus;
  dynamic custLoanSelfieVerifyStatus;
  dynamic createdByName;
  dynamic teleAssignEmpId;
  dynamic teleAssignEmpName;
  dynamic teleAssignSupId;
  dynamic teleAssignEmpAddress;
  dynamic teleAssignEmpPincode;
  dynamic teleSupName;
  dynamic fosAssignEmpId;
  dynamic fosAssignEmpName;
  dynamic fosAssignSupId;
  dynamic fosAssignEmpAddress;
  dynamic fosAssignEmpPincode;
  dynamic fosSupName;
  List<dynamic> history;
  List<AssignAuth> assignAuth;
  LeadAssign leadAssignTeleFrom;
  LeadAssign leadAssignTeleTo;
  LeadAssign leadAssignFosTo;
  LeadAssign leadAssignFosFrom;

  Lead({
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
    // this.custActiveLoan,
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
    required this.history,
    required this.assignAuth,
    required this.leadAssignTeleFrom,
    required this.leadAssignTeleTo,
    required this.leadAssignFosTo,
    required this.leadAssignFosFrom,
  });

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
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
    // custActiveLoan: json["cust_active_loan"],
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
    history: List<dynamic>.from(json["history"].map((x) => x)),
    assignAuth: List<AssignAuth>.from(json["assign_auth"].map((x) => AssignAuth.fromJson(x))),
    leadAssignTeleFrom: LeadAssign.fromJson(json["lead_assign_tele_from"]),
    leadAssignTeleTo: LeadAssign.fromJson(json["lead_assign_tele_to"]),
    leadAssignFosTo: LeadAssign.fromJson(json["lead_assign_fos_to"]),
    leadAssignFosFrom: LeadAssign.fromJson(json["lead_assign_fos_from"]),
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
    // "cust_active_loan": custActiveLoan,
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
    "history": List<dynamic>.from(history.map((x) => x)),
    "lead_assign_tele_from": leadAssignTeleFrom.toJson(),
    "lead_assign_tele_to": leadAssignTeleTo.toJson(),
    "lead_assign_fos_to": leadAssignFosTo.toJson(),
    "lead_assign_fos_from": leadAssignFosFrom.toJson(),
  };
}

class AssignAuth {
  dynamic id;
  dynamic leadId;
  dynamic empId;
  String? remark;
  String? assignDecision;
  String? remarkDateTime;
  String? remarkUpdateBy;
  String? updateByName;

  AssignAuth({
    this.id,
    this.leadId,
    this.empId,
    this.remark,
    this.assignDecision,
    this.remarkDateTime,
    this.remarkUpdateBy,
    this.updateByName,
  });

  factory AssignAuth.fromJson(Map<String, dynamic> json) => AssignAuth(
    id: json["id"],
    leadId: json["lead_id"],
    empId: json["emp_id"],
    remark: json["remark"],
    assignDecision: json["assign_decision"],
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
    "remark_date_time": remarkDateTime,
    "remark_update_by": remarkUpdateBy,
    "update_by_name": updateByName,
  };
}

class LeadAssign {
  int? id;
  dynamic eid;
  dynamic supId;
  String? supName;
  String? empFname;
  String? empLname;
  String? empDob;
  String? empGender;
  String? empPan;
  String? empAadhar;
  String? empPassport;
  String? empDl;
  String? empSocial;
  String? empPhone;
  String? empEmail;
  String? empCountryId;
  String? empStateId;
  String? empPresentAddress;
  String? empPresentAddressPin;
  String? empPermanentAddress;
  String? empPermanentAddressPin;
  String? empFunction;
  String? empDesignation;
  String? empBand;
  int? empJoinSalary;
  int? empPresentSalary;
  int? empSalaryRevisionCount;
  int? empDesignationRevisionCount;
  String? empBankDetail;
  String? empRelative;
  String? empReference;
  String? empStatus;
  String? empJoinDate;
  String? empResignDate;
  String? empLastWorkingDate;
  String? empCreateBy;
  String? empApprovedBy;
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
  dynamic docRentAgreement;
  String? empMaritalStatus;
  String? empEducation;
  String? empCreateDatetime;
  String? empSaveType;
  dynamic empRelivingDate;
  dynamic empRelivingLetter;
  dynamic empPassword;
  String? empPhoneOtp;
  String? empFpOtpStatus;
  String? propertyOwnerType;
  String? addressProofType;

  LeadAssign({
    this.id,
    this.eid,
    this.supId,
    this.supName,
    this.empFname,
    this.empLname,
    this.empDob,
    this.empGender,
    this.empPan,
    this.empAadhar,
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
    this.empJoinDate,
    this.empResignDate,
    this.empLastWorkingDate,
    this.empCreateBy,
    this.empApprovedBy,
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
    this.empPhoneOtp,
    this.empFpOtpStatus,
    this.propertyOwnerType,
    this.addressProofType,
  });

  factory LeadAssign.fromJson(Map<String, dynamic> json) => LeadAssign(
    id: json["id"],
    eid: json["eid"],
    supId: json["sup_id"],
    supName: json["sup_name"],
    empFname: json["emp_fname"],
    empLname: json["emp_lname"],
    empDob: json["emp_dob"],
    empGender: json["emp_gender"],
    empPan: json["emp_pan"],
    empAadhar: json["emp_aadhar"],
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
    empJoinDate: json["emp_join_date"],
    empResignDate: json["emp_resign_date"],
    empLastWorkingDate: json["emp_last_working_date"],
    empCreateBy: json["emp_create_by"],
    empApprovedBy: json["emp_approved_by"],
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
    empPhoneOtp: json["emp_phone_otp"],
    empFpOtpStatus: json["emp_fp_otp_status"],
    propertyOwnerType: json["property_owner_type"],
    addressProofType: json["address_proof_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "eid": eid,
    "sup_id": supId,
    "sup_name": supName,
    "emp_fname": empFname,
    "emp_lname": empLname,
    "emp_dob": empDob,
    "emp_gender": empGender,
    "emp_pan": empPan,
    "emp_aadhar": empAadhar,
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
    "emp_join_date": empJoinDate,
    "emp_resign_date": empResignDate,
    "emp_last_working_date": empLastWorkingDate,
    "emp_create_by": empCreateBy,
    "emp_approved_by": empApprovedBy,
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
    "emp_phone_otp": empPhoneOtp,
    "emp_fp_otp_status": empFpOtpStatus,
    "property_owner_type": propertyOwnerType,
    "address_proof_type": addressProofType,
  };
}
