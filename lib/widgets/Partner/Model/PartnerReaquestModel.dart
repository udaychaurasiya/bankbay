// To parse this JSON data, do
//
//     final partnerReaquestModel = partnerReaquestModelFromJson(jsonString);

import 'dart:convert';

PartnerReaquestModel partnerReaquestModelFromJson(String str) => PartnerReaquestModel.fromJson(json.decode(str));

String partnerReaquestModelToJson(PartnerReaquestModel data) => json.encode(data.toJson());

class PartnerReaquestModel {
  String? message;
  String? status;
  Data? data;

  PartnerReaquestModel({
    this.message,
    this.status,
    this.data,
  });

  factory PartnerReaquestModel.fromJson(Map<String, dynamic> json) => PartnerReaquestModel(
    message: json["message"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  int? limit;
  int? page;
  List<Partnerdatum>? partnerdata;

  Data({
    this.limit,
    this.page,
    this.partnerdata,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    limit: json["limit"],
    page: json["page"],
    partnerdata: List<Partnerdatum>.from(json["partnerdata"].map((x) => Partnerdatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "page": page,
    "partnerdata": List<dynamic>.from(partnerdata!.map((x) => x.toJson())),
  };
}

class Partnerdatum {
  int? id;
  String? pid;
  String? custId;
  dynamic supId;
  dynamic partnerPresentAddress;
  dynamic partnerPresentAddressPin;
  dynamic partnerPermanentAddress;
  dynamic partnerPermanentAddressPin;
  dynamic empBankDetail;
  dynamic partnerReference;
  String? partnerStatus;
  DateTime? partnerJoinDate;
  String? partnerApprovedDate;
  dynamic partnerLastWorkingDate;
  dynamic partnerCreateBy;
  dynamic partnerApprovedBy;
  String? addressProofType;
  String? propertyOwnerType;
  dynamic partnerBand;
  dynamic docPan;
  dynamic docAadhar;
  dynamic docPassport;
  dynamic docProfilePic;
  dynamic docSalaryslip;
  dynamic docBanking;
  dynamic docOhp;
  dynamic docRelationProof;
  dynamic docPresentAddress;
  dynamic docPermanentAddress;
  dynamic doc10ThProof;
  dynamic doc12ThProof;
  dynamic docGraduationProof;
  dynamic docMastersProof;
  dynamic docPhdProof;
  dynamic docCertificationProof;
  dynamic docRentAgreement;
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
  String? otpEmailStatus;
  String? otpPhoneStatus;
  String? custStatus;
  String? custCompanyType;
  String? isUser;
  String? custCountry;
  String? custState;
  String? stateName;
  String? countryName;

  Partnerdatum({
    this.id,
    this.pid,
    this.custId,
    this.supId,
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
    this.otpEmailStatus,
    this.otpPhoneStatus,
    this.custStatus,
    this.custCompanyType,
    this.isUser,
    this.custCountry,
    this.custState,
    this.stateName,
    this.countryName,
  });

  factory Partnerdatum.fromJson(Map<String, dynamic> json) => Partnerdatum(
    id: json["id"]??"",
    pid: json["pid"]??"",
    custId: json["cust_id"]??"",
    supId: json["sup_id"]??"",
    partnerPresentAddress: json["partner_present_address"]??"",
    partnerPresentAddressPin: json["partner_present_address_pin"]??"",
    partnerPermanentAddress: json["partner_permanent_address"]??"",
    partnerPermanentAddressPin: json["partner_permanent_address_pin"]??"",
    empBankDetail: json["emp_bank_detail"]??"",
    partnerReference: json["partner_reference"]??"",
    partnerStatus: json["partner_status"]??"",
    partnerJoinDate: DateTime.parse(json["partner_join_date"]??""),
    partnerApprovedDate: json["partner_approved_date"]??"",
    partnerLastWorkingDate: json["partner_last_working_date"]??"",
    partnerCreateBy: json["partner_create_by"]??"",
    partnerApprovedBy: json["partner_approved_by"]??"",
    addressProofType: json["address_proof_type"]??"",
    propertyOwnerType: json["property_owner_type"]??"",
    partnerBand: json["partner_band"]??"",
    docPan: json["doc_pan"]??"",
    docAadhar: json["doc_aadhar"]??"",
    docPassport: json["doc_passport"]??"",
    docProfilePic: json["doc_profile_pic"]??"",
    docSalaryslip: json["doc_salaryslip"]??"",
    docBanking: json["doc_banking"]??"",
    docOhp: json["doc_ohp"]??"",
    docRelationProof: json["doc_relation_proof"]??"",
    docPresentAddress: json["doc_present_address"]??"",
    docPermanentAddress: json["doc_permanent_address"]??"",
    doc10ThProof: json["doc_10th_proof"]??"",
    doc12ThProof: json["doc_12th_proof"]??"",
    docGraduationProof: json["doc_graduation_proof"]??"",
    docMastersProof: json["doc_masters_proof"]??"",
    docPhdProof: json["doc_phd_proof"]??"",
    docCertificationProof: json["doc_certification_proof"]??"",
    docRentAgreement: json["doc_rent_agreement"]??"",
    custLocIp: json["cust_loc_ip"]??"",
    custPincode: json["cust_pincode"]??"",
    custAddress: json["cust_address"]??"",
    custMaritalStatus: json["cust_marital_status"]??"",
    custOccupation: json["cust_occupation"]??"",
    custCompany: json["cust_company"]??"",
    custEducation: json["cust_education"]??"",
    custIncome: json["cust_income"]??"",
    custLeadCount: json["cust_lead_count"]??"",
    custProfilePic: json["cust_profile_pic"]??"",
    custAssignCount: json["cust_assign_count"]??"",
    custFirstAssignTo: json["cust_first_assign_to"]??"",
    custLastAssignTo: json["cust_last_assign_to"]??"",
    custServiceCount: json["cust_service_count"]??"",
    custWalletAmt: json["cust_wallet_amt"]??"",
    otpEmailStatus: json["otp_email_status"]??"",
    otpPhoneStatus: json["otp_phone_status"]??"",
    custStatus: json["cust_status"]??"",
    custCompanyType: json["cust_company_type"]??"",
    isUser: json["is_user"]??"",
    custCountry: json["cust_country"]??"",
    custState: json["cust_state"]??"",
    stateName: json["state_name"]??"",
    countryName: json["country_name"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pid": pid,
    "cust_id": custId,
    "sup_id": supId,
    "partner_present_address": partnerPresentAddress,
    "partner_present_address_pin": partnerPresentAddressPin,
    "partner_permanent_address": partnerPermanentAddress,
    "partner_permanent_address_pin": partnerPermanentAddressPin,
    "emp_bank_detail": empBankDetail,
    "partner_reference": partnerReference,
    "partner_status": partnerStatus,
    "partner_join_date": partnerJoinDate!.toIso8601String(),
    "partner_approved_date": partnerApprovedDate,
    "partner_last_working_date": partnerLastWorkingDate,
    "partner_create_by": partnerCreateBy,
    "partner_approved_by": partnerApprovedBy,
    "address_proof_type": addressProofType,
    "property_owner_type": propertyOwnerType,
    "partner_band": partnerBand,
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
    "otp_email_status": otpEmailStatus,
    "otp_phone_status": otpPhoneStatus,
    "cust_status": custStatus,
    "cust_company_type": custCompanyType,
    "is_user": isUser,
    "cust_country": custCountry,
    "cust_state": custState,
    "state_name": stateName,
    "country_name": countryName,
  };
}
