// ignore_for_file: non_constant_identifier_names, avoid_print, deprecated_member_use, invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bank_bay/models/add_employee_permission_access_model.dart';
import 'package:bank_bay/models/check_assign_approval_exist_model.dart';
import 'package:bank_bay/models/check_owner_exist_model.dart';
import 'package:bank_bay/models/check_supervisorId_exist_model.dart';
import 'package:bank_bay/models/details_documet_update_status_model.dart';
import 'package:bank_bay/models/draft_loan_lead_model.dart';
import 'package:bank_bay/models/employee_details_model.dart';
import 'package:bank_bay/models/get_lead_details_model.dart';
import 'package:bank_bay/models/my_loan_history_model.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/utils/BaseClient.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/widgets/Customer%20details/Details/details_status.dart';
import 'package:bank_bay/widgets/Partner/Model/PartnerReaquestModel.dart';
import 'package:bank_bay/widgets/Partner/Model/all_partner_model.dart';
import 'package:bank_bay/widgets/Partner/Model/partner_approval_model.dart';
import 'package:bank_bay/widgets/Partner/Model/partner_pushback_model.dart';
import 'package:bank_bay/widgets/Partner/Model/partner_request_model.dart';
import 'package:bank_bay/widgets/Profile/Model/CountryModel.dart';
import 'package:bank_bay/widgets/Profile/Model/StateModel.dart';
import 'package:bank_bay/widgets/Profile/Model/user_details_model.dart';
import 'package:bank_bay/widgets/Profile/Model/profile_complete_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:otp_text_field/otp_text_field.dart';

class PartnerController extends GetxController{
  GetStorage storage = GetStorage();
  RxBool partnerLoading=false.obs;
  RxBool partnerLoadMore=false.obs;

  @override
  void onInit() {
    allPartnerPagination();
    partnerPushbackPagination();
    partnerApprovedPagination();
    partnerRequestPagination();
    myLoanHistoryPagination();
    isCheckedList.assignAll(List.generate(rejectItemList.length, (index) => false));
    isLoanListCheckedList.assignAll(List.generate(loanListRejectItemList.length, (index) => false));
    partnerRefreshList();
    refreshDropdownList();
    super.onInit();
  }

  List<String> genderList = [];
  List<String> maritalStatusList = [];
  List<String> highestQualificationList = [];
  List<String> draftCompanyType = [];
  List<String> draftLoanTypeList = [];
  List<String> draftLoanYearList = [];
  List<String> draftLoanMonthList = [];

  void refreshDropdownList(){
    genderList = ["Select Gender" ,"Male", "Female", "Other"];
    maritalStatusList = ["Select Marital", "Married", "Single", "Divorced"];
    highestQualificationList = ["Select Qualification", "High School", "Graduation", "Masters", "Phd", "Certificate", "Diploma","Mca"];
    draftCompanyType= ["Select Company", "Private Limited","Public Limited", "Proprietorship", "Partnership", "LLP", "OPC", "NGO", "Government"];
    draftLoanTypeList= ["select loan","Personal Loan","Business Loan", "Self-Employed Loan"];
    draftLoanYearList= ["select year","1","3", "5","7","9", "12"];
    draftLoanMonthList= ["select month","12", "15","20","25", "30"];
  }

  var partnerrequest=PartnerReaquestModel().obs;
  var profileComplete=ProfileCompleteModel(data: ProfileData(cmpStatus: [])).obs;
  TextEditingController sendInvite=TextEditingController();
  TextEditingController etName=TextEditingController();
  TextEditingController etPhone=TextEditingController();
  TextEditingController etPinCode=TextEditingController();
  TextEditingController etSocail=TextEditingController();
  TextEditingController etEmail=TextEditingController();
  TextEditingController etCustmer=TextEditingController();
  TextEditingController etAdhar=TextEditingController();

  TextEditingController pFName = TextEditingController();
  TextEditingController pNumber = TextEditingController();
  TextEditingController pEmail = TextEditingController();
  TextEditingController pDob = TextEditingController();
  TextEditingController pFacebook = TextEditingController();
  TextEditingController pLinkedin = TextEditingController();
  TextEditingController pPanCard = TextEditingController();
  TextEditingController pPinCode = TextEditingController();
  TextEditingController pAddress = TextEditingController();
  TextEditingController pAadhaar = TextEditingController();
  TextEditingController pState = TextEditingController();
  TextEditingController pCountry = TextEditingController();
  OtpFieldController pOtpVerify = OtpFieldController();
  var selectCountry;
  var selectState;

  /// partner profile update fields
  TextEditingController emp_fName = TextEditingController();
  TextEditingController emp_lName = TextEditingController();
  TextEditingController emp_dob = TextEditingController();
  TextEditingController emp_phone = TextEditingController();
  TextEditingController emp_email = TextEditingController();
  TextEditingController emp_facebook = TextEditingController();
  TextEditingController emp_linkedin = TextEditingController();
  TextEditingController emp_present_address_pin = TextEditingController();
  TextEditingController emp_present_address = TextEditingController();
  TextEditingController emp_password = TextEditingController();
  TextEditingController emp_country = TextEditingController();
  TextEditingController emp_state = TextEditingController();
  TextEditingController emp_PanCard = TextEditingController();
  TextEditingController emp_Aadhaar = TextEditingController();
  /// emp payroll field
  TextEditingController empSupervisorId = TextEditingController();
  TextEditingController empJoiningSalary = TextEditingController();
  TextEditingController empPresentSalary = TextEditingController();
  TextEditingController empDesignation = TextEditingController();
  TextEditingController empJoiningDate = TextEditingController();
  TextEditingController empResignDate = TextEditingController();
  TextEditingController empLastWorkingDate = TextEditingController();
  TextEditingController empRelivingDate = TextEditingController();

  /// partner add fields
  TextEditingController supervisorId = TextEditingController();
  TextEditingController referralId = TextEditingController();
  TextEditingController functionUnit = TextEditingController();
  RxString partnerPayrollBrand = "Beginner".obs;
  List<String> partnerBandList = [];
  /// add partner access variables
  RxString partnerEmpViewAll = "No".obs;
  RxString partnerAddEMP = "No".obs;
  RxString partnerUpdateEMP = "No".obs;
  RxString partnerEmpPushBack = "No".obs;
  RxString partnerEmpApprove = "No".obs;
  RxString partnerEmpPendingApprove = "No".obs;
  RxString partnerPartnerViewAll = "No".obs;
  RxString partnerPartnerAdd = "No".obs;
  RxString partnerPartnerUpdate = "No".obs;
  RxString partnerPartnerPushBack = "No".obs;
  RxString unassignedLeads = "No".obs;
  RxString partnerAssignAllLead = "No".obs;
  RxString partnerAssignMyLead = "No".obs;
  RxString partnerAssignMyTeamLead = "No".obs;
  RxString partnerAssignMyPartnerLead = "No".obs;
  RxString partnerAddLead = "No".obs;
  RxString partnerMyLead = "No".obs;
  RxString partnerMyTeamLead = "No".obs;
  RxString partnerMyPartnerLead = "No".obs;
  RxString partnerAllCust = "No".obs;
  RxString partnerMyCust = "No".obs;
  RxString partnerMyTeamCust = "No".obs;
  RxString partnerMyPartnerCust = "No".obs;
  RxString partnerMySales = "No".obs;
  RxString partnerIncentiveMGMTView = "No".obs;
  RxString partnerIncentiveMGMTEdit = "No".obs;
  RxString partnerPanelManageEmployee = "No".obs;
  RxString partnerPanelManagePartner = "No".obs;
  RxString partnerPanelManageCustomer = "No".obs;
  RxString partnerNewLeadTab = "No".obs;
  RxString partnerVerificationTab = "No".obs;
  RxString partnerDisbursedTab = "No".obs;
  RxString partnerIncentiveTab = "No".obs;

  /// register field
  RxString gender ="Select Gender".obs;
  RxString companyType = "IT Company".obs;
  RxString maritalStatus = "Select Marital Status".obs;
  RxString highestQualification = "Select Qualification".obs;
  RxString otpVerify = "".obs;
  RxString profileImg = "".obs;
  TextEditingController apName = TextEditingController();
  TextEditingController apEmail = TextEditingController();
  TextEditingController apPassword = TextEditingController();
  TextEditingController apPanCard = TextEditingController();
  TextEditingController apNumber = TextEditingController();
  TextEditingController apDob = TextEditingController();
  TextEditingController apCompanyName = TextEditingController();
  TextEditingController apMonthlyAmount = TextEditingController();
  TextEditingController forgetNumber = TextEditingController();
  /// customer details
  TextEditingController customerDate = TextEditingController();
  TextEditingController customerTime = TextEditingController();

  RxInt selectedComunityIndex = 0.obs;

  /// lead update status fields
  var loginBankName = "select bank".obs;
  TextEditingController sanctionAmount = TextEditingController();
  TextEditingController sanctionRoi = TextEditingController();
  TextEditingController sanctionTenure = TextEditingController();
  TextEditingController sanctionDate = TextEditingController();

  TextEditingController disbursedAmount = TextEditingController();
  TextEditingController disbursedTenure = TextEditingController();
  TextEditingController disbursedRoi = TextEditingController();
  TextEditingController disbursedBankName = TextEditingController();
  TextEditingController disbursedBankAccountName = TextEditingController();
  TextEditingController disbursedBankAccountNumber = TextEditingController();
  TextEditingController disbursedBankIFSCCode = TextEditingController();
  TextEditingController disbursedMethod = TextEditingController();
  TextEditingController disbursedDate = TextEditingController();

  TextEditingController loginDate = TextEditingController();
  TextEditingController loginAppId = TextEditingController();
  TextEditingController loginAmount = TextEditingController();
  TextEditingController loginTenure = TextEditingController();

  /// hold verify rejected form fields
  List<Map> holdStatusList = <Map>[];
  List<Map> rejectedStatusList = <Map>[];
  RxString cust_interested_loan ="No".obs;
  RxString cust_wants_loan ="No".obs;
  RxString cust_applied_last_month ="No".obs;
  RxString cust_processing_loan ="No".obs;
  RxString cust_bankbay_application ="No".obs;

  List<String> employeeCourseTypeList = [];
  List<String> employeeCourseGradeList = [];
  List<String> employeeExperienceJobLevelList = [];
  List<String> employeeExperienceIndustryList = [];
  List<String> employeeExperienceJobFunctionList = [];
  ///  employee profile about section
  void partnerRefreshList(){
    employeeCourseTypeList = ["MBA", "B.Tech", "M.Tech"];
    employeeCourseGradeList = ["Garde A", "Grade B", "Grade C"];
    employeeExperienceJobLevelList = ["IT-Software", "Finance", "Operations", "Other"];
    employeeExperienceIndustryList = ["Telecom", "ITES", "Plastics","Retail","Textile","Other"];
    employeeExperienceJobFunctionList = ["Garde A", "Grade B", "Grade C"];
    partnerBandList = ["Beginner", "Practitioner", "Professional", "Star", "Gem", "Ambassador"];
  }


  /// details reject popup
  RxList<bool> isCheckedList = <bool>[].obs;
  List<ListItem> rejectItemList = [
    ListItem(title: 'Low Civil score', isSelected: false),
    ListItem(title: 'Financial norms not met', isSelected: false),
    ListItem(title: 'Age norms not met', isSelected: false),
    ListItem(title: 'Banking norms not met', isSelected: false),
    ListItem(title: 'Customer not interested', isSelected: false),
    ListItem(title: 'Too many credit enquires', isSelected: false),
    ListItem(title: 'Negative residence verification', isSelected: false),
    ListItem(title: 'Negative office verification', isSelected: false),
    ListItem(title: 'Age norms not met', isSelected: false),
    ListItem(title: 'Ownership norms not met', isSelected: false),
    ListItem(title: 'Incorrect lead', isSelected: false),
  ];

