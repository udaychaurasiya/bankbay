import 'dart:io';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_push_back_details.dart';
import 'package:bank_bay/widgets/Profile/employee_profile.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmployeePhotoEdit extends StatefulWidget {
  final String empId;
  final String pageName;
  const EmployeePhotoEdit({super.key, required this.empId, required this.pageName});

  @override
  State<EmployeePhotoEdit> createState() => _EmployeePhotoEditState();
}

class _EmployeePhotoEditState extends State<EmployeePhotoEdit> {
  var partnerController = Get.find<PartnerController>();
  RxString employeePhotoEdit = "".obs;

  @override
  void initState() {
    saveDataAbout();
    super.initState();
  }
  saveDataAbout()async{
    bool status = await partnerController.getEmployeeDetailsNetworkApi(widget.empId.toString());
    if(status==true){
      employeePhotoEdit.value = partnerController.employeeDetails.value.data.basicDetails.docProfilePic??"";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      color: AllColors.white.withOpacity(0.9),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: ()=> employeeProfileTab.value=3,
              child: Text("SKIP",
                style: fontMedium.copyWith(
                  color: Colors.black.withOpacity(0.9),
                ),
              ),
            ),
          ),
          Text(
            "Selfie",
            style: fontBold.copyWith(fontSize: 22.r, color: Colors.black),
          ),
          SizedBox(height: 2.r),
          Text(
            "Let's take a s/elfie",
            style: fontSmall.copyWith(color: Colors.black.withOpacity(0.6)),
          ),
          SizedBox(height: 50.r),
          Obx(() => DottedBorder(
            borderType: BorderType.Circle,
            radius: Radius.circular(100.r),
            strokeWidth: 1.5.r,
            dashPattern: const [5, 4],
            color: AllColors.black.withOpacity(0.5),
            child: InkWell(
              onTap: () {
                imageDialogBox(context);
              },
              child: CircleAvatar(
                radius: 80.r,
                backgroundColor: AllColors.white,
                backgroundImage: partnerController.employeeProfileImg.value.isNotEmpty
                    ? FileImage(File(partnerController.employeeProfileImg.value)) as ImageProvider<Object>
                    : NetworkImage(AppConstants.BASE_URL+employeePhotoEdit.value.toString()),
                child: partnerController.employeeProfileImg.value.isEmpty ? Icon(
                    Icons.camera_alt_outlined, size: 26.r,
                    color: AllColors.black.withOpacity(0.5)) : null,
              ),
            ),
          ),
          ),
          SizedBox(height: 50.r),
          Text(
            "Be sure to sit in full light area. \nMake sure your face is visible within area",
            style: fontRegular.copyWith(
                color: AllColors.black.withOpacity(0.7), fontSize: 13.r),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25.r),
          CustomButton(
            title: "Update".tr,
            background: true,
            radius: 30.r,
            width: Get.width - 100,
            onTap: ()async {
              employeePushBackDetailsTab.value = 3;
              // if(partnerController.employeeProfileImg.value!=""){
              //   bool status = await partnerController.employeeUploadSelfieNetworkApi();
              //   if(status==true){
              //     employeeProfileTab.value=3;
              //   }
              // }else{
              //   BaseController().errorSnack("Please take a selfie or choose image");
              // }
            },
          ),
          SizedBox(height: 40.r),
        ],
      ),
    );
  }

  void imageDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context,) {
        return AlertDialog(
          content: SizedBox(
            height: 180.r,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.r, right: 25.r, top: 20.r),
                  child: Column(
                    children: [
                      Text(
                        "Choose Image",
                        style: fontBold.copyWith(fontSize: 18.r),
                      ),
                      SizedBox(height: 15.r),
                      Container(
                        height: 2.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AllColors.lightGrey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        partnerController.employeeProfileDocumentImages(false, 15);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              Images.gallery,
                              height: 50.r,
                              width: 50.r,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5.r),
                            Text(
                              "Gallery",
                              style: fontMedium.copyWith(fontSize: 15.r),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1.r,
                      height: 40.r,
                      color: AllColors.lightGrey.withOpacity(0.8),
                      margin: EdgeInsets.symmetric(vertical: 5.r),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        partnerController.employeeProfileDocumentImages(true, 15);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              Images.camera,
                              height: 50.r,
                              width: 50.r,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5.r),
                            Text(
                              "Camera",
                              style: fontMedium.copyWith(fontSize: 15.r),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.zero,
          actionsOverflowButtonSpacing: 0,
          actionsOverflowDirection: VerticalDirection.down,
          actions: [
            Container(
              color: Colors.red,
            )
          ],
        );
      },
    );
  }
}
