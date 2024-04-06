import 'dart:io';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDraftLoanDocs extends StatefulWidget {
  final String? leadId;
  const CustomerDraftLoanDocs({super.key, required this.leadId});

  @override
  State<CustomerDraftLoanDocs> createState() => _CustomerDraftLoanDocsState();
}

class _CustomerDraftLoanDocsState extends State<CustomerDraftLoanDocs> {
  var controller = Get.find<PartnerController>();
  var loginController = Get.find<LoginController>();
  var userImage = "".obs;
  var panCardImage = "".obs;
  var aadharCardImage = "".obs;
  var salarySlipImage = "".obs;
  var bankingImage = "".obs;
  var ownerShipImage = "".obs;
  var relationShipImage = "".obs;

  @override
  void initState() {
    saveData();
    super.initState();
  }

  saveData()async{
    bool status = await controller.getLeadDetailsNetworkApi(widget.leadId);
    if(status==true){
      userImage.value = controller.getLeadDetails.value.data.custLoanSelfie.toString();
      panCardImage.value = controller.getLeadDetails.value.data.docPan.toString();
      aadharCardImage.value = controller.getLeadDetails.value.data.docAadhar.toString();
      salarySlipImage.value = controller.getLeadDetails.value.data.docSalaryslip.toString();
      bankingImage.value = controller.getLeadDetails.value.data.docBanking.toString();
      ownerShipImage.value = controller.getLeadDetails.value.data.docOhp.toString();
      relationShipImage.value = controller.getLeadDetails.value.data.docRelationProof.toString();
      controller.leadUserImage.value = "";
      controller.leadPanCardImage.value = "";
      controller.leadAadhaarCardImage.value = "";
      controller.leadSalarySlipImage.value = "";
      controller.leadBankStatementImage.value = "";
      controller.leadOwnerShipProof.value = "";
      controller.leadRelationshipProof.value = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    RxString detailsOwnerValue = (controller.getLeadDetails.value.data.propertyOwnerType.toString()=="2"?"Family Proof":"My Proof").obs;
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("Validate Document", style: fontBold.copyWith(fontSize: 13.r),)),
          Center(child: Text("Update or Get document upload as needed", style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.6),fontStyle: FontStyle.italic),)),
          SizedBox(height: 20.r),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => controller.leadUserImage.value!=""?
                ChooseImageDocument(
                  title: "Borrower's Photo".tr,
                  subTitle: "user image upload",
                  image: controller.leadUserImage.value,
                  onTap: () => leadDocsReUploadImageBox(context, 1),
                ) :
                ChooseImageDocumentView(
                title: "Borrower's Photo".tr,
                image: userImage.value,
                subTitle: "user image upload",
                onTap: () => leadDocsReUploadImageBox(context, 1),
              ),
              ),
              SizedBox(height: 15.r),
              Obx(() => controller.leadPanCardImage.value!=""?
                ChooseImageDocument(
                  title: "Pan Card".tr,
                  subTitle: "pan card image upload".tr,
                  image: controller.leadPanCardImage.value,
                  onTap: () => leadDocsReUploadImageBox(context, 2),
                ) :
                ChooseImageDocumentView(
                title: "Pan Card".tr,
                subTitle: "pan card image upload".tr,
                image: panCardImage.value,
                onTap: () => leadDocsReUploadImageBox(context, 2),
              ),
              ),
              SizedBox(height: 15.r),
              Obx(() => controller.leadAadhaarCardImage.value!=""?
                ChooseImageDocument(
                  title: "Aadhaar (both sides)".tr,
                  subTitle: "single PDF file".tr,
                  image: controller.leadAadhaarCardImage.value,
                  onTap: () => leadDocsReUploadImageBox(context, 3),
                ) :
                ChooseImageDocumentView(
                title: "Aadhaar (both sides)".tr,
                subTitle: "single PDF file".tr,
                image: aadharCardImage.value,
                onTap: () => leadDocsReUploadImageBox(context, 3),
              ),
              ),
              SizedBox(height: 15.r),
              Obx(() => controller.leadSalarySlipImage.value!=""?
                ChooseImageDocument(
                  title: "Salary Slips".tr,
                  subTitle: "latest 3 months".tr,
                  image: controller.leadSalarySlipImage.value,
                  onTap: () => leadDocsReUploadImageBox(context, 4),
                ) :
                ChooseImageDocumentView(
                title: "Salary Slips".tr,
                subTitle: "latest 3 months".tr,
                image: salarySlipImage.value,
                onTap: () => leadDocsReUploadImageBox(context, 4),
              ),
              ),
              SizedBox(height: 15.r),
              Obx(() => controller.leadBankStatementImage.value!=""?
                ChooseImageDocument(
                  title: "Bank Statement".tr,
                  subTitle: "latest 6 months".tr,
                  image: controller.leadBankStatementImage.value,
                  onTap: () => leadDocsReUploadImageBox(context, 5),
                ) :
                ChooseImageDocumentView(
                title: "Bank Statement".tr,
                subTitle: "latest 6 months".tr,
                image: bankingImage.value,
                onTap: () => leadDocsReUploadImageBox(context, 5),
              ),
              ),
              SizedBox(height: 30.r),
              Text("Property ownership Proof", style: fontBold.copyWith(),),
              SizedBox(height: 20.r),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: ()=> detailsOwnerValue.value = "My Proof",
                      child: Row(
                        children: [
                          SizedBox(
                            height: 20.r,
                            width: 20.r,
                            child: Radio(
                              value: "My Proof",
                              groupValue: detailsOwnerValue.value,
                              onChanged: (value) {
                                detailsOwnerValue.value = value.toString();
                                print("object ${detailsOwnerValue.value}");
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
                      onTap: ()=> detailsOwnerValue.value = "Family Proof",
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.r,
                            width: 20.r,
                            child: Radio(
                              value: "Family Proof",
                              groupValue: detailsOwnerValue.value,
                              onChanged: (value) {
                                detailsOwnerValue.value = value.toString();
                                print("object ${detailsOwnerValue.value}");
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
                  ],
                ),
              ),
              if(detailsOwnerValue.value=="My Proof"||detailsOwnerValue.value=="Family Proof")
                SizedBox(height: 20.r),
              if(detailsOwnerValue.value=="My Proof"||detailsOwnerValue.value=="Family Proof")
                Obx(() => controller.leadOwnerShipProof.value!=""?
                  ChooseImageDocument(
                    title: "Ownership Proof".tr,
                    subTitle: "Electric bill/ holding tax/ Sale deed any One".tr,
                    image: controller.leadOwnerShipProof.value,
                    onTap: () => leadDocsReUploadImageBox(context, 6),
                  ) :
                  ChooseImageDocumentView(
                  title: "Ownership Proof".tr,
                  subTitle: "Electric bill/ holding tax/ Sale deed any One".tr,
                  image: ownerShipImage.value,
                  onTap: () => leadDocsReUploadImageBox(context, 6),
                ),
                ),
              if(detailsOwnerValue.value=="Family Proof")
                SizedBox(height: 20.r),
              if(detailsOwnerValue.value=="Family Proof")
                Obx(() => controller.leadRelationshipProof.value!=""?
                  ChooseImageDocument(
                    title: "Relationship proof".tr,
                    subTitle: "Marriage certificate that shows relationship with property owner".tr,
                    image: controller.leadRelationshipProof.value,
                    onTap: () => leadDocsReUploadImageBox(context, 7),
                  ) :
                  ChooseImageDocumentView(
                  title: "Relationship proof".tr,
                  subTitle: "Marriage certificate that shows relationship with property owner".tr,
                  image: relationShipImage.value,
                  onTap: () => leadDocsReUploadImageBox(context, 7),
                ),
                ),
            ],
          ),
          SizedBox(height: 30.r),
          CustomButton(
            title: "Update".tr,
            background: true,
            radius: 5.r,
            height: 35.r,
            width: Get.width - 60,
            onTap: () async{
              bool status = await controller.leadDocumentReUploadNetworkApi(
                controller.getLeadDetails.value.data.custId,
                controller.getLeadDetails.value.data.id,
                detailsOwnerValue.value=="Family Proof"?2:1,
                "owned",
              );
              if(status==true){
                controller.getLeadDetailsNetworkApi(widget.leadId);
                controller.getLeadDetails.refresh();
              }
            },
          ),
          // InkWell(
          //   onTap: () async{
          //     /*bool status = await*/ controller.leadDocumentReUploadNetworkApi(
          //       controller.getLeadDetails.value.data.custId,
          //       controller.getLeadDetails.value.data.id,
          //       detailsOwnerValue.value=="Family Proof"?2:1,
          //       // controller.leadUserImage.value
          //     );
          //   },
          //   child: Container(
          //     height: 35.h,
          //     decoration: BoxDecoration(
          //         color: AllColors.darkBlue,
          //         border: Border.all(color: AllColors.darkBlue)
          //     ),
          //     child: Center(
          //       child: Text("Update Now",style: fontBold.copyWith(color: Colors.white),),
          //     ),
          //   ),
          // ),
          SizedBox(height: 15.r),
        ],
      ),
      ),
    );
  }

  leadDocsReUploadImageBox(BuildContext context, type) {
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
                        controller.leadDocumentReUpload(false,type);
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
                        controller.leadDocumentReUpload(true,type);
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
  final String image;
  const ChooseImageDocument(
      {super.key, this.onTap, required this.title, this.subTitle, required this.image});

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
            child: Align(
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
          child: SizedBox(
            height: 90.r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(title.toString(),style: fontBold.copyWith(
                          color: AllColors.black.withOpacity(0.9),
                          fontSize: 13.r,
                          letterSpacing: 0.2),
                      ),
                      Text(subTitle ?? "", style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.5),fontSize: 11.r),),
                    ],
                  ),
                ),
                const SizedBox(),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChooseImageDocumentView extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String? subTitle;
  final String image;
  const ChooseImageDocumentView({super.key, this.onTap, required this.title, this.subTitle, required this.image});

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
            child: InkWell(
              onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+image.toString())),
              child: Container(
                height: 100.r,
                width: 150.r,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.BASE_URL+image.toString(),
                      )
                  ),
                ),
                child: Align(
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
              ),
            )
        ),
        SizedBox(width: 15.r),
        Expanded(
          child: SizedBox(
            height: 90.r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title.toString(),style: fontBold.copyWith(
                    color: AllColors.black.withOpacity(0.9),
                    fontSize: 13.r,
                    letterSpacing: 0.2),
                ),
                Text(subTitle ?? "", style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.5),fontSize: 11.r),),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}