  /// loan list details reject popup
  RxList<bool> isLoanListCheckedList = <bool>[].obs;
  List<ListItem> loanListRejectItemList = [
    ListItem(title: 'Low Civil score', isSelected: false),
    ListItem(title: 'Financial norms not met', isSelected: false),
    ListItem(title: 'Age norms not met', isSelected: false),
    ListItem(title: 'Banking norms not met', isSelected: false),
    ListItem(title: 'Customer not interested', isSelected: false),
    ListItem(title: 'Too many credit enquires', isSelected: false),
    ListItem(title: 'Negative residence verification', isSelected: false),
    ListItem(title: 'Negative office verification', isSelected: false),
    ListItem(title: 'Age norms not met', isSelected: false),
    ListItem(title: 'Ownership norms not met', isSelected: false),
    // Add more items as needed
  ];

  loanTypeEncode(String value){
    switch (value) {
      case "PL":
        return "Personal Loan";
      case "BL":
        return "Business Loan";
      case "SEL":
        return "Self-Employee Loan";
      default:
        return "Personal Loan";
    }
  }

  loanTypeDecode(String value){
    switch (value) {
      case "Personal Loan":
        return "PL";
      case "Business Loan":
        return "BL";
      case "Self-Employee Loan":
        return "SEL";
      case "All Loan":
        return "";
      case "No Loan Customer":
        return "NO";
      default:
        return "";
    }
  }

  sourceFilterSendValue(String value){
    switch (value) {
      case "All Source":
        return "";
      case "Employee":
        return "employee";
      case "Partner":
        return "partner";
      case "Customer":
        return "customer";
      default:
        return "";
    }
  }

  leadStatusNameFilter(String value){
    switch (value) {
      case "All":
        return "";
      case "Unassigned":
        return "unassigned";
      case "Assigned":
        return "assigned";
      case "Rejected":
        return "rejected";
      case "Draft":
        return "draft";
      case "New":
        return "new";
      case "Hold":
        return "hold";
      case "Login":
        return "login";
      case "Sanctioned":
        return "sanctioned";
      case "Disbursed":
        return "disbursed";
      case "Inc Due":
        return "Inc Due";
      case "Inc Approval":
        return "inc_approval";
      case "Inc Paid":
        return "inc_paid";
      case "Pending Verification":
        return "pending_verification";
      case "Rejected Validation":
        return "rejected_validation";
      case "Validated":
        return "validated";
      case "Direct":
        return "direct";
      case "Indirect":
        return "indirect";
      case "Login Validation":
        return "login_validation";
      case "Disburse Validation":
        return "disbursed_validation";
      case "Incentive Validation":
        return "inc_validation";
      case "Hold Validation":
        return "hold_validation";
      case "Pending Validation":
        return "pending_validation";
      case "Verification Validation":
        return "verification_validation";
      case "Sanctioned Validation":
        return "sanctioned_validation";
      default:
        return "";
    }
  }

  leadPageNameDecode(String value){
    switch (value) {
      case "Unassigned":
        return "unassignedLeads";
      case "Assigned":
        return "assignedLeads";
      case "Rejected":
        return "rejectedLeads";
      case "Draft":
        return "draftLeads";
      case "New":
        return "newLeads";
      case "Hold":
        return "holdLeads";
      case "Login":
        return "loginLeads";
      case "Sanctioned":
        return "sanctionedLeads";
      case "Disbursed":
        return "disbursedLeads";
      case "Inc Due":
        return "incDueLeads";
      case "Inc Approval":
        return "incApprovalLeads";
      case "Inc Paid":
        return "incPaidLeads";
      case "Pending Verification":
        return "pendingVerificationLeads";
      case "Rejected Validation":
        return "rejectedValidationLeads";
      case "Validated":
        return "validatedLeads";
      case "Direct":
        return "directLeads";
      case "Indirect":
        return "indirectLeads";
      case "Login Validation":
        return "loginValidationLeads";
      case "Disburse Validation":
        return "disburseValidationLeads";
      case "Incentive Validation":
        return "incentiveValidationLeads";
    // case "Validated":
    //   return "validated";
    // case "Validated":
    //   return "validated";

      default:
        return "";
    }
  }

  leadStageStatusDecode(String value){
    switch (value) {
      case "All Stage":
        return "";
      case "Draft":
        return "draft";
      case "Submitted":
        return "submitted";
      case "Released":
        return "released";
      case "Hold":
        return "hold";
      case "Verified":
        return "verified";
      case "Login":
        return "login";
      case "Sanction":
        return "sanctioned";
      case "Disbursed":
        return "disbursed";
      case "Inc Due":
        return "Inc Due";
      case "Inc Paid":
        return "Inc Paid";
      case "Rejected":
        return "rejected";
      default:
        return "";
    }
  }

  String formatAmount(amount){
    double number = double.parse(amount);
    NumberFormat formatter = NumberFormat("#,##0.00", "en_US");
    String formattedValue = formatter.format(number);
    return formattedValue.trim();
  }

  Future<bool> getProfileCompleteApi() async {
    profileComplete.value.data.cmpStatus.clear();
    var response = await BaseClient().get("${AppConstants.PROFILE_COMPLETE}?cust_id=${GetStorage().read(AppConstant.cust_id).toString().trim()}&type=2")
        .catchError(BaseController().handleError);
    print(response);
    if (jsonDecode(response)["status"] == "1") {
      profileComplete.value = profileCompleteModelFromJson(response);
      profileComplete.refresh();
      update();
      return true;
    }
    // profileComplete.value = profileCompleteModelFromJson(response);
    return false;
  }

