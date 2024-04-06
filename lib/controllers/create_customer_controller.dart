import 'dart:convert';
import 'dart:io';
import 'package:bank_bay/models/duplicate_lead_model.dart';
import 'package:bank_bay/models/search_customer_model.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/utils/BaseClient.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CreateCustomerController extends GetxController{
  GetStorage storage = GetStorage();
  RxInt selectedRadioTile = 0.obs;

  List<String> genderList = [];
  List<String> maritalStatusList = [];
  List<String> qualificationList = [];

  void refreshDropdownList(){
    genderList = ["Select Gender" ,"Male", "Female", "Other"];
    maritalStatusList = ["Select Marital", "Married", "Single", "Divorced"];
    qualificationList = ["Select Qualification", "High School", "Graduation", "Masters", "Phd", "Certificate", "Diploma","Mca"];
  }

  /// search customer api integrate
  var searchCustomerModel = SearchCustomerModel(data: []).obs;
  Future<bool> searchCustomerNetworkApi(searchValue) async {
    searchCustomerModel.value.data.clear();
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().get("${AppConstants.SEARCH_CUSTOMER_API}?search_val=$searchValue").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==============>>>>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.lead_id, "${jsonDecode(response)["data"][0]["id"]}");
      storage.write(AppConstant.lead_cust_id, "${jsonDecode(response)["data"][0]["cust_id"]}");
      storage.write(AppConstant.create_id, "${jsonDecode(response)["data"][0]["id"]}");
      storage.write(AppConstant.create_cust_id, "${jsonDecode(response)["data"][0]["cust_id"]}");
      // BaseController().successSnack(jsonDecode(response)["message"]);
      searchCustomerModel.value = searchCustomerModelFromJson(response);
      searchCustomerModel.refresh();
      update();
      return true;
    }
    searchCustomerModel.value = searchCustomerModelFromJson(response);
    searchCustomerModel.refresh();
    update();
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// registration api integrate
  TextEditingController custFName = TextEditingController();
  TextEditingController custLName = TextEditingController();
  TextEditingController custDob = TextEditingController();
  TextEditingController custEmail = TextEditingController();
  TextEditingController custPhone = TextEditingController();
  TextEditingController custPinCode = TextEditingController();
  TextEditingController custAddress = TextEditingController();
  TextEditingController custPan = TextEditingController();
  TextEditingController custAadhaar = TextEditingController();
  TextEditingController custPassword = TextEditingController();
  RxString custGender = "Select Gender".obs;
  RxString custMaritalStatus = "Select Marital".obs;
  RxString custQualification = "Select Qualification".obs;
  RxString createPhotoImg = "".obs;

  clearTextField(){
    custFName.clear();
    custLName.clear();
    custDob.clear();
    custEmail.clear();
    custPhone.clear();
    custPinCode.clear();
    custAddress.clear();
    custPan.clear();
    custAadhaar.clear();
    custPassword.clear();
    custGender.value = "Select Gender";
    custMaritalStatus.value = "Select Marital";
    custQualification.value = "Select Qualification";
    createPhotoImg.value="";
  }

  Future<bool> registrationNetworkApi() async {
    var bodyRequest = {
    "password": "",
    if(storage.read(AppConstant.cust_id)==null)
    "lead_source": "",
    if(storage.read(AppConstant.cust_id)!=null)
    "lead_source": storage.read(AppConstant.cust_id).toString().trim(),
    "cust_name": "${custFName.text} ${custLName.text}",
    "cust_dob": custDob.text,
    "cust_gender": custGender.value.toString(),
    "cust_marital_status": custMaritalStatus.value.toString(),
    "cust_education": custQualification.value.toString(),
    "cust_email": custEmail.text,
    "cust_phone": custPhone.text,
    "cust_pan": custPan.text,
    "cust_aadhar": custAadhaar.text,
    "cust_address": custAddress.text,
    "cust_pincode": custPinCode.text,
    };
    print("request =============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.REGISTER_URL_NEW, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==============>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.lead_id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.lead_cust_id, "${jsonDecode(response)["data"]["cust_id"]??""}");
      storage.write(AppConstant.create_id, "${jsonDecode(response)["data"]["id"]??""}");
      storage.write(AppConstant.create_cust_id, "${jsonDecode(response)["data"]["cust_id"]??""}");
      clearTextField();
      BaseController().successSnack("${jsonDecode(response)["message"]}  ${jsonDecode(response)["data"]["otp_phone"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"].toString());
    return false;
  }

  /// selfie image choose
  Future chooseCropImage(bool isCamera, type) async {
    final ImagePicker picker = ImagePicker();
    try {
      await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 80,
      ).then((value) {
        if(value != null){
          _cropImage(File(value.path), type);
        }
        return null;
      });
    } on Exception catch (e) {
      print("image response $e");
    }
  }

  /// crop selfie image code
  _cropImage(File imgFile, type) async {
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
      switch(type){
        case 1:
          createPhotoImg.value = croppedFile.path;
          break;

      }
      // Navigator.pop(Get.context!);
    }
  }

  /// createCustSelfieNetworkApi integrate
  Future<bool> createCustSelfieNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().selfieUpload("${AppConstants.UPLOAD_SELFIE}?customer_id=${storage.read(AppConstant.create_cust_id).toString().trim()}", createPhotoImg.value)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      createPhotoImg.value="";
      BaseController().successSnack("${jsonDecode(response)["message"]??""}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }


  /// createCustKycNetworkApi api integrate
  Future<bool> createCustKycNetworkApi() async {
    var bodyRequest = {
      "cust_id": storage.read(AppConstant.create_cust_id).toString().trim(),
      "cust_aadhar": custAadhaar.text.toString(),
      "cust_pan": custPan.text.toString(),
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

  RxString verifyOtp = "".obs;
  /// otp api integrate
  Future<bool> createCustOtpVerificationApi(otp) async {
    var bodyRequest = {
      "tbl_custID": storage.read(AppConstant.create_id).toString().trim(),
      "otp_phone": otp,
    };
    print("request =============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.VERIFY_URL, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      clearTextField();
      BaseController().successSnack("${jsonDecode(response)["message"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// checkDuplicateLeadNetworkApi api integrate
  var checkDuplicateLeadModel = DuplicateLeadModel(data: DuplicateData(plData: [],blData: [], selData: [], custData: CustData())).obs;
  Future<bool> checkDuplicateLeadNetworkApi(custId, loanType) async {
    var bodyRequest = {
      "cust_id": custId.toString(),
      "loan_type": loanType.toString(),
    };

    print("request =============>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.CHECK_DUPLICATE_LEAD, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ==================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      checkDuplicateLeadModel.value = duplicateLeadModelFromJson(response);
      checkDuplicateLeadModel.refresh();
      update();
      // BaseController().successSnack("${jsonDecode(response)["message"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }



}