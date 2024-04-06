// ignore_for_file: invalid_use_of_protected_member, avoid_print, non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously, unnecessary_null_comparison
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bank_bay/models/add_emp_about_model.dart';
import 'package:bank_bay/models/add_employee_permission_access_model.dart';
import 'package:bank_bay/models/all_employee_model.dart';
import 'package:bank_bay/models/all_leads_data_model.dart';
import 'package:bank_bay/models/all_leads_model.dart';
import 'package:bank_bay/models/approve_assign_model.dart';
import 'package:bank_bay/models/employee_approve_model.dart';
import 'package:bank_bay/models/employee_push_back_model.dart';
import 'package:bank_bay/models/employee_request_list_model.dart';
import 'package:bank_bay/models/forget_data_model.dart';
import 'package:bank_bay/models/fresh_lead_model.dart';
import 'package:bank_bay/models/get_my_lead_model.dart';
import 'package:bank_bay/models/get_notifications_model.dart';
import 'package:bank_bay/models/hold_leads_model.dart';
import 'package:bank_bay/models/inc_approval_model.dart';
import 'package:bank_bay/models/inc_due_leads_model.dart';
import 'package:bank_bay/models/inc_paid_model.dart';
import 'package:bank_bay/models/kyc_model.dart';
import 'package:bank_bay/models/login_leads_model.dart';
import 'package:bank_bay/models/my_cust_model.dart';
import 'package:bank_bay/models/my_team_model.dart';
import 'package:bank_bay/models/new_leads_model.dart';
import 'package:bank_bay/models/sanctioned_leads_model.dart';
import 'package:bank_bay/models/team_leads_model.dart';
import 'package:bank_bay/models/unassign_model.dart';
import 'package:bank_bay/models/verification_data_model.dart';
import 'package:bank_bay/models/verified_leads_model.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/utils/BaseClient.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_snackbar.dart';
import 'package:bank_bay/widgets/LeadManager/add_lead.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/Model/CountryModel.dart';
import 'package:bank_bay/widgets/Profile/Model/StateModel.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'permission_controller.dart';

