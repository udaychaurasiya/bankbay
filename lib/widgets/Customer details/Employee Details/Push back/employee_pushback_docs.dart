
import 'dart:io';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_push_back_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmployeePushBackDocsScreen extends StatefulWidget {
  final String empId;
  const EmployeePushBackDocsScreen({super.key, required this.empId});

  @override
  State<EmployeePushBackDocsScreen> createState() => _EmployeePushBackDocsScreenState();
}
var controller =  Get.find<PartnerController>();

class _EmployeePushBackDocsScreenState extends State<EmployeePushBackDocsScreen> {
  var empPassport = "".obs;
  var empPAN = "".obs;
  var empAadhaarCard = "".obs;
  var empSalarySlips = "".obs;
  var empBankStatement = "".obs;
  var emp10THMarksheet = "".obs;
  var empGraduation = "".obs;
  var empMaster = "".obs;
  var empCertificate = "".obs;
  var empAppointmentForm = "".obs;
  var empAppointmentLatter = "".obs;
  var empOwnerShip = "".obs;
  var empRealAgree = "".obs;
  var empRelationship = "".obs;

  @override
  void initState() {
    controller.getEmployeeDetailsNetworkApi(widget.empId.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var ownedValue = (controller.employeeDetails.value.data.basicDetails.addressProofType.toString()=="rented"?2:1).obs;
    RxString genderValue = (controller.employeeDetails.value.data.basicDetails.propertyOwnerType.toString()=="2"?"Family Proof":"My Proof").obs;
    return GetBuilder<PartnerController>(
        builder: (controller) {
          empPassport.value = controller.employeeDetails.value.data.basicDetails.docPassport.toString();
          empPAN.value = controller.employeeDetails.value.data.basicDetails.docPan.toString();
          empAadhaarCard.value = controller.employeeDetails.value.data.basicDetails.docAadhar.toString();
          empSalarySlips.value = controller.employeeDetails.value.data.basicDetails.docSalaryslip.toString();
          empBankStatement.value = controller.employeeDetails.value.data.basicDetails.docBanking.toString();
          emp10THMarksheet.value = controller.employeeDetails.value.data.basicDetails.doc10ThProof.toString();
          empGraduation.value = controller.employeeDetails.value.data.basicDetails.docGraduationProof.toString();
          empMaster.value = controller.employeeDetails.value.data.basicDetails.docMastersProof.toString();
          empCertificate.value = controller.employeeDetails.value.data.basicDetails.doc12ThProof.toString();
          empAppointmentForm.value = controller.employeeDetails.value.data.basicDetails.empRelivingLetter.toString();
          empAppointmentLatter.value = controller.employeeDetails.value.data.basicDetails.docPhdProof.toString();
          empOwnerShip.value = controller.employeeDetails.value.data.basicDetails.docOhp.toString();
          empRealAgree.value = controller.employeeDetails.value.data.basicDetails.docRentAgreement.toString();
          empRelationship.value = controller.employeeDetails.value.data.basicDetails.docRelationProof.toString();

          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.r),
                    Obx(() => controller.empPassportImage.value!=""?
                      ChooseImageDocument(
                        title: "Passport Photo".tr,
                        image: controller.empPassportImage.value,
                        subTitle: controller.empPassportImageName.value!=""?controller.empPassportImageName.value:"",
                        onTap: () => employeeProfileDocsProofImageBox(context, 1),
                      ) :
                      ChooseImageDocumentView(
                        title: "Passport Photo".tr,
                        image: empPassport.value,
                        onTap: () => employeeProfileDocsProofImageBox(context, 1),
                      ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => controller.empPANImage.value!=""?
                      ChooseImageDocument(
                        image: controller.empPANImage.value,
                        subTitle: controller.empPANImageName.value!=""?controller.empPANImageName.value:"Single PDF file",
                        title: "PAN Card".tr,
                        onTap: () => employeeProfileDocsProofImageBox(context, 2),
                      ):
                      ChooseImageDocumentView(
                        image: empPAN.value,
                        title: "PAN Card".tr,
                        onTap: () => employeeProfileDocsProofImageBox(context, 2),
                      ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => controller.empAadhaarCardImage.value!=""?
                    ChooseImageDocument(
                      image: controller.empAadhaarCardImage.value,
                      subTitle: controller.empAadhaarCardImageName.value!=""?controller.empAadhaarCardImageName.value:"Single PDF file",
                      title: "AADHAAR (both sides)".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 3),
                    ):
                    ChooseImageDocumentView(
                      image: empAadhaarCard.value,
                      title: "AADHAAR (both sides)".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 3),
                    ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => controller.empSalarySlipsImage.value!=""?
                    ChooseImageDocument(
                      image: controller.empSalarySlipsImage.value,
                      subTitle: controller.empSalarySlipsImageName.value!=""?controller.empSalarySlipsImageName.value:"Single PDF file",
                      title: "Salary Slip".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 4),
                    ):
                    ChooseImageDocumentView(
                      image: empSalarySlips.value,
                      title: "Salary Slip".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 4),
                    ),
                    ),

                    SizedBox(height: 20.r),
                    Obx(() => controller.empBankStatementImage.value!=""?
                    ChooseImageDocument(
                      image: controller.empBankStatementImage.value,
                      subTitle: controller.empBankStatementImageName.value!=""?controller.empBankStatementImageName.value:"Single PDF file",
                      title: "Bank Statement".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 5),
                    ):
                    ChooseImageDocumentView(
                      image: empBankStatement.value,
                      title: "Bank Statement".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 5),
                    ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => controller.emp10THMarksheetImage.value!=""?
                    ChooseImageDocument(
                      image: controller.emp10THMarksheetImage.value,
                      subTitle: controller.emp10THMarksheetImageName.value!=""?controller.emp10THMarksheetImageName.value:"Single PDF file",
                      title: "10th Mark Sheet".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 6),
                    ):
                    ChooseImageDocumentView(
                      image: emp10THMarksheet.value,
                      title: "10th Mark Sheet".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 6),
                    ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => controller.empGraduationImage.value!=""?
                    ChooseImageDocument(
                      image: controller.empGraduationImage.value,
                      subTitle: controller.empGraduationImageName.value!=""?controller.empGraduationImageName.value:"Single PDF file",
                      title: "Graduation Mark sheet".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 7),
                    ):
                    ChooseImageDocumentView(
                      image: empGraduation.value,
                      title: "Graduation Mark sheet".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 7),
                    ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => controller.empMasterImage.value!=""?
                    ChooseImageDocument(
                      image: controller.empMasterImage.value,
                      subTitle: controller.empMasterImageName.value!=""?controller.empMasterImageName.value:"Single PDF file",
                      title: "Master/PHD Mark sheet".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 8),
                    ):
                    ChooseImageDocumentView(
                      image: empMaster.value,
                      title: "Master/PHD Mark sheet".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 8),
                    ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => controller.empCertificateImage.value!=""?
                    ChooseImageDocument(
                      image: controller.empCertificateImage.value,
                      subTitle: controller.empCertificateImageName.value!=""?controller.empCertificateImageName.value:"Single PDF file",
                      title: "Certificate Diploma".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 9),
                    ):
                    ChooseImageDocumentView(
                      image: empCertificate.value,
                      title: "Certificate Diploma".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 9),
                    ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => controller.empAppointmentFormImage.value!=""?
                    ChooseImageDocument(
                      image: controller.empAppointmentFormImage.value,
                      subTitle: controller.empAppointmentFormImageName.value!=""?controller.empAppointmentFormImageName.value:"Single PDF file",
                      title: "Appointment & Relieving Letter From All Post Companies".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 10),
                    ):
                    ChooseImageDocumentView(
                      image: empAppointmentForm.value,
                      title: "Appointment & Relieving Letter From All Post Companies".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 10),
                    ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => controller.empAppointmentLatterImage.value!=""?
                    ChooseImageDocument(
                      image: controller.empAppointmentLatterImage.value,
                      subTitle: controller.empAppointmentLatterImageName.value!=""?controller.empAppointmentLatterImageName.value:"Single PDF file",
                      title: "Appointment Letter".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 11),
                    ):
                    ChooseImageDocumentView(
                      image: empAppointmentLatter.value,
                      title: "Appointment Letter".tr,
                      onTap: () => employeeProfileDocsProofImageBox(context, 11),
                    ),
                    ),
                    SizedBox(height: 20.r),
                    Text("Address Proof",style: fontBold.copyWith(),),
                    SizedBox(height: 20.r),
                    Obx(() => Container(
                      height: 30.r,
                      width: Get.width/2,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.r, color: AllColors.blue),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                ownedValue.value = 1;
                                print("value ${ownedValue.value}");
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r),bottomLeft: Radius.circular(5.r)),
                                  color:  ownedValue.value == 1?AllColors.blue.withOpacity(0.9):AllColors.white.withOpacity(0.9),
                                ),
                                child: Text("Owned", style: fontSmall.copyWith(color: ownedValue.value == 1 ?AllColors.white.withOpacity(0.9):AllColors.blue.withOpacity(0.9)),),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                ownedValue.value = 2;
                                print("value ${ownedValue.value}");
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(5.r),bottomRight: Radius.circular(5.r)),
                                  color: ownedValue.value == 2?AllColors.blue.withOpacity(0.9):AllColors.white.withOpacity(0.9),
                                ),
                                child: Text("Rented", style: fontSmall.copyWith(color: ownedValue.value == 2?AllColors.white.withOpacity(0.9):AllColors.blue.withOpacity(0.9)),),
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
                          if(ownedValue.value == 1 && (genderValue.value=="My Proof"||genderValue.value=="Family Proof"))
                            SizedBox(height: 20.r),
                          if(ownedValue.value == 1 && (genderValue.value=="My Proof"||genderValue.value=="Family Proof"))
                            Obx(() => controller.empOwnerShipProof.value!=""?
                            ChooseImageDocument(
                              image: controller.empOwnerShipProof.value,
                              subTitle: controller.empOwnerShipProofName.value!=""?controller.empOwnerShipProofName.value:"Single PDF file",
                              title: "Ownership Proof".tr,
                              onTap: () => employeeProfileDocsProofImageBox(context, 12),
                            ):
                            ChooseImageDocumentView(
                              image: empOwnerShip.value,
                              title: "Ownership Proof".tr,
                              onTap: () => employeeProfileDocsProofImageBox(context, 12),
                            ),
                            ),
                          if(ownedValue.value == 2 && (genderValue.value=="My Proof"||genderValue.value=="Family Proof"))
                            SizedBox(height: 20.r),
                          if(ownedValue.value == 2 && (genderValue.value=="My Proof"||genderValue.value=="Family Proof"))
                            Obx(() => controller.empRealAgreeProof.value!=""?
                            ChooseImageDocument(
                              image: controller.empRealAgreeProof.value,
                              subTitle: controller.empRealAgreeProofName.value!=""?controller.empRealAgreeProofName.value:"Single PDF file",
                              title: "Rent Agreement".tr,
                              onTap: () => employeeProfileDocsProofImageBox(context, 13),
                            ):
                            ChooseImageDocumentView(
                              image: empRealAgree.value,
                              title: "Rent Agreement".tr,
                              onTap: () => employeeProfileDocsProofImageBox(context, 13),
                            ),
                            ),
                          if((ownedValue.value == 2 || ownedValue.value == 1) && genderValue.value=="Family Proof")
                            SizedBox(height: 20.r),
                          if((ownedValue.value == 2 || ownedValue.value == 1) && genderValue.value=="Family Proof")
                            Obx(() => controller.empRelationshipProof.value!=""?
                            ChooseImageDocument(
                              image: controller.empRelationshipProof.value,
                              subTitle: controller.empRelationshipProofName.value!=""?controller.empRelationshipProofName.value:"Single PDF file",
                              title: "Relationship Proof".tr,
                              onTap: () => employeeProfileDocsProofImageBox(context, 14),
                            ):
                            ChooseImageDocumentView(
                              image: empRelationship.value,
                              title: "Relationship Proof".tr,
                              onTap: () => employeeProfileDocsProofImageBox(context, 14),
                            ),
                            ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 30.r),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:15.0.r),
                child: CustomButton(
                  title: "Next".tr,
                  bgColor: AllColors.green,
                  background: false,
                  height: 38.r,
                  radius: 0,
                  onTap: ()async{
                    bool status = await controller.addEmployeeDocumentNetworkApi(
                        ownedValue.value==2?"rented":"owned", genderValue.value=="Family Proof"?2:1,
                        controller.employeeDetails.value.data.basicDetails.id,
                    );
                    if (status == true) {
                      employeePushBackDetailsTab.value = 4;
                    }
                  },
                ),
              ),
            ],
          );
        }
    );
  }

  employeeProfileDocsProofImageBox(BuildContext context, type) {
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
                        controller.employeeProfileDocumentImages(false,type);
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
                        controller.employeeProfileDocumentImages(true,type);
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

class ChooseImageDocumentView extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String? subTitle;
  final String? fileName;
  final String image;
  final bool? optional;
  const ChooseImageDocumentView(
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
            child: Container(
              height: 100.r,
              width: 150.r,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image=="null"||image==""?Images.noDataFound:AppConstants.BASE_URL+image.toString(),
                  ),
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
            )
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
