// To parse this JSON data, do
//
//     final teamLeadsModel = teamLeadsModelFromJson(jsonString);

import 'dart:convert';

TeamLeadsModel teamLeadsModelFromJson(String str) => TeamLeadsModel.fromJson(json.decode(str));

String teamLeadsModelToJson(TeamLeadsModel data) => json.encode(data.toJson());

class TeamLeadsModel {
  String? message;
  String? status;
  TeamLeadData data;

  TeamLeadsModel({
    this.message,
    this.status,
    required this.data,
  });

  factory TeamLeadsModel.fromJson(Map<String, dynamic> json) => TeamLeadsModel(
    message: json["message"],
    status: json["status"],
    data: TeamLeadData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class TeamLeadData {
  int? limit;
  int? page;
  List<Count> counts;
  List<TeamLead> teamLead;

  TeamLeadData({
    this.limit,
    this.page,
    required this.counts,
    required this.teamLead,
  });

  factory TeamLeadData.fromJson(Map<String, dynamic> json) => TeamLeadData(
    limit: json["limit"],
    page: json["page"],
    counts: json["counts"]==null?[]:List<Count>.from(json["counts"].map((x) => Count.fromJson(x))),
    teamLead: json["teamLead"]==null?[]:List<TeamLead>.from(json["teamLead"].map((x) => TeamLead.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "page": page,
    "counts": List<dynamic>.from(counts.map((x) => x.toJson())),
    "teamLead": List<dynamic>.from(teamLead.map((x) => x.toJson())),
  };
}

class Count {
  String? title;
  int? count;

  Count({
    this.title,
    this.count,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
    title: json["title"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "count": count,
  };
}

class TeamLead {
  int? id;
  String? leadId;
  String? custId;
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
  String? nextFollowupTime;
  String? leadRemark;
  String? loginBankName;
  String? bankDocSubmitDate;
  String? bankLoginDate;
  String? loanAppId;
  String? leadStatus;
  int? holdCount;
  String? leadDropCat;
  String? sancDate;
  int? sancAmt;
  String? sancRoi;
  int? sancDuration;
  int? disbAmt;
  String? disbRoi;
  int? disbDuration;
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
  String? createdByName;

  TeamLead({
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
    this.leadStatus,
    this.holdCount,
    this.leadDropCat,
    this.sancDate,
    this.sancAmt,
    this.sancRoi,
    this.sancDuration,
    this.disbAmt,
    this.disbRoi,
    this.disbDuration,
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
    this.createdByName,
  });

  factory TeamLead.fromJson(Map<String, dynamic> json) => TeamLead(
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
    leadStatus: json["lead_status"],
    holdCount: json["hold_count"],
    leadDropCat: json["lead_drop_cat"],
    sancDate: json["sanc_date"],
    sancAmt: json["sanc_amt"],
    sancRoi: json["sanc_roi"],
    sancDuration: json["sanc_duration"],
    disbAmt: json["disb_amt"],
    disbRoi: json["disb_roi"],
    disbDuration: json["disb_duration"],
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
    createdByName: json["created_by_name"],
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
    "lead_status": leadStatus,
    "hold_count": holdCount,
    "lead_drop_cat": leadDropCat,
    "sanc_date": sancDate,
    "sanc_amt": sancAmt,
    "sanc_roi": sancRoi,
    "sanc_duration": sancDuration,
    "disb_amt": disbAmt,
    "disb_roi": disbRoi,
    "disb_duration": disbDuration,
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
    "lead_lock_status" : leadLockStatus,
    "locked_by" : lockedBy,
    "acc_trx_date" : accTrxDate,
    "acc_trx_id" : accTrxId,
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
    "created_by_name": createdByName,
  };
}
