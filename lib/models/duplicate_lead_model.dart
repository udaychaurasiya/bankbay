
import 'dart:convert';

DuplicateLeadModel duplicateLeadModelFromJson(String str) => DuplicateLeadModel.fromJson(json.decode(str));

String duplicateLeadModelToJson(DuplicateLeadModel data) => json.encode(data.toJson());

class DuplicateLeadModel {
  String? message;
  String? status;
  bool? popupStatus;
  DuplicateData data;

  DuplicateLeadModel({
    this.message,
    this.status,
    this.popupStatus,
    required this.data,
  });

  factory DuplicateLeadModel.fromJson(Map<String, dynamic> json) => DuplicateLeadModel(
    message: json["message"],
    status: json["status"],
    popupStatus: json["popup_status"],
    data: DuplicateData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "popup_status": popupStatus,
    "data": data.toJson(),
  };
}

class DuplicateData {
  dynamic active;
  CustData custData;
  List<LDatum> plData;
  List<LDatum> blData;
  List<LDatum> selData;

  DuplicateData({
    this.active,
    required this.custData,
    required this.plData,
    required this.blData,
    required this.selData,
  });

  factory DuplicateData.fromJson(Map<String, dynamic> json) => DuplicateData(
    active: json["Active"],
    custData: CustData.fromJson(json["cust_data"]),
    plData: List<LDatum>.from(json["pl_data"].map((x) => LDatum.fromJson(x))),
    blData: List<LDatum>.from(json["bl_data"].map((x) => LDatum.fromJson(x))),
    selData: List<LDatum>.from(json["sel_data"].map((x) => LDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Active": active,
    "cust_data": custData.toJson(),
    "pl_data": List<dynamic>.from(plData.map((x) => x.toJson())),
    "bl_data": List<dynamic>.from(blData.map((x) => x.toJson())),
    "sel_data": List<dynamic>.from(selData.map((x) => x.toJson())),
  };
}

class CustData {
  dynamic id;
  dynamic custId;
  String? custCreateDatetime;
  String? custSource;
  String? custName;
  String? custLname;
  String? custPhone;
  String? custEmail;
  String? custSocial;
  String? custDob;
  int? custAge;
  String? custGender;
  String? custAadhar;
  String? custPan;
  String? adharVerifyStatus;
  String? panVerifyStatus;
  dynamic custPassport;
  dynamic custLocIp;
  String? custPincode;
  String? custAddress;
  String? custMaritalStatus;
  dynamic custOccupation;
  dynamic custCompany;
  String? custEducation;
  int? custIncome;
  int? custLeadCount;
  dynamic custProfilePic;
  int? custAssignCount;
  dynamic custFirstAssignTo;
  dynamic custLastAssignTo;
  int? custServiceCount;
  int? custWalletAmt;
  int? otpPhone;
  String? otpPhoneStatus;
  int? otpEmail;
  dynamic otpEmailStatus;
  dynamic custStatus;
  dynamic custCompanyType;
  String? custPassword;
  dynamic loginPin;
  dynamic otpStatusLoginpin;
  String? isUser;
  dynamic custCountry;
  dynamic custState;
  dynamic fringerprintLock;

  CustData({
    this.id,
    this.custId,
    this.custCreateDatetime,
    this.custSource,
    this.custName,
    this.custLname,
    this.custPhone,
    this.custEmail,
    this.custSocial,
    this.custDob,
    this.custAge,
    this.custGender,
    this.custAadhar,
    this.custPan,
    this.adharVerifyStatus,
    this.panVerifyStatus,
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
    this.otpStatusLoginpin,
    this.isUser,
    this.custCountry,
    this.custState,
    this.fringerprintLock,
  });

  factory CustData.fromJson(Map<String, dynamic> json) => CustData(
    id: json["id"],
    custId: json["cust_id"],
    custCreateDatetime: json["cust_create_datetime"],
    custSource: json["cust_source"],
    custName: json["cust_name"],
    custLname: json["cust_lname"],
    custPhone: json["cust_phone"],
    custEmail: json["cust_email"],
    custSocial: json["cust_social"],
    custDob: json["cust_dob"],
    custAge: json["cust_age"],
    custGender: json["cust_gender"],
    custAadhar: json["cust_aadhar"],
    custPan: json["cust_pan"],
    adharVerifyStatus: json["adhar_verify_status"],
    panVerifyStatus: json["pan_verify_status"],
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
    otpStatusLoginpin: json["otp_status_loginpin"],
    isUser: json["is_user"],
    custCountry: json["cust_country"],
    custState: json["cust_state"],
    fringerprintLock: json["fringerprint_lock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cust_id": custId,
    "cust_create_datetime": custCreateDatetime,
    "cust_source": custSource,
    "cust_name": custName,
    "cust_lname": custLname,
    "cust_phone": custPhone,
    "cust_email": custEmail,
    "cust_social": custSocial,
    "cust_dob": custDob,
    "cust_age": custAge,
    "cust_gender": custGender,
    "cust_aadhar": custAadhar,
    "cust_pan": custPan,
    "adhar_verify_status": adharVerifyStatus,
    "pan_verify_status": panVerifyStatus,
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
    "otp_status_loginpin": otpStatusLoginpin,
    "is_user": isUser,
    "cust_country": custCountry,
    "cust_state": custState,
    "fringerprint_lock": fringerprintLock,
  };
}


class LDatum {
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
  dynamic leadAssignHistory;
  dynamic leadAssignTele;
  dynamic leadAssignFos;
  dynamic leadAssignPartner;
  dynamic firstCallDateTime;
  dynamic lastCallDateTime;
  dynamic followupCreatedBy;
  int? followupCount;
  dynamic nextFollowupDate;
  dynamic nextFollowupTime;
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
  dynamic validateBy;
  int? holdCount;
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
  String? custActiveLoan;
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
  dynamic docSalaryslip;
  dynamic docBanking;
  dynamic docOhp;
  dynamic docRelationProof;
  dynamic docPresentAddress;
  dynamic docPermanentAddress;
  String? custLoanSelfie;
  String? docPanVerifyStatus;
  String? docAadharVerifyStatus;
  dynamic docPassportVerifyStatus;
  dynamic docSalaryslipVerifyStatus;
  dynamic docBankingVerifyStatus;
  dynamic docOhpVerifyStatus;
  dynamic docRelationProofVerifyStatus;
  dynamic docPresentAddressVerifyStatus;
  dynamic docPermanentAddressVerifyStatus;
  String? custLoanSelfieVerifyStatus;
  String? otpPhoneStatus;
  String? adharVerifyStatus;
  String? panVerifyStatus;
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
  String? leadSourceBy;
  String? createdByName;

  LDatum({
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
    this.validateBy,
    this.holdCount,
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
    this.custActiveLoan,
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
    this.otpPhoneStatus,
    this.adharVerifyStatus,
    this.panVerifyStatus,
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
    this.leadSourceBy,
    this.createdByName,
  });

  factory LDatum.fromJson(Map<String, dynamic> json) => LDatum(
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
    validateStatus: json["validate_status"],
    validateBy: json["validate_by"],
    holdCount: json["hold_count"],
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
    custActiveLoan: json["cust_active_loan"],
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
    otpPhoneStatus: json["otp_phone_status"],
    adharVerifyStatus: json["adhar_verify_status"],
    panVerifyStatus: json["pan_verify_status"],
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
    leadSourceBy: json["lead_source_by"],
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
    "login_amount": loginAmount,
    "login_tenure": loginTenure,
    "application_form": applicationForm,
    "lead_status": leadStatus,
    "validate_status": validateStatus,
    "validate_by": validateBy,
    "hold_count": holdCount,
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
    "cust_active_loan": custActiveLoan,
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
    "otp_phone_status": otpPhoneStatus,
    "adhar_verify_status": adharVerifyStatus,
    "pan_verify_status": panVerifyStatus,
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
    "lead_source_by": leadSourceBy,
    "created_by_name": createdByName,
  };
}