  RxInt minutes = 1.obs;
  RxInt seconds = 0.obs;
  Timer? timer;
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0.0) {
        seconds.value--;
      } else {
        if (minutes.value > 0.0) {
          minutes.value--;
          seconds.value = 30;
        } else {
          timer.cancel();
        }
      }
    });
  }

  void resetTimer() {
    timer?.cancel();
    minutes.value = 1;
    seconds.value = 0;
    startTimer();
    Future.delayed(const Duration(milliseconds: 500));
  }

  /// selfie image choose
  Future chooseImage(bool isCamera) async {
    final ImagePicker picker = ImagePicker();
    try {
      await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 80,
      ).then((value) {
        if(value != null){
          _cropImage(File(value.path));
        }
        return null;
      });
    } on Exception catch (e) {
      print("image response $e");
    }
  }

  /// crop selfie image code
  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image Crop",
            toolbarColor: AllColors.themeColor,
            toolbarWidgetColor: AllColors.white,
            statusBarColor:  AllColors.themeColor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
          IOSUiSettings(
            title: "Image",
          ),
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      profileImg.value = croppedFile.path;
      // Navigator.pop(Get.context!);
    }
  }

  /// upload  document all images
  RxString panCardImage = "".obs;
  RxString aadhaarCardImage = "".obs;
  RxString rentAgreement = "".obs;
  RxString bankStatementImage = "".obs;
  RxString ownerShipProof = "".obs;
  RxString relationshipProof = "".obs;
  RxString panCardImageName = "".obs;
  RxString aadhaarCardImageName = "".obs;
  RxString rentAgreementName = "".obs;
  RxString bankStatementImageName = "".obs;
  RxString ownerShipProofName = "".obs;
  RxString relationshipProofName = "".obs;

  /// document image choose
  Future partnerDocumentImages(bool isCamera, type) async {
    final ImagePicker picker = ImagePicker();
    var pickedFile;
    try {
          pickedFile = await picker.pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 80,
        );
      // }

      if (pickedFile != null) {
        print("type value ${pickedFile.name.toString()}");
        print("type value $type");
        switch (type) {
          case 1:
            panCardImage.value = pickedFile.path;
            panCardImageName.value = pickedFile.name.toString();
            print("Pan Card ${File(panCardImage.value)}");
            break;
          case 2:
            aadhaarCardImage.value = pickedFile.path;
            aadhaarCardImageName.value = pickedFile.name.toString();
            print("Aadhaar Card ${File(aadhaarCardImage.value)}");
            break;
          case 3:
            rentAgreement.value = pickedFile.path;
            rentAgreementName.value = pickedFile.name.toString();
            print("Salary Slips ${File(rentAgreement.value)}");
            break;
          case 4:
            bankStatementImage.value = pickedFile.path;
            bankStatementImageName.value = pickedFile.name.toString();
            print("Bank Statement ${File(bankStatementImage.value)}");
            break;
          case 5:
            ownerShipProof.value = pickedFile.path;
            ownerShipProofName.value = pickedFile.name.toString();
            print("Ownership ${File(ownerShipProof.value)}");
            break;
          case 6:
            relationshipProof.value = pickedFile.path;
            relationshipProofName.value = pickedFile.name.toString();
            print("Relationship ${File(relationshipProof.value)}");
            break;
        }
      } else {
        print('No image selected.');
      }
    } on Exception catch (e) {
      print("image response $e");
    }
  }

  /// uploadDocumentNetworkApi integrate
  Future<bool> partnerUploadDocumentNetworkApi(owner_type, proof_type) async {
    var bodyRequest = {
      "property_owner_type": owner_type.toString(),
      "address_proof_type": proof_type.toString(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().partnerDocumentUploadPost("${AppConstants.PARTNER_DOCUMENT_UPLOAD}?cust_id=${storage.read(AppConstant.partner_cust_id).toString().trim()}",
      bodyRequest, panCardImage.value, aadhaarCardImage.value, rentAgreement.value, bankStatementImage.value, ownerShipProof.value, relationshipProof.value,)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      panCardImage.value="";
      aadhaarCardImage.value="";
      rentAgreement.value="";
      bankStatementImage.value="";
      ownerShipProof.value="";
      relationshipProof.value="";
      panCardImageName.value="";
      aadhaarCardImageName.value="";
      rentAgreementName.value="";
      bankStatementImageName.value="";
      ownerShipProofName.value="";
      relationshipProofName.value="";
      gender.value ="Select Gender";
      companyType.value = "IT Company";
      maritalStatus.value = "Select Marital Status";
      highestQualification.value = "Select Qualification";
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// partnerLoginNetworkApi api integrate
  Future<bool> partnerLoginNetworkApi() async {
    var bodyRequest = {
      "lead_source": GetStorage().read(AppConstant.cust_id).toString().trim(),
      "cust_name": apName.text.toString(),
      "cust_dob": apDob.text.toString(),
      "cust_gender": gender.value,
      "cust_marital_status": maritalStatus.value,
      "cust_education": highestQualification.value,
      "cust_email": apEmail.text.toString(),
      "cust_pan": "",
      "cust_phone": apNumber.text.toString(),
      "password": apPassword.text.toString(),
    };
    print("request =============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.REGISTER_URL_NEW, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==============>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      otpVerify.value = "${jsonDecode(response)["data"]["otp_phone"]??""}";
      storage.write(AppConstant.partner_id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.partner_cust_id, "${jsonDecode(response)["data"]["cust_id"]??""}");
      BaseController().successSnack("${jsonDecode(response)["message"]}  ${jsonDecode(response)["data"]["otp_phone"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"].toString());
    return false;
  }

  /// partnerOtpVerificationApi api integrate
  Future<bool> partnerOtpVerificationApi(otp) async {
    var bodyRequest = {
      "tbl_custID": storage.read(AppConstant.partner_id).toString().trim(),
      "otp_phone": otp,
    };
    print("request =============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.VERIFY_URL, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.partner_id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.partner_cust_id, "${jsonDecode(response)["data"]["cust_id"]??""}");
      apName.clear();
      apDob.clear();
      gender.value ="Select Gender";
      companyType.value = "IT Company";
      maritalStatus.value = "Select Marital Status";
      highestQualification.value = "Select Qualification";
      apEmail.clear();
      apPassword.clear();
      apPanCard.clear();
      apNumber.clear();
      BaseController().successSnack("${jsonDecode(response)["message"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// partnerUploadSelfieNetworkApi integrate
  Future<bool> partnerUploadSelfieNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().selfieUpload("${AppConstants.UPLOAD_SELFIE}?customer_id=${storage.read(AppConstant.partner_cust_id).toString().trim()}", profileImg.value)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.partner_id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.partner_cust_id, "${jsonDecode(response)["data"]["cust_id"]??""}");
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      profileImg.value = "";
      apName.clear();
      apDob.clear();
      apEmail.clear();
      apPanCard.clear();
      apNumber.clear();
      apPassword.clear();
      gender.value ="Select Gender";
      companyType.value = "IT Company";
      maritalStatus.value = "Select Marital Status";
      highestQualification.value = "Select Qualification";
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// partnerRequestNetworkApi api integrate
  var partner_request_model = PartnerRequestModel(data: []).obs;
  RxBool partner_request_loader = false.obs;
  ScrollController partnerApprovedController = ScrollController();
  int partnerApprovedNext = 10;
  Future<bool> partnerRequestNetworkApi() async {
    partner_request_model.value.data.clear();
    // Get.context!.loaderOverlay.show();
    partner_request_loader.value=false;
    var response = await BaseClient().get("${AppConstants.PARTNER_REQUEST}?limit=$partnerApprovedNext&page=0&emp_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
    partner_request_loader.value=true;
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"];
      if(data.isNotEmpty){
        if(partnerLoadMore.value==false){
          // BaseController().successSnack(context, jsonDecode(response)["message"]);
          partner_request_model.value = partnerRequestModelFromJson(response);
          partner_request_model.refresh();
          update();
        }
        else{
          // BaseController().successSnack(context, jsonDecode(response)["message"]);
          partner_request_model.value = partnerRequestModelFromJson(response);
          partner_request_model.refresh();
          update();
        }
        partnerLoading.value=true;
        partnerLoadMore.value=false;
      }else{
        partnerLoading.value=false;
        partnerLoadMore.value=false;
      }
      return true;
    }
    partner_request_model.value = partnerRequestModelFromJson(response);
    partner_request_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  partnerApprovedPagination() async {
    partnerApprovedController.addListener(() {
      if (partnerApprovedController.position.maxScrollExtent == partnerApprovedController.position.pixels) {
        partnerApprovedNext+=10;
        if(partnerLoading.value){
          partnerLoadMore.value=true;
          partnerRequestNetworkApi();
        }
      }
    });
  }

  /// partnerApprovalNetworkApi api integrate
  var partner_approval_model = PartnerApprovalModel(data: []).obs;
  RxBool partner_approval_loader = false.obs;
  ScrollController partnerRequestController = ScrollController();
  int partnerRequestNext = 10;
  Future<bool> partnerApprovalNetworkApi() async {
    partner_approval_model.value.data.clear();
    // Get.context!.loaderOverlay.show();
    partner_approval_loader.value=false;
    var response = await BaseClient().get("${AppConstants.PARTNER_DIRECT_REQUEST}?limit=$partnerRequestNext&page=0&emp_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
    partner_approval_loader.value=true;
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"];
      if(data.isNotEmpty){
        if(partnerLoadMore.value==false){
          partner_approval_model.value = partnerApprovalModelFromJson(response);
          partner_approval_model.refresh();
          update();
        }
        else{
          partner_approval_model.value = partnerApprovalModelFromJson(response);
          partner_approval_model.refresh();
          update();
        }
        partnerLoading.value=true;
        partnerLoadMore.value=false;
      }else{
        partnerLoading.value=false;
        partnerLoadMore.value=false;
      }
      return true;
    }
    partner_approval_model.value = partnerApprovalModelFromJson(response);
    partner_approval_model.refresh();
    update();
    return false;
  }

  partnerRequestPagination() async {
    partnerRequestController.addListener(() {
      if (partnerRequestController.position.maxScrollExtent == partnerRequestController.position.pixels) {
        partnerRequestNext+=10;
        if(partnerLoading.value){
          partnerLoadMore.value=true;
          partnerApprovalNetworkApi();
        }
      }
    });
  }

  /// partnerPushbackNetworkApi api integrate
  var partner_pushback_model = PartnerPushbackModel(data: []).obs;
  RxBool partner_pushback_loader = false.obs;
  ScrollController partnerPushbackController = ScrollController();
  int partnerPushbackNext = 10;
  Future<bool> partnerPushbackNetworkApi() async {
    partner_pushback_model.value.data.clear();
    // Get.context!.loaderOverlay.show();
    partner_pushback_loader.value=false;
    var response = await BaseClient().get("${AppConstants.PARTNER_PUSHBACK}?limit=$partnerPushbackNext&page=0&emp_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
    partner_pushback_loader.value=true;
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"];
      if(data.isNotEmpty){
        if(partnerLoadMore.value==false){
          // BaseController().successSnack(context, jsonDecode(response)["message"]);
          partner_pushback_model.value = partnerPushbackModelFromJson(response);
          partner_pushback_model.refresh();
          update();
        }
        else{
          // BaseController().successSnack(context, jsonDecode(response)["message"]);
          partner_pushback_model.value = partnerPushbackModelFromJson(response);
          partner_pushback_model.refresh();
          update();
        }
        partnerLoading.value=true;
        partnerLoadMore.value=false;
      }else{
        partnerLoading.value=false;
        partnerLoadMore.value=false;
      }
      return true;
    }
    partner_pushback_model.value = partnerPushbackModelFromJson(response);
    partner_pushback_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  partnerPushbackPagination() async {
    partnerPushbackController.addListener(() {
      if (partnerPushbackController.position.maxScrollExtent == partnerPushbackController.position.pixels) {
        partnerPushbackNext+=10;
        if(partnerLoading.value){
          partnerLoadMore.value=true;
          partnerPushbackNetworkApi();
        }
      }
    });
  }

  /// allPartnerNetworkApi api integrate
  var all_partner_model = AllPartnerModel(data: []).obs;
  RxBool all_partner_loader = false.obs;
  ScrollController allPartnerController = ScrollController();
  int allPartnerNext = 10;
  Future<bool> allPartnerNetworkApi() async {
    all_partner_model.value.data.clear();
    // Get.context!.loaderOverlay.show();
    all_partner_loader.value=false;
    var response = await BaseClient().get("${AppConstants.ALL_PARTNER}?limit=$allPartnerNext&page=0").catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
    all_partner_loader.value=true;
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"];
      if(data.isNotEmpty){
        if(partnerLoadMore.value==false){
          // BaseController().successSnack(context, jsonDecode(response)["message"]);
          all_partner_model.value = allPartnerModelFromJson(response);
          all_partner_model.refresh();
          update();
        }
        else{
          // BaseController().successSnack(context, jsonDecode(response)["message"]);
          all_partner_model.value = allPartnerModelFromJson(response);
          all_partner_model.refresh();
          update();
        }
        partnerLoading.value=true;
        partnerLoadMore.value=false;
      }else{
        partnerLoading.value=false;
        partnerLoadMore.value=false;
      }
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    all_partner_model.value = allPartnerModelFromJson(response);
    all_partner_model.refresh();
    update();
    return false;
  }

  allPartnerPagination() async {
    allPartnerController.addListener(() {
      if (allPartnerController.position.maxScrollExtent == allPartnerController.position.pixels) {
        allPartnerNext+=10;
        if(partnerLoading.value){
          partnerLoadMore.value=true;
          allPartnerNetworkApi();
        }
      }
    });
  }

  /// partnerUpdatePayrollNetworkApi api integrate
  Future<bool> partnerUpdatePayrollNetworkApi(pId, band, supId) async {
    var bodyRequest = {
      "partner_id": pId.toString(),
      "partner_band": band.toString(),
      "sup_id": supId.toString(),
    };
    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.PARTNER_UPDATE_PAYROLL, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// partnerUpdateAboutNetworkApi api integrate
  Future<bool> partnerUpdateAboutNetworkApi(pId, status, remarks) async {
    var bodyRequest = {
      "partner_id": pId.toString(),
      "partner_approved_by": storage.read(AppConstant.cust_id).toString().trim(),
      "partner_status": status.toString(),
      "remark": remarks.toString(),
      // "updated_by": ,
    };
    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_PARTNER_REQUEST, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// partnerUpdateAccessNetworkApi api integrate
  Future<bool> partnerUpdateAccessNetworkApi(
      pId,
      changeCount,
      empViewAll,
      addEmp,
      updateEmp,
      empPushBack,
      empApprove,
      empPendingApproval,
      partnerViewAll,
      partnerAdd,
      partnerUpdate,
      partnerPushBack,
      partnerPendingApproval,
      unassignedLeads,
      assignAllLead,
      assignMyLead,
      assignMyTeamLead,
      assignMyPartnerLead,
      addLead,
      myLead,
      myTeamLead,
      myPartnerLead,
      allCust,
      my_cust,
      myTeamCust,
      myPartnerCust,
      mySales,
      incentiveMgmtView,
      incentiveMgmtEdit,
      panelManagerEmployee,
      panelManagerPartner,
      panelManagerCustomer) async {
    var bodyRequest = {
      "partner_id": pId.toString(),
      "partner_approved_by": storage.read(AppConstant.cust_id).toString().trim(),
      "access_change_count": changeCount.toString(),
      "emp_view_all" : empViewAll,
      "add_emp" : addEmp,
      "update_emp" : updateEmp,
      "emp_push_back" : empPushBack,
      "emp_approve" : empApprove,
      "emp_pending_approval" : empPendingApproval,
      "partner_view_all" : partnerViewAll,
      "partner_add" : partnerAdd,
      "partner_update" : partnerUpdate,
      "partner_push_back" : partnerPushBack,
      "partner_pending_approval" : partnerPendingApproval,
      "unassigned_leads" : unassignedLeads,
      "assign_all_lead" : assignAllLead,
      "assign_my_lead" : assignMyLead,
      "assign_myteam_lead" : assignMyTeamLead,
      "assign_mypartner_lead" : assignMyPartnerLead,
      "add_lead" : addLead,
      "my_lead" : myLead,
      "myteam_lead" : myTeamLead,
      "mypartner_lead" : myPartnerLead,
      "all_cust" : allCust,
      "my_cust" : my_cust,
      "myteam_cust" : myTeamCust,
      "mypartner_cust" : myPartnerCust,
      "my_sales" : mySales,
      "incentive_mgmt_view" : incentiveMgmtView,
      "incentive_mgmt_edit" : incentiveMgmtEdit,
      "panel_manage_employee" : panelManagerEmployee,
      "panel_manage_partner" : panelManagerPartner,
      "panel_manage_customer" : panelManagerCustomer,

    };
    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.PARTNER_ACCESS_UPDATE, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// state api integration
  var stateModel = StateModel(data: []).obs;
  Future<bool> getStateNetworkApi(String countryId) async {
    print("country $countryId");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().get("${AppConstants.STATE_API}?countryid=$countryId").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // BaseController().successSnack(context, jsonDecode(response)["message"]);
      stateModel.value=stateModelFromJson(response);
      // if(userdetails.value.data.details.custCountry!="null") {
      //   selectState = stateModel.value.data[stateModel.value.data.indexWhere((element2) =>
      // element2.stateName == userdetails.value.data.details.custState.toString()) != -1 ? stateModel.value.data.indexWhere((element2) =>
      // element2.stateName == userdetails.value.data.details.custState.toString()) : 0];
      // }
      stateModel.refresh();
      update();
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// country api integration
  var countryModel = CountryModel(data: []).obs;
  Future<bool> getCountryNetworkApi(BuildContext context) async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().get("${AppConstants.COUNTRY_API}?limit=100&page=0").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // BaseController().successSnack(context, jsonDecode(response)["message"]);
      countryModel.value=countryModelFromJson(response);
      if(userdetails.value.data.details.custCountry!="null") {
        selectCountry = countryModel.value.data[countryModel.value.data.indexWhere((element2) =>
      element2.countryName == userdetails.value.data.details.custCountry.toString()) != -1 ? countryModel.value.data.indexWhere((element2) =>
      element2.countryName == userdetails.value.data.details.custCountry.toString()) : 0];
      }

      countryModel.refresh();
      update();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// getUserDetailsApi api integration
  var userdetails=UserDetailsModel(data: UserDetailsData(allLeade: [], details: UserDetails(), partnerdetails: PartnerDetails(), access: PartnerAccess(), remarks: [],)).obs;
  Future<bool> getUserDetailsApi(userId)async{
    userdetails.value.data.isNull;
    // Get.context!.loaderOverlay.show();
    var response=await BaseClient().get("${AppConstants.CUSTOMER_DETAILS}?cust_id=${userId.toString()}").catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
    print("responseUserDetailsApi ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      // BaseController().successSnack(jsonDecode(response)["message"]);
      userdetails.value=userDetailsModelFromJson(response);
      userdetails.refresh();
      update();
      return true;
    }
    userdetails.value=userDetailsModelFromJson(response);
    userdetails.refresh();
    update();
    return  false;
  }

  /// updateProfileNetwork api integration
  Future<bool> updateProfileNetwork(qualification, marital, gender) async {
    print("object $qualification $marital $gender");
    var bodyRequest = {
      "cust_id": storage.read(AppConstant.cust_id).toString().trim(),
      "cust_aadhar": pAadhaar.text,
      "cust_pan": pPanCard.text,
      "cust_phone": pNumber.text,
      "line_address": pAddress.text,
      "cust_pincode": pPinCode.text,
      "cust_state": pState.text,
      "cust_country": pCountry.text,
      "cust_social": json.encode([{"fab": pFacebook.text,"linkdin": pLinkedin.text}]),
      "cust_email": pEmail.text,
      "cust_education": qualification.toString(),
      "cust_marital_status": marital.toString(),
      "cust_gender": gender.toString(),
      "cust_dob": pDob.text,
      "cust_name": pFName.text,
    };
    print("bodyRequest ================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_PROFILE, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  RxString verifyOtp = "".obs;
  /// otp api integrate
  Future<bool> profileOtpVerificationApi(otp) async {
    var bodyRequest = {
      "tbl_custID": storage.read(AppConstant.id).toString().trim(),
      "otp_phone": otp,
    };
    print("request =============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.VERIFY_URL, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.name, "${jsonDecode(response)["data"]["cust_name"]??""}");
      storage.write(AppConstant.email, "${jsonDecode(response)["data"]["cust_email"]??""}");
      storage.write(AppConstant.phone, "${jsonDecode(response)["data"]["cust_phone"]??""}");
      BaseController().successSnack("${jsonDecode(response)["message"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// resendOTPApi api integrate
  Future<bool> profileResendOTPNetworkApi(BuildContext context) async {
    var bodyRequest = {
      "cust_id": storage.read(AppConstant.cust_id).toString().trim(),
    };
    print("request ============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.RESEND_OTP, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"].toString()} - ${jsonDecode(response)["data"]["otp_phone"].toString()}");
      verifyOtp.value = "${jsonDecode(response)["data"]["otp_phone"]??""}";
      // storage.write(AppConstant.id, "${jsonDecode(response)["data"]["id"]??""}");
      // storage.write(AppConstant.cust_id, "${jsonDecode(response)["data"]["cust_id"]??""}");
      storage.write(AppConstant.phone, "${jsonDecode(response)["data"]["cust_phone"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  saveProfileDate(){
    String data=userdetails.value.data.details.custSocial.toString();
    try {
      List<dynamic> custSocialList = json.decode(data);
      for (dynamic item in custSocialList) {
        print(item);
        String fabValue = item['fab'];
        String linkedinValue = item['linkdin'];
        pFacebook.text =fabValue;
        pLinkedin.text =linkedinValue;
      }
    } catch (e) {
      print('Error decoding JSON: $e');
    }
    pPinCode.text = userdetails.value.data.details.custPincode??"";
    pDob.text = userdetails.value.data.details.custDob??"";
    pEmail.text = userdetails.value.data.details.custEmail??"";
    pFName.text = userdetails.value.data.details.custName??"";
    pPinCode.text = userdetails.value.data.details.custPincode??"";
    pAddress.text = userdetails.value.data.details.custAddress??"";
    pAadhaar.text = userdetails.value.data.details.custAadhar??"";
    pPanCard.text = userdetails.value.data.details.custPan??"";
    pNumber.text = userdetails.value.data.details.custPhone??"";
    pState.text = userdetails.value.data.details.custState??"";
    pCountry.text = userdetails.value.data.details.custCountry??"";

  }

  /// userKYCUpdateNetworkApi api integrate
  Future<bool> userKYCUpdateNetworkApi() async {
    var bodyRequest = {
      "cust_id": storage.read(AppConstant.cust_id).toString().trim(),
      "cust_aadhar": pAadhaar.text.toString(),
      "cust_pan": pPanCard.text.toString(),
    };
    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_KYC, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// uploadSelfieNetworkApi integrate
  Future<bool> uploadSelfieNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().selfieUpload("${AppConstants.UPLOAD_SELFIE}?customer_id=${storage.read(AppConstant.cust_id).toString().trim()}", profileImg.value)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }


  /// upload  document all images
  RxString pPanCardImage = "".obs;
  RxString pAadhaarCardImage = "".obs;
  RxString pRentAgreement = "".obs;
  RxString pBankStatementImage = "".obs;
  RxString pOwnerShipProof = "".obs;
  RxString pRelationshipProof = "".obs;
  RxString pPanCardImageName = "".obs;
  RxString pAadhaarCardImageName = "".obs;
  RxString pRentAgreementName = "".obs;
  RxString pBankStatementImageName = "".obs;
  RxString pOwnerShipProofName = "".obs;
  RxString pRelationshipProofName = "".obs;

  /// document image choose
  Future profileDocumentImages(bool isCamera, type) async {
    final ImagePicker picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        print("type value ${pickedFile.name.toString()}");
        print("type value $type");
        switch (type) {
          case 1:
            pPanCardImage.value = pickedFile.path;
            pPanCardImageName.value = pickedFile.name.toString();
            print("Pan Card ${File(pPanCardImage.value)}");
            break;
          case 2:
            pAadhaarCardImage.value = pickedFile.path;
            pAadhaarCardImageName.value = pickedFile.name.toString();
            print("Aadhaar Card ${File(pAadhaarCardImage.value)}");
            break;
          case 3:
            pRentAgreement.value = pickedFile.path;
            pRentAgreementName.value = pickedFile.name.toString();
            print("Salary Slips ${File(pRentAgreement.value)}");
            break;
          case 4:
            pBankStatementImage.value = pickedFile.path;
            pBankStatementImageName.value = pickedFile.name.toString();
            print("Bank Statement ${File(pBankStatementImage.value)}");
            break;
          case 5:
            pOwnerShipProof.value = pickedFile.path;
            pOwnerShipProofName.value = pickedFile.name.toString();
            print("Ownership ${File(pOwnerShipProof.value)}");
            break;
          case 6:
            pRelationshipProof.value = pickedFile.path;
            pRelationshipProofName.value = pickedFile.name.toString();
            print("Relationship ${File(pRelationshipProof.value)}");
            break;
        }
      } else {
        print('No image selected.');
      }
    } on Exception catch (e) {
      print("image response $e");
    }
  }

  /// uploadDocumentNetworkApi integrate
  Future<bool> profileUploadDocumentNetworkApi(owner_type, proof_type) async {
    var bodyRequest = {
      "property_owner_type": owner_type.toString(),
      "address_proof_type": proof_type.toString(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().employeeDocumentUploadPost("${AppConstants.PARTNER_DOCUMENT_UPLOAD}?cust_id=${storage.read(AppConstant.cust_id).toString().trim()}",
      bodyRequest, pPanCardImage.value, pAadhaarCardImage.value, pRentAgreement.value, pBankStatementImage.value, pOwnerShipProof.value, pRelationshipProof.value,)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      pPanCardImage.value="";
      pAadhaarCardImage.value="";
      pRentAgreement.value="";
      pBankStatementImage.value="";
      pOwnerShipProof.value="";
      pRelationshipProof.value="";
      pPanCardImageName.value="";
      pAadhaarCardImageName.value="";
      pRentAgreementName.value="";
      pBankStatementImageName.value="";
      pOwnerShipProofName.value="";
      pRelationshipProofName.value="";
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// getCustomerDetailsNetworkApi api integration
  var customerDetails = UserDetailsModel(data: UserDetailsData(allLeade: [], details: UserDetails(), partnerdetails: PartnerDetails(), access: PartnerAccess(), remarks: [],)).obs;
  Future<bool> getCustomerDetailsNetworkApi(customerId)async{
    // customerDetails.value.data.allLeade.clear();
    customerDetails.value.data.isNull;
    print("CustomerDetailsNetworkApi json================>>>>>>>>>>>>>");
    print("${AppConstants.CUSTOMER_DETAILS}?cust_id=${customerId.toString()}");
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().get("${AppConstants.CUSTOMER_DETAILS}?cust_id=${customerId.toString()}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("responseCustomerDetailsNetworkApi ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      // storage.write(AppConstant.partnerStatus, jsonDecode(response)["data"]["partnerdetails"]["partner_status"]);
      // BaseController().successSnack(jsonDecode(response)["message"]);
      customerDetails.value=userDetailsModelFromJson(response);
      customerDetails.refresh();
      update();
      return true;
    }
    customerDetails.value=userDetailsModelFromJson(response);
    customerDetails.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return  false;
  }

  /// partnerResendOTPNetworkApi api integrate
  Future<bool> partnerResendOTPNetworkApi(BuildContext context) async {
    var bodyRequest = {
      "cust_id": storage.read(AppConstant.partner_cust_id).toString().trim(),
    };
    print("request ============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.RESEND_OTP, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"].toString()} - ${jsonDecode(response)["data"]["otp_phone"].toString()}");
      verifyOtp.value = "${jsonDecode(response)["data"]["otp_phone"]??""}";
      storage.write(AppConstant.partner_id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.partner_cust_id, "${jsonDecode(response)["data"]["cust_id"]??""}");
      storage.write(AppConstant.phone, "${jsonDecode(response)["data"]["cust_phone"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// get lead details api integration
  var getLeadDetails=LeadDetailsModel(data: LeadDetailsData(history: [], custActiveLoan: [], incHistory: [], incAttachment: [], rejectedHistory: DHistory(remarks: []), verifiedHistory: VerifiedHistory(remarks: []), holdHistory: DHistory(remarks: []),
      loginHistory: StatusHistory(), disbursedHistory: StatusHistory(), sanctionedHistory: StatusHistory(), incDueHistory: StatusHistory(), incApproveHistory: StatusHistory(), incPaidHistory: StatusHistory())).obs;
  Future<bool> getLeadDetailsNetworkApi(leadId)async{
    getLeadDetails.value.data.isNull;
    getLeadDetails.value.data.custActiveLoan.clear();
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().get("${AppConstants.GET_LEAD_DETAILS}?id=$leadId")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      getLeadDetails.value=leadDetailsModelFromJson(response);
      getLeadDetails.refresh();
      update();
      return true;
    }
    getLeadDetails.value=leadDetailsModelFromJson(response);
    getLeadDetails.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return  false;
  }

  /// customer details status images
  List<String> statusList = ["select status", "Hold", "Verified", "Login", "Rejected","Sanctioned","Disbursed"];
  List<String> statusLoginBankList = ["select bank", "Axis Bank Ltd", "Bank Of Baroda", "Bank of India", "IndusInd Bank Ltd.",
  "Punjab National Bank","Kotak Mahindra Bank Ltd.","State Bank of India",
  "ICICI Bank Ltd","Yes Bank Ltd","HDFC Bank Ltd"];
  RxString loginFilterImage = "".obs;
  RxString sanctionedFilterImage = "".obs;
  RxString disbursedFilterImage = "".obs;
  clearStatusData(){
    isCheckedList.clear();
    isCheckedList.assignAll(List<bool>.filled(controller.rejectItemList.length, false));
    rejectedStatusList.clear();
    holdStatusList.clear();
    cust_interested_loan.value = "No";
    cust_wants_loan.value = "No";
    cust_applied_last_month.value = "No";
    cust_processing_loan.value = "No";
    cust_bankbay_application.value = "No";
    loginBankName.value = "select bank";
    employeeId.clear();
    teleCheckID.clear();
    fosCheckID.clear();
    approvalReason.clear();
    sanctionAmount.clear();
    sanctionRoi.clear();
    sanctionTenure.clear();
    sanctionDate.clear();
    disbursedAmount.clear();
    disbursedTenure.clear();
    disbursedRoi.clear();
    disbursedBankName.clear();
    disbursedBankAccountName.clear();
    disbursedBankAccountNumber.clear();
    disbursedBankIFSCCode.clear();
    disbursedMethod.clear();
    disbursedDate.clear();
    loginDate.clear();
    loginAppId.clear();
    loginAmount.clear();
    loginTenure.clear();
    sanctionAmount.clear();
    sanctionRoi.clear();
    sanctionTenure.clear();
    sanctionDate.clear();
    sanctionedFilterImage.value="";
    disbursedAmount.clear();
    disbursedTenure.clear();
    disbursedRoi.clear();
    disbursedBankName.clear();
    disbursedBankAccountName.clear();
    disbursedBankAccountNumber.clear();
    disbursedBankIFSCCode.clear();
    disbursedMethod.clear();
    disbursedDate.clear();
    disbursedFilterImage.value="";
    loginDate.clear();
    loginAppId.clear();
    loginAmount.clear();
    loginTenure.clear();
    loginFilterImage.value="";
  }

  Future customerDetailsStatusImages(bool isCamera, type) async {
    final ImagePicker picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        print("type value $type");
        switch (type) {
          case 1:
            loginFilterImage.value = pickedFile.path;
            print("loginFilterImage ${File(loginFilterImage.value)}");
            break;
          case 2:
            sanctionedFilterImage.value = pickedFile.path;
            print("sanctionedFilterImage ${File(sanctionedFilterImage.value)}");
            break;
          case 3:
            disbursedFilterImage.value = pickedFile.path;
            print("disbursedFilterImage ${File(disbursedFilterImage.value)}");
            break;
        }
      } else {
        print('No image selected.');
      }
    } on Exception catch (e) {
      print("image response $e");
    }
  }

  /// updateLeadStatusNetworkApi api integrate
  Future<bool> updateLeadStatusNetworkApi(leadID, nextDate, nextTime, remark, lead_cust_id, leadStatus) async {
    print("object $leadID");
    var bodyRequest = {
      "lead_id": leadID.toString(),
      "next_date": nextDate.toString(),
      "next_time": nextTime.toString(),
      "lead_status": leadStatus.toString().toLowerCase(),
      "remark": remark.toString(),
      "sync_amount": sanctionAmount.text,
      "sync_roi": sanctionRoi.text,
      "sync_tenure": sanctionTenure.text,
      "sync_date": sanctionDate.text,
      "disb_amount": disbursedAmount.text,
      "disb_tenure": disbursedTenure.text,
      "disb_roi": disbursedRoi.text,
      "disb_bank_name": disbursedBankName.text,
      "disb_bank_account_no": disbursedBankAccountNumber.text,
      "disb_bank_account_name": disbursedBankAccountName.text,
      "disb_bank_ifsc": disbursedBankIFSCCode.text,
      "disb_method": disbursedMethod.text,
      "disb_date": disbursedDate.text,
      "bank_name": loginBankName.value=="select bank"?"":loginBankName.value,
      "login_date": loginDate.text,
      "app_id": loginAppId.text,
      "login_amount": loginAmount.text,
      "login_tenure": loginTenure.text,
      "updated_by": storage.read(AppConstant.cust_id).toString(),
    };
    print("bodyRequest ============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().updateLeadStatusPost("${AppConstants.UPDATE_LEAD_STATUS}?customer_id=${lead_cust_id.toString()}",
        bodyRequest, loginFilterImage.value, sanctionedFilterImage.value, disbursedFilterImage.value).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack(jsonDecode(response)["message"]);
      clearStatusData();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// updateLeadStatusNetworkApi2 api integrate
  Future<bool> updateLeadStatusNetworkApi2(leadID, nextDate, nextTime, remark, lead_cust_id, leadStatus) async {
    var verifyDataList = [
      {
        "is_customer_interested_in_availing_loan": cust_interested_loan.value,
      },
      {
        "how_soon_the_customer_wants_loan": cust_wants_loan.value,
      },
      {
        "has_customer_applied_for_loan_in_last12_months": cust_applied_last_month.value,
      },
      {
        "is_somebody_else_is_processing_loan_as_well": cust_processing_loan.value,
      },
      {
        "is_customer_user_of_bankbay_application": cust_bankbay_application.value,
      },
    ];
    print("object $leadID");
    var bodyRequest = {
      "lead_id": leadID.toString(),
      "next_date": nextDate.toString(),
      "next_time": nextTime.toString(),
      "lead_status": leadStatus.toString().toLowerCase(),
      "remark": remark.toString(),
      if(leadStatus=="Hold")
      "reason": jsonEncode(holdStatusList),
      if(leadStatus=="Verified")
        "reason": jsonEncode(verifyDataList),
      if(leadStatus=="Rejected")
        "reason": jsonEncode(rejectedStatusList),
      if(leadStatus=="")
        "reason": jsonEncode([]),
      "updated_by": storage.read(AppConstant.cust_id).toString(),
    };
    print("bodyRequest ============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().updateLeadStatusPost("${AppConstants.UPDATE_LEAD_STATUS}?customer_id=${lead_cust_id.toString()}",
        bodyRequest, loginFilterImage.value, sanctionedFilterImage.value, disbursedFilterImage.value).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack(jsonDecode(response)["message"]);
      clearStatusData();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// myLeadHistoryNetworkApi api integrate
  var my_loan_history_model = MyLoanHistoryModel(data: MyLoanHistoryData(leads: [])).obs;
  RxBool my_loan_history_model_loader = false.obs;
  ScrollController myLoanController = ScrollController();
  int myLoanNext = 10;
  Future<bool> myLeadHistoryNetworkApi(bool refresh, date,monthYear,lead_type) async {
    Get.context!.loaderOverlay.show();
    if(refresh==true) my_loan_history_model_loader.value=false;
    var response = await BaseClient().get("${AppConstants.MY_LOAN_HISTORY}?page=0&limit=$myLoanNext&lead_type=$lead_type&date=$date&monthyear=$monthYear&customer_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    if(refresh==true) my_loan_history_model_loader.value=true;
    Get.context!.loaderOverlay.hide();
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["Leads"];
      if(data.isNotEmpty){
        if(partnerLoadMore.value==false){
          my_loan_history_model.value = myLoanHistoryModelFromJson(response);
          my_loan_history_model.refresh();
          update();
        }
        else{
          my_loan_history_model.value = myLoanHistoryModelFromJson(response);
          my_loan_history_model.refresh();
          update();
        }
        partnerLoading.value=true;
        partnerLoadMore.value=false;
      }else{
        partnerLoading.value=false;
        partnerLoadMore.value=false;
      }
      return true;
    }
    my_loan_history_model.value = myLoanHistoryModelFromJson(response);
    my_loan_history_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  myLoanHistoryPagination() async {
    myLoanController.addListener(() {
      if (myLoanController.position.maxScrollExtent == myLoanController.position.pixels) {
        myLoanNext+=10;
        if(partnerLoading.value){
          partnerLoadMore.value=true;
          myLeadHistoryNetworkApi(false, "","",controller.loanTypeDecode(loginController.selectLoanType.value));
        }
      }
    });
  }

  /// updateLeadDocumentStatusNetworkApi api integrate
  var update_document_status_model = DetailsUpdateDocumentStatusModel(data: []).obs;
  Future<bool> updateLeadDocumentStatusNetworkApi(leadId, docType, docStatus) async {
    var bodyRequest = {
      "lead_id": leadId.toString(),
      "doc_type": docType.toString(),
      "doc_status": docStatus.toString(),
    };
    print("bodyRequest =============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_LEAD_DOCUMENT_STATUS, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack(jsonDecode(response)["message"]);
      update_document_status_model.value = detailsUpdateDocumentStatusModelFromJson(response);
      update_document_status_model.refresh();
      update();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// partnerKYCUpdateNetworkApi api integrate
  Future<bool> partnerKYCUpdateNetworkApi(partnerCustId, pan, aadhaar) async {
    var bodyRequest = {
      "cust_id": partnerCustId,
      "cust_aadhar": aadhaar.toString(),
      "cust_pan": pan.toString(),
    };
    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_KYC, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// partnerUpdateAccessNetworkApi api integrate
  String partnerCompleteIdUpdate = "";
  Future<bool> partnerAddAccessNetworkApi() async {
    var bodyRequest = {
      "partner_id": storage.read(AppConstant.partner_cust_id)??"",
      "access_change_by": storage.read(AppConstant.cust_id).toString(),
      "access_change_count": "0",
      "emp_view_all" : partnerEmpViewAll.value,
      "add_emp" : partnerAddEMP.value,
      "update_emp" : partnerUpdateEMP.value,
      "emp_push_back" : partnerEmpPushBack.value,
      "emp_approve" : partnerEmpApprove.value,
      "emp_pending_approval" : partnerEmpPendingApprove.value,
      "partner_view_all" : partnerEmpViewAll.value,
      "partner_add" : partnerPartnerAdd.value,
      "partner_update" : partnerPartnerUpdate.value,
      "partner_push_back" : partnerPartnerPushBack.value,
      "partner_pending_approval" : partnerEmpPendingApprove.value,
      "unassigned_leads" : unassignedLeads.value,
      "assign_all_lead" : partnerAssignAllLead.value,
      "assign_my_lead" : partnerAssignMyLead.value,
      "assign_myteam_lead" : partnerAssignMyTeamLead.value,
      "assign_mypartner_lead" : partnerAssignMyPartnerLead.value,
      "add_lead" : partnerAddLead.value,
      "my_lead" : partnerMyLead.value,
      "myteam_lead" : partnerMyTeamLead.value,
      "mypartner_lead" : partnerMyPartnerLead.value,
      "all_cust" : partnerAllCust.value,
      "my_cust" : partnerMyCust.value,
      "myteam_cust" : partnerMyTeamCust.value,
      "mypartner_cust" : partnerMyPartnerCust.value,
      "my_sales" : partnerMySales.value,
      "incentive_mgmt_view" : partnerIncentiveMGMTView.value,
      "incentive_mgmt_edit" : partnerIncentiveMGMTEdit.value,
      "panel_manage_employee" : partnerPanelManageEmployee.value,
      "panel_manage_partner" : partnerPanelManagePartner.value,
      "panel_manage_customer" : partnerPanelManageCustomer.value,
      "new_lead_tab" : partnerNewLeadTab.value,
      "verification_lead_tab" : partnerVerificationTab.value,
      "disbursed_lead_tab" : partnerDisbursedTab.value,
      "incentive_lead_tab" : partnerIncentiveTab.value,
    };
    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.PARTNER_ACCESS_UPDATE, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      partnerCompleteIdUpdate = jsonDecode(response)["data"][0]["pid"].toString();
      print("sjs $partnerCompleteIdUpdate");
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// my loan history details loan fields
  RxList<Map> loanHistoryFieldList=<Map>[{
    "loan_type": TextEditingController(),
    "tenure": TextEditingController(),
    "month": TextEditingController(),
    "loan_amt": TextEditingController(),
    "roi": TextEditingController(),
  }].obs;

  /// getEmployeeDetailsNetworkApi api integration
  var employeeDetails=EmployeeDetailsModel(data: EmployeeDetailsData(basicDetails: BasicDetails(), exprience: [], education: [], accessDefault: AccessDefault(), accessSpecial: AccessSpecial(), remark: [], allLeade: [],)).obs;
  Future<bool> getEmployeeDetailsNetworkApi(employeeId)async{
    employeeDetails.value.data.isNull;
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().get("${AppConstants.GET_EMPLOYEE_DETAILS}?empId=$employeeId")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      // BaseController().successSnack(jsonDecode(response)["message"]);
      employeeDetails.value=employeeDetailsModelFromJson(response);
      employeeDetails.refresh();
      update();
      return true;
    }
    employeeDetails.value=employeeDetailsModelFromJson(response);
    employeeDetails.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return  false;
  }

  /// getEmployeeDetailsGetAmountNetworkApi api integration
  var employeeAmountDetails=EmployeeDetailsModel(data: EmployeeDetailsData(basicDetails: BasicDetails(), exprience: [], education: [], accessDefault: AccessDefault(), accessSpecial: AccessSpecial(), remark: [], allLeade: [],)).obs;
  Future<bool> getEmployeeDetailsGetAmountNetworkApi(employeeId)async{
    employeeAmountDetails.value.data.isNull;
    var response=await BaseClient().get("${AppConstants.GET_EMPLOYEE_DETAILS}?empId=$employeeId")
        .catchError(BaseController().handleError);
    print("response ===========================>>>>>>>>>>>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      // BaseController().successSnack(jsonDecode(response)["message"]);
      employeeAmountDetails.value=employeeDetailsModelFromJson(response);
      employeeAmountDetails.refresh();
      update();
      return true;
    }
    employeeAmountDetails.value=employeeDetailsModelFromJson(response);
    employeeAmountDetails.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return  false;
  }

  /// checkAssignmentApprovalExistNetworkApi api integration
  TextEditingController employeeId = TextEditingController();
  TextEditingController approvalReason = TextEditingController();
  var check_assign_approval_exist_model = CheckAssignApprovalExistModel(data: []).obs;
  Future<bool> checkAssignmentApprovalExistNetworkApi(employee_id)async{
    check_assign_approval_exist_model.value.data.clear();
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().get("${AppConstants.CHECK_ASSIGNMENT_APPROVAL_EXIST}?employee_id=$employee_id&emp_login_id=${storage.read(AppConstant.cust_id).toString()}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      check_assign_approval_exist_model.value=checkAssignApprovalExistModelFromJson(response);
      check_assign_approval_exist_model.refresh();
      update();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return  false;
  }

  /// assignmentChangeApprovalNetworkApi api integration
  Future<bool> assignmentChangeApprovalNetworkApi(leadId, status, empId, remark)async{
    var bodyRequest = {
      "lead_id": leadId.toString(),
      "status": status.toString(),
      "emp_id": empId.toString(),
      "remark" : remark.toString(),
      "remark_update_by" : storage.read(AppConstant.cust_id).toString(),
    };
    print("request =================>>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.ASSIGNMENT_CHANGE_APPROVAL, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack("This ID is not an authored approved");
    return  false;
  }

  /// checkCheckOwnerExistNetworkApi api integration
  TextEditingController teleCheckID = TextEditingController();
  TextEditingController fosCheckID = TextEditingController();
   var check_owner_exist_model = CheckOwnerExistModel(data: []).obs;
  Future<bool> checkOwnerExistNetworkApi(String name, String idValue)async{
    check_owner_exist_model.value.data.clear();
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().get("${AppConstants.CHECK_OWNER_EXIST}?${getValue(name, idValue).toString()}&emp_login_id=${storage.read(AppConstant.cust_id).toString()}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      check_owner_exist_model.value = checkOwnerExistModelFromJson(response);
      check_owner_exist_model.refresh();
      update();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return  false;
  }

  /// checkOwnerExistFosNetworkApi api integrate
  var check_owner_exist_fos = CheckOwnerExistModel(data: []).obs;
  Future<bool> checkOwnerExistFosNetworkApi(String name, String idValue)async{
    check_owner_exist_fos.value.data.clear();
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().get("${AppConstants.CHECK_OWNER_EXIST}?${getValue(name, idValue).toString()}&emp_login_id=${storage.read(AppConstant.cust_id).toString()}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      check_owner_exist_fos.value = checkOwnerExistModelFromJson(response);
      check_owner_exist_fos.refresh();
      update();
      return true;
    }
    check_owner_exist_fos.value = checkOwnerExistModelFromJson(response);
    check_owner_exist_fos.refresh();
    update();
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return  false;
  }

  /// checkOwnerExistFosNetworkApi api integrate
  var check_owner_exist_tele = CheckOwnerExistModel(data: []).obs;
  Future<bool> checkOwnerExistTeleNetworkApi(String name, String idValue)async{
    check_owner_exist_tele.value.data.clear();
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().get("${AppConstants.CHECK_OWNER_EXIST}?${getValue(name, idValue).toString()}&emp_login_id=${storage.read(AppConstant.cust_id).toString()}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      check_owner_exist_tele.value = checkOwnerExistModelFromJson(response);
      check_owner_exist_tele.refresh();
      update();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    check_owner_exist_tele.value = checkOwnerExistModelFromJson(response);
    check_owner_exist_tele.refresh();
    update();
    return  false;
  }


  getValue(nameValue, idValue){
    switch(nameValue){
      case "pan":
        return "pan=$idValue";
      case "phone":
        return "mobile=$idValue";
      case "UID":
        return "employee_id=$idValue";
    }
  }

  /// updateLeadAssignFosNetworkApi api integrate
  Future<bool> updateLeadAssignFosNetworkApi(leadId, leadAssignFos, leadAssignBy) async {
    var bodyRequest = {
      "lead_id": leadId.toString(),
      "lead_assign_fos": leadAssignFos.toString(),
      "lead_assign_by": leadAssignBy.toString(),
    };

    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_LEAD_ASSIGN_FOS, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// updateLeadAssignTeleNetworkApi api integrate
  Future<bool> updateLeadAssignTeleNetworkApi(leadId, leadAssignTele, leadAssignBy) async {
    var bodyRequest = {
      "lead_id": leadId.toString(),
      "lead_assign_tele": leadAssignTele.toString(),
      "lead_assign_by": leadAssignBy.toString(),
    };
    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_LEAD_ASSIGN_TELE, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      teleCheckID.clear();
      fosCheckID.clear();
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// updateIncDueNetworkApi api integrate
  Future<bool> updateIncDueNetworkApi(leadId, status, acc_trx_date, remarks, custId) async {
    var bodyRequest = {
      "lead_id": leadId.toString(),
      "status": status.toString(),
      "acc_trx_date": acc_trx_date.toString(),
      "remarks": remarks.toString(),
      "remark_update_by": storage.read(AppConstant.cust_id).toString(),
    };

    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    // var response = await BaseClient().imagePost("${AppConstants.UPDATE_INC_DUE}?customer_id=C100009", bodyRequest, leadDetailsImageList.value, "attachment").catchError(BaseController().handleError);
    var response = await BaseClient().imagePost("${AppConstants.UPDATE_INC_DUE}?customer_id=$custId", bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      // leadDetailsImageList.clear();
      // leadDetailsImageListAddField();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// upload  document all images
  RxString empPassportImage = "".obs;
  RxString empPANImage = "".obs;
  RxString empAadhaarCardImage = "".obs;
  RxString empSalarySlipsImage = "".obs;
  RxString empBankStatementImage = "".obs;
  RxString emp10THMarksheetImage = "".obs;
  RxString empGraduationImage = "".obs;
  RxString empMasterImage = "".obs;
  RxString empCertificateImage = "".obs;
  RxString empAppointmentFormImage = "".obs;
  RxString empAppointmentLatterImage = "".obs;
  RxString empOwnerShipProof = "".obs;
  RxString empRealAgreeProof = "".obs;
  RxString empRelationshipProof = "".obs;
  /// upload document name
  RxString empPassportImageName = "".obs;
  RxString empPANImageName = "".obs;
  RxString empAadhaarCardImageName = "".obs;
  RxString empSalarySlipsImageName = "".obs;
  RxString empBankStatementImageName = "".obs;
  RxString emp10THMarksheetImageName = "".obs;
  RxString empGraduationImageName = "".obs;
  RxString empMasterImageName = "".obs;
  RxString empCertificateImageName = "".obs;
  RxString empAppointmentFormImageName = "".obs;
  RxString empAppointmentLatterImageName = "".obs;
  RxString empOwnerShipProofName = "".obs;
  RxString empRealAgreeProofName = "".obs;
  RxString empRelationshipProofName = "".obs;
  /// profile selfie employee
  RxString employeeProfileImg = "".obs;
  /// document image choose
  Future employeeProfileDocumentImages(bool isCamera, type) async {
    final ImagePicker picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        print("type value ${pickedFile.name.toString()}");
        print("type value $type");
        switch (type) {
          case 1:
            empPassportImage.value = pickedFile.path;
            empPassportImageName.value = pickedFile.name.toString();
            break;
          case 2:
            empPANImage.value = pickedFile.path;
            empPANImageName.value = pickedFile.name.toString();
            break;
          case 3:
            empAadhaarCardImage.value = pickedFile.path;
            empAadhaarCardImageName.value = pickedFile.name.toString();
            break;
          case 4:
            empSalarySlipsImage.value = pickedFile.path;
            empSalarySlipsImageName.value = pickedFile.name.toString();
            break;
          case 5:
            empBankStatementImage.value = pickedFile.path;
            empBankStatementImageName.value = pickedFile.name.toString();
            break;
          case 6:
            emp10THMarksheetImage.value = pickedFile.path;
            emp10THMarksheetImageName.value = pickedFile.name.toString();
            break;
          case 7:
            empGraduationImage.value = pickedFile.path;
            empGraduationImageName.value = pickedFile.name.toString();
            break;
          case 8:
            empMasterImage.value = pickedFile.path;
            empMasterImageName.value = pickedFile.name.toString();
            break;
          case 9:
            empCertificateImage.value = pickedFile.path;
            empCertificateImageName.value = pickedFile.name.toString();
            break;
          case 10:
            empAppointmentFormImage.value = pickedFile.path;
            empAppointmentFormImageName.value = pickedFile.name.toString();
            break;
          case 11:
            empAppointmentLatterImage.value = pickedFile.path;
            empAppointmentLatterImageName.value = pickedFile.name.toString();
            break;
          case 12:
            empOwnerShipProof.value = pickedFile.path;
            empOwnerShipProofName.value = pickedFile.name.toString();
            break;
          case 13:
            empRealAgreeProof.value = pickedFile.path;
            empRealAgreeProofName.value = pickedFile.name.toString();
            break;
          case 14:
            empRelationshipProof.value = pickedFile.path;
            empRelationshipProofName.value = pickedFile.name.toString();
            break;
          case 15:
            employeeProfileImg.value = pickedFile.path;
            print("employee profile selfie ===>>>>>  ${employeeProfileImg.value}");
            break;

        }
      } else {
        print('No image selected.');
      }
    } on Exception catch (e) {
      print("image response $e");
    }
  }

  /// employee profile document update api integrate
  Future<bool> addEmployeeDocumentNetworkApi(ownerType, addressProof, empId) async {
    var bodyRequest = {
      "tbl_EmpID": empId.toString(),
      "emp_save_type": "2",
      "property_owner_type": ownerType.toString(),
      "address_proof_type": addressProof.toString(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().empDocumentUploadPost("${AppConstants.EMP_DOCUMENT_UPLOAD}?eid=${storage.read(AppConstant.emp_eId).toString().trim()}",
      bodyRequest, empPassportImage.value, empPANImage.value, empAadhaarCardImage.value, empSalarySlipsImage.value, empBankStatementImage.value,
      emp10THMarksheetImage.value, empGraduationImage.value, empMasterImage.value, empCertificateImage.value, empAppointmentFormImage.value,
      empAppointmentLatterImage.value, empOwnerShipProof.value, empRealAgreeProof.value, empRelationshipProof.value,
    ).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      empPassportImageName.value = "";
      empPANImageName.value = "";
      empAadhaarCardImageName.value = "";
      empSalarySlipsImageName.value = "";
      empBankStatementImageName.value = "";
      emp10THMarksheetImageName.value = "";
      empGraduationImageName.value = "";
      empMasterImageName.value = "";
      empCertificateImageName.value = "";
      empAppointmentFormImageName.value = "";
      empAppointmentLatterImageName.value = "";
      empOwnerShipProofName.value = "";
      empRealAgreeProofName.value = "";
      empRelationshipProofName.value = "";
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// employee profile kyc api integrate
  Future<bool> employeeProfileKYCNetworkApi() async {
    var bodyRequest = {
      "tbl_EmpID": storage.read(AppConstant.id).toString().trim(),
      "emp_pan": emp_PanCard.text.toString(),
      "emp_aadhar": emp_Aadhaar.text.toString(),
      "emp_save_type": "2",
    };
    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.EMPLOYEE_KYC, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  ///  employee profile update education fields
  var empEducationTextFieldList= [];
  var emp_course_type="MBA".obs;
  var emp_start_date="".obs;
  var emp_end_date="".obs;
  RxList<Map> empEducationFieldList=<Map>[{
    "emp_course_name": TextEditingController(),
    "emp_institute_name":  TextEditingController(),
    "emp_course_type": null,
    "emp_course_grade": TextEditingController(),
    "emp_course_start": TextEditingController(),
    "emp_course_end": TextEditingController(),
    "emp_skills": TextEditingController(),
  }].obs;
  empEducationAddField(){
    empEducationFieldList.value.add({
      "emp_institute_name":  TextEditingController(),
      "emp_course_name": TextEditingController(),
      "emp_course_type": null,
      "emp_course_start": TextEditingController(),
      "emp_course_end": TextEditingController(),
      "emp_course_grade": TextEditingController(),
      "emp_skills": TextEditingController(),
    });
    empEducationFieldList.refresh();
    update();
  }
  empEducationDeleteField(int i){
    empEducationFieldList.value.removeAt(i);
    empEducationFieldList.refresh();
    update();
  }

  /// employee profile update experience fields
  var empExperienceTextFieldList= [];
  var emp_function= "IT-Software".obs;
  var emp_industry= "Telecom".obs;
  var emp_company_size = "Garde A".obs;
  var emp_join_start_date ="".obs;
  var emp_join_end_date ="".obs;
  RxList<Map> empExperienceFieldList=<Map>[{
    "emp_designation":  TextEditingController(),
    "emp_company": TextEditingController(),
    "emp_function": null,
    "emp_industry": null,
    "emp_company_size": null,
    "emp_joining_salary": TextEditingController(),
    "emp_last_salary": TextEditingController(),
    "emp_job_start_date": TextEditingController(),
    "emp_job_end_date": TextEditingController(),
  }].obs;
  empExperienceAddField(){
    empExperienceFieldList.value.add({
      "emp_designation":  TextEditingController(),
      "emp_company": TextEditingController(),
      "emp_function": null,
      "emp_industry": null,
      "emp_company_size": null,
      "emp_joining_salary": TextEditingController(),
      "emp_last_salary": TextEditingController(),
      "emp_job_start_date": TextEditingController(),
      "emp_job_end_date": TextEditingController(),
    });
    empExperienceFieldList.refresh();
    update();
  }
  empExperienceDeleteField(int i){
    empExperienceFieldList.value.removeAt(i);
    empExperienceFieldList.refresh();
    update();
  }
  var socialMedia=[];
  Future<bool> employeeProfileUpdateAboutNetworkApi(gender, maritalStatus, qualification) async {
    socialMedia.clear();
    socialMedia.add({"fb": emp_facebook.text});
    socialMedia.add({"insta": emp_facebook.text},);
    socialMedia.add({"twitter": emp_linkedin.text});
    empEducationTextFieldList.clear();
    for(var element in empEducationFieldList.value) {
      empEducationTextFieldList.add({
        "emp_institute_name":  element["emp_institute_name"].text.toString(),
        "emp_course_name": element["emp_course_name"].text.toString(),
        "emp_course_type": emp_course_type.value.toString(),
        "emp_course_start": element["emp_course_start"].text.toString(),
        "emp_course_end": element["emp_course_end"].text.toString(),
        "emp_course_grade": element["emp_course_grade"].text.toString(),
        "emp_skills": element["emp_skills"].text.toString(),
      });
    }
    print("ei bxbbx $empEducationTextFieldList");

    empExperienceTextFieldList.clear();
    for(var element in empExperienceFieldList.value) {
      empExperienceTextFieldList.add({
        "emp_designation":  element["emp_designation"].text.toString(),
        "emp_company": element["emp_company"].text.toString(),
        "emp_function": emp_function.value.toString(),
        "emp_industry": emp_industry.value.toString(),
        "emp_company_size": emp_company_size.value.toString(),
        "emp_joining_salary": element["emp_joining_salary"].text.toString(),
        "emp_last_salary": element["emp_last_salary"].text.toString(),
        "emp_job_start_date": element["emp_job_start_date"].text.toString(),
        "emp_job_end_date": element["emp_job_end_date"].text.toString(),
      });
    }

    var bodyRequest = {
      "emp_fname": emp_fName.text,
      "emp_lname": emp_lName.text,
      "emp_dob": emp_dob.text.toString(),
      "emp_gender": gender.toString(),
      "emp_marital_status": maritalStatus.toString(),
      "emp_education": qualification.toString(),
      "emp_phone": emp_phone.text,
      "emp_email": emp_email.text,
      "emp_social": json.encode(socialMedia),
      "emp_present_address_pin": emp_present_address_pin.text,
      "emp_present_address": emp_present_address.text,
      "education": jsonEncode(empEducationTextFieldList),
      "experience": jsonEncode(empExperienceTextFieldList),
      "emp_id": storage.read(AppConstant.cust_id).toString().trim(),
    };
    print("body request ==========>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.EMPLOYEE_PUSHBACK_ABOUT_UPDATE, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response >>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack(jsonDecode(response)["message"]??"");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// employeeApprovalRequestNetworkApi api integration
  Future<bool> employeeApprovalRequestNetworkApi(empId, status, reqEmpId, remark, updatedBy)async{
    var bodyRequest = {
      "emp_id": empId.toString(),
      "req_approver_id": reqEmpId.toString(),
      "approve_status": status.toString(),
      "remark" : remark.toString(),
      "updated_by" : updatedBy.toString(),
    };
    print("request =================>>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.EMPLOYEE_APPROVAL_REQUEST, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"].toString());
    return  false;
  }

  /// partnerApprovalRequestNetworkApi api integration
  Future<bool> partnerApprovalRequestNetworkApi(partnerId, status, reqEmpId, remark, updatedBy)async{
    var bodyRequest = {
      "partner_id": partnerId.toString(),
      "req_approver_id": reqEmpId.toString(),
      "approve_status": status.toString(),
      "remark" : remark.toString(),
      "updated_by" : updatedBy.toString(),
    };
    print("request =================>>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.PARTNER_APPROVAL_REQUEST, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      approvalReason.clear();
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"].toString());
    return  false;
  }

 /// partnerApprovalRequestNetworkApi api integration
  Future<bool> appShareNetworkApi()async{
    var bodyRequest = {
      "cust_id": storage.read(AppConstant.cust_id).toString().trim(),
      "send_mobile": sendInvite.text.toString(),
    };
    print("request =================>>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.APP_SHARE_API, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      sendInvite.clear();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"].toString());
    return  false;
  }

  var add_partner_access_model = AddEmployeePermissionAccessModel(data: PermissionAccessData()).obs;
  Future<bool> getAddEmployeeAccessNetworkApi() async {
    add_partner_access_model.value.data.isNull;
    var response = await BaseClient().get("${AppConstants.GET_USER_PERMISSION}?customer_id=${GetStorage().read(AppConstant.partner_cust_id).toString().trim()}").catchError(BaseController().handleError);
    print(response);
    if (jsonDecode(response)["status"] == "1") {
      add_partner_access_model.value = addEmployeePermissionAccessModelFromJson(response);
      add_partner_access_model.refresh();
      update();
      return true;
    }
    return false;
  }

  /// partner pushback update fields
  var pushbackSocialMedia=[];
  TextEditingController pPushbackFName = TextEditingController();
  TextEditingController pPushbackNumber = TextEditingController();
  TextEditingController pPushbackEmail = TextEditingController();
  TextEditingController pPushbackDob = TextEditingController();
  TextEditingController pPushbackFacebook = TextEditingController();
  TextEditingController pPushbackLinkedin = TextEditingController();
  TextEditingController pPushbackPinCode = TextEditingController();
  TextEditingController pPushbackAddress = TextEditingController();
  TextEditingController pPushbackState = TextEditingController();
  TextEditingController pPushbackCountry = TextEditingController();
  TextEditingController pPushbackPanCard = TextEditingController();
  TextEditingController pPushbackAadhaar = TextEditingController();

  /// partner add fields
  RxString partnerPushbackPayrollBrand = "Beginner".obs;
  Future<bool> partnerPushbackAccessNetworkApi(pPushbackId, accessCount) async {
    var bodyRequest = {
      "partner_id": pPushbackId.toString(),
      "access_change_by": storage.read(AppConstant.cust_id).toString().trim(),
      "access_change_count": accessCount.toString(),
      "emp_view_all" : partnerEmpViewAll.value,
      "add_emp" : partnerAddEMP.value,
      "update_emp" : partnerUpdateEMP.value,
      "emp_push_back" : partnerEmpPushBack.value,
      "emp_approve" : partnerEmpApprove.value,
      "emp_pending_approval" : partnerEmpPendingApprove.value,
      "partner_view_all" : partnerEmpViewAll.value,
      "partner_add" : partnerPartnerAdd.value,
      "partner_update" : partnerPartnerUpdate.value,
      "partner_push_back" : partnerPartnerPushBack.value,
      "partner_pending_approval" : partnerEmpPendingApprove.value,
      "unassigned_leads" : unassignedLeads.value,
      "assign_all_lead" : partnerAssignAllLead.value,
      "assign_my_lead" : partnerAssignMyLead.value,
      "assign_myteam_lead" : partnerAssignMyTeamLead.value,
      "assign_mypartner_lead" : partnerAssignMyPartnerLead.value,
      "add_lead" : partnerAddLead.value,
      "my_lead" : partnerMyLead.value,
      "myteam_lead" : partnerMyTeamLead.value,
      "mypartner_lead" : partnerMyPartnerLead.value,
      "all_cust" : partnerAllCust.value,
      "my_cust" : partnerMyCust.value,
      "myteam_cust" : partnerMyTeamCust.value,
      "mypartner_cust" : partnerMyPartnerCust.value,
      "my_sales" : partnerMySales.value,
      "incentive_mgmt_view" : partnerIncentiveMGMTView.value,
      "incentive_mgmt_edit" : partnerIncentiveMGMTEdit.value,
      "panel_manage_employee" : partnerPanelManageEmployee.value,
      "panel_manage_partner" : partnerPanelManagePartner.value,
      "panel_manage_customer" : partnerPanelManageCustomer.value,
    };
    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.PARTNER_ACCESS_UPDATE, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      partnerCompleteIdUpdate = jsonDecode(response)["data"][0]["pid"].toString();
      print("sjs $partnerCompleteIdUpdate");
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// partnerPushbackKycNetworkApi api integrate
  Future<bool> partnerPushbackKycNetworkApi(custId) async {
    var bodyRequest = {
      "cust_id": custId.toString(),
      "cust_pan": pPushbackPanCard.text.toString(),
      "cust_aadhar": pPushbackAadhaar.text.toString(),
    };
    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_KYC, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// partnerPushbackAboutNetworkApi api integration
  Future<bool> partnerPushbackAboutNetworkApi(custId, qualification, marital, gender) async {
    pushbackSocialMedia.clear();
    pushbackSocialMedia.add({"fb": pPushbackFacebook.text});
    pushbackSocialMedia.add({"linkdin": pPushbackLinkedin.text},);
    var bodyRequest = {
      "cust_id": custId,
      "cust_aadhar": pPushbackAadhaar.text,
      "cust_pan": pPushbackPanCard.text,
      "cust_phone": pPushbackNumber.text,
      "line_address": pPushbackAddress.text,
      "cust_pincode": pPushbackPinCode.text,
      "cust_state": pPushbackState.text,
      "cust_country": pPushbackCountry.text,
      "cust_social": json.encode(pushbackSocialMedia),
      "cust_email": pPushbackEmail.text,
      "cust_education": qualification.toString(),
      "cust_marital_status": marital.toString(),
      "cust_gender": gender.toString(),
      "cust_dob": pPushbackDob.text,
      "cust_name": pPushbackFName.text,
    };
    print("bodyRequest ================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_PROFILE, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// uploadDocumentNetworkApi integrate
  Future<bool> partnerPushbackDocsNetworkApi(custId, owner_type, proof_type) async {
    var bodyRequest = {
      "property_owner_type": owner_type.toString(),
      "address_proof_type": proof_type.toString(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().employeeDocumentUploadPost("${AppConstants.PARTNER_DOCUMENT_UPLOAD}?cust_id=${custId.toString()}",
      bodyRequest, pPanCardImage.value, pAadhaarCardImage.value, pRentAgreement.value, pBankStatementImage.value, pOwnerShipProof.value, pRelationshipProof.value,)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      pPanCardImage.value="";
      pAadhaarCardImage.value="";
      pRentAgreement.value="";
      pBankStatementImage.value="";
      pOwnerShipProof.value="";
      pRelationshipProof.value="";
      pPanCardImageName.value="";
      pAadhaarCardImageName.value="";
      pRentAgreementName.value="";
      pBankStatementImageName.value="";
      pOwnerShipProofName.value="";
      pRelationshipProofName.value="";
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// lead details reupload document all images
  RxString leadUserImage = "".obs;
  RxString leadPanCardImage = "".obs;
  RxString leadAadhaarCardImage = "".obs;
  RxString leadSalarySlipImage = "".obs;
  RxString leadBankStatementImage = "".obs;
  RxString leadOwnerShipProof = "".obs;
  RxString leadRelationshipProof = "".obs;

  /// lead details reupload document image choose
  Future leadDocumentReUpload(bool isCamera, type) async {
    final ImagePicker picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        switch (type) {
          case 1:
            leadUserImage.value = pickedFile.path;
            print("User image ${File(leadUserImage.value)}");
            break;
          case 2:
            leadPanCardImage.value = pickedFile.path;
            print("pan Card ${File(leadPanCardImage.value)}");
            break;
          case 3:
            leadAadhaarCardImage.value = pickedFile.path;
            print("aadhar card ${File(leadAadhaarCardImage.value)}");
            break;
          case 4:
            leadSalarySlipImage.value = pickedFile.path;
            print("Salary slip ${File(leadSalarySlipImage.value)}");
            break;
          case 5:
            leadBankStatementImage.value = pickedFile.path;
            print("Bank Statement ${File(leadBankStatementImage.value)}");
            break;
          case 6:
            leadOwnerShipProof.value = pickedFile.path;
            print("Ownership ${File(leadOwnerShipProof.value)}");
            break;
          case 7:
            leadRelationshipProof.value = pickedFile.path;
            print("Relationship ${File(leadRelationshipProof.value)}");
            break;
        }
      } else {
        print('No image selected.');
      }
    } on Exception catch (e) {
      print("image response $e");
    }
  }

  /// leadUploadDocumentNetworkApi integrate
  Future<bool> leadDocumentReUploadNetworkApi(leadCustId, leadId, ownerProofType, addressProofType) async {
    var bodyRequest = {
      "id": leadId.toString(),
      "property_owner_type": ownerProofType.toString(),
      "address_proof_type": addressProofType.toString(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().userDocumentUploadPost("${AppConstants.UPLOAD_DOCUMENT_API}?customer_id=$leadCustId",
      bodyRequest, leadUserImage.value, leadPanCardImage.value.toString(), leadAadhaarCardImage.value.toString(),
        leadSalarySlipImage.value.toString(), leadBankStatementImage.value.toString(), leadOwnerShipProof.value.toString(),
        leadRelationshipProof.value.toString()).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      leadUserImage.value = "";
      leadPanCardImage.value = "";
      leadAadhaarCardImage.value = "";
      leadSalarySlipImage.value = "";
      leadBankStatementImage.value = "";
      leadOwnerShipProof.value = "";
      leadRelationshipProof.value = "";
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// employee selfie image choose
  Future multipleChooseImage(bool isCamera, int index) async {
    final ImagePicker picker = ImagePicker();
    try {
      await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 80,
      ).then((value) {
        if(value != null){
          leadDetailsImageList.value[index]["attachment"] = value;
          leadDetailsImageList.refresh();
          update();
          print("shjvsh ${controller.leadDetailsImageList.value[index]["attachment"]}");
        }
        return null;
      });
    } on Exception catch (e) {
      print("image response $e");
    }
  }
  RxList<Map> leadDetailsImageList=<Map>[{
    "attachment": null,
  }].obs;
  leadDetailsImageListAddField(){
    leadDetailsImageList.value.add({
      "attachment": null,
    });
    leadDetailsImageList.refresh();
    update();
  }
  leadDetailsImageListDeleteField(int i){
    leadDetailsImageList.value.removeAt(i);
    leadDetailsImageList.refresh();
    update();
  }

  /// updateAssignLeadNetworkApi integrate
  Future<bool> updateAssignLeadNetworkApi(leadId, teleEid, fosEid) async {
    var bodyRequest = {
      "lead_id": leadId.toString(),
      "lead_assign_tele": teleEid.toString(),
      "lead_assign_fos": fosEid.toString(),
      "lead_assign_by": storage.read(AppConstant.cust_id).toString(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_ASSIGN_LEAD, bodyRequest)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack(jsonDecode(response)["message"]);
      controller.check_owner_exist_tele.value.data.clear();
      controller.check_owner_exist_fos.value.data.clear();
      teleCheckID.clear();
      fosCheckID.clear();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// checkSupIdExistNetworkApi integrate
  var check_supId_exist_model = CheckSupervisorIdExistModel(data: []).obs;
  Future<bool> checkSupIdExistNetworkApi(supId)async{
    check_supId_exist_model.value.data.clear();
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().get("${AppConstants.CHECK_SUPERVISOR_EXIST}?sup_id=$supId&emp_login_id=${storage.read(AppConstant.cust_id).toString()}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"]=="1")
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      check_supId_exist_model.value=checkSupervisorIdExistModelFromJson(response);
      check_supId_exist_model.refresh();
      update();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return  false;
  }

  /// updateLoanLeadKYCdNetworkApi integrate
  TextEditingController loanAadharCard = TextEditingController();
  TextEditingController loanPanCard = TextEditingController();
  Future<bool> updateLoanLeadKYCdNetworkApi(leadId) async {
    var bodyRequest = {
      "lead_id": leadId.toString(),
      "cust_pan": loanPanCard.text,
      "cust_aadhar": loanAadharCard.text.toString(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_LOAN_KYC, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// draftLoanLeadUpdateNetworkApi integrate
  TextEditingController draftLoanName = TextEditingController();
  TextEditingController draftLoanDob = TextEditingController();
  TextEditingController draftLoanEMail = TextEditingController();
  TextEditingController draftLoanPhone = TextEditingController();
  TextEditingController draftLoanNetSalary = TextEditingController();
  TextEditingController draftLoanCompanyName = TextEditingController();
  TextEditingController draftLoanAmount = TextEditingController();
  TextEditingController draftLoanTenure = TextEditingController();
  var draftLoanType = "select loan".obs;
  var draftTenure = "select year".obs;
  var draftMonth = "select month".obs;
  var draftLoanTextFieldList= [];
  RxList<Map> custDraftLoanList=<Map>[{
    "loan_type": null,
    "tenure": null,
    "month": null,
    "loan_amt": TextEditingController(),
    "roi": TextEditingController(),
  }].obs;
  userAddField(){
    custDraftLoanList.value.add({
      "loan_type": null,
      "tenure": null,
      "month": null,
      "loan_amt": TextEditingController(),
      "roi": TextEditingController(),
    });
    custDraftLoanList.refresh();
    update();
  }
  userDeleteField(int i){
    custDraftLoanList.value.removeAt(i);
    custDraftLoanList.refresh();
    update();
  }
  Future<bool> draftLoanLeadUpdateNetworkApi(leadId, gender, marital, education, companyType) async {
    draftLoanTextFieldList.clear();
    for(var element in custDraftLoanList.value) {
      draftLoanTextFieldList.add({
        "loan_type": draftLoanType.value=="select loan"?"":draftLoanType.value,
        "tenure": draftTenure.value=="select year"?"":draftTenure.value,
        "month": draftMonth.value=="select month"?"":draftMonth.value,
        "loan_amt":element["loan_amt"].text.toString(),
        "roi":element["roi"].text.toString()});
    }

    var bodyRequest = {
      "lead_id": leadId.toString(),
      "cust_name": draftLoanName.text,
      "cust_email": draftLoanEMail.text,
      "cust_gender": gender.toString(),
      "cust_marital_status": marital.toString(),
      "cust_education": education.toString(),
      "cust_company": draftLoanCompanyName.text,
      "cust_company_type": companyType.toString(),
      "cust_phone": draftLoanPhone.text,
      "cust_net_salary": draftLoanNetSalary.text,
      "loan_turner": draftLoanTenure.text,
      "loan_amount": draftLoanAmount.text,
      "cust_active_loan": jsonEncode(draftLoanTextFieldList)
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_DRAFT_LOAN_LEAD, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// uploadSelfieNetworkApi integrate
  Future<bool> employeeUploadSelfieNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().empSelfieUpload("${AppConstants.EMPLOYEE_PROFILE_UPLOAD}?eid=${storage.read(AppConstant.cust_id).toString().trim()}", employeeProfileImg.value)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.profile, jsonDecode(response)["data"]["doc_profile_pic"]??"");
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      employeeProfileImg.value = "";
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// myLeadHistoryNetworkApi api integrate
  var draft_loan_history_model = DraftLoanLeadModel(data: DraftLoanLeadData(leads: [])).obs;
  ScrollController draftLoanLeadController = ScrollController();
  RxBool draft_history_model_loader = false.obs;
  int draftLoanLeadNext = 10;
  Future<bool> draftLoanLeadNetworkApi(bool refresh, date,monthYear,lead_type) async {
    Get.context!.loaderOverlay.show();
    if(refresh==true) draft_history_model_loader.value=false;
    var response = await BaseClient().get("${AppConstants.DRAFT_LOAN_LEAD_API}?page=0&limit=$draftLoanLeadNext&lead_type=$lead_type&date=$date&monthyear=$monthYear&customer_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    if(refresh==true) draft_history_model_loader.value=true;
    Get.context!.loaderOverlay.hide();
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["Leads"];
      if(data.isNotEmpty){
        if(partnerLoadMore.value==false){
          draft_loan_history_model.value = draftLoanLeadModelFromJson(response);
          draft_loan_history_model.refresh();
          update();
        }
        else{
          draft_loan_history_model.value = draftLoanLeadModelFromJson(response);
          draft_loan_history_model.refresh();
          update();
        }
        partnerLoading.value=true;
        partnerLoadMore.value=false;
      }else{
        partnerLoading.value=false;
        partnerLoadMore.value=false;
      }
      return true;
    }
    draft_loan_history_model.value = draftLoanLeadModelFromJson(response);
    draft_loan_history_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  draftLoanLeadPagination() async {
    draftLoanLeadController.addListener(() {
      if (draftLoanLeadController.position.maxScrollExtent == draftLoanLeadController.position.pixels) {
        draftLoanLeadNext+=10;
        if(partnerLoading.value){
          partnerLoadMore.value=true;
          draftLoanLeadNetworkApi(false,"","",controller.loanTypeDecode(loginController.selectLoanType.value));
        }
      }
    });
  }

  Future<bool> updateFingerprintLockNetworkApi(lockValue) async {
    var bodyRequest = {
      "userid": storage.read(AppConstant.cust_id).toString().trim(),
      "fringerprint_lock": lockValue.toString(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_FINGERPRINT_LOCK, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  RxInt radioSelected = 1.obs;
  RxString radioVal = 'month'.obs;

  void handleRadioValueChanged(int value) {
    radioSelected(value);
    radioVal(value == 1 ? 'month' : 'year');
  }

  /// validate leads status update
  Future<bool> validateLeadsStatusNetworkApi(leadId, remarks) async {
    var bodyRequest = {
      "lead_id": leadId.toString(),
      "remark": remarks.toString(),
      "updated_by": storage.read(AppConstant.cust_id).toString().trim(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.VALIDATE_LEAD_STATUS, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }
}