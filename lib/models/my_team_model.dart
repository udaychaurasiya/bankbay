import 'dart:convert';

MyTeamLeadsModel myTeamLeadsModelFromJson(String str) => MyTeamLeadsModel.fromJson(json.decode(str));

String myTeamLeadsModelToJson(MyTeamLeadsModel data) => json.encode(data.toJson());

class MyTeamLeadsModel {
  String? message;
  String? status;
  List<CustData> data;
  List<EmpList> empList;

  MyTeamLeadsModel({
    this.message,
    this.status,
    required this.data,
    required this.empList,
  });

  factory MyTeamLeadsModel.fromJson(Map<String, dynamic> json) => MyTeamLeadsModel(
    message: json["message"],
    status: json["status"],
    data: List<CustData>.from(json["data"]==null?[]:json["data"].map((x) => CustData.fromJson(x))),
    empList: json["emp_list"]==null?[]:List<EmpList>.from(json["emp_list"].map((x) => EmpList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "emp_list": List<dynamic>.from(empList.map((x) => x.toJson())),
  };
}

class CustData {
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
  dynamic custPassport;
  dynamic custLocIp;
  dynamic custPincode;
  dynamic custAddress;
  String? custMaritalStatus;
  dynamic custOccupation;
  String? custCompany;
  String? custEducation;
  int? custIncome;
  int? custLeadCount;
  String? custProfilePic;
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
  String? custCompanyType;
  String? custPassword;
  dynamic loginPin;
  dynamic otpStatusLoginpin;
  String? isUser;
  dynamic custCountry;
  dynamic custState;
  dynamic countryId;
  dynamic stateId;

  CustData({
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
    this.otpStatusLoginpin,
    this.isUser,
    this.custCountry,
    this.custState,
    this.countryId,
    this.stateId,
  });

  factory CustData.fromJson(Map<String, dynamic> json) => CustData(
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
    "otp_status_loginpin": otpStatusLoginpin,
    "is_user": isUser,
    "cust_country": custCountry,
    "cust_state": custState,
    "country_id": countryId,
    "state_id": stateId,
  };
}

class EmpList {
  dynamic id;
  dynamic eid;
  dynamic supId;
  dynamic empSourceId;
  String? empFname;
  String? empLname;
  String? empDob;
  String? empGender;
  dynamic empPan;
  dynamic empAadhar;
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
  dynamic empFunction;
  dynamic empDesignation;
  dynamic empBand;
  dynamic empJoinSalary;
  dynamic empPresentSalary;
  dynamic empSalaryRevisionCount;
  dynamic empDesignationRevisionCount;
  dynamic empBankDetail;
  dynamic empRelative;
  dynamic empReference;
  String? empStatus;
  String? pushbackCount;
  dynamic empJoinDate;
  dynamic empResignDate;
  dynamic empLastWorkingDate;
  String? empCreateBy;
  dynamic empApprovedBy;
  dynamic approveStatus;
  dynamic reqApproverId;
  dynamic docPan;
  dynamic docAadhar;
  dynamic docPassport;
  String? docProfilePic;
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
  String? empMaritalStatus;
  String? empEducation;
  String? empCreateDatetime;
  dynamic empSaveType;
  dynamic empRelivingDate;
  dynamic empRelivingLetter;
  String? empPassword;
  String? empWallet;
  String? empPhoneOtp;
  String? empFpOtpStatus;
  String? propertyOwnerType;
  String? addressProofType;
  dynamic fringerprintLock;
  String? supName;

  EmpList({
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
  });

  factory EmpList.fromJson(Map<String, dynamic> json) => EmpList(
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
  };
}

class AccessDefault {
  dynamic id;
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
  };
}

class AccessSpecial {
  dynamic id;
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
    "assignement_change_approval": assignementChangeApproval,
    "change_by_name": changeByName,
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

