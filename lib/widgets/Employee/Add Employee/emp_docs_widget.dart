import 'dart:io';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/widgets/Employee/create_employee.dart';
import 'package:bank_bay/widgets/Employee/employee_home.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DocsScreen extends StatefulWidget {
  const DocsScreen({super.key});

  @override
  State<DocsScreen> createState() => _DocsScreenState();
}

class _DocsScreenState extends State<DocsScreen> {
  var controller = Get.find<LoginController>();
  var ownedValue = "owned".obs;
  RxString genderValue = "My Proof".obs;

  @override
  Widget build(BuildContext context) {
    controller.kPassportImage.value="";
    controller.kPANImage.value="";
    controller.kAadhaarCardImage.value="";
    controller.k10THMarksheetImage.value="";
    controller.kAppointmentFormImage.value="";
    controller.kAppointmentLatterImage.value="";
    controller.kSalarySlipsImage.value="";
    controller.kBankStatementImage.value="";
    controller.kGraduationImage.value="";
    controller.kMasterImage.value="";
    controller.kCertificateImage.value="";
    controller.kOwnerShipProof.value="";
    controller.kRealAgreeProof.value="";
    controller.kRelationshipProof.value="";
    controller.kPANImageName.value = "";
    controller.kAadhaarCardImageName.value = "";
    controller.kSalarySlipsImageName.value = "";
    controller.kBankStatementImageName.value = "";
    controller.k10THMarksheetImageName.value = "";
    controller.kGraduationImageName.value = "";
    controller.kMasterImageName.value = "";
    controller.kCertificateImageName.value = "";
    controller.kAppointmentFormImageName.value = "";
    controller.kAppointmentLatterImageName.value = "";
    controller.kOwnerShipProofName.value = "";
    controller.kRealAgreeProofName.value = "";
    controller.kRelationshipProofName.value = "";
    double width =MediaQuery.of(context).size.width;
    return Container(
      color: AllColors.white,
      child: Column(
        children: [
          SizedBox(height: 20.r),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0.r),
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChooseImageDocument(
                  title: "Passport Photo".tr,
                  subTitle: "Password File",
                  onTap: () => addEMPDocsProofImageBox(context,1),
                  image: controller.kPassportImage.value,
                  fileName: controller.kPassportImageName.value,
                ),
                SizedBox(height: 20.r),
                ChooseImageDocument(
                  title: "PAN Card".tr,
                  subTitle: "Pan card",
                  onTap: () => addEMPDocsProofImageBox(context,2),
                  image: controller.kPANImage.value,
                  fileName: controller.kPANImageName.value,
                ),
                SizedBox(height: 20.r),
                ChooseImageDocument(
                  title: "Aadhaar (both sides)".tr,
                  onTap: () => addEMPDocsProofImageBox(context,3),
                  image: controller.kAadhaarCardImage.value,
                  fileName: controller.kAadhaarCardImageName.value,
                  subTitle: "Single PDF File",
                ),
                SizedBox(height: 20.r),
                ChooseImageDocument(
                  title: "Salary Slip".tr,
                  onTap: () => addEMPDocsProofImageBox(context,4),
                  image: controller.kSalarySlipsImage.value,
                  fileName: controller.kSalarySlipsImageName.value,
                  subTitle: "Latest month",
                  optional: true,
                ),
                SizedBox(height: 20.r),
                ChooseImageDocument(
                  title: "Bank Statement".tr,
                  onTap: () => addEMPDocsProofImageBox(context,5),
                  image: controller.kBankStatementImage.value,
                  fileName: controller.kBankStatementImageName.value,
                  subTitle: "Latest month salary credit",
                  optional: true,
                ),
                SizedBox(height: 20.r),
                ChooseImageDocument(
                  title: "10th Mark Sheet".tr,
                  onTap: () => addEMPDocsProofImageBox(context,6),
                  image: controller.k10THMarksheetImage.value,
                  fileName: controller.k10THMarksheetImageName.value,
                ),
                SizedBox(height: 20.r),
                ChooseImageDocument(
                  title: "Graduation Mark sheet".tr,
                  onTap: () => addEMPDocsProofImageBox(context,7),
                  image: controller.kGraduationImage.value,
                  fileName: controller.kGraduationImageName.value,
                  optional: true,
                ),
                SizedBox(height: 20.r),
                ChooseImageDocument(
                  title: "Master/PHD Mark sheet".tr,
                  onTap: () => addEMPDocsProofImageBox(context,8),
                  image: controller.kMasterImage.value,
                  fileName: controller.kMasterImageName.value,
                  optional: true,
                ),
                SizedBox(height: 20.r),
                ChooseImageDocument(
                  title: "Certificate Diploma".tr,
                  onTap: () => addEMPDocsProofImageBox(context,9),
                  image: controller.kCertificateImage.value,
                  fileName: controller.kCertificateImageName.value,
                  optional: true,
                ),
                SizedBox(height: 20.r),
                ChooseImageDocument(
                  title: "Appointment & Relieving Letter From All Post Companies".tr,
                  onTap: () => addEMPDocsProofImageBox(context,10),
                  image: controller.kAppointmentFormImage.value,
                  fileName: controller.kAppointmentFormImageName.value,
                ),
                SizedBox(height: 20.r),
                ChooseImageDocument(
                  title: "Appointment Letter".tr,
                  onTap: () => addEMPDocsProofImageBox(context,11),
                  image: controller.kAppointmentLatterImage.value,
                  fileName: controller.kAppointmentLatterImageName.value,
                  subTitle: "Gross by our company",
                ),
                SizedBox(height: 20.r),
                Text("Address Proof",style: fontBold.copyWith(),),
                SizedBox(height: 20.r),
                Obx(() => Container(
                  height: 30.r,
                  width: width/2,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.r, color: AllColors.blue),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ownedValue.value = "owned";
                            controller.kOwnerShipProof.value="";
                            controller.kRealAgreeProof.value="";
                            controller.kRelationshipProof.value="";
                            print("value ${ownedValue.value}");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r),bottomLeft: Radius.circular(5.r)),
                              color:  ownedValue.value == "owned"?AllColors.blue.withOpacity(0.9):AllColors.white.withOpacity(0.9),
                            ),
                            child: Text("Owned", style: fontSmall.copyWith(color: ownedValue.value == "owned" ?AllColors.white.withOpacity(0.9):AllColors.blue.withOpacity(0.9)),),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ownedValue.value = "ranted";
                            controller.kOwnerShipProof.value="";
                            controller.kRealAgreeProof.value="";
                            controller.kRelationshipProof.value="";
                            print("value ${ownedValue.value}");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5.r),bottomRight: Radius.circular(5.r)),
                              color: ownedValue.value == "ranted"?AllColors.blue.withOpacity(0.9):AllColors.white.withOpacity(0.9),
                            ),
                            child: Text("Rented", style: fontSmall.copyWith(color: ownedValue.value == "ranted"?AllColors.white.withOpacity(0.9):AllColors.blue.withOpacity(0.9)),),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                SizedBox(height: 20.r),
                Obx(() {
                  return Column(
                    children: [
                      InkWell(
                        onTap: (){
                          controller.kOwnerShipProof.value="";
                          controller.kRealAgreeProof.value="";
                          controller.kRelationshipProof.value="";
                          genderValue.value = "My Proof";
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              height: 20.r,
                              width: 20.r,
                              child: Radio(
                                value: "My Proof",
                                groupValue: genderValue.value,
                                onChanged: (value) {
                                  controller.kOwnerShipProof.value="";
                                  controller.kRealAgreeProof.value="";
                                  controller.kRelationshipProof.value="";
                                  genderValue.value = value.toString();
                                  print("object ${genderValue.value}");
                                },
                              ),
                            ),
                            SizedBox(width: 10.r),
                            Text(
                              "Property proof is in my name",
                              style: fontSmall.copyWith(
                                  color: Colors.black.withOpacity(0.7),wordSpacing: 0.2,letterSpacing: 0.1),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.r),
                      InkWell(
                        onTap: (){
                          controller.kOwnerShipProof.value="";
                          controller.kRealAgreeProof.value="";
                          controller.kRelationshipProof.value="";
                          genderValue.value = "Family Proof";
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.r,
                              width: 20.r,
                              child: Radio(
                                value: "Family Proof",
                                groupValue: genderValue.value,
                                onChanged: (value) {
                                  controller.kOwnerShipProof.value="";
                                  controller.kRealAgreeProof.value="";
                                  controller.kRelationshipProof.value="";
                                  genderValue.value = value.toString();
                                  print("object ${genderValue.value}");
                                },
                              ),
                            ),
                            SizedBox(width: 10.r),
                            Text(
                              "Property proof is in my family member's name",
                              style: fontSmall.copyWith(
                                  color: Colors.black.withOpacity(0.7),wordSpacing: 0.2,letterSpacing: 0.1),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if(ownedValue.value == "owned" && (genderValue.value=="My Proof"||genderValue.value=="Family Proof"))
                        SizedBox(height: 20.r),
                      if(ownedValue.value == "owned" && (genderValue.value=="My Proof"||genderValue.value=="Family Proof"))
                        ChooseImageDocument(
                          title: "Ownership Proof".tr,
                          onTap: () => addEMPDocsProofImageBox(context,12),
                          image: controller.kOwnerShipProof.value,
                          fileName: controller.kOwnerShipProofName.value,
                          subTitle: "Electric bill/".tr,
                        ),
                      if(ownedValue.value == "ranted" && (genderValue.value=="My Proof"||genderValue.value=="Family Proof"))
                        SizedBox(height: 20.r),
                      if(ownedValue.value == "ranted" && (genderValue.value=="My Proof"||genderValue.value=="Family Proof"))
                        ChooseImageDocument(
                          title: "Rent Agreement".tr,
                          onTap: () => addEMPDocsProofImageBox(context,13),
                          image: controller.kRealAgreeProof.value,
                          fileName: controller.kRealAgreeProofName.value,
                          subTitle: "Rent Agreement".tr,
                        ),
                      if((ownedValue.value == "ranted" || ownedValue.value == "owned") && genderValue.value=="Family Proof")
                        SizedBox(height: 20.r),
                      if((ownedValue.value == "ranted" || ownedValue.value == "owned") && genderValue.value=="Family Proof")
                        ChooseImageDocument(
                          title: "Relationship Proof".tr,
                          onTap: () => addEMPDocsProofImageBox(context,14),
                          image: controller.kRelationshipProof.value,
                          fileName: controller.kRelationshipProofName.value,
                        ),
                    ],
                  );
                })
              ],
            ),
            ),
          ),
          SizedBox(height: 20.r),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:15.0.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  title: "Save Draft".tr,
                  width: 140.r,
                  bgColor: AllColors.green,
                  background: false,
                  height: 38.r,
                  radius: 0,
                  onTap: ()async{
                    bool status = await  controller.addEmployeeDocumentNetworkApi("1", genderValue.value=="Family Proof"?2:1 ,ownedValue.value);
                    if (status == true) {
                      employeeHomeTab.value=3;
                    }
                  },
                ),
                CustomButton(
                  title: "Next".tr,
                  width: 140.r,
                  // bgColor: AllColors.green,
                  background: true,
                  height: 38.r,
                  radius: 0,
                  onTap: ()async{
                    if (
                    (controller.kPassportImage.value != "" &&
                        controller.kPANImage.value != "" &&
                        controller.kAadhaarCardImage.value != "" &&
                        controller.k10THMarksheetImage.value != "" &&
                        controller.kAppointmentFormImage.value != "" &&
                        controller.kAppointmentLatterImage.value != "") &&
                        (controller.kSalarySlipsImage.value != "" ||
                            controller.kBankStatementImage.value != "" ||
                            controller.kGraduationImage.value != "" ||
                            controller.kMasterImage.value != "" ||
                            controller.kCertificateImage.value != "" ||
                            controller.kOwnerShipProof.value != "" ||
                            controller.kRealAgreeProof.value != "" ||
                            controller.kRelationshipProof.value != "")) {
                      bool status = await controller.addEmployeeDocumentNetworkApi("2", genderValue.value=="Family Proof"?2:1, ownedValue.value);
                      if (status == true) {
                        addEMPTab.value=4;
                      }
                    }else{
                      BaseController().errorSnack("Please choose all required documents Images");
                    }
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 20.r),
        ],
      ),
    );
  }

  addEMPDocsProofImageBox(BuildContext context, type) {
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
                        controller.KYCDocumentImages(false,type);
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
                        controller.KYCDocumentImages(true,type);
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

class ChooseImageDocument extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String? subTitle;
  final String? fileName;
  final String image;
  final bool? optional;
  const ChooseImageDocument(
      {super.key, this.onTap, required this.title, this.subTitle, required this.image, this.optional=false, this.fileName=""});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DottedBorder(
          borderType: BorderType.Rect,
          radius: Radius.circular(5.r),
          strokeWidth: 1.5.r,
          dashPattern: const [5, 4],
          color: AllColors.black.withOpacity(0.5),
          child: image!=""?
          Container(
            height: 100.r,
            width: 150.r,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(File(image.toString()),
                  )
              ),
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                title: "Browser Files".tr,
                height: 22.r,
                radius: 0,
                onTap: onTap,
                bgColor: AllColors.black.withOpacity(0.5),
                background: false,
                border: false,
                miniFont: true,
              ),
            ),
          ) :
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
            child: Column(
              children: [
                Icon(Icons.cloud_download_rounded, size: 25.r,
                    color: Colors.black.withOpacity(0.6)),
                SizedBox(height: 3.r),
                Text(
                  "Drag & Drop files here",
                  style: fontExtraSmall.copyWith(
                      color: Colors.black.withOpacity(0.6)),
                ),
                SizedBox(height: 5.r),
                Text(
                  "or",
                  style: fontExtraSmall.copyWith(
                      color: Colors.black.withOpacity(0.6)),
                ),
                SizedBox(height: 5.r),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.r, vertical: 3.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      border: Border.all(
                          width: 1.r, color: AllColors.blue.withOpacity(0.9)),
                    ),
                    child: Text("Browser Files", style: fontExtraSmall.copyWith(
                        color: AllColors.blue.withOpacity(0.9),
                        letterSpacing: 0.1),),
                  ),
                ),
                SizedBox(height: 5.r),
              ],
            ),
          ),
        ),
        SizedBox(width: 15.r),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: title.toString(),
                  style: fontSmall.copyWith(
                      color: AllColors.black.withOpacity(0.9),
                      letterSpacing: 0.2),
                  children: [
                    TextSpan(text: optional==false? " * ":"", style: fontMedium.copyWith(
                      color: AllColors.red.withOpacity(0.8),
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.r),
              Text(subTitle ?? "", style: fontExtraSmall.copyWith(
                  color: AllColors.black.withOpacity(0.5)),),
              SizedBox(height: 2.r),
              Text(fileName.toString(), style: fontExtraSmall.copyWith(
                  color: AllColors.black.withOpacity(0.5)),),
            ],
          ),
        )
      ],
    );
  }
}


