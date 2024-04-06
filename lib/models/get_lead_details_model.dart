import 'dart:convert';

LeadDetailsModel leadDetailsModelFromJson(String str) => LeadDetailsModel.fromJson(json.decode(str));

String leadDetailsModelToJson(LeadDetailsModel data) => json.encode(data.toJson());

class LeadDetailsModel {
  String? message;
  String? status;
  LeadDetailsData data;

  LeadDetailsModel({
    this.message,
    this.status,
    required this.data,
  });

  factory LeadDetailsModel.fromJson(Map<String, dynamic> json) => LeadDetailsModel(
    message: json["message"],
    status: json["status"],
    data: LeadDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class LeadDetailsData {
  dynamic id;
  dynamic leadId;
  dynamic custId;
  String? custName;
  String? leadType;
  DateTime? leadDateTime;
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
  String? validateStatus;
  dynamic leadDropCat;
  dynamic sancDate;
  int? sancAmt;
  String? sancRoi;
  dynamic syncTenure;
  dynamic syncLatter;
  int? sancDuration;
  int? disbAmt;
  String? disbRoi;
  int? disbDuration;
  dynamic disbTenure;
  dynamic disbBankName;
  dynamic disbBankAccountName;
  dynamic disbBankAccountNo;
  dynamic disbBankIfsc;
  dynamic disbMethod;
  dynamic disbDate;
  dynamic disbLatter;
  String? custGender;
  String? custPhone;
  String? custEmail;
  String? custPan;
  dynamic custAadhar;
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
  dynamic accTrxDate;
  dynamic accTrxId;
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
  dynamic docRelationProofVerifyStatus;
  dynamic docPresentAddressVerifyStatus;
  dynamic docPermanentAddressVerifyStatus;
  String? custLoanSelfieVerifyStatus;
  String? createdByName;
  String? otpPhoneStatus;
  String? panVerifyStatus;
  String? aadharVerifyStatus;
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
  String? fosSupName;
  String? verifiedName;
  dynamic verifiedId;
  dynamic partnerIncDue;
  dynamic fosIncDue;
  dynamic teleIncDue;
  List<History> history;
  DHistory holdHistory;
  DHistory rejectedHistory;
  VerifiedHistory verifiedHistory;
  StatusHistory loginHistory;
  StatusHistory disbursedHistory;
  StatusHistory sanctionedHistory;
  StatusHistory incDueHistory;
  StatusHistory incApproveHistory;
  StatusHistory incPaidHistory;
  List<IncAttachment> incAttachment;
  List<IncHistory> incHistory;
  int? allLeadecount;
  int? activeLeadecount;
  int? droppedLeadecount;

  LeadDetailsData({
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
    this.validateStatus,
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
    this.otpPhoneStatus,
    this.panVerifyStatus,
    this.aadharVerifyStatus,
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
    this.verifiedName,
    this.verifiedId,
    this.partnerIncDue,
    this.fosIncDue,
    this.teleIncDue,
    required this.history,
    required this.holdHistory,
    required this.rejectedHistory,
    required this.verifiedHistory,
    required this.loginHistory,
    required this.disbursedHistory,
    required this.sanctionedHistory,
    required this.incDueHistory,
    required this.incApproveHistory,
    required this.incPaidHistory,
    required this.incAttachment,
    required this.incHistory,
    this.allLeadecount,
    this.activeLeadecount,
    this.droppedLeadecount,
  });

  factory LeadDetailsData.fromJson(Map<String, dynamic> json) => LeadDetailsData(
    id: json["id"],
    leadId: json["lead_id"],
    custId: json["cust_id"],
    custName: json["cust_name"],
    leadType: json["lead_type"],
    leadDateTime: DateTime.parse(json["lead_date_time"]),
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
    validateStatus: json["validate_status"],
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
    custActiveLoan: json["cust_active_loan"]==null||json["cust_active_loan"]==""?[]:List<CustActiveLoan>.from(json["cust_active_loan"].map((x) => CustActiveLoan.fromJson(x))),
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
    otpPhoneStatus: json["otp_phone_status"],
    panVerifyStatus: json["pan_verify_status"],
    aadharVerifyStatus: json["adhar_verify_status"],
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
    verifiedName: json["verified_name"],
    verifiedId: json["verified_id"],
    partnerIncDue: json["partner_inc_due"],
    fosIncDue: json["fos_inc_due"],
    teleIncDue: json["tele_inc_due"],
    history: List<History>.from(json["history"].map((x) => History.fromJson(x))),
    holdHistory: DHistory.fromJson(json["hold_history"]),
    rejectedHistory: DHistory.fromJson(json["rejected_history"]),
    verifiedHistory: VerifiedHistory.fromJson(json["verified_history"]),
    loginHistory: StatusHistory.fromJson(json["login_history"]),
    disbursedHistory: StatusHistory.fromJson(json["disbursed_history"]),
    sanctionedHistory: StatusHistory.fromJson(json["sanctioned_history"]),
    incDueHistory: StatusHistory.fromJson(json["inc_due_history"]),
    incApproveHistory: StatusHistory.fromJson(json["inc_approve_history"]),
    incPaidHistory: StatusHistory.fromJson(json["inc_paid_history"]),
    incAttachment: List<IncAttachment>.from(json["inc_attachment"].map((x) => IncAttachment.fromJson(x))),
    incHistory: List<IncHistory>.from(json["inc_history"].map((x) => IncHistory.fromJson(x))),
    allLeadecount: json["allLeadecount"],
    activeLeadecount: json["activeLeadecount"],
    droppedLeadecount: json["droppedLeadecount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "cust_id": custId,
    "cust_name": custName,
    "lead_type": leadType,
    "lead_date_time": leadDateTime!.toIso8601String(),
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
    "validate_status": validateStatus,
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
    "otp_phone_status": otpPhoneStatus,
    "pan_verify_status": panVerifyStatus,
    "adhar_verify_status": aadharVerifyStatus,
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
    "verified_name": verifiedName,
    "verified_id": verifiedId,
    "partner_inc_due": partnerIncDue,
    "fos_inc_due": fosIncDue,
    "tele_inc_due": teleIncDue,
    "history": List<History>.from(history.map((x) => x.toJson())),
    "hold_history": holdHistory.toJson(),
    "rejected_history": rejectedHistory.toJson(),
    "verified_history": verifiedHistory.toJson(),
    "login_history": loginHistory.toJson(),
    "disbursed_history": disbursedHistory.toJson(),
    "sanctioned_history": sanctionedHistory.toJson(),
    "inc_due_history": incDueHistory.toJson(),
    "inc_approve_history": incApproveHistory.toJson(),
    "inc_paid_history": incPaidHistory.toJson(),
    "inc_attachment": List<dynamic>.from(incAttachment.map((x) => x.toJson())),
    "inc_history": List<dynamic>.from(incHistory.map((x) => x.toJson())),
    "allLeadecount": allLeadecount,
    "activeLeadecount": activeLeadecount,
    "droppedLeadecount": droppedLeadecount,
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
  String? leadStatus;
  // List<dynamic> remarks;
  String? notes;
  String? updatedBy;
  String? datetime;
  String? updateByName;

  History({
    this.id,
    this.leadId,
    this.leadStatus,
    // required this.remarks,
    this.notes,
    this.updatedBy,
    this.datetime,
    this.updateByName,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json["id"],
    leadId: json["lead_id"],
    leadStatus: json["lead_status"],
    // remarks: json["remarks"]==null?[]:List<dynamic>.from(json["remarks"].map((x) => x)),
    notes: json["notes"],
    updatedBy: json["updated_by"],
    datetime: json["datetime"],
    updateByName: json["update_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "lead_status": leadStatus,
    // "remarks": List<dynamic>.from(remarks.map((x) => x)),
    "notes": notes,
    "updated_by": updatedBy,
    "datetime": datetime,
    "update_by_name": updateByName,
  };
}

class StatusHistory {
  dynamic id;
  dynamic leadId;
  String? leadStatus;
  // List<dynamic> remarks;
  String? notes;
  String? updatedBy;
  String? datetime;
  String? updateByName;

  StatusHistory({
    this.id,
    this.leadId,
    this.leadStatus,
    // required this.remarks,
    this.notes,
    this.updatedBy,
    this.datetime,
    this.updateByName,
  });

  factory StatusHistory.fromJson(Map<String, dynamic> json) => StatusHistory(
    id: json["id"],
    leadId: json["lead_id"],
    leadStatus: json["lead_status"],
    // remarks: json["remarks"]==null?[]:List<dynamic>.from(json["remarks"].map((x) => x)),
    notes: json["notes"],
    updatedBy: json["updated_by"],
    datetime: json["datetime"],
    updateByName: json["update_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "lead_status": leadStatus,
    // "remarks": List<dynamic>.from(remarks.map((x) => x)),
    "notes": notes,
    "updated_by": updatedBy,
    "datetime": datetime,
    "update_by_name": updateByName,
  };
}

class DHistory {
  dynamic id;
  dynamic leadId;
  String? leadStatus;
  List<HoldHistoryRemark> remarks;
  String? notes;
  String? updatedBy;
  dynamic datetime;
  String? updateByName;

  DHistory({
    this.id,
    this.leadId,
    this.leadStatus,
    required this.remarks,
    this.notes,
    this.updatedBy,
    this.datetime,
    this.updateByName,
  });

  factory DHistory.fromJson(Map<String, dynamic> json) => DHistory(
    id: json["id"],
    leadId: json["lead_id"],
    leadStatus: json["lead_status"],
    remarks: json["remarks"]==null?[]:List<HoldHistoryRemark>.from(json["remarks"].map((x) => HoldHistoryRemark.fromJson(x))),
    notes: json["notes"],
    updatedBy: json["updated_by"],
    datetime: json["datetime"]==null?json["datetime"]:DateTime.parse(json["datetime"]),
    updateByName: json["update_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "lead_status": leadStatus,
    "remarks": List<dynamic>.from(remarks.map((x) => x.toJson())),
    "notes": notes,
    "updated_by": updatedBy,
    "datetime": datetime!.toIso8601String(),
    "update_by_name": updateByName,
  };
}

class HoldHistoryRemark {
  String reason;

  HoldHistoryRemark({
    required this.reason,
  });

  factory HoldHistoryRemark.fromJson(Map<String, dynamic> json) => HoldHistoryRemark(
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
  DateTime? remarkDateTime;
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
    remarkDateTime: DateTime.parse(json["remark_date_time"]),
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
    "remark_date_time": remarkDateTime!.toIso8601String(),
    "remark_update_by": remarkUpdateBy,
    "update_by_name": updateByName,
  };
}

class VerifiedHistory {
  dynamic id;
  dynamic leadId;
  String? leadStatus;
  List<VerifiedHistoryRemark> remarks;
  String? notes;
  String? updatedBy;
  dynamic datetime;
  String? updateByName;

  VerifiedHistory({
    this.id,
    this.leadId,
    this.leadStatus,
    required this.remarks,
    this.notes,
    this.updatedBy,
    this.datetime,
    this.updateByName,
  });

  factory VerifiedHistory.fromJson(Map<String, dynamic> json) => VerifiedHistory(
    id: json["id"],
    leadId: json["lead_id"],
    leadStatus: json["lead_status"],
    remarks: json["remarks"]==null?[]:List<VerifiedHistoryRemark>.from(json["remarks"].map((x) => VerifiedHistoryRemark.fromJson(x))),
    notes: json["notes"],
    updatedBy: json["updated_by"],
    datetime: json["datetime"]==null?json["datetime"]:DateTime.parse(json["datetime"]),
    updateByName: json["update_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "lead_status": leadStatus,
    "remarks": List<dynamic>.from(remarks.map((x) => x.toJson())),
    "notes": notes,
    "updated_by": updatedBy,
    "datetime": datetime!.toIso8601String(),
    "update_by_name": updateByName,
  };
}

class VerifiedHistoryRemark {
  String? isCustomerInterestedInAvailingLoan;
  String? howSoonTheCustomerWantsLoan;
  String? hasCustomerAppliedForLoanInLast12Months;
  String? isSomebodyElseIsProcessingLoanAsWell;
  String? isCustomerUserOfBankbayApplication;

  VerifiedHistoryRemark({
    this.isCustomerInterestedInAvailingLoan,
    this.howSoonTheCustomerWantsLoan,
    this.hasCustomerAppliedForLoanInLast12Months,
    this.isSomebodyElseIsProcessingLoanAsWell,
    this.isCustomerUserOfBankbayApplication,
  });

  factory VerifiedHistoryRemark.fromJson(Map<String, dynamic> json) => VerifiedHistoryRemark(
    isCustomerInterestedInAvailingLoan: json["is_customer_interested_in_availing_loan"]??"",
    howSoonTheCustomerWantsLoan: json["how_soon_the_customer_wants_loan"]??"",
    hasCustomerAppliedForLoanInLast12Months: json["has_customer_applied_for_loan_in_last12_months"]??"",
    isSomebodyElseIsProcessingLoanAsWell: json["is_somebody_else_is_processing_loan_as_well"]??"",
    isCustomerUserOfBankbayApplication: json["is_customer_user_of_bankbay_application"]??"",
  );

  Map<String, dynamic> toJson() => {
    "is_customer_interested_in_availing_loan": isCustomerInterestedInAvailingLoan,
    "how_soon_the_customer_wants_loan": howSoonTheCustomerWantsLoan,
    "has_customer_applied_for_loan_in_last12_months": hasCustomerAppliedForLoanInLast12Months,
    "is_somebody_else_is_processing_loan_as_well": isSomebodyElseIsProcessingLoanAsWell,
    "is_customer_user_of_bankbay_application": isCustomerUserOfBankbayApplication,
  };
}
