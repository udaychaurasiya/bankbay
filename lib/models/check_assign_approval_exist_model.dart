import 'dart:convert';

CheckAssignApprovalExistModel checkAssignApprovalExistModelFromJson(String str) => CheckAssignApprovalExistModel.fromJson(json.decode(str));

String checkAssignApprovalExistModelToJson(CheckAssignApprovalExistModel data) => json.encode(data.toJson());

class CheckAssignApprovalExistModel {
  String? message;
  String? status;
  List<CheckAssignApprovalExist> data;

  CheckAssignApprovalExistModel({
    this.message,
    this.status,
    required this.data,
  });

  factory CheckAssignApprovalExistModel.fromJson(Map<String, dynamic> json) => CheckAssignApprovalExistModel(
    message: json["message"],
    status: json["status"],
    data: List<CheckAssignApprovalExist>.from(json["data"].map((x) => CheckAssignApprovalExist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CheckAssignApprovalExist {
  int? id;
  String? eid;
  String? supId;
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
  String? docRentAgreement;
  String? empMaritalStatus;
  String? empEducation;
  String? empCreateDatetime;
  String? empSaveType;
  String? empRelivingDate;
  String? empRelivingLetter;
  String? empPassword;
  String? empPhoneOtp;
  String? empFpOtpStatus;
  String? propertyOwnerType;
  String? addressProofType;
  String? supName;

  CheckAssignApprovalExist({
    this.id,
    this.eid,
    this.supId,
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
    this.supName,
  });

  factory CheckAssignApprovalExist.fromJson(Map<String, dynamic> json) => CheckAssignApprovalExist(
    id: json["id"],
    eid: json["eid"],
    supId: json["sup_id"],
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
    supName: json["sup_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "eid": eid,
    "sup_id": supId,
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
    "sup_name": supName,
  };
}