class LoginController extends GetxController{
  var controller = Get.put(PermissionController());
  final partnerController = Get.put(PartnerController());
  final GlobalKey<ScaffoldState> scaffoldKeyLead = GlobalKey<ScaffoldState>(debugLabel: "leadManager");
  GetStorage storage = GetStorage();
  RxString userLoanLeadId = "".obs;
  RxString FCM_TOKEN = "".obs;
  RxInt index = 0.obs;
  RxBool isLoading=false.obs;
  RxBool isLoadMore=false.obs;
  RxInt addEMPTab = 0.obs;
  DateTime? currentBackPressTime;
  RxString urlValue = "".obs;
  RxString profileImg = "".obs;
  RxString verifyOtp = "".obs;
  RxString emailOtp = "".obs;
  RxString phoneOtp = "".obs;
  RxInt phoneOtp1 = 0.obs;
  RxString gender ="Select Gender".obs;
  RxString companyType = "Select Company".obs;
  RxString maritalStatus = "Select Marital Status".obs;
  RxString highestQualification = "Select Qualification".obs;
  RxInt currentSliderValue = 1.obs;
  RxInt loanTenure = 1.obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    employeeRefreshList();
    addItemsAllEmployeeList();
    addItemsApprovedList();
    addItemsEmpPushBackList();
    myLeadsPagination();
    teamLeadsPagination();
    unassignedLeadPagination();
    allLeadsPagination();
    newLeadPagination();
    holdLeadPagination();
    loginLeadPagination();
    verifiedLeadPagination();
    sanctionedLeadPagination();
    incDueLeadPagination();
    incApprovalLeadPagination();
    incPaidLeadPagination();
    allLeadsDataPagination();
    verificationDataPagination();
    super.onInit();
  }

  /// add employee access variables
  RxString empViewAll = "No".obs;
  RxString addEMP = "No".obs;
  RxString updateEMP = "No".obs;
  RxString empPushBack = "No".obs;
  RxString empApprove = "No".obs;
  RxString empPendingApprove = "No".obs;
  RxString partnerViewAll = "No".obs;
  RxString partnerAdd = "No".obs;
  RxString partnerUpdate = "No".obs;
  RxString partnerPushBack = "No".obs;
  RxString partnerPendingApproval = "No".obs;
  RxString unassignedLeads = "No".obs;
  RxString assignAllLead = "No".obs;
  RxString assignMyLead = "No".obs;
  RxString assignMyTeamLead = "No".obs;
  RxString assignMyPartnerLead = "No".obs;
  RxString addLead = "No".obs;
  RxString myLead = "No".obs;
  RxString myTeamLead = "No".obs;
  RxString myPartnerLead = "No".obs;
  RxString AllCust = "No".obs;
  RxString myCust = "No".obs;
  RxString myTeamCust = "No".obs;
  RxString myPartnerCust = "No".obs;
  RxString mySales = "No".obs;
  RxString incentiveMGMTView = "No".obs;
  RxString incentiveMGMTEdit = "No".obs;
  RxString applySelfLoan = "No".obs;
  RxString panelManagePartner = "No".obs;
  RxString assignmentChangeApproval = "No".obs;
  RxString panelManageEmployee = "No".obs;
  RxString panelManageCustomer = "No".obs;
  RxString NewLeadTab = "No".obs;
  RxString VerificationTab = "No".obs;
  RxString DisbursedTab = "No".obs;
  RxString IncentiveTab = "No".obs;

  /// lead filter drawer
  void openEndDrawer() {
    if (scaffoldKeyLead.currentState != null) {
      scaffoldKeyLead.currentState!.openEndDrawer();
    } else {
      print("ScaffoldState is null. Cannot open end drawer.");
    }
  }

  String obfuscateEmail(String email) {
    if (email == "" || email.isEmpty) {
      return "";
    }

    // Split the email address into local part and domain part
    List<String> parts = email.split('@');
    if (parts.length != 2) {
      return email; // Return original email if it doesn't contain '@'
    }

    String localPart = parts[0];
    String domainPart = parts[1];

    // Obfuscate local part
    String obfuscatedLocalPart = '';
    for (int i = 0; i < localPart.length; i++) {
      if (i < 2 || i >= localPart.length - 2) {
        obfuscatedLocalPart += localPart[i];
      } else {
        obfuscatedLocalPart += '*';
      }
    }

    // Return obfuscated email address
    return '$obfuscatedLocalPart@$domainPart';
  }

  String obfuscatePhoneNumber(String phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return '';
    }

    // Check if the phone number has at least 4 digits
    if (phoneNumber.length < 4) {
      return phoneNumber; // Return original phone number if it has less than 4 digits
    }

    // Obfuscate phone number
    String obfuscatedPhoneNumber = '';
    for (int i = 0; i < phoneNumber.length; i++) {
      if (i < 2 || i >= phoneNumber.length - 2) {
        obfuscatedPhoneNumber += phoneNumber[i];
      } else {
        obfuscatedPhoneNumber += '*';
      }
    }

    // Return obfuscated phone number
    return obfuscatedPhoneNumber;
  }


  /// all lead filter fields
  RxString loanType ="Personal loan".obs;
  TextEditingController customerPan = TextEditingController();
  TextEditingController customerPhone = TextEditingController();
  TextEditingController loanOwnerPan = TextEditingController();
  TextEditingController loanOwnerPhone = TextEditingController();
  TextEditingController leadStartDate = TextEditingController();
  TextEditingController leadEndDate = TextEditingController();

  /// employee login password
  TextEditingController empID = TextEditingController();
  TextEditingController empPassword = TextEditingController();
  /// generate pin or password
  TextEditingController generateNumber = TextEditingController();
  TextEditingController generatePin = TextEditingController();
  TextEditingController generatePassword = TextEditingController();
  TextEditingController otpVerify = TextEditingController();
  TextEditingController createPassword = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  /// change password
  TextEditingController oldPassword = TextEditingController();
  TextEditingController oldNewPassword = TextEditingController();
  TextEditingController oldConfirmPassword = TextEditingController();
  /// add emp kyc password
  TextEditingController kPanCard = TextEditingController();
  TextEditingController kAadhaarCard = TextEditingController();

  /// lead registration field
  TextEditingController leadName = TextEditingController();
  TextEditingController leadEmail = TextEditingController();
  TextEditingController leadPassword = TextEditingController();
  TextEditingController leadPanCard = TextEditingController();
  TextEditingController leadNumber = TextEditingController();
  TextEditingController leadDob = TextEditingController();
  TextEditingController leadCompanyName = TextEditingController();
  TextEditingController leadMonthlyAmount = TextEditingController();
  /// user register field
  TextEditingController etName = TextEditingController();
  TextEditingController etEmail = TextEditingController();
  TextEditingController etPassword = TextEditingController();
  TextEditingController etPanCard = TextEditingController();
  TextEditingController etNumber = TextEditingController();
  TextEditingController etDob = TextEditingController();
  TextEditingController etCompanyName = TextEditingController();
  TextEditingController etMonthlyAmount = TextEditingController();
  /// emp payroll field
  TextEditingController pSupervisorId = TextEditingController();
  TextEditingController pJoiningSalary = TextEditingController();
  TextEditingController pPresentSalary = TextEditingController();
  TextEditingController pDesignation = TextEditingController();
  TextEditingController pJoiningDate = TextEditingController();
  TextEditingController pResignDate = TextEditingController();
  TextEditingController pLastWorkingDate = TextEditingController();
  TextEditingController pRelivingDate = TextEditingController();
  RxString pFunctionUnit = "".obs;
  RxString pBrand = "".obs;
  /// kyc api integrate
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
  RxString emp_gender = "".obs;
  RxString emp_marital_status = "".obs;
  RxString emp_highest_qualification = "".obs;
  var selectCountry;
  var selectState;

  void setCurrentIndex(int index, bool notify) {
    currentIndex.value = index;
    update();
  }

  List bannerData = [
    "https://c0.wallpaperflare.com/preview/811/935/645/adults-analysis-brainstorming-collaboration.jpg",
    "https://c0.wallpaperflare.com/preview/389/615/630/business-businessman-communication-concept.jpg",
    "https://c0.wallpaperflare.com/preview/513/460/937/adult-analyzing-brainstorming-collaboration.jpg",
  ];

  /// on back exit app
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      urlValue.value = "";
      currentBackPressTime = now;
      index.value=0;
      CustomAnimation().showCustomToast('Press again to exit', isError: false);
      // ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      return Future.value(false);
    }
    return Future.value(true);
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

  /// employee selfie image choose
  RxString empProfileImg = "".obs;
  Future empChooseImage(bool isCamera, name) async {
    final ImagePicker picker = ImagePicker();
    try {
      await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 80,
      ).then((value) {
        if(value != null){
          _empCropImage(File(value.path), name);
        }
        return null;
      });
    } on Exception catch (e) {
      print("image response $e");
    }
  }

  /// employee crop selfie image code
  _empCropImage(File imgFile, name) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] :
        [
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
      if(name=="empProfile") {
        empProfileImg.value = croppedFile.path;
      }
      // Navigator.pop(Get.context!);
    }
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

  /// login api integrate
  Future<bool> loginNetworkApi() async {
    var bodyRequest = {
      "lead_source": "",
      "cust_name": etName.text.toString(),
      "cust_dob": etDob.text.toString(),
      "cust_gender": gender.value,
      "cust_marital_status": maritalStatus.value,
      "cust_education": highestQualification.value,
      "cust_email": etEmail.text.toString(),
      "cust_pan": etPanCard.text.toString(),
      "cust_phone": etNumber.text.toString(),
      "password": etPassword.text.toString(),
    };
    print("request =============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.REGISTER_URL_NEW, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==============>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      verifyOtp.value = "${jsonDecode(response)["data"]["otp_phone"]??""}";
      storage.write(AppConstant.id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.cust_id, "${jsonDecode(response)["data"]["cust_id"]??""}");
      storage.write(AppConstant.phone, "${jsonDecode(response)["data"]["cust_phone"]??""}");
      BaseController().successSnack("${jsonDecode(response)["message"]}  ${jsonDecode(response)["data"]["otp_phone"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"].toString());
    return false;
  }

  /// otp api integrate
  Future<bool> otpVerificationApi(otp) async {
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
      verifyOtp.value = "${jsonDecode(response)["data"]["otp_phone"]??""}";
      storage.write(AppConstant.id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.name, "${jsonDecode(response)["data"]["cust_name"]??""}");
      storage.write(AppConstant.email, "${jsonDecode(response)["data"]["cust_email"]??""}");
      storage.write(AppConstant.phone, "${jsonDecode(response)["data"]["cust_phone"]??""}");
      otpVerify.clear();
      etName.clear();
      etDob.clear();
      gender.value ="Select Gender";
      companyType.value = "IT Company";
      maritalStatus.value = "Select Marital Status";
      highestQualification.value = "Select Qualification";
      etEmail.clear();
      etPassword.clear();
      etPanCard.clear();
      etNumber.clear();
      BaseController().successSnack("${jsonDecode(response)["message"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// resendOTPApi api integrate
  Future<bool> resendOTPNetworkApi(BuildContext context) async {
    var bodyRequest = {
      "cust_id": storage.read(AppConstant.cust_id).toString().trim(),
    };
    print("request ============>>>>>>>>>>>>> $bodyRequest");
    context.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.RESEND_OTP, bodyRequest).catchError(BaseController().handleError);
    context.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"].toString()} - ${jsonDecode(response)["data"][0]["otp_phone"].toString()}");
      verifyOtp.value = "${jsonDecode(response)["data"][0]["otp_phone"]??""}";
      storage.write(AppConstant.id, "${jsonDecode(response)["data"][0]["id"]??""}");
      storage.write(AppConstant.phone, "${jsonDecode(response)["data"][0]["cust_phone"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// login api integrate
  Future<bool> leadLoginNetworkApi() async {
    var bodyRequest = {
      "lead_source": GetStorage().read(AppConstant.cust_id).toString(),
      "cust_name": leadName.text.toString(),
      "cust_dob": leadDob.text.toString(),
      "cust_gender": gender.value,
      "cust_marital_status": maritalStatus.value,
      "cust_education": highestQualification.value,
      "cust_email": leadEmail.text.toString(),
      "cust_pan": leadPanCard.text.toString(),
      "cust_phone": leadNumber.text.toString(),
      "password": "",
    };
    print("request ============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.REGISTER_URL, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response =================>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.lead_id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.lead_cust_id, "${jsonDecode(response)["data"]["cust_id"]??""}");
      BaseController().successSnack("${jsonDecode(response)["message"]}  ${jsonDecode(response)["data"]["otp_phone"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"].toString());
    return false;
  }

  /// otp api integrate
  Future<bool> leadOtpVerificationApi(otp) async {
    var bodyRequest = {
      "tbl_custID": storage.read(AppConstant.lead_id).toString().trim(),
      "otp_phone": otp,
    };
    print("request ===========>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.VERIFY_URL, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.lead_id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.lead_cust_id, "${jsonDecode(response)["data"]["cust_id"]??""}");
      otpVerify.clear();
      leadName.clear();
      leadDob.clear();
      gender.value ="Select Gender";
      companyType.value = "IT Company";
      maritalStatus.value = "Select Marital Status";
      highestQualification.value = "Select Qualification";
      leadEmail.clear();
      leadPassword.clear();
      leadPanCard.clear();
      leadNumber.clear();
      BaseController().successSnack("${jsonDecode(response)["message"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// forgetPasswordNetworkAPI api integrate
  var forget_data = ForgetDataModel(data: []).obs;
  Future<bool> forgetPasswordNetworkAPI() async {
    var bodyRequest = {
      // "tbl_custID": storage.read(AppConstant.id).toString().trim(),
      "mobile": generateNumber.text,
    };
    print("request ==================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.FORGET_PASSWORD, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack(jsonDecode(response)["message"]);
      storage.write(AppConstant.id, jsonDecode(response)["data"][0]["id"]);
      storage.write(AppConstant.cust_id, jsonDecode(response)["data"][0]["cust_id"]);
      phoneOtp.value = "${jsonDecode(response)["data"][0]["otp_phone"] ?? ""}";
      forget_data.value = forgetDataModelFromJson(response);
      forget_data.refresh();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// phoneOtpVerifyNetworkAPI api integrate
  Future<bool> phoneOtpVerifyNetworkAPI(otp) async {
    var bodyRequest = {
      "tbl_custID": storage.read(AppConstant.id).toString().trim(),
      "otp_phone": otp.toString(),
    };
    print("request ==============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.VERIFY_PHONE, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("Otp Verify ${jsonDecode(response)["message"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// newPasswordApi integrate
  Future<bool> newPasswordNetworkApi() async {
    var bodyRequest = {
      "tbl_custID": storage.read(AppConstant.id).toString().trim(),
      "newpassword": createPassword.text,
      "cpassword": rePassword.text,
    };

    print("request ===============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.NEW_PASSWORD, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      createPassword.clear();
      rePassword.clear();
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// userPasswordLoginNetworkApi integrate
  Future<bool> userLoginNetworkApi(BuildContext context, value, userId, password) async {
    var bodyRequest = {
      "username": userId.toString(),
      "password":  password.toString(),
    };
    print("request ========>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.USER_LOGIN, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      if(jsonDecode(response)["data"]["cust_id"].toString().startsWith("C10")==true){
        sendFCMTokenNetworkApi(jsonDecode(response)["data"]["cust_id"],FCM_TOKEN.value.toString());
        storage.write(AppConstant.name, jsonDecode(response)["data"]["cust_name"]??"");
        storage.write(AppConstant.id, jsonDecode(response)["data"]["id"]??"");
        storage.write(AppConstant.pId, jsonDecode(response)["data"]["partnerdetails"]["pid"]);
        storage.write(AppConstant.sup_id, jsonDecode(response)["data"]["sup_id"]??"");
        storage.write(AppConstant.phone, jsonDecode(response)["data"]["cust_phone"]??"");
        storage.write(AppConstant.email, jsonDecode(response)["data"]["cust_email"]??"");
        storage.write(AppConstant.cust_id, jsonDecode(response)["data"]["cust_id"]??"");
        storage.write(AppConstant.profile, jsonDecode(response)["data"]["cust_profile_pic"]??"");
        bool status = await controller.userPermissionNetworkApi(jsonDecode(response)["data"]["cust_id"].toString());
        if (status == true) {
          if(value=="userHome") {
            Get.offAll(() => const DashboardScreen());
            index.value=0;
            indexValue.value=1;
          }else if(value=="leadScreen") {
            Get.offAll(() => const DashboardScreen());
            index.value=1;
            screenValue.value=1;
            indexValue.value=1;
          }else if(value=="home") {
            Get.offAll(() => const DashboardScreen());
            index.value=0;
            indexValue.value = 1;
          }
        }
      }
      if(jsonDecode(response)["data"]["eid"].toString().startsWith("E10")==true){
        sendFCMTokenNetworkApi(jsonDecode(response)["data"]["eid"]??"",FCM_TOKEN.value.toString());
        storage.write(AppConstant.name, "${jsonDecode(response)["data"]["emp_fname"]??""} ${jsonDecode(response)["data"]["emp_lname"]??""}");
        storage.write(AppConstant.id, jsonDecode(response)["data"]["id"]??"");
        storage.write(AppConstant.cust_id, jsonDecode(response)["data"]["eid"]??"");
        storage.write(AppConstant.email, jsonDecode(response)["data"]["emp_email"]??"");
        storage.write(AppConstant.profile, jsonDecode(response)["data"]["doc_profile_pic"]??"");
        storage.write(AppConstant.phone, jsonDecode(response)["data"]["emp_phone"]??"");
        storage.write(AppConstant.sup_id, jsonDecode(response)["data"]["sup_id"]??"");
        bool status = await controller.userPermissionNetworkApi(jsonDecode(response)["data"]["eid"].toString());
        if (status == true) {
          if(value=="userHome") {
            Get.offAll(() => const DashboardScreen());
            index.value=0;
            indexValue.value=1;
          }else if(value=="leadScreen") {
            Get.offAll(() => const DashboardScreen());
            index.value=1;
            screenValue.value=1;
            indexValue.value=1;
          }else if(value=="home") {
            Get.offAll(() => const DashboardScreen());
            index.value=0;
            indexValue.value = 1;
          }
        }
      }

      BaseController().successSnack(jsonDecode(response)["message"]??"");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// sendFCMTokenNetworkApi integrate
  Future<bool> sendFCMTokenNetworkApi(userId, tokenId) async {
    var bodyRequest = {
      "user_id": userId.toString(),
      "token": tokenId.toString(),
    };

    print("request ================>>>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_FCM_TOKEN, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response =====================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// userGeneratePinNetworkApi integrate
  Future<bool> userGeneratePinNetworkApi() async {
    var bodyRequest = {
      "loginpin": generatePin.text.toString(),
      "mobile": generateNumber.text.toString(),
    };
    print("request ===============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.GENERATE_OTP_API, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response =================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      phoneOtp.value="${jsonDecode(response)["data"][0]["otp_phone"] ?? ""}";
      storage.write(AppConstant.id, jsonDecode(response)["data"][0]["id"]);
      storage.write(AppConstant.cust_id, jsonDecode(response)["data"][0]["cust_id"]);
      BaseController().successSnack(jsonDecode(response)["message"]??"  ${jsonDecode(response)["data"][0]["otp_phone"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// changePasswordNetworkApi integrate
  Future<bool> changePasswordNetworkApi() async {
    var bodyRequest = {
      if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E100"))
        "emp_id": storage.read(AppConstant.cust_id).toString().trim(),
      if(GetStorage().read(AppConstant.cust_id).toString().startsWith("C100"))
        "tbl_custID": storage.read(AppConstant.id).toString().trim(),
      "oldpassword": oldPassword.text.toString(),
      "newpassword": oldNewPassword.text.toString(),
      "cpassword": oldConfirmPassword.text.toString(),
    };
    print("request ==================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response;
    if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E100")) {
      response = await BaseClient().post(AppConstants.EMPLOYEE_CHANGE_PASSWORD, bodyRequest).catchError(BaseController().handleError);
    }else {
      response = await BaseClient().post(AppConstants.CHANGE_PASSWORD, bodyRequest).catchError(BaseController().handleError);
    }
    Get.context!.loaderOverlay.hide();
    print("response ====================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      oldPassword.clear();
      oldNewPassword.clear();
      oldConfirmPassword.clear();
      BaseController().successSnack(jsonDecode(response)["message"]??"");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// otpVerifyPinNetworkApi integrate
  Future<bool> otpVerifyPinNetworkApi(otp) async {
    var bodyRequest = {
      "tbl_custID": storage.read(AppConstant.id).toString().trim(),
      "otp_phone": otp.toString(),
    };
    print("request ===================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.OTP_VERIFY_PIN, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ===================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.phone, jsonDecode(response)["data"]["cust_phone"]);
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// customer loan lead
  var leadLoanTypeList= ["select loan","Personal Loan","Business Loan", "Self-Employed Loan"];
  var leadLoanYearList= ["select year","1","3", "5","7","9", "12"];
  var leadLoanMonthList= ["select month","12", "15","20","25", "30"];
  var loanTextFieldList= [];
  var userLoanTextFieldList= [];
  var loan_type2="".obs;
  var tenure2="".obs;
  var month2 ="".obs;
  var user_loan_type="".obs;
  var user_tenure="".obs;
  var user_month ="".obs;
  RxList<Map> leadFieldList=<Map>[{
    "loan_type": null,
    "tenure": null,
    "month": null,
    "loan_amt": TextEditingController(),
    "roi": TextEditingController(),
  }].obs;
  addField(){
    leadFieldList.value.add({
      "loan_type": null,
      "tenure": null,
      "month": null,
      "loan_amt": TextEditingController(),
      "roi": TextEditingController(),
    });
    leadFieldList.refresh();
    update();
  }

  deleteField(int i){
    leadFieldList.value.removeAt(i);
    leadFieldList.refresh();
    update();
  }



  /// user loan lead
  List<String> userLoanTypeList = [];
  List<String> userLoanYearList = [];
  List<String> userLoanMonthList = [];
  List<String> userCompanyType = [];
  employeeRefreshList(){
    userLoanTypeList= ["select loan","Personal Loan","Business Loan", "Self-Employed Loan"];
    userLoanYearList= ["select year","1","3", "5","7","9", "12"];
    userLoanMonthList= ["select month","12", "15","20","25", "30"];
    userCompanyType= ["Private Limited","Public Limited", "Proprietorship", "Partnership", "LLP", "OPC", "NGO", "Government"];
    employeeCourseTypeList = ["Select Course Type", "MBA", "B.Tech", "M.Tech", "High School", "Graduation", "Masters", "Phd", "Certificate", "Diploma","Mca"];
    employeeGradeTypeList = ["Select Grade", "Garde A", "Grade B", "Grade C"];
    employeeCompanySizeList = ["Select Company Size","0-50","50-100","100-500","500-1000","1000-5000","Above 5000"];
    employeeExperienceJobLevelList = ["Select Job Level", "IT-Software", "Finance", "Operations", "Other"];
    employeeExperienceIndustryList = ["Select Industry", "Telecom", "ITES", "Plastics","Retail","Textile","Other"];
    functionUnitList = ["Administration", "Audit","Finance","Legal","Quality","Training"," IT-Software","IT-Network","Operations","Sales", "Marketing"];
    bandList = ["E1", "E2", "E3", "E4", "E5", "E6", "E7", "E8", "E9", "E10"];
  }
  RxList<Map> userFieldList=<Map>[{
    "loan_type": null,
    "tenure": null,
    "month": null,
    "loan_amt": TextEditingController(),
    "roi": TextEditingController(),
  }].obs;
  userAddField(){
    userFieldList.value.add({
      "loan_type": null,
      "tenure": null,
      "month": null,
      "loan_amt": TextEditingController(),
      "roi": TextEditingController(),
    });
    userFieldList.refresh();
    update();
  }
  userDeleteField(int i){
    userFieldList.value.removeAt(i);
    userFieldList.refresh();
    update();
  }

  /// customerLoanLeadNetworkApi integrate
  Future<bool> customerLoanLeadNetworkApi(loan_type, leadId, loanForType) async {
    userLoanTextFieldList.clear();
    for(var element in userFieldList.value) {
      userLoanTextFieldList.add({"loan_type": user_loan_type.value.toString(),"loan_amt":element["loan_amt"].text.toString(),
        "tenure": user_tenure.value.toString(), "month": user_month.value.toString(),"roi":element["roi"].text.toString()});
    }
    var bodyRequest = {
      if(loanForType=="myLoan")
      "tbl_custID": storage.read(AppConstant.id).toString().trim(),
      if(loanForType=="userLoan")
      "tbl_custID": storage.read(AppConstant.create_id).toString().trim(),
      if(loanForType=="myLoan")
        if(GetStorage().read(AppConstant.pId)!=""&&GetStorage().read(AppConstant.pId)!=null)
        "lead_source": storage.read(AppConstant.cust_id).toString().trim(),
      if(loanForType=="myLoan")
        if(GetStorage().read(AppConstant.pId)==""||GetStorage().read(AppConstant.pId)==null)
          "lead_source": "",
      if(loanForType=="userLoan")
        "lead_source": storage.read(AppConstant.cust_id).toString().trim(),
      "lead_type": loan_type,
      "loan_amount": "${currentSliderValue.value}00000",
      "loan_turner": "${loanTenure.value} year",
      "cust_company": etCompanyName.text,
      "cust_company_type":  companyType.value,
      "cust_active_loan": jsonEncode(userLoanTextFieldList),
      "cust_net_salary": etMonthlyAmount.text,
      "lead_id": "",
    };
    print("request ==========>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.CUSTOMER_LOAN_LEAD, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==============>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.loan_id, jsonDecode(response)["data"]["id"]??"");
      userLoanLeadId.value = "${jsonDecode(response)["data"]["id"]??""}";
      BaseController().successSnack(jsonDecode(response)["message"]??"");
      currentSliderValue.value=1;
      loanTenure.value=1;
      companyType.value = "Select Company";
      etCompanyName.clear();
      etMonthlyAmount.clear();
      userFieldList.value.clear();
      userFieldList.value.add({
        "loan_type": null,
        "tenure": null,
        "month": null,
        "loan_amt": TextEditingController(),
        "roi": TextEditingController(),
      });
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// leadCustomerLoanLeadNetworkApi integrate
  Future<bool> leadCustomerLoanLeadNetworkApi(loan_type) async {
    loanTextFieldList.clear();
    for(var element in leadFieldList.value) {
      loanTextFieldList.add({"loan_type":loan_type2.value.toString(),"loan_amt":element["loan_amt"].text.toString(),"tenure":tenure2.value.toString(),
        "month":month2.value.toString(),"roi":element["roi"].text.toString()});
    }
    print("lead rxFieldList ====>>> $loanTextFieldList");
    var bodyRequest = {
      "tbl_custID": storage.read(AppConstant.lead_id).toString().trim(),
      "lead_source": storage.read(AppConstant.create_cust_id).toString().trim(),
      "lead_type": loan_type,
      "loan_amount": "${currentSliderValue.value}00000",
      "loan_turner": "${loanTenure.value} year",
      "cust_company": leadCompanyName.text,
      "cust_company_type":  companyType.value,
      "cust_net_salary": leadMonthlyAmount.text,
      "cust_active_loan": jsonEncode(loanTextFieldList),
    };
    print("request ==========>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.CUSTOMER_LOAN_LEAD, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==============>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.lead_loan_id, "${jsonDecode(response)["data"]["id"]??""}");
      leadCompanyName.clear();
      companyType.value = "Select Company";
      leadMonthlyAmount.clear();
      loanTextFieldList=[];
      leadFieldList.clear();
      leadFieldList.value.add({
        "loan_type": null,
        "tenure": null,
        "month": null,
        "loan_amt": TextEditingController(),
        "roi": TextEditingController(),
      });
      BaseController().successSnack(jsonDecode(response)["message"]??"");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// upload  document all images
  RxString leadProfileSelfie = "".obs;
  RxString panCardImage = "".obs;
  RxString aadhaarCardImage = "".obs;
  RxString salarySlipsImage = "".obs;
  RxString bankStatementImage = "".obs;
  RxString ownerShipProof = "".obs;
  RxString relationshipProof = "".obs;
  RxString leadProfileSelfieName = "".obs;
  RxString panCardImageName = "".obs;
  RxString aadhaarCardImageName = "".obs;
  RxString salarySlipsImageName = "".obs;
  RxString bankStatementImageName = "".obs;
  RxString ownerShipProofName = "".obs;
  RxString relationshipProofName = "".obs;

  /// document image choose
  Future documentImages(bool isCamera, type) async {
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
            salarySlipsImage.value = pickedFile.path;
            salarySlipsImageName.value = pickedFile.name.toString();
            print("Salary Slips ${File(salarySlipsImage.value)}");
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
          case 7:
            leadProfileSelfie.value = pickedFile.path;
            leadProfileSelfieName.value = pickedFile.name.toString();
            print("Relationship ${File(leadProfileSelfie.value)}");
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
  Future<bool> uploadDocumentNetworkApi(proofType, ownerType) async {
    var bodyRequest = {
      "id": storage.read(AppConstant.loan_id).toString().trim(),
      "address_proof_type": "${proofType??"owned"}",
      "property_owner_type": ownerType.toString(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().userDocumentUploadPost("${AppConstants.UPLOAD_DOCUMENT_API}?customer_id=${storage.read(AppConstant.create_cust_id).toString().trim()}",
      bodyRequest, leadProfileSelfie.value, panCardImage.value, aadhaarCardImage.value, salarySlipsImage.value, bankStatementImage.value,
      genderValue.value=="My Proof"||genderValue.value=="Family Proof"?ownerShipProof.value:"",genderValue.value=="Family Proof"? relationshipProof.value:"",)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.remove(AppConstant.lead_id);
      storage.remove(AppConstant.lead_cust_id);
      storage.remove(AppConstant.create_id);
      storage.remove(AppConstant.create_cust_id);
      leadProfileSelfie.value="";
      panCardImage.value="";
      aadhaarCardImage.value="";
      salarySlipsImage.value="";
      bankStatementImage.value="";
      ownerShipProof.value="";
      relationshipProof.value="";
      leadProfileSelfieName.value="";
      panCardImageName.value="";
      aadhaarCardImageName.value="";
      salarySlipsImageName.value="";
      bankStatementImageName.value="";
      ownerShipProofName.value="";
      relationshipProofName.value="";
      loanTextFieldList.clear();
      etCompanyName.clear();
      etMonthlyAmount.clear();
      gender.value ="Select Gender";
      companyType.value = "IT Company";
      maritalStatus.value = "Select Marital";
      highestQualification.value = "Select Qualification";
      loanTextFieldList=[];
      currentSliderValue.value=1;
      loanTenure.value=1;
      companyType.value = "Select Company";
      etCompanyName.clear();
      etMonthlyAmount.clear();
      userFieldList.value.clear();
      userFieldList.value.add({
        "loan_type": null,
        "tenure": null,
        "month": null,
        "loan_amt": TextEditingController(),
        "roi": TextEditingController(),
      });
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// leadUploadDocumentNetworkApi integrate
  Future<bool> leadUploadDocumentNetworkApi(proofType, ownerType) async {
    var bodyRequest = {
      "id": storage.read(AppConstant.lead_loan_id).toString().trim(),
      "address_proof_type": proofType.toString(),
      "property_owner_type": ownerType.toString(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().userDocumentUploadPost("${AppConstants.UPLOAD_DOCUMENT_API}?customer_id=${storage.read(AppConstant.lead_cust_id).toString().trim()}",
      bodyRequest, leadProfileSelfie.value, panCardImage.value, aadhaarCardImage.value, salarySlipsImage.value, bankStatementImage.value, ownerShipProof.value, relationshipProof.value,)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      leadProfileSelfie.value="";
      panCardImage.value="";
      aadhaarCardImage.value="";
      salarySlipsImage.value="";
      bankStatementImage.value="";
      ownerShipProof.value="";
      relationshipProof.value="";
      panCardImageName.value="";
      leadProfileSelfieName.value="";
      aadhaarCardImageName.value="";
      salarySlipsImageName.value="";
      bankStatementImageName.value="";
      ownerShipProofName.value="";
      relationshipProofName.value="";
      loanTextFieldList.clear();
      leadCompanyName.clear();
      leadMonthlyAmount.clear();
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

  /// uploadSelfieNetworkApi integrate
  Future<bool> uploadSelfieNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().selfieUpload("${AppConstants.UPLOAD_SELFIE}?customer_id=${storage.read(AppConstant.cust_id).toString().trim()}", profileImg.value)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // storage.write(AppConstant.id, "${jsonDecode(response)["data"]["id"]??""}");
      // storage.write(AppConstant.cust_id, "${jsonDecode(response)["data"]["cust_id"]??""}");
      // storage.write(AppConstant.profile, jsonDecode(response)["data"]["cust_profile_pic"]??"");
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      profileImg.value = "";
      etName.clear();
      etDob.clear();
      etEmail.clear();
      etPanCard.clear();
      etNumber.clear();
      etPassword.clear();
      gender.value ="Select Gender";
      companyType.value = "IT Company";
      maritalStatus.value = "Select Marital Status";
      highestQualification.value = "Select Qualification";
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// leadUploadSelfieNetworkApi integrate
  Future<bool> leadUploadSelfieNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().selfieUpload("${AppConstants.UPLOAD_SELFIE}?customer_id=${storage.read(AppConstant.lead_cust_id).toString().trim()}", profileImg.value)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.lead_id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.lead_cust_id, "${jsonDecode(response)["data"]["cust_id"]??""}");
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      profileImg.value = "";
      etName.clear();
      etDob.clear();
      etEmail.clear();
      etPanCard.clear();
      etNumber.clear();
      etPassword.clear();
      gender.value ="Select Gender";
      companyType.value = "IT Company";
      maritalStatus.value = "Select Marital Status";
      highestQualification.value = "Select Qualification";
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// getUserPermissionNetworkApi integrate
  Future<bool> getUserPermissionNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().get("${AppConstants.GET_USER_PERMISSION}?customer_id=${storage.read(AppConstant.cust_id).toString().trim()}")
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

  /// getMyLeadNetworkApi api integrate
  var get_my_lead_model = GetMyLeadModel(data: MyLeadData(allLead: [], counts: [])).obs;
  RxBool get_my_lead_loader = false.obs;
  ScrollController myLeadController = ScrollController();
  int myLeadNext = 10;
  Future<bool> getMyLeadNetworkApi(date, monthYear,lead_type, custPan, custMobile, leadOwnerPan, leadOwnerPhone, leadStatus)
  async {
    Get.context!.loaderOverlay.show();
    get_my_lead_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_MY_LEAD}?cust_pan=$custPan&limit=$myLeadNext&page=0&lead_status=$leadStatus&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&date=$date&lead_type=$lead_type&monthyear=$monthYear&customer_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    get_my_lead_loader.value=true;
    Get.context!.loaderOverlay.hide();
    print("response >>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["allLead"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          get_my_lead_model.value = getMyLeadModelFromJson(response);
          get_my_lead_model.refresh();
          update();
        }
        else{
          get_my_lead_model.value = getMyLeadModelFromJson(response);
          get_my_lead_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    get_my_lead_model.value = getMyLeadModelFromJson(response);
    get_my_lead_model.refresh();
    update();
    return false;
  }

  myLeadsPagination() async {
    myLeadController.addListener(() {
      if (myLeadController.position.maxScrollExtent == myLeadController.position.pixels) {
        myLeadNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          getMyLeadNetworkApi("","",partnerController.loanTypeDecode(selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(selectStageType.value));
        }
      }
    });
  }

  /// freshLeadNetworkApi api integrate
  var fresh_lead_model = FreshLeadModel(data: FreshData(freshLead: [])).obs;
  RxBool fresh_lead_loader = false.obs;
  Future<bool> freshLeadNetworkApi() async {
    print("customer id ${storage.read(AppConstant.cust_id).toString().trim()}");
    Get.context!.loaderOverlay.show();
    // fresh_lead_loader.value=false;
    var response = await BaseClient().get("${AppConstants.FRESH_LEAD}?lead_source=${storage.read(AppConstant.cust_id).toString().trim()}&limit=20&page=0").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    // fresh_lead_loader.value=true;
    print("response >>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // BaseController().successSnack(jsonDecode(response)["message"]);
      fresh_lead_model.value = freshLeadModelFromJson(response);
      fresh_lead_model.refresh();
      update();
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    fresh_lead_model.value = freshLeadModelFromJson(response);
    fresh_lead_model.refresh();
    update();
    return false;
  }

  /// click event to call dail keyboard
  launchCaller() async {
    const url = "tel: 8928515699";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// upload  document all images
  RxString kPassportImage = "".obs;
  RxString kPANImage = "".obs;
  RxString kAadhaarCardImage = "".obs;
  RxString kSalarySlipsImage = "".obs;
  RxString kBankStatementImage = "".obs;
  RxString k10THMarksheetImage = "".obs;
  RxString kGraduationImage = "".obs;
  RxString kMasterImage = "".obs;
  RxString kCertificateImage = "".obs;
  RxString kAppointmentFormImage = "".obs;
  RxString kAppointmentLatterImage = "".obs;
  RxString kOwnerShipProof = "".obs;
  RxString kRealAgreeProof = "".obs;
  RxString kRelationshipProof = "".obs;
  /// upload document name
  RxString kPassportImageName = "".obs;
  RxString kPANImageName = "".obs;
  RxString kAadhaarCardImageName = "".obs;
  RxString kSalarySlipsImageName = "".obs;
  RxString kBankStatementImageName = "".obs;
  RxString k10THMarksheetImageName = "".obs;
  RxString kGraduationImageName = "".obs;
  RxString kMasterImageName = "".obs;
  RxString kCertificateImageName = "".obs;
  RxString kAppointmentFormImageName = "".obs;
  RxString kAppointmentLatterImageName = "".obs;
  RxString kOwnerShipProofName = "".obs;
  RxString kRealAgreeProofName = "".obs;
  RxString kRelationshipProofName = "".obs;

  /// document image choose
  Future KYCDocumentImages(bool isCamera, type) async {
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
            kPassportImage.value = pickedFile.path;
            kPassportImageName.value = pickedFile.name.toString();
            print("Pan Card ${File(panCardImage.value)}");
            break;
          case 2:
            kPANImage.value = pickedFile.path;
            kPANImageName.value = pickedFile.name.toString();
            print("Aadhaar Card ${File(aadhaarCardImage.value)}");
            break;
          case 3:
            kAadhaarCardImage.value = pickedFile.path;
            kAadhaarCardImageName.value = pickedFile.name.toString();
            print("Salary Slips ${File(salarySlipsImage.value)}");
            break;
          case 4:
            kSalarySlipsImage.value = pickedFile.path;
            kSalarySlipsImageName.value = pickedFile.name.toString();
            print("Bank Statement ${File(bankStatementImage.value)}");
            break;
          case 5:
            kBankStatementImage.value = pickedFile.path;
            kBankStatementImageName.value = pickedFile.name.toString();
            print("Ownership ${File(ownerShipProof.value)}");
            break;
          case 6:
            k10THMarksheetImage.value = pickedFile.path;
            k10THMarksheetImageName.value = pickedFile.name.toString();
            print("Relationship ${File(relationshipProof.value)}");
            break;
          case 7:
            kGraduationImage.value = pickedFile.path;
            kGraduationImageName.value = pickedFile.name.toString();
            print("Relationship ${File(relationshipProof.value)}");
            break;
          case 8:
            kMasterImage.value = pickedFile.path;
            kMasterImageName.value = pickedFile.name.toString();
            print("Relationship ${File(relationshipProof.value)}");
            break;
          case 9:
            kCertificateImage.value = pickedFile.path;
            kCertificateImageName.value = pickedFile.name.toString();
            print("Relationship ${File(relationshipProof.value)}");
            break;
          case 10:
            kAppointmentFormImage.value = pickedFile.path;
            kAppointmentFormImageName.value = pickedFile.name.toString();
            print("Relationship ${File(relationshipProof.value)}");
            break;
          case 11:
            kAppointmentLatterImage.value = pickedFile.path;
            kAppointmentLatterImageName.value = pickedFile.name.toString();
            print("Relationship ${File(relationshipProof.value)}");
            break;
          case 12:
            kOwnerShipProof.value = pickedFile.path;
            kOwnerShipProofName.value = pickedFile.name.toString();
            print("Relationship ${File(relationshipProof.value)}");
            break;
          case 13:
            kRealAgreeProof.value = pickedFile.path;
            kRealAgreeProofName.value = pickedFile.name.toString();
            print("Relationship ${File(relationshipProof.value)}");
            break;
          case 14:
            kRelationshipProof.value = pickedFile.path;
            kRelationshipProofName.value = pickedFile.name.toString();
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

  /// addEmployeeDocumentNetworkApi integrate
  Future<bool> addEmployeeDocumentNetworkApi(type,ownerType, addressProof) async {
    var bodyRequest = {
      "tbl_EmpID": storage.read(AppConstant.emp_id).toString().trim(),
      "emp_save_type": type.toString(),
      "property_owner_type": ownerType.toString(),
      "address_proof_type": addressProof.toString(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().empDocumentUploadPost("${AppConstants.EMP_DOCUMENT_UPLOAD}?eid=${storage.read(AppConstant.emp_eId).toString().trim()}",
      bodyRequest, kPassportImage.value, kPANImage.value, kAadhaarCardImage.value, kSalarySlipsImage.value, kBankStatementImage.value,
      k10THMarksheetImage.value, kGraduationImage.value, kMasterImage.value, kCertificateImage.value, kAppointmentFormImage.value,
      kAppointmentLatterImage.value, kRealAgreeProof.value, kOwnerShipProof.value, kRelationshipProof.value,
    ).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      kPassportImage.value = "";
      kPANImage.value = "";
      kAadhaarCardImage.value = "";
      kSalarySlipsImage.value = "";
      kBankStatementImage.value = "";
      k10THMarksheetImage.value = "";
      kGraduationImage.value = "";
      kMasterImage.value = "";
      kCertificateImage.value = "";
      kAppointmentFormImage.value = "";
      kAppointmentLatterImage.value = "";
      kOwnerShipProof.value = "";
      kRealAgreeProof.value = "";
      kRelationshipProof.value = "";
      kPassportImageName.value = "";
      kPANImageName.value = "";
      kAadhaarCardImageName.value = "";
      kSalarySlipsImageName.value = "";
      kBankStatementImageName.value = "";
      k10THMarksheetImageName.value = "";
      kGraduationImageName.value = "";
      kMasterImageName.value = "";
      kCertificateImageName.value = "";
      kAppointmentFormImageName.value = "";
      kAppointmentLatterImageName.value = "";
      kOwnerShipProofName.value = "";
      kRealAgreeProofName.value = "";
      kRelationshipProofName.value = "";
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// add employee education test form field
  var educationTextFieldList= [];
  var emp_course_type="Select Course Type".obs;
  var emp_grade="Select Grade".obs;
  var emp_add_course_type="".obs;
  var emp_add_grade="".obs;
  var emp_start_date="".obs;
  var emp_end_date="".obs;
  List<String> employeeCourseTypeList = [];
  List<String> employeeGradeTypeList = [];
  List<String> employeeCompanySizeList = [];
  List<String> employeeExperienceJobLevelList = [];
  List<String> employeeExperienceIndustryList = [];
  RxList<Map> educationFieldList=<Map>[{
    "emp_course_name": TextEditingController(),
    "emp_institute_name":  TextEditingController(),
    "emp_course_type": null,
    "emp_course_grade": TextEditingController(),
    "emp_course_start": TextEditingController(),
    "emp_course_end": TextEditingController(),
    "emp_skills": TextEditingController(),
  }].obs;
  educationAddField(){
    educationFieldList.value.add({
      "emp_institute_name":  TextEditingController(),
      "emp_course_name": TextEditingController(),
      "emp_course_type": null,
      "emp_course_start": TextEditingController(),
      "emp_course_end": TextEditingController(),
      "emp_course_grade": TextEditingController(),
      "emp_skills": TextEditingController(),
    });
    educationFieldList.refresh();
    update();
  }
  educationDeleteField(int i){
    educationFieldList.value.removeAt(i);
    educationFieldList.refresh();
    update();
  }

  /// add employee experience text form field
  var experienceTextFieldList= [];
  var emp_function="Select Job Level".obs;
  var emp_industry="Select Industry".obs;
  var emp_company_size ="Select Company Size".obs;
  var emp_add_function="".obs;
  var emp_add_industry="".obs;
  var emp_add_company_size ="".obs;
  var emp_join_start_date ="".obs;
  var emp_join_end_date ="".obs;
  RxList<Map> experienceFieldList=<Map>[{
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
  experienceAddField(){
    experienceFieldList.value.add({
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
    experienceFieldList.refresh();
    update();
  }
  experienceDeleteField(int i){
    experienceFieldList.value.removeAt(i);
    experienceFieldList.refresh();
    update();
  }

  var add_emp_about_data = AddEmpAboutModel(data: AboutData(counts: [], allLead: [])).obs;
  var socialMedia=[];
  Future<bool> addEmployeeAboutNetworkApi(type) async {
    socialMedia.clear();
    socialMedia.add({"fb": emp_facebook.text});
    socialMedia.add({"insta": emp_facebook.text},);
    socialMedia.add({"twitter": emp_linkedin.text});
    educationTextFieldList.clear();
    for(var element in educationFieldList.value) {
      educationTextFieldList.add({
        "emp_institute_name":  element["emp_institute_name"].text.toString(),
        "emp_course_name": element["emp_course_name"].text.toString(),
        "emp_course_type": emp_add_course_type.value=="Select Course Type"?"":emp_add_course_type.value,
        "emp_course_start": element["emp_course_start"].text.toString(),
        "emp_course_end": element["emp_course_end"].text.toString(),
        "emp_course_grade": element["emp_course_grade"].text.toString(),
        // "emp_course_grade": emp_add_grade.value=="Select Grade"?"":emp_add_grade.value,
        "emp_skills": element["emp_skills"].text.toString(),
      });
    }
    experienceTextFieldList.clear();
    for(var element in experienceFieldList.value) {
      experienceTextFieldList.add({
        "emp_designation":  element["emp_designation"].text.toString(),
        "emp_company": element["emp_company"].text.toString(),
        "emp_function": emp_add_function.value=="Select Job Level"?"":emp_add_function.value,
        "emp_industry": emp_add_industry.value=="Select Job Level"?"":emp_add_industry.value,
        "emp_company_size": emp_add_company_size.value=="Select Company Size"?"":emp_add_company_size.value,
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
      "emp_gender": emp_gender.value.toString(),
      "emp_marital_status": emp_marital_status.value.toString(),
      "emp_education": emp_highest_qualification.value.toString(),
      "emp_phone": emp_phone.text,
      "emp_email": emp_email.text,
      "emp_social": json.encode(socialMedia),
      "emp_present_address_pin": emp_present_address_pin.text,
      "emp_present_address": emp_present_address.text,
      "education": jsonEncode(educationTextFieldList),
      "experience": jsonEncode(experienceTextFieldList),
      "emp_save_type": type.toString(),
      "emp_password": emp_password.text,
      "emp_source_id": storage.read(AppConstant.cust_id).toString().trim(),
    };

    print("body request ==========>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.EMPLOYEE_REGISTER, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response >>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("Employee Register ${jsonDecode(response)["message"]??""}");
      storage.write(AppConstant.emp_id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.emp_eId, "${jsonDecode(response)["data"]["eid"]??""}");
      add_emp_about_data.value = addEmpAboutModelFromJson(response);
      emp_fName.clear();
      emp_lName.clear();
      emp_dob.clear();
      emp_phone.clear();
      emp_email.clear();
      emp_facebook.clear();
      emp_linkedin.clear();
      emp_present_address_pin.clear();
      emp_present_address.clear();
      emp_password.clear();
      educationTextFieldList.clear();
      experienceTextFieldList.clear();
      educationFieldList.clear();
      experienceFieldList.clear();
      educationFieldList.value.add({
          "emp_institute_name":  TextEditingController(),
          "emp_course_name": TextEditingController(),
          "emp_course_type": null,
          "emp_course_start": TextEditingController(),
          "emp_course_end": TextEditingController(),
          "emp_course_grade": TextEditingController(),
          "emp_skills": TextEditingController(),
      });
      experienceFieldList.value.add({
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
      selectCountry=null;
      selectState=null;
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// addEmployeeKYCNetworkApi api integrate
  var add_emp_kyc_data = AddEmpKycModel(data: KYCData(educationList: [], experienceList: [])).obs;
  Future<bool> addEmployeeKYCNetworkApi(type) async {
    var bodyRequest = {
      "tbl_EmpID": storage.read(AppConstant.emp_id).toString().trim(),
      "emp_aadhar": kAadhaarCard.text.toString(),
      "emp_pan": kPanCard.text.toString(),
      "emp_save_type": type.toString(),
    };
    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.EMPLOYEE_KYC, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      add_emp_kyc_data.value = addEmpKycModelFromJson(response);
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      kAadhaarCard.clear();
      kPanCard.clear();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// employeePayrollNetworkApi api integrate
  Future<bool> employeePayrollNetworkApi(type, supId) async {
    var bodyRequest = {
      "tbl_EmpID": storage.read(AppConstant.emp_id).toString().trim(),
      "emp_save_type": type.toString(),
      "sup_id": supId.toString(),
      "emp_designation": pDesignation.text,
      "emp_function": pFunctionUnit.value,
      "emp_band": pBrand.value,
      "emp_join_date": pJoiningDate.text,
      "emp_join_salary": pJoiningSalary.text,
      "emp_present_salary": pPresentSalary.text,
      "emp_resign_date": pResignDate.text,
      "emp_last_working_date": pLastWorkingDate.text,
      "emp_reliving_date": pRelivingDate.text,
    };
    print("body request ==================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.EMPLOYEE_PAYROLL, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response =================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      pSupervisorId.clear();
      pDesignation.clear();
      pFunctionUnit.value = "";
      pBrand.value = "";
      pJoiningDate.clear();
      pJoiningSalary.clear();
      pPresentSalary.clear();
      pResignDate.clear();
      pLastWorkingDate.clear();
      pRelivingDate.clear();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// employeeAccessNetworkApi api integrate
  var emp_access_data = AddEmpKycModel(data: KYCData(educationList: [], experienceList: [])).obs;
  String employeeCompleteIdUpdate = "";
  Future<bool> employeeAccessNetworkApi(type) async {
    var bodyRequest = {
      "gUserID": storage.read(AppConstant.emp_eId)??"",
      "access_change_by": storage.read(AppConstant.cust_id)??"",
      "emp_save_type": type.toString(),
      "emp_view_all": empViewAll.value.toString(),
      "add_emp": addEMP.value.toString(),
      "update_emp": updateEMP.value.toString(),
      "emp_push_back": empPushBack.value.toString(),
      "emp_approve": empApprove.value.toString(),
      "partner_view_all": partnerViewAll.value.toString(),
      "partner_add": partnerAdd.value.toString(),
      "partner_update": partnerUpdate.value.toString(),
      "partner_push_back": partnerPushBack.value.toString(),
      "partner_pending_approval": partnerPendingApproval.value.toString(),
      "unassigned_leads": unassignedLeads.value.toString(),
      "assign_all_lead": assignAllLead.value.toString(),
      "assign_my_lead": assignMyLead.value.toString(),
      "assign_myteam_lead": assignMyTeamLead.value.toString(),
      "assign_mypartner_lead": assignMyPartnerLead.value.toString(),
      "add_lead": addLead.value.toString(),
      "my_lead": myLead.value.toString(),
      "myteam_lead": myTeamLead.value.toString(),
      "mypartner_lead": myPartnerLead.value.toString(),
      "all_cust": AllCust.value.toString(),
      "my_cust": myCust.value.toString(),
      "myteam_cust": myTeamCust.value.toString(),
      "mypartner_cust": myPartnerCust.value.toString(),
      "my_sales": mySales.value.toString(),
      "incentive_mgmt_view": incentiveMGMTView.value.toString(),
      "incentive_mgmt_edit": incentiveMGMTEdit.value.toString(),
      "apply_self_loan": applySelfLoan.value.toString(),
      "emp_pending_approval": empPendingApprove.value.toString(),
      "assignement_change_approval": assignmentChangeApproval.value.toString(),
      "panel_manage_customer": panelManageCustomer.value.toString(),
      "panel_manage_partner": panelManagePartner.value.toString(),
      "panel_manage_employee": panelManageEmployee.value.toString(),
      "new_lead_tab" : NewLeadTab.value,
      "verification_lead_tab" : VerificationTab.value,
      "disbursed_lead_tab" : DisbursedTab.value,
      "incentive_lead_tab" : IncentiveTab.value,
    };

    print("body request ==================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.EMPLOYEE_ACCESS, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response =================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // storage.write(AppConstant.eId, jsonDecode(response)["data"]["eid"]??"");
      employeeCompleteIdUpdate = "${jsonDecode(response)["data"]["user_id"]}";
      print("ss ${employeeCompleteIdUpdate.toString()} jjagbs  ${jsonDecode(response)["data"]["user_id"]}");
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// teamLeadsNetworkApi api integrate
  var team_leads_model = TeamLeadsModel(data: TeamLeadData(counts: [], teamLead: [])).obs;
  RxBool team_leads_loader = false.obs;
  ScrollController teamLeadsController = ScrollController();
  int teamLeadsNext = 10;
  Future<bool> teamLeadsNetworkApi(date,monthYear,lead_type, custPan, custMobile, leadOwnerPan, leadOwnerPhone, leadStatus, empType, listType,directIndirect)
  async {
    Get.context!.loaderOverlay.show();
    team_leads_loader.value=false;
    var response;
    if(empType=="employee"||empType=="partner"){
      response = await BaseClient().get(
          "${AppConstants.TEAM_LEAD}?cust_pan=$custPan&cust_mob=$custMobile&lead_status=${leadStatus=="All Stage"?"":leadStatus}&cust_list_type=$directIndirect&lead_owner_pan=$leadOwnerPan&"
              "lead_owner_phone=$leadOwnerPhone&page=0&limit=$teamLeadsNext&lead_type=$lead_type&date=$date&monthyear=$monthYear&"
              "cust_id=${storage.read(AppConstant.cust_id).toString().trim()}&emp_type=$empType&list_type=$listType").catchError(BaseController().handleError);
    }else{
      response = await BaseClient().get(
        "${AppConstants.TEAM_LEAD}?cust_pan=$custPan&cust_mob=$custMobile&lead_status=$leadStatus&cust_list_type=$directIndirect&lead_owner_pan=$leadOwnerPan&"
            "lead_owner_phone=$leadOwnerPhone&page=0&limit=$teamLeadsNext&lead_type=$lead_type&date=$date&monthyear=$monthYear&"
            "cust_id=${storage.read(AppConstant.cust_id).toString().trim()}&emp_type=$empType").catchError(BaseController().handleError);
    }
    team_leads_loader.value=true;
    Get.context!.loaderOverlay.hide();
    print("response ===============>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["teamLead"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          team_leads_model.value = teamLeadsModelFromJson(response);
          team_leads_model.refresh();
          update();
        }
        else{
          team_leads_model.value = teamLeadsModelFromJson(response);
          team_leads_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    team_leads_model.value = teamLeadsModelFromJson(response);
    team_leads_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  teamLeadsPagination() async {
    teamLeadsController.addListener(() {
      if (teamLeadsController.position.maxScrollExtent == teamLeadsController.position.pixels) {
        teamLeadsNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          teamLeadsNetworkApi("","",partnerController.loanTypeDecode(selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(selectStageType.value),partnerController.sourceFilterSendValue(filterTypeSelected.value.toString()),partnerController.leadStatusNameFilter(isTeamLeadEmpSelected.value),partnerController.leadStatusNameFilter(selectEmployeePartnerValue.value));
        }
      }
    });
  }


  /// unassignedNetworkApi api integrate
  var unassigned_model = UnassignedModel(data: UnassignedData(unasignLeade: [])).obs;
  RxBool unassigned_loader = false.obs;
  ScrollController unassignedLeadController = ScrollController();
  int unassignedLeadNext = 10;
  Future<bool> unassignedNetworkApi(date,monthYear,lead_type, custPan, custMobile, leadStatus, leadOwnerPan, leadOwnerPhone)
  async {
    unassigned_model.value.data.unasignLeade.clear();
    Get.context!.loaderOverlay.show();
    // unassigned_loader.value=false;
    var response = await BaseClient().get("${AppConstants.UNASSIGN_LEAD}?cust_pan=$custPan&cust_mob=$custMobile&lead_status=$leadStatus&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&page=0&limit=$unassignedLeadNext&lead_type=$lead_type&date=$date&monthyear=$monthYear").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    // unassigned_loader.value=true;
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["unasignLeade"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          unassigned_model.value = unassignedModelFromJson(response);
          unassigned_model.refresh();
          update();
        }
        else{
          unassigned_model.value = unassignedModelFromJson(response);
          unassigned_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    unassigned_model.value = unassignedModelFromJson(response);
    unassigned_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  unassignedLeadPagination() async {
    unassignedLeadController.addListener(() {
      if (unassignedLeadController.position.maxScrollExtent == unassignedLeadController.position.pixels) {
        unassignedLeadNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          unassignedNetworkApi("","","","","","","","");
        }
      }
    });
  }

  /// employeeApproveNetworkApi api integrate
  var employee_approve_model = EmployeeApproveModel(data: EMPApproveData(empdata: [])).obs;
  RxBool employee_approve_loader = false.obs;
  Future<bool> employeeApproveNetworkApi(BuildContext context) async {
    // employee_approve_model.value.data.empdata.clear();
    employee_approve_loader.value=false;
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().get("${AppConstants.EMPLOYEE_APPROVE}?limit=${50}&page=0&emp_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    employee_approve_loader.value=true;
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // BaseController().successSnack(context, jsonDecode(response)["message"]);
      employee_approve_model.value = employeeApproveModelFromJson(response);
      employee_approve_model.refresh();
      update();
      return true;
    }
    employee_approve_model.value = employeeApproveModelFromJson(response);
    employee_approve_model.refresh();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// getMyTeamNetworkApi api integrate
  var my_team_model = MyTeamLeadsModel(data: [], empList: []).obs;
  RxBool my_team_loader = false.obs;
  var selectedMyTeamFilter = "All Member".obs;
  Future<bool> getMyTeamNetworkApi(custType, custListType,directIndirect) async {
    Get.context!.loaderOverlay.show();
    my_team_loader.value=false;
    var response;
    if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")==true){
      response = await BaseClient().get("${AppConstants.GET_MY_TEAM}?cust_id=${storage.read(AppConstant.cust_id).toString().trim()}"
          "&cust_type=${custType=="All Member"?"":custType.toString().toLowerCase()}&cust_list_type=$directIndirect").catchError(BaseController().handleError);
    }else{
      response = await BaseClient().get("${AppConstants.GET_MY_TEAM}?cust_id=${storage.read(AppConstant.cust_id).toString().trim()}"
          "&cust_list_type=$custListType").catchError(BaseController().handleError);
    }
    my_team_loader.value=true;
    Get.context!.loaderOverlay.hide();
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // BaseController().successSnack(context, jsonDecode(response)["message"]);
      my_team_model.value = myTeamLeadsModelFromJson(response);
      my_team_model.refresh();
      update();
      return true;
    }
    my_team_model.value = myTeamLeadsModelFromJson(response);
    my_team_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// getMyCustNetworkApi api integrate
  var my_cust_model = MyCustModel(data: []).obs;
  RxBool my_cust_loader = false.obs;
  Future<bool> getMyCustNetworkApi(custListType, sourceType, loanType, custStatus,directIndirect) async {
    Get.context!.loaderOverlay.show();
    my_cust_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_MY_CUST}?cust_id=${storage.read(AppConstant.cust_id).toString().trim()}"
        "&page=0&limit=${50}&cust_list=$sourceType&cust_loan_type=$loanType&cust_status=$custStatus&cust_list_type=$directIndirect").catchError(BaseController().handleError);
    my_cust_loader.value=true;
    Get.context!.loaderOverlay.hide();
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // BaseController().successSnack(context, jsonDecode(response)["message"]);
      my_cust_model.value = myCustModelFromJson(response);
      my_cust_model.refresh();
      update();
      return true;
    }
    my_cust_model.value = myCustModelFromJson(response);
    my_cust_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// employeeRequestNetworkApi api integrate
  int approvedNext = 10;
  ScrollController approvedController = ScrollController();
  var employee_request_model = EmployeeRequestList(data: EmployeeRequestData(empdata: [])).obs;
  RxBool employee_request_loader = false.obs;
  Future<bool> employeeRequestNetworkApi() async {
    employee_request_model.value.data.empdata.clear();
    // Get.context!.loaderOverlay.show();
    employee_request_loader.value=false;
    var response = await BaseClient().get("${AppConstants.EMPLOYEE_REQUEST_LIST}?limit=$approvedNext&page=0&emp_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
    employee_request_loader.value=true;
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["empdata"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          // BaseController().successSnack(context, jsonDecode(response)["message"]);
          employee_request_model.value = employeeRequestListFromJson(response);
          employee_request_model.refresh();
          update();
        }
        else{
          // BaseController().successSnack(context, jsonDecode(response)["message"]);
          employee_request_model.value = employeeRequestListFromJson(response);
          employee_request_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    employee_request_model.value = employeeRequestListFromJson(response);
    employee_request_model.refresh();
    update();
    return false;
  }

  addItemsApprovedList() async {
    approvedController.addListener(() {
      if (approvedController.position.maxScrollExtent == approvedController.position.pixels) {
        approvedNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          employeeRequestNetworkApi();
        }
      }
    });
  }
  /// employeePushBACKNetworkApi api integrate
  ScrollController empPushBackController = ScrollController();
  int empPushbackNext = 10;
  var employee_push_back_model = EmployeePushBackModel(data: EmpPushBackData(empdata: [])).obs;
  RxBool employee_push_back_loader = false.obs;
  Future<bool> employeePushBACKNetworkApi() async {
    employee_push_back_model.value.data.empdata.clear();
    // Get.context!.loaderOverlay.show();
    employee_push_back_loader.value=false;
    var response = await BaseClient().get("${AppConstants.EMPLOYEE_PUSHBACK}?limit=$empPushbackNext&page=0&emp_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
    employee_push_back_loader.value=true;
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["empdata"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          // BaseController().successSnack(context, jsonDecode(response)["message"]);
          employee_push_back_model.value = employeePushBackModelFromJson(response);
          employee_push_back_model.refresh();
          update();
        }
        else{
          // BaseController().successSnack(context, jsonDecode(response)["message"]);
          employee_push_back_model.value = employeePushBackModelFromJson(response);
          employee_push_back_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    employee_push_back_model.value = employeePushBackModelFromJson(response);
    employee_push_back_model.refresh();
    update();
    return false;
  }

  addItemsEmpPushBackList() async {
    empPushBackController.addListener(() {
      if (empPushBackController.position.maxScrollExtent == empPushBackController.position.pixels) {
        empPushbackNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          employeePushBACKNetworkApi();
        }
      }
    });
  }

  /// allEmployeeNetworkApi api integrate
  ScrollController allEmployeeController = ScrollController();
  int allEmpNext = 10;
  var all_employee_model = AllEmployeeModel(data: AllEMPData(empdata: [])).obs;
  RxBool all_employee_loader = false.obs;
  Future<bool> allEmployeeNetworkApi() async {
    all_employee_model.value.data.empdata.clear();
    // Get.context!.loaderOverlay.show();
    all_employee_loader.value=false;
    var response = await BaseClient().get("${AppConstants.ALL_EMPLOYEE}?limit=$allEmpNext&page=0").catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
    all_employee_loader.value=true;
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["empdata"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          // BaseController().successSnack(context, jsonDecode(response)["message"]);
          all_employee_model.value = allEmployeeModelFromJson(response);
          all_employee_model.refresh();
          update();
        }
        else{
          // BaseController().successSnack(context, jsonDecode(response)["message"]);
          all_employee_model.value = allEmployeeModelFromJson(response);
          all_employee_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    all_employee_model.value = allEmployeeModelFromJson(response);
    all_employee_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  addItemsAllEmployeeList() async {
    allEmployeeController.addListener(() {
      if (allEmployeeController.position.maxScrollExtent == allEmployeeController.position.pixels) {
        allEmpNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          allEmployeeNetworkApi();
        }
      }
    });
  }

  /// employeeLoginNetworkApi integrate
  Future<bool> employeeLoginNetworkApi(BuildContext context,String value) async {
    var bodyRequest = {
      "emp_id": empID.text.toString(),
      "emp_password":  empPassword.text.toString(),
    };
    print("request ===============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.EMPLOYEE_LOGIN, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.name, "${jsonDecode(response)["data"][0]["emp_fname"]??""} ${jsonDecode(response)["data"][0]["emp_lname"]??""}");
      storage.write(AppConstant.id, jsonDecode(response)["data"][0]["id"]??"");
      storage.write(AppConstant.cust_id, jsonDecode(response)["data"][0]["eid"]??"");
      storage.write(AppConstant.email, jsonDecode(response)["data"][0]["emp_email"]??"");
      storage.write(AppConstant.profile, jsonDecode(response)["data"][0]["doc_profile_pic"]??"");
      storage.write(AppConstant.phone, jsonDecode(response)["data"][0]["emp_phone"]??"");
      storage.write(AppConstant.sup_id, jsonDecode(response)["data"][0]["sup_id"]??"");
      empID.clear();
      empPassword.clear();
      bool status = await controller.userPermissionNetworkApi(jsonDecode(response)["data"][0]["eid"].toString());
      if (status == true) {
        if(value=="userHome") {
          Get.offAll(() => const DashboardScreen());
          index.value=0;
          indexValue.value=1;
        }else if(value=="leadScreen") {
          Get.offAll(() => const DashboardScreen());
          index.value=1;
          screenValue.value=1;
          indexValue.value=1;
        }else if(value=="home") {
          Get.offAll(() => const DashboardScreen());
          index.value=0;
          indexValue.value = 1;
        }
      }
      BaseController().successSnack(jsonDecode(response)["message"]??"");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// newLeadsNetworkApi api integrate
  var new_leads_model = NewLeadsModel(data: NewLeadsData(newLeade: [])).obs;
  RxBool new_leads_loader = false.obs;
  ScrollController newLeadController = ScrollController();
  int newLeadNext = 10;
  Future<bool> newLeadsNetworkApi(date,monthYear,lead_type, custPan, custMobile, leadStatus, leadOwnerPan, leadOwnerPhone)
  async {
    new_leads_model.value.data.newLeade.clear();
    Get.context!.loaderOverlay.show();
    // new_leads_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_NEW_LEAD}?cust_pan=$custPan&cust_mob=$custMobile&lead_status=$leadStatus&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&page=0&limit=$newLeadNext&lead_type=$lead_type&date=$date&monthyear=$monthYear").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    // new_leads_loader.value=true;
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["newLeade"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          new_leads_model.value = newLeadsModelFromJson(response);
          new_leads_model.refresh();
          update();
        }
        else{
          new_leads_model.value = newLeadsModelFromJson(response);
          new_leads_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    new_leads_model.value = newLeadsModelFromJson(response);
    new_leads_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  newLeadPagination() async {
    newLeadController.addListener(() {
      if (newLeadController.position.maxScrollExtent == newLeadController.position.pixels) {
        newLeadNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          newLeadsNetworkApi("","","","","","","","");
        }
      }
    });
  }


  /// holdLeadsNetworkApi api integrate
  var hold_leads_model = HoldLeadsModel(data: HoldLeadsData(holdLeade: [])).obs;
  RxBool hold_leads_loader = false.obs;
  ScrollController holdLeadController = ScrollController();
  int holdLeadNext = 10;
  Future<bool> holdLeadsNetworkApi(date,monthYear,lead_type, custPan, custMobile, leadStatus, leadOwnerPan, leadOwnerPhone)
  async {
    hold_leads_model.value.data.holdLeade.clear();
    Get.context!.loaderOverlay.show();
    // hold_leads_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_HOLD_LEAD}?cust_pan=$custPan&cust_mob=$custMobile&lead_status=$leadStatus&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&page=0&limit=$holdLeadNext&lead_type=$lead_type&date=$date&monthyear=$monthYear").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    // hold_leads_loader.value=true;
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["holdLeade"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          hold_leads_model.value = holdLeadsModelFromJson(response);
          hold_leads_model.refresh();
          update();
        }
        else{
          hold_leads_model.value = holdLeadsModelFromJson(response);
          hold_leads_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    hold_leads_model.value = holdLeadsModelFromJson(response);
    hold_leads_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  holdLeadPagination() async {
    holdLeadController.addListener(() {
      if (holdLeadController.position.maxScrollExtent == holdLeadController.position.pixels) {
        holdLeadNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          holdLeadsNetworkApi("","","","","","","","");
        }
      }
    });
  }

  /// loginLeadsNetworkApi api integrate
  var login_leads_model = LoginLeadsModel(data: LoginLeadsData(loginLeade: [])).obs;
  RxBool login_leads_loader = false.obs;
  ScrollController loginLeadController = ScrollController();
  int loginLeadNext = 10;
  Future<bool> loginLeadsNetworkApi(date,monthYear,lead_type, custPan, custMobile, leadStatus, leadOwnerPan, leadOwnerPhone, leadStatusType, custType,directIndirect)
  async {
    Get.context!.loaderOverlay.show();
    login_leads_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_LOGIN_LEAD}?cust_pan=$custPan&cust_mob=$custMobile&lead_status="
        "$leadStatus&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&page=0&limit=$loginLeadNext&lead_type=$lead_type"
        "&date=$date&monthyear=$monthYear&cust_type=$custType&cust_list_type=$directIndirect&cust_lead_type=$leadStatusType"
        "&cust_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    login_leads_loader.value=true;
    Get.context!.loaderOverlay.hide();
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["loginLeade"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          login_leads_model.value = loginLeadsModelFromJson(response);
          login_leads_model.refresh();
          update();
        }
        else{
          login_leads_model.value = loginLeadsModelFromJson(response);
          login_leads_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    login_leads_model.value = loginLeadsModelFromJson(response);
    login_leads_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  loginLeadPagination() async {
    loginLeadController.addListener(() {
      if (loginLeadController.position.maxScrollExtent == loginLeadController.position.pixels) {
        loginLeadNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          loginLeadsNetworkApi("","","","","","","","",partnerController.leadStatusNameFilter(leadsPageName.value), partnerController.sourceFilterSendValue(filterTypeSelected.value),partnerController.leadStatusNameFilter(selectEmployeePartnerValue.value));
        }
      }
    });
  }

  /// verifiedLeadsNetworkApi api integrate
  var verified_leads_model = VerifiedLeadsModel(data: VerifiedLeadsData(verifiedLeade: [])).obs;
  RxBool verified_leads_loader = false.obs;
  ScrollController verifiedLeadController = ScrollController();
  int verifiedLeadNext = 10;
  Future<bool> verifiedLeadsNetworkApi(date,monthYear,lead_type, custPan, custMobile, leadStatus, leadOwnerPan, leadOwnerPhone)
  async {
    verified_leads_model.value.data.verifiedLeade.clear();
    Get.context!.loaderOverlay.show();
    // verified_leads_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_VERIFIED_LEAD}?cust_pan=$custPan&cust_mob=$custMobile&lead_status=$leadStatus&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&page=0&limit=$verifiedLeadNext&lead_type=$lead_type&date=$date&monthyear=$monthYear").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    // verified_leads_loader.value=true;
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["verifiedLeade"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          verified_leads_model.value = verifiedLeadsModelFromJson(response);
          verified_leads_model.refresh();
          update();
        }
        else{
          verified_leads_model.value = verifiedLeadsModelFromJson(response);
          verified_leads_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    verified_leads_model.value = verifiedLeadsModelFromJson(response);
    verified_leads_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  verifiedLeadPagination() async {
    verifiedLeadController.addListener(() {
      if (verifiedLeadController.position.maxScrollExtent == verifiedLeadController.position.pixels) {
        verifiedLeadNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          verifiedLeadsNetworkApi("","","","","","","","");
        }
      }
    });
  }

  /// sanctionedLeadsNetworkApi api integrate
  var sanctioned_leads_model = SanctionedLeadsModel(data: SanctionedLeadsData(sanctionedLeade: [])).obs;
  RxBool sanctioned_leads_loader = false.obs;
  ScrollController sanctionedLeadController = ScrollController();
  int sanctionedLeadNext = 10;
  Future<bool> sanctionedLeadsNetworkApi(date,monthYear,lead_type, custPan, custMobile, leadStatus, leadOwnerPan, leadOwnerPhone, custType, leadStatusType,directIndirect)
  async {
    // sanctioned_leads_model.value.data.sanctionedLeade.clear();
    Get.context!.loaderOverlay.show();
    // sanctioned_leads_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_SANCTIONED_LEAD}?cust_pan=$custPan&cust_mob=$custMobile&lead_status=$leadStatus&cust_list_type=$directIndirect"
        "&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&page=0&limit=$sanctionedLeadNext&lead_type=$lead_type&date=$date&monthyear=$monthYear"
        "&cust_id=${storage.read(AppConstant.cust_id)??""}&cust_type=$custType&cust_lead_type=$leadStatusType").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    // sanctioned_leads_loader.value=true;
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["sanctionedLeade"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          sanctioned_leads_model.value = sanctionedLeadsModelFromJson(response);
          sanctioned_leads_model.refresh();
          update();
        }
        else{
          sanctioned_leads_model.value = sanctionedLeadsModelFromJson(response);
          sanctioned_leads_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    sanctioned_leads_model.value = sanctionedLeadsModelFromJson(response);
    sanctioned_leads_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  sanctionedLeadPagination() async {
    sanctionedLeadController.addListener(() {
      if (sanctionedLeadController.position.maxScrollExtent == sanctionedLeadController.position.pixels) {
        sanctionedLeadNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          sanctionedLeadsNetworkApi("","","","","","","","",partnerController.leadStatusNameFilter(leadsPageName.value), partnerController.sourceFilterSendValue(filterTypeSelected.value),partnerController.leadStatusNameFilter(selectEmployeePartnerValue.value));
        }
      }
    });
  }

  /// disbursedLeadsNetworkApi api integrate
  var disbursed_data_model = IncDueLeadsModel(data: IncDueLeadsData(disbursedLeade: [])).obs;
  RxBool disbursed_data_loader = false.obs;
  ScrollController disbursedLeadController = ScrollController();
  int disbursedDataNext = 10;
  Future<bool> disbursedLeadsNetworkApi(date,monthYear,lead_type, custPan, custMobile, leadStatus, leadOwnerPan, leadOwnerPhone, custType, leadStatusType,directIndirect)
  async {
    // disbursed_data_model.value.data.loginLeade.clear();
    Get.context!.loaderOverlay.show();
    // disbursed_data_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_INC_DUE_LEAD}?cust_pan=$custPan&cust_mob=$custMobile&lead_status=$leadStatus&cust_list_type=$directIndirect"
        "&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&page=0&limit=$disbursedDataNext&lead_type=$lead_type&date=$date&monthyear=$monthYear"
        "&cust_id=${storage.read(AppConstant.cust_id)??""}&cust_type=$custType&cust_lead_type=$leadStatusType").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    // disbursed_data_loader.value=true;
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["disbursedLeade"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          disbursed_data_model.value = incDueLeadsModelFromJson(response);
          disbursed_data_model.refresh();
          update();
        }
        else{
          disbursed_data_model.value = incDueLeadsModelFromJson(response);
          disbursed_data_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    disbursed_data_model.value = incDueLeadsModelFromJson(response);
    disbursed_data_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  incDueLeadPagination() async {
    disbursedLeadController.addListener(() {
      if (disbursedLeadController.position.maxScrollExtent == disbursedLeadController.position.pixels) {
        disbursedDataNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          disbursedLeadsNetworkApi("","",partnerController.loanTypeDecode(selectLoanType.value),"","","","","",partnerController.sourceFilterSendValue(filterTypeSelected.value),partnerController.leadStatusNameFilter(leadsPageName.value),partnerController.leadStatusNameFilter(selectEmployeePartnerValue.value));
        }
      }
    });
  }

  /// incApprovalLeadsNetworkApi api integrate
  var inc_approval_leads_model = IncApprovalModel(data: IncApprovalData(loginLeade: [])).obs;
  RxBool inc_approval_leads_loader = false.obs;
  ScrollController incApprovalLeadController = ScrollController();
  int incApprovalLeadNext = 10;
  Future<bool> incApprovalLeadsNetworkApi(date,monthYear,lead_type, custPan, custMobile, leadStatus, leadOwnerPan, leadOwnerPhone)
  async {
    inc_approval_leads_model.value.data.loginLeade.clear();
    Get.context!.loaderOverlay.show();
    // inc_approval_leads_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_INC_APPROVAL_LEAD}?cust_pan=$custPan&cust_mob=$custMobile&lead_status=$leadStatus&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&page=0&limit=$incApprovalLeadNext&lead_type=$lead_type&date=$date&monthyear=$monthYear").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    // inc_approval_leads_loader.value=true;
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["loginLeade"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          inc_approval_leads_model.value = incApprovalModelFromJson(response);
          inc_approval_leads_model.refresh();
          update();
        }
        else{
          inc_approval_leads_model.value = incApprovalModelFromJson(response);
          inc_approval_leads_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    inc_approval_leads_model.value = incApprovalModelFromJson(response);
    inc_approval_leads_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  incApprovalLeadPagination() async {
    incApprovalLeadController.addListener(() {
      if (incApprovalLeadController.position.maxScrollExtent == incApprovalLeadController.position.pixels) {
        incApprovalLeadNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          incApprovalLeadsNetworkApi("","","","","","","","");
        }
      }
    });
  }

  /// incPaidLeadsNetworkApi api integrate
  var incentive_model = IncPaidLeadsModel(data: IncPaidLeadsData(disbursedLeade: [])).obs;
  RxBool incentive_loader = false.obs;
  ScrollController incentiveController = ScrollController();
  int incentiveDataNext = 10;
  Future<bool> incentiveDataNetworkApi(date,monthYear,lead_type, custPan, custMobile, leadStatus, leadOwnerPan, leadOwnerPhone,custType,leadStatusType,directIndirect)
  async {
    Get.context!.loaderOverlay.show();
    incentive_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_INC_PAID_LEAD}?cust_pan=$custPan&cust_mob=$custMobile&lead_status=$leadStatus&cust_list_type=$directIndirect"
        "&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&page=0&limit=$incentiveDataNext&lead_type=$lead_type&date=$date&monthyear=$monthYear"
        "&cust_id=${storage.read(AppConstant.cust_id)??""}&cust_type=$custType&cust_lead_type=$leadStatusType").catchError(BaseController().handleError);
    incentive_loader.value=true;
    Get.context!.loaderOverlay.hide();
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["disbursedLeade"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          incentive_model.value = incPaidLeadsModelFromJson(response);
          incentive_model.refresh();
          update();
        }
        else{
          incentive_model.value = incPaidLeadsModelFromJson(response);
          incentive_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    incentive_model.value = incPaidLeadsModelFromJson(response);
    incentive_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  incPaidLeadPagination() async {
    incentiveController.addListener(() {
      if (incentiveController.position.maxScrollExtent == incentiveController.position.pixels) {
        incentiveDataNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          incentiveDataNetworkApi("","",partnerController.loanTypeDecode(selectLoanType.value),"","","","","",partnerController.sourceFilterSendValue(filterTypeSelected.value),partnerController.leadStatusNameFilter(leadsPageName.value),partnerController.leadStatusNameFilter(selectEmployeePartnerValue.value));
        }
      }
    });
  }

  /// allLeadsNetworkApi api integrate
  var all_leads_model = AllLeadsModel(data: AllLeadsData(allLeade: [])).obs;
  RxBool all_leads_loader = false.obs;
  ScrollController allLeadController = ScrollController();
  int allLeadNext = 10;
  Future<bool> allLeadsNetworkApi(date,monthYear,lead_type, custPan, custMobile, leadStatus, leadOwnerPan, leadOwnerPhone)
  async {
    all_leads_model.value.data.allLeade.clear();
    Get.context!.loaderOverlay.show();
    // all_leads_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_ALL_LEAD}?cust_pan=$custPan&cust_mob=$custMobile&lead_status=$leadStatus&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&page=0&limit=$allLeadNext&lead_type=$lead_type&date=$date&monthyear=$monthYear").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    // all_leads_loader.value=true;
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["allLeade"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          all_leads_model.value = allLeadsModelFromJson(response);
          all_leads_model.refresh();
          update();
        }
        else{
          all_leads_model.value = allLeadsModelFromJson(response);
          all_leads_model.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    all_leads_model.value = allLeadsModelFromJson(response);
    all_leads_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  allLeadsPagination() async {
    allLeadController.addListener(() {
      if (allLeadController.position.maxScrollExtent == allLeadController.position.pixels) {
        allLeadNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          allLeadsNetworkApi("","","","","","","","");
        }
      }
    });
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
    var response = await BaseClient().get("${AppConstants.COUNTRY_API}?limit=20&page=0").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // BaseController().successSnack(context, jsonDecode(response)["message"]);
      countryModel.value=countryModelFromJson(response);
      countryModel.refresh();
      update();
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// updateEmployeeRequestNetworkApi api integrate
  Future<bool> updateEmployeeRequestNetworkApi(empId,status, remarks) async {
    var bodyRequest = {
      "emp_id": empId.toString(),
      "emp_approved_by": storage.read(AppConstant.cust_id).toString().trim(),
      "emp_status": status.toString(),
      "remark": remarks.toString(),
    };
    print("request =============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.UPDATE_EMPLOYEE_REQUEST, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==============>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack(jsonDecode(response)["message"].toString());
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"].toString());
    return false;
  }

  /// unassignedNetworkApi api integrate
  var approve_assign_model = ApproveAssignModel(data: ApproveAssignData(leads: [])).obs;
  RxBool approve_assign_loader = false.obs;
  Future<bool> approveAssignNetworkApi(date,monthYear,lead_type, custPan, custMobile, leadOwnerPan, leadOwnerPhone, leadStatus)
  async {
    Get.context!.loaderOverlay.show();
    approve_assign_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_APPROVE_ASSIGN}?cust_pan=$custPan&cust_mob"
        "=$custMobile&lead_status=$leadStatus&lead_owner_pan=$leadOwnerPan&lead_owner_phone"
        "=$leadOwnerPhone&page=0&limit=100&lead_type=$lead_type&date=$date&monthyear=$monthYear&emp_id=${storage.read(AppConstant.emp_eId).toString()}").catchError(BaseController().handleError);
    approve_assign_loader.value=true;
    Get.context!.loaderOverlay.hide();
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      approve_assign_model.value = approveAssignModelFromJson(response);
      approve_assign_model.refresh();
      update();
      return true;
    }
    approve_assign_model.value = approveAssignModelFromJson(response);
    approve_assign_model.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  var add_employee_access_model = AddEmployeePermissionAccessModel(data: PermissionAccessData()).obs;
  Future<bool> getAddEmployeeAccessNetworkApi() async {
    add_employee_access_model.value.data.isNull;
    var response = await BaseClient().get("${AppConstants.GET_USER_PERMISSION}?customer_id=${GetStorage().read(AppConstant.emp_eId).toString().trim()}").catchError(BaseController().handleError);
    print(response);
    if (jsonDecode(response)["status"] == "1") {
      add_employee_access_model.value = addEmployeePermissionAccessModelFromJson(response);
      add_employee_access_model.refresh();
      update();
      return true;
    }
    // profileComplete.value = profileCompleteModelFromJson(response);
    return false;
  }


  /// partner profile update fields
  TextEditingController emp_pushback_fName = TextEditingController();
  TextEditingController emp_pushback_lName = TextEditingController();
  TextEditingController emp_pushback_dob = TextEditingController();
  TextEditingController emp_pushback_phone = TextEditingController();
  TextEditingController emp_pushback_email = TextEditingController();
  TextEditingController emp_pushback_facebook = TextEditingController();
  TextEditingController emp_pushback_linkedin = TextEditingController();
  TextEditingController emp_pushback_present_address_pin = TextEditingController();
  TextEditingController emp_pushback_present_address = TextEditingController();
  TextEditingController emp_pushback_country = TextEditingController();
  TextEditingController emp_pushback_state = TextEditingController();
  TextEditingController emp_pushback_PanCard = TextEditingController();
  TextEditingController emp_pushback_Aadhaar = TextEditingController();

  ///  employee profile update education fields
  var empPushbackEducationTextFieldList= [];
  var emp_pushback_course_type="MBA".obs;
  var emp_pushback_grade="Garde A".obs;
  var emp_pushback_start_date="".obs;
  var emp_pushback_end_date="".obs;
  RxList<Map> empPushbackEducationFieldList=<Map>[{
    "emp_course_name": TextEditingController(),
    "emp_institute_name":  TextEditingController(),
    "emp_course_type": null,
    "emp_course_grade": TextEditingController(),
    "emp_course_start": TextEditingController(),
    "emp_course_end": TextEditingController(),
    "emp_skills": TextEditingController(),
  }].obs;
  empPushbackEducationAddField(){
    empPushbackEducationFieldList.value.add({
      "emp_course_name": TextEditingController(),
      "emp_institute_name":  TextEditingController(),
      "emp_course_type": null,
      "emp_course_grade": TextEditingController(),
      "emp_course_start": TextEditingController(),
      "emp_course_end": TextEditingController(),
      "emp_skills": TextEditingController(),
    });
    empPushbackEducationFieldList.refresh();
    update();
  }
  empPushbackEducationDeleteField(int i){
    empPushbackEducationFieldList.value.removeAt(i);
    empPushbackEducationFieldList.refresh();
    update();
  }

  /// employee profile update experience fields
  var empPushbackExperienceTextFieldList= [];
  var emp_pushback_function= "IT-Software".obs;
  var emp_pushback_industry= "Telecom".obs;
  var emp_pushback_company_size = "Garde A".obs;
  var emp_pushback_join_start_date ="".obs;
  var emp_pushback_join_end_date ="".obs;
  RxList<Map> empPushbackExperienceFieldList=<Map>[{
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
  empPushbackExperienceAddField(){
    empPushbackExperienceFieldList.value.add({
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
    empPushbackExperienceFieldList.refresh();
    update();
  }
  empPushbackExperienceDeleteField(int i){
    empPushbackExperienceFieldList.value.removeAt(i);
    empPushbackExperienceFieldList.refresh();
    update();
  }
  var pushbackSocialMedia=[];

  /// emp payroll field
  Rx<String?> unit = "Administration".obs;
  List<String> functionUnitList = [];
  Rx<String?> brand = "E1".obs;
  List<String> bandList = [];
  TextEditingController empPushbackJoiningSalary = TextEditingController();
  TextEditingController empPushbackPresentSalary = TextEditingController();
  TextEditingController empPushbackDesignation = TextEditingController();
  TextEditingController empPushbackJoiningDate = TextEditingController();
  TextEditingController empPushbackResignDate = TextEditingController();
  TextEditingController empPushbackLastWorkingDate = TextEditingController();
  TextEditingController empPushbackRelivingDate = TextEditingController();

  Future<bool> employeePushBackAboutUpdateNetworkApi(empId,gender, maritalStatus, hEducation) async {
    pushbackSocialMedia.clear();
    pushbackSocialMedia.add({"fb": emp_pushback_facebook.text});
    pushbackSocialMedia.add({"insta": emp_pushback_linkedin.text},);
    empPushbackEducationTextFieldList.clear();
    for(var element in empPushbackEducationFieldList.value) {
      empPushbackEducationTextFieldList.add({
        "emp_institute_name":  element["emp_institute_name"].text.toString(),
        "emp_course_name": element["emp_course_name"].text.toString(),
        "emp_course_type": emp_course_type.value.toString(),
        "emp_course_start": element["emp_course_start"].text.toString(),
        "emp_course_end": element["emp_course_end"].text.toString(),
        "emp_course_grade": element["emp_course_grade"].text.toString(),
        "emp_skills": element["emp_skills"].text.toString(),
      });
    }
    print("gasbag $empPushbackEducationTextFieldList");

    empPushbackExperienceTextFieldList.clear();
    for(var element in empPushbackExperienceFieldList.value) {
      empPushbackExperienceTextFieldList.add({
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
    print("gasbag $empPushbackExperienceTextFieldList");

    var bodyRequest = {
      "emp_fname": emp_pushback_fName.text.toString(),
      "emp_lname": emp_pushback_lName.text.toString(),
      "emp_dob": emp_pushback_dob.text.toString(),
      "emp_gender": gender.toString(),
      "emp_marital_status": maritalStatus.toString(),
      "emp_education": hEducation.toString(),
      "emp_phone": emp_pushback_phone.text.toString(),
      "emp_email": emp_pushback_email.text.toString(),
      "emp_social": json.encode(pushbackSocialMedia),
      "emp_present_address_pin": emp_pushback_present_address_pin.text.toString(),
      "emp_present_address": emp_pushback_present_address.text.toString(),
      "education": jsonEncode(empPushbackEducationTextFieldList),
      "experience": jsonEncode(empPushbackExperienceTextFieldList),
      "emp_id": empId.toString(),
    };

    print("body request ==================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.EMPLOYEE_PUSHBACK_ABOUT_UPDATE, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response =================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // storage.write(AppConstant.eId, jsonDecode(response)["data"]["eid"]??"");
      // employeeCompleteIdUpdate = "${jsonDecode(response)["data"]["user_id"]}";
      // print("ss ${employeeCompleteIdUpdate.toString()} jjagbs  ${jsonDecode(response)["data"]["user_id"]}");
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  Future<bool> employeePushBackKycUpdateNetworkApi(type, empId, panCard, aadharCard) async {
    var bodyRequest = {
      "tbl_EmpID": empId.toString(),
      "emp_pan": panCard.toString(),
      "emp_aadhar": aadharCard.toString(),
      "emp_save_type": type.toString(),
    };
    print("request =================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.EMPLOYEE_KYC, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      add_emp_kyc_data.value = addEmpKycModelFromJson(response);
      // storage.write(AppConstant.emp_id, "${jsonDecode(response)["data"]["id"]??""}");
      // storage.write(AppConstant.emp_eId, "${jsonDecode(response)["data"]["eid"]??""}");
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      kAadhaarCard.clear();
      kPanCard.clear();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// employeePushBackPayrollUpdateNetworkApi api integrate
  Future<bool> employeePushBackPayrollUpdateNetworkApi(empId, supId) async {
    var bodyRequest = {
      "tbl_EmpID": empId.toString(),
      "emp_save_type": "2",
      "sup_id": supId.toString(),
      "emp_designation": empPushbackDesignation.text,
      "emp_function": unit.value.toString(),
      "emp_band": brand.value.toString(),
      "emp_join_date": empPushbackJoiningDate.text,
      "emp_join_salary": empPushbackJoiningSalary.text,
      "emp_present_salary": empPushbackPresentSalary.text,
      "emp_resign_date": empPushbackResignDate.text,
      "emp_last_working_date": empPushbackLastWorkingDate.text,
      "emp_reliving_date": empPushbackRelivingDate.text,
    };

    print("body request ==================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.EMPLOYEE_PAYROLL, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response =================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  Future<bool> employeePushBackAccessUpdateNetworkApi(empId) async {
    var bodyRequest = {
      "gUserID": empId.toString(),
      "access_change_by": storage.read(AppConstant.cust_id).toString(),
      "emp_save_type": "2",
      "emp_view_all": empViewAll.value.toString(),
      "add_emp": addEMP.value.toString(),
      "update_emp": updateEMP.value.toString(),
      "emp_push_back": empPushBack.value.toString(),
      "emp_approve": empApprove.value.toString(),
      "partner_view_all": partnerViewAll.value.toString(),
      "partner_add": partnerAdd.value.toString(),
      "partner_update": partnerUpdate.value.toString(),
      "partner_push_back": partnerPushBack.value.toString(),
      "partner_pending_approval": partnerPendingApproval.value.toString(),
      "unassigned_leads": unassignedLeads.value.toString(),
      "assign_all_lead": assignAllLead.value.toString(),
      "assign_my_lead": assignMyLead.value.toString(),
      "assign_myteam_lead": assignMyTeamLead.value.toString(),
      "assign_mypartner_lead": assignMyPartnerLead.value.toString(),
      "add_lead": addLead.value.toString(),
      "my_lead": myLead.value.toString(),
      "myteam_lead": myTeamLead.value.toString(),
      "mypartner_lead": myPartnerLead.value.toString(),
      "all_cust": AllCust.value.toString(),
      "my_cust": myCust.value.toString(),
      "myteam_cust": myTeamCust.value.toString(),
      "mypartner_cust": myPartnerCust.value.toString(),
      "my_sales": mySales.value.toString(),
      "incentive_mgmt_view": incentiveMGMTView.value.toString(),
      "incentive_mgmt_edit": incentiveMGMTEdit.value.toString(),
      "apply_self_loan": applySelfLoan.value.toString(),
      "emp_pending_approval": empPendingApprove.value.toString(),
      "assignement_change_approval": assignmentChangeApproval.value.toString(),
      "panel_manage_customer": panelManageCustomer.value.toString(),
      "panel_manage_partner": panelManagePartner.value.toString(),
      "panel_manage_employee": panelManageEmployee.value.toString(),
    };

    print("body request ==================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.EMPLOYEE_ACCESS, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response =================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }


  var isMyTeamPtnrSelected = "sourced".obs;
  var isMyTeamEmpSelected = "all".obs;
  var isTeamLeadEmpSelected = "all".obs;
  var isMyCustEMPSelected = "All".obs;
  var myLoanTypeSelected = "My Loan".obs;
  var incentiveRadio = "All".obs;
  var approvalAssignRadio = "All".obs;
  var filterTypeSelected = "All Source".obs;
  var leadsPageName = "All".obs;
  var selectLoanType = "All Loan".obs;
  var selectStageType = "All Stage".obs;
  var selectEmployeePartnerValue = "All Reports".obs;


  /// allLeadsDataNetworkApi api integrate
  var allLeadsDataModel = AllLeadDataModel(data: AllDataList(newLeade: [])).obs;
  ScrollController allLeadsScroller = ScrollController();
  int allLeadsDataNext = 10;
  RxBool new_lead_loader = false.obs;
  Future<bool> allLeadsDataNetworkApi(date,monthYear, custPan, leadType, custMobile, leadOwnerPan, leadOwnerPhone, loanListType, leadTabStatus,directIndirect)
  async {
    Get.context!.loaderOverlay.show();
    if(allLeadsDataNext==10) new_lead_loader.value=false;
    var response = await BaseClient().get("${AppConstants.GET_ALL_LEADS_STATUS_API}?cust_pan=$custPan&cust_mob=$custMobile"
        "&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&page=0&"
        "limit=$allLeadsDataNext&date=$date&monthyear=$monthYear&lead_type=$leadType&cust_list_type=$directIndirect&lead_status=${loanListType=="all"?"":loanListType}&loan_list_type="
        "$leadTabStatus&cust_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    if(allLeadsDataNext==10) new_lead_loader.value=true;
    Get.context!.loaderOverlay.hide();
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["newLeade"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          allLeadsDataModel.value = allLeadDataModelFromJson(response);
          allLeadsDataModel.refresh();
          update();
        } else{
          allLeadsDataModel.value = allLeadDataModelFromJson(response);
          allLeadsDataModel.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    allLeadsDataModel.value = allLeadDataModelFromJson(response);
    allLeadsDataModel.refresh();
    update();
    return false;
  }

  allLeadsDataPagination() async {
    allLeadsScroller.addListener(() {
      if (allLeadsScroller.position.maxScrollExtent == allLeadsScroller.position.pixels) {
        allLeadsDataNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(selectLoanType.value.toString()),"","","", partnerController.leadStatusNameFilter(leadsPageName.value),partnerController.sourceFilterSendValue(filterTypeSelected.value),partnerController.leadStatusNameFilter(selectEmployeePartnerValue.value)).then((hasMoreData) {
            if (!hasMoreData) {
              print("=======$hasMoreData================================No more data available===========================================");
            }
          });
          allLeadsDataModel.refresh();
          update();
        }
      }
    });
  }

  /// verificationNetworkApi api integrate
  var verificationDataModel = VerificationDataModel(data: VerificationDataList(newLeade: [])).obs;
  ScrollController verificationScroller = ScrollController();
  int verificationDataNext = 10;
  RxBool verification_loader = false.obs;

  Future<bool> verificationNetworkApi(date,monthYear, custPan, leadType, custMobile, leadOwnerPan, leadOwnerPhone, leadStatus, loanListType, directIndirect)
  async {
    Get.context!.loaderOverlay.show();
    verification_loader.value=false;
    var response = await BaseClient().get("${AppConstants.VERIFICATION_LEAD_API}?cust_pan=$custPan&cust_mob=$custMobile"
        "&lead_owner_pan=$leadOwnerPan&lead_owner_phone=$leadOwnerPhone&page=0&"
        "limit=$verificationDataNext&date=$date&monthyear=$monthYear&lead_type=$leadType&lead_status=$leadStatus&cust_list_type=$directIndirect&loan_list_type=$loanListType"
        "&cust_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    verification_loader.value=true;
    Get.context!.loaderOverlay.hide();
    print("response ==========>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      List<dynamic> data = jsonDecode(response)["data"]["newLeade"];
      if(data.isNotEmpty){
        if(isLoadMore.value==false){
          verificationDataModel.value = verificationDataModelFromJson(response);
          verificationDataModel.refresh();
          update();
        } else{
          verificationDataModel.value = verificationDataModelFromJson(response);
          verificationDataModel.refresh();
          update();
        }
        isLoading.value=true;
        isLoadMore.value=false;
      }else{
        isLoading.value=false;
        isLoadMore.value=false;
      }
      return true;
    }
    verificationDataModel.value = verificationDataModelFromJson(response);
    verificationDataModel.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  verificationDataPagination() async {
    verificationScroller.addListener(() {
      if (verificationScroller.position.maxScrollExtent == verificationScroller.position.pixels) {
        verificationDataNext+=10;
        if(isLoading.value){
          isLoadMore.value=true;
          verificationNetworkApi("","","",partnerController.loanTypeDecode(selectLoanType.value.toString()),"","","", partnerController.leadStatusNameFilter(leadsPageName.value),partnerController.sourceFilterSendValue(filterTypeSelected.value),partnerController.leadStatusNameFilter(selectEmployeePartnerValue.value));
          verificationDataModel.refresh();
          update();
        }
      }
    });
  }

  /// get notifications api integrate
  /// search customer api integrate
  var getNotificationData = GetNotificationsModel(data: []).obs;
  Future<bool> getNotificationsNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().get("${AppConstants.GET_NOTIFICATIONS_API}?user_id=${storage.read(AppConstant.cust_id).toString().trim()}").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==============>>>>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      // BaseController().successSnack(jsonDecode(response)["message"]);
      getNotificationData.value = getNotificationsModelFromJson(response);
      getNotificationData.refresh();
      update();
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

}