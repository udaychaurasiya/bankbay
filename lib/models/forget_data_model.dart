import 'dart:convert';

ForgetDataModel forgetDataModelFromJson(String str) => ForgetDataModel.fromJson(json.decode(str));

String forgetDataModelToJson(ForgetDataModel data) => json.encode(data.toJson());

class ForgetDataModel {
  String? message;
  String? status;
  List<Datum> data;

  ForgetDataModel({
    this.message,
    this.status,
    required this.data,
  });

  factory ForgetDataModel.fromJson(Map<String, dynamic> json) => ForgetDataModel(
    message: json["message"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? custId;
  String? custCreateDatetime;
  String? custSource;
  String? custName;
  String? custPhone;
  String? custEmail;
  String? custDob;
  int? custAge;
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
  dynamic otpPhone;
  String? otpPhoneStatus;
  dynamic otpEmail;
  String? otpEmailStatus;
  String? custStatus;
  String? custCompanyType;
  dynamic custPassword;

  Datum({
    this.id,
    this.custId,
    this.custCreateDatetime,
    this.custSource,
    this.custName,
    this.custPhone,
    this.custEmail,
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
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    custId: json["cust_id"],
    custCreateDatetime: json["cust_create_datetime"],
    custSource: json["cust_source"],
    custName: json["cust_name"],
    custPhone: json["cust_phone"],
    custEmail: json["cust_email"],
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cust_id": custId,
    "cust_create_datetime": custCreateDatetime,
    "cust_source": custSource,
    "cust_name": custName,
    "cust_phone": custPhone,
    "cust_email": custEmail,
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
  };
}
