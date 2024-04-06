
import 'dart:convert';

AddEmpKycModel addEmpKycModelFromJson(String str) => AddEmpKycModel.fromJson(json.decode(str));

String addEmpKycModelToJson(AddEmpKycModel data) => json.encode(data.toJson());

class AddEmpKycModel {
  String? message;
  String? status;
  KYCData data;

  AddEmpKycModel({
    this.message,
    this.status,
    required this.data,
  });

  factory AddEmpKycModel.fromJson(Map<String, dynamic> json) => AddEmpKycModel(
    message: json["message"],
    status: json["status"],
    data: KYCData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class KYCData {
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
  String? empMaritalStatus;
  String? empEducation;
  String? empCreateDatetime;
  String? empSaveType;
  dynamic empRelivingDate;
  dynamic empRelivingLetter;
  List<EducationList> educationList;
  List<ExperienceList> experienceList;

  KYCData({
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
    this.empMaritalStatus,
    this.empEducation,
    this.empCreateDatetime,
    this.empSaveType,
    this.empRelivingDate,
    this.empRelivingLetter,
    required this.educationList,
    required this.experienceList,
  });

  factory KYCData.fromJson(Map<String, dynamic> json) => KYCData(
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
    empMaritalStatus: json["emp_marital_status"],
    empEducation: json["emp_education"],
    empCreateDatetime: json["emp_create_datetime"],
    empSaveType: json["emp_save_type"],
    empRelivingDate: json["emp_reliving_date"],
    empRelivingLetter: json["emp_reliving_letter"],
    educationList: List<EducationList>.from(json["educationList"].map((x) => EducationList.fromJson(x))),
    experienceList: List<ExperienceList>.from(json["experienceList"].map((x) => ExperienceList.fromJson(x))),
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
    "emp_marital_status": empMaritalStatus,
    "emp_education": empEducation,
    "emp_create_datetime": empCreateDatetime,
    "emp_save_type": empSaveType,
    "emp_reliving_date": empRelivingDate,
    "emp_reliving_letter": empRelivingLetter,
    "educationList": List<dynamic>.from(educationList.map((x) => x.toJson())),
    "experienceList": List<dynamic>.from(experienceList.map((x) => x.toJson())),
  };
}

class EducationList {
  int? id;
  String? eid;
  String? empInstituteName;
  String? empCourseName;
  String? empCourseType;
  String? empCourseStart;
  String? empCourseEnd;
  String? empCourseGrade;
  String? empSkills;

  EducationList({
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

  factory EducationList.fromJson(Map<String, dynamic> json) => EducationList(
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

class ExperienceList {
  int? id;
  String? eid;
  String? empDesignation;
  String? empCompany;
  String? empFunction;
  String? empIndustry;
  String? empCompanySize;
  String? empJobStartDate;
  String? empJobEndDate;
  int? empLastSalary;
  int? empJoiningSalary;

  ExperienceList({
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

  factory ExperienceList.fromJson(Map<String, dynamic> json) => ExperienceList(
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
