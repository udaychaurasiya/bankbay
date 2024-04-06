import 'dart:convert';

AllPartnerModel allPartnerModelFromJson(String str) => AllPartnerModel.fromJson(json.decode(str));

String allPartnerModelToJson(AllPartnerModel data) => json.encode(data.toJson());

class AllPartnerModel {
  String? message;
  String? status;
  int? page;
  int? limit;
  List<AllPartnerData> data;

  AllPartnerModel({
    this.message,
    this.status,
    this.page,
    this.limit,
    required this.data,
  });

  factory AllPartnerModel.fromJson(Map<String, dynamic> json) => AllPartnerModel(
    message: json["message"],
    status: json["status"],
    page: json["page"],
    limit: json["limit"],
    data: List<AllPartnerData>.from(json["data"].map((x) => AllPartnerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "page": page,
    "limit": limit,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AllPartnerData {
  int? id;
  String? pid;
  String? custId;
  String? supId;
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
  dynamic partnerApprovedBy;
  String? addressProofType;
  String? propertyOwnerType;
  String? partnerBand;
  String? docPan;
  String? docAadhar;
  dynamic docPassport;
  dynamic docProfilePic;
  dynamic docSalaryslip;
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
  String? custName;
  String? custDob;
  String? custEmail;
  String? custPhone;
  String? custSocial;
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
  String? otpEmailStatus;
  String? otpPhoneStatus;
  String? custStatus;
  String? custCompanyType;
  String? isUser;
  String? custCountry;
  String? custState;
  dynamic stateName;
  dynamic countryName;
  Access access;

  AllPartnerData({
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
    this.custName,
    this.custDob,
    this.custEmail,
    this.custPhone,
    this.custSocial,
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
    this.otpEmailStatus,
    this.otpPhoneStatus,
    this.custStatus,
    this.custCompanyType,
    this.isUser,
    this.custCountry,
    this.custState,
    this.stateName,
    this.countryName,
    required this.access,
  });

  factory AllPartnerData.fromJson(Map<String, dynamic> json) => AllPartnerData(
    id: json["id"],
    pid: json["pid"],
    custId: json["cust_id"],
    supId: json["sup_id"],
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
    custName: json["cust_name"],
    custDob: json["cust_dob"],
    custEmail: json["cust_email"],
    custPhone: json["cust_phone"],
    custSocial: json["cust_social"],
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
    otpEmailStatus: json["otp_email_status"],
    otpPhoneStatus: json["otp_phone_status"],
    custStatus: json["cust_status"],
    custCompanyType: json["cust_company_type"],
    isUser: json["is_user"],
    custCountry: json["cust_country"],
    custState: json["cust_state"],
    stateName: json["state_name"],
    countryName: json["country_name"],
    access: Access.fromJson(json["access"]),
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
    "partner_join_date": partnerJoinDate,
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
    "cust_name": custName,
    "cust_dob": custDob,
    "cust_email": custEmail,
    "cust_phone": custPhone,
    "cust_social": custSocial,
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
    "otp_email_status": otpEmailStatus,
    "otp_phone_status": otpPhoneStatus,
    "cust_status": custStatus,
    "cust_company_type": custCompanyType,
    "is_user": isUser,
    "cust_country": custCountry,
    "cust_state": custState,
    "state_name": stateName,
    "country_name": countryName,
    "access": access.toJson(),
  };
}

class Access {
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
  String? myteamLead;
  String? assignMypartnerLead;
  String? addLead;
  String? myLead;
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

  Access({
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
    this.myteamLead,
    this.assignMypartnerLead,
    this.addLead,
    this.myLead,
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
  });

  factory Access.fromJson(Map<String, dynamic> json) => Access(
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
    myteamLead: json["myteam_lead"],
    assignMypartnerLead: json["assign_mypartner_lead"],
    addLead: json["add_lead"],
    myLead: json["my_lead"],
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
    "myteam_lead": myteamLead,
    "assign_mypartner_lead": assignMypartnerLead,
    "add_lead": addLead,
    "my_lead": myLead,
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
  };
}
