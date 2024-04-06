import 'dart:io';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailsDocument extends StatefulWidget {
  final String? leadId;
  final String? pageName;
  const DetailsDocument({super.key, required this.leadId, this.pageName});

  @override
  State<DetailsDocument> createState() => _DetailsDocumentState();
}

class _DetailsDocumentState extends State<DetailsDocument> {
  var controller = Get.find<PartnerController>();
  var loginController = Get.find<LoginController>();
  var permissionController = Get.find<PermissionController>();
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
    // var ownedValue = (controller.getLeadDetails.value.data.addressProofType.toString()=="rented"?2:1).obs;
    RxString detailsOwnerValue = (controller.getLeadDetails.value.data.propertyOwnerType.toString()=="2"?"Family Proof":"My Proof").obs;
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("Validate Document", style: fontBold.copyWith(fontSize: 13.r),)),
          Center(child: Text("Update or Get document upload as needed", style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.6),fontStyle: FontStyle.italic),)),
          SizedBox(height: 20.r),
          if(controller.getLeadDetails.value.data.leadSource.toString()==GetStorage().read(AppConstant.cust_id).toString())
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => controller.leadUserImage.value!=""?
                  ChooseImageDocument(
                    title: "Borrower's Photo".tr,
                    subTitle: "user image upload",
                    image: controller.leadUserImage.value,
                    status: controller.getLeadDetails.value.data.custLoanSelfieVerifyStatus,
                    onTap: () => leadDocsReUploadImageBox(context, 1),
                  ) :
                  ChooseImageDocumentView(
                    pageName: widget.pageName,
                    title: "Borrower's Photo".tr,
                    image: userImage.value,
                    subTitle: "user image upload",
                    status: controller.getLeadDetails.value.data.custLoanSelfieVerifyStatus,
                    onTap: () => leadDocsReUploadImageBox(context, 1),
                  ),
                ),
                SizedBox(height: 15.r),
                Obx(() => controller.leadPanCardImage.value!=""?
                  ChooseImageDocument(
                    title: "Pan Card".tr,
                    subTitle: "pan card image upload".tr,
                    image: controller.leadPanCardImage.value,
                    status: controller.getLeadDetails.value.data.docPanVerifyStatus,
                    onTap: () => leadDocsReUploadImageBox(context, 2),
                  ) :
                  ChooseImageDocumentView(
                    pageName: widget.pageName,
                    title: "Pan Card".tr,
                    subTitle: "pan card image upload".tr,
                    image: panCardImage.value,
                    status: controller.getLeadDetails.value.data.docPanVerifyStatus,
                    onTap: () => leadDocsReUploadImageBox(context, 2),
                  ),
                ),
                SizedBox(height: 15.r),
                Obx(() => controller.leadAadhaarCardImage.value!=""?
                  ChooseImageDocument(
                    title: "Aadhaar (both sides)".tr,
                    subTitle: "single PDF file".tr,
                    image: controller.leadAadhaarCardImage.value,
                    status: controller.getLeadDetails.value.data.docAadharVerifyStatus,
                    onTap: () => leadDocsReUploadImageBox(context, 3),
                  ) :
                  ChooseImageDocumentView(
                    pageName: widget.pageName,
                    title: "Aadhaar (both sides)".tr,
                    subTitle: "single PDF file".tr,
                    image: aadharCardImage.value,
                    status: controller.getLeadDetails.value.data.docAadharVerifyStatus,
                    onTap: () => leadDocsReUploadImageBox(context, 3),
                  ),
                ),
                SizedBox(height: 15.r),
                Obx(() => controller.leadSalarySlipImage.value!=""?
                  ChooseImageDocument(
                    title: "Salary Slips".tr,
                    subTitle: "latest 3 months".tr,
                    image: controller.leadSalarySlipImage.value,
                    status: controller.getLeadDetails.value.data.docSalaryslipVerifyStatus,
                    onTap: () => leadDocsReUploadImageBox(context, 4),
                  ) :
                  ChooseImageDocumentView(
                    pageName: widget.pageName,
                    title: "Salary Slips".tr,
                    subTitle: "latest 3 months".tr,
                    image: salarySlipImage.value,
                    status: controller.getLeadDetails.value.data.docSalaryslipVerifyStatus,
                    onTap: () => leadDocsReUploadImageBox(context, 4),
                  ),
                ),
                SizedBox(height: 15.r),
                Obx(() => controller.leadBankStatementImage.value!=""?
                  ChooseImageDocument(
                    title: "Bank Statement".tr,
                    subTitle: "latest 6 months".tr,
                    image: controller.leadBankStatementImage.value,
                    status: controller.getLeadDetails.value.data.docBankingVerifyStatus,
                    onTap: () => leadDocsReUploadImageBox(context, 5),
                  ) :
                  ChooseImageDocumentView(
                    pageName: widget.pageName,
                    title: "Bank Statement".tr,
                    subTitle: "latest 6 months".tr,
                    image: bankingImage.value,
                    status: controller.getLeadDetails.value.data.docBankingVerifyStatus,
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
                      status: controller.getLeadDetails.value.data.docOhpVerifyStatus,
                      onTap: () => leadDocsReUploadImageBox(context, 6),
                    ) :
                    ChooseImageDocumentView(
                      pageName: widget.pageName,
                      title: "Ownership Proof".tr,
                      subTitle: "Electric bill/ holding tax/ Sale deed any One".tr,
                      image: ownerShipImage.value,
                      status: controller.getLeadDetails.value.data.docOhpVerifyStatus,
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
                      status: controller.getLeadDetails.value.data.docRelationProofVerifyStatus,
                      onTap: () => leadDocsReUploadImageBox(context, 7),
                    ) :
                    ChooseImageDocumentView(
                      pageName: widget.pageName,
                      title: "Relationship proof".tr,
                      subTitle: "Marriage certificate that shows relationship with property owner".tr,
                      image: relationShipImage.value,
                      status: controller.getLeadDetails.value.data.docRelationProofVerifyStatus,
                      onTap: () => leadDocsReUploadImageBox(context, 7),
                    ),
                  ),
              ],
            ),
          if(controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id).toString())
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoanDetailsDocumentView(
                  pageName: widget.pageName,
                  title: "Borrower's Photo".tr,
                  subTitle: "user image upload".tr,
                  image: controller.getLeadDetails.value.data.custLoanSelfie.toString(),
                  status: controller.getLeadDetails.value.data.custLoanSelfieVerifyStatus,
                  sourceID: controller.getLeadDetails.value.data.leadSource,
                  no: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId,"selfie", "NOT OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                    }
                  },
                  yes: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId,"selfie", "OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                    }
                  },
                  permission: (controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")?true:false,
                ),
                SizedBox(height: 15.r),
                LoanDetailsDocumentView(
                  pageName: widget.pageName,
                  title: "Pan Card".tr,
                  subTitle: "pan card image upload".tr,
                  image: controller.getLeadDetails.value.data.docPan.toString(),
                  status: controller.getLeadDetails.value.data.docPanVerifyStatus,
                  sourceID: controller.getLeadDetails.value.data.leadSource,
                  no: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId,"pan", "NOT OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                    }
                  },
                  yes:  ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId,"pan", "OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                    }
                  },
                  permission: (controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")?true:false,
                ),
                SizedBox(height: 15.r),
                LoanDetailsDocumentView(
                  pageName: widget.pageName,
                  title: "Aadhaar (both sides)".tr,
                  subTitle: "single PDF file".tr,
                  image: controller.getLeadDetails.value.data.docAadhar.toString(),
                  status: controller.getLeadDetails.value.data.docAadharVerifyStatus,
                  sourceID: controller.getLeadDetails.value.data.leadSource,
                  no: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId,"aadhar", "NOT OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                    }
                  },
                  yes: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId,"aadhar", "OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                    }
                  },
                  permission: (controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")?true:false,
                ),
                SizedBox(height: 15.r),
                LoanDetailsDocumentView(
                  pageName: widget.pageName,
                  title: "Salary Slips".tr,
                  subTitle: "latest 3 months".tr,
                  status: controller.getLeadDetails.value.data.docSalaryslipVerifyStatus,
                  image: controller.getLeadDetails.value.data.docSalaryslip.toString(),
                  sourceID: controller.getLeadDetails.value.data.leadSource,
                  no: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId.toString(),"salary_slip", "NOT OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                    }
                  },
                  yes: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId.toString(),"salary_slip", "OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                    }
                  },
                  permission: (controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")?true:false,
                ),
                SizedBox(height: 15.r),
                LoanDetailsDocumentView(
                  pageName: widget.pageName,
                  title: "Bank Statement".tr,
                  subTitle: "latest 6 months".tr,
                  image: controller.getLeadDetails.value.data.docBanking.toString(),
                  status: controller.getLeadDetails.value.data.docBankingVerifyStatus,
                  sourceID: controller.getLeadDetails.value.data.leadSource,
                  no: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId,"bank_statement", "NOT OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                    }
                  },
                  yes: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId,"bank_statement", "OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                    }
                  },
                  permission: (controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")?true:false,
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
                  LoanDetailsDocumentView(
                    pageName: widget.pageName,
                    title: "Ownership Proof".tr,
                    subTitle: "Electric bill/ holding tax/ Sale deed any One".tr,
                    image: controller.getLeadDetails.value.data.docOhp.toString(),
                    status: controller.getLeadDetails.value.data.docOhpVerifyStatus,
                    sourceID: controller.getLeadDetails.value.data.leadSource,
                    no: ()async{
                      bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId,"ownership_proof", "NOT OK");
                      if(status==true){
                        controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                      }
                    },
                    yes: ()async{
                      bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId,"ownership_proof", "OK");
                      if(status==true){
                        controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                      }
                    },
                    permission: (controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")?true:false,
                  ),
                if(detailsOwnerValue.value=="Family Proof")
                  SizedBox(height: 20.r),
                if(detailsOwnerValue.value=="Family Proof")
                  LoanDetailsDocumentView(
                    pageName: widget.pageName,
                    title: "Relationship proof".tr,
                    subTitle: "Marriage certificate that shows relationship with property owner".tr,
                    image: controller.getLeadDetails.value.data.docRelationProof.toString(),
                    status: controller.getLeadDetails.value.data.docRelationProofVerifyStatus,
                    sourceID: controller.getLeadDetails.value.data.leadSource,
                    no: ()async{
                      bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId,"relationship_proof", "NOT OK");
                      if(status==true){
                        controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                      }
                    },
                    yes: ()async{
                      bool status = await controller.updateLeadDocumentStatusNetworkApi(controller.getLeadDetails.value.data.leadId,"relationship_proof", "OK");
                      if(status==true){
                        controller.getLeadDetailsNetworkApi(controller.getLeadDetails.value.data.id);
                      }
                    },
                    permission: (controller.getLeadDetails.value.data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")?true:false,
                  ),
              ],
            ),
          if(controller.getLeadDetails.value.data.leadSource.toString()==GetStorage().read(AppConstant.cust_id).toString())
            SizedBox(height: 30.r),
          if(controller.getLeadDetails.value.data.leadSource.toString()==GetStorage().read(AppConstant.cust_id).toString())
            if((controller.getLeadDetails.value.data.custLoanSelfieVerifyStatus=="NOT OK")||
                (controller.getLeadDetails.value.data.docPanVerifyStatus=="NOT OK")||
                (controller.getLeadDetails.value.data.docAadharVerifyStatus=="NOT OK")||
                (controller.getLeadDetails.value.data.docSalaryslipVerifyStatus=="NOT OK")||
                (controller.getLeadDetails.value.data.docBankingVerifyStatus=="NOT OK")||
                (controller.getLeadDetails.value.data.docOhpVerifyStatus=="NOT OK")||
                (controller.getLeadDetails.value.data.docRelationProofVerifyStatus=="NOT OK"))
            InkWell(
              onTap: () async{
                bool status = await controller.leadDocumentReUploadNetworkApi(
                  controller.getLeadDetails.value.data.custId,
                  controller.getLeadDetails.value.data.id,
                  detailsOwnerValue.value=="Family Proof"?2:1,
                  /*ownedValue.value==2?"ranted":*/"owned",
                );
                if(status==true){
                  bool status = await permissionController.lockUnlockLeadNetworkApi(controller.getLeadDetails.value.data.leadId.toString(), "false");
                  if(status==true){
                    _sendScreen();
                  }
                }
              },
              child: Container(
                height: 35.h,
                decoration: BoxDecoration(
                    color: AllColors.darkBlue,
                    border: Border.all(color: AllColors.darkBlue)
                ),
                child: Center(
                  child: Text("Save as Draft",style: fontBold.copyWith(color: Colors.white),),
                ),
              ),
            ),
          // SizedBox(height: 15.r),
          // InkWell(
          //   onTap: () async{
          //     bool status = await controller.leadDocumentReUploadNetworkApi(
          //       controller.getLeadDetails.value.data.custId,
          //       controller.getLeadDetails.value.data.id,
          //       detailsOwnerValue.value=="Family Proof"?2:1,
          //       /*ownedValue.value==2?"ranted":*/"owned",
          //     );
          //     if(status==true){
          //       bool status = await permissionController.lockUnlockLeadNetworkApi(controller.getLeadDetails.value.data.leadId.toString(), "false");
          //       if(status==true){
          //         _sendScreen();
          //       }
          //     }
          //   },
          //   child: Container(
          //     height: 35.h,
          //     decoration: BoxDecoration(
          //         color: AllColors.green,
          //         // border: Border.all(color: AllColors.darkBlue)
          //     ),
          //     child: Center(
          //       child: Text("Submit for Verification",style: fontBold.copyWith(color: Colors.white),),
          //     ),
          //   ),
          // ),
        ],
      ),),
    );
  }

  _sendScreen(){
    switch (widget.pageName) {
      case "freshLeads":
        Get.back(
            result: {
              loginController.freshLeadNetworkApi(),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "assignedLeads":
        Get.back(
            result: {
              loginController.getMyLeadNetworkApi("","","","","","","",""),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "teamLeads":
        Get.back(
            result: {
              loginController.teamLeadsNetworkApi("","","","","","","","",loginController.filterTypeSelected.value,loginController.isTeamLeadEmpSelected.value,controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "newLead":
        Get.back(
            result: {
              loginController.allLeadsDataNetworkApi("","","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","",controller.leadStatusNameFilter(loginController.leadsPageName.value.toString()),controller.sourceFilterSendValue(loginController.filterTypeSelected.value.toString()),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "verificationLead":
        Get.back(
            result: {
              loginController.verificationNetworkApi("","","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","",controller.leadStatusNameFilter(loginController.leadsPageName.value),controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "loginLead":
        Get.back(
            result: {
              loginController.loginLeadsNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","",controller.leadStatusNameFilter(loginController.leadsPageName.value), controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "sanctionedLead":
        Get.back(
            result: {
              loginController.sanctionedLeadsNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","",controller.leadStatusNameFilter(loginController.leadsPageName.value), controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "disbursedLead":
        Get.back(
            result: {
              loginController.disbursedLeadsNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","",controller.leadStatusNameFilter(loginController.leadsPageName.value), controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              Navigator.of(context).pop(),
            }
        );
        break;
      case "incentiveLead":
        Get.back(
            result: {
              loginController.incentiveDataNetworkApi("","",controller.loanTypeDecode(loginController.selectLoanType.value.toString()),"","","","","",controller.leadStatusNameFilter(loginController.leadsPageName.value), controller.sourceFilterSendValue(loginController.filterTypeSelected.value),controller.leadStatusNameFilter(loginController.selectEmployeePartnerValue.value)),
              Navigator.of(context).pop(),
            }
        );
        break;
    }
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

class LoanDetailsDocumentView extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? status;
  final String image;
  final bool permission;
  final dynamic sourceID;
  final GestureTapCallback? no;
  final GestureTapCallback? yes;
  final GestureTapCallback? chooseImage;
  final String? pageName;
  const LoanDetailsDocumentView({super.key, required this.title, this.subTitle, required this.image, this.no, this.yes, this.status="", required this.permission, this.sourceID, this.chooseImage, this.pageName});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DottedBorder(
          borderType: BorderType.Rect,
          radius: Radius.circular(5.r),
          strokeWidth: 1.5.r,
          dashPattern: const [5, 4],
          color: AllColors.black.withOpacity(0.5),
          child: InkWell(
            onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+image.toString())),
            child: SizedBox(
              height: 90.r,
              width: 150.r,
              child: CachedNetworkImage(
                imageUrl: AppConstants.BASE_URL+image,
                fadeOutDuration: const Duration(seconds: 3),
                imageBuilder: (context,
                    imageProvider) =>
                    Container(
                      decoration:
                      BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter:
                            const ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
                      ),
                    ),
                placeholder: (context, url) =>
                    Center(
                      child: SizedBox(
                        height: 45.r,
                        width: 45.r,
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                errorWidget: (context, url, error) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 40.r, color: AllColors.orange.withOpacity(0.7),),
                    SizedBox(height: 3.r),
                    Text("Image not found!", style: fontExtraSmall.copyWith(color: AllColors.black.withOpacity(0.7)),)
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 15.r),
        Expanded(
          child: SizedBox(
            height: 90.r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(permission==true)
                    if(status==""||status==null)
                      if(pageName!="unassignedLead")
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                              title: "Ok".tr,
                              width: 55.r,
                              height: 26.r,
                              radius: 0,
                              bgColor: AllColors.green.withOpacity(0.8),
                              background: false,
                              onTap: yes,
                            ),
                            CustomButton(
                              title: "Not Ok".tr,
                              width: 70.r,
                              height: 26.r,
                              radius: 0,
                              bgColor: AllColors.red.withOpacity(0.6),
                              background: false,
                              onTap: no,
                            ),
                          ],
                        ),
                      ),
                    if(permission==false)
                      if(status==""||status==null)
                        Text("Verification Pending",style: fontBold.copyWith(
                          color: AllColors.red.withOpacity(0.7),
                          fontSize: 14.r,
                          letterSpacing: 0.2,
                        ),
                        ),
                    if(status!=""&&status!=null)
                      if(status=="OK")
                        if(pageName!="unassignedLead")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(Images.ok, height: 20.r, width: 20.r, fit: BoxFit.cover,),
                            Text("Verify",style: fontBold.copyWith(
                              color: AllColors.green,
                              fontSize: 14.r,
                              letterSpacing: 0.2,
                            ),
                            ),
                          ],
                        ),
                    if(status!=""&&status!=null)
                      if(status=="NOT OK")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(Images.notOk, height: 20.r, width: 20.r, fit: BoxFit.cover),
                            SizedBox(width: 3.r),
                            Text("ReUpload",style: fontBold.copyWith(
                              color: AllColors.red.withOpacity(0.7),
                              fontSize: 14.r,
                              letterSpacing: 0.2,
                            ),
                            ),
                          ],
                        ),
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ChooseImageDocument extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String? subTitle;
  final String image;
  final String? status;
  const ChooseImageDocument(
      {super.key, this.onTap, required this.title, this.subTitle, required this.image, this.status});

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
            child: status=="OK"||(status==""||status==null)?const SizedBox() :
              Align(
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
                SizedBox(height: 10.r),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(status==""||status==null)
                      Text("Verification Pending",style: fontBold.copyWith(
                        color: AllColors.red.withOpacity(0.7),
                        fontSize: 14.r,
                        letterSpacing: 0.2,
                      ),
                      ),
                    if(status!=""&&status!=null)
                      if(status=="OK")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(Images.ok, height: 20.r, width: 20.r, fit: BoxFit.cover,),
                            Text("Verify",style: fontBold.copyWith(
                              color: AllColors.green,
                              fontSize: 14.r,
                              letterSpacing: 0.2,
                            ),
                            ),
                          ],
                        ),
                    if(status!=""&&status!=null)
                      if(status=="NOT OK")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(Images.notOk, height: 20.r, width: 20.r, fit: BoxFit.cover),
                            SizedBox(width: 3.r),
                            Text("ReUpload",style: fontBold.copyWith(
                              color: AllColors.red.withOpacity(0.7),
                              fontSize: 14.r,
                              letterSpacing: 0.2,
                            ),
                            ),
                          ],
                        ),
                  ],
                ),
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
  final String? status;
  final String? pageName;
  const ChooseImageDocumentView(
      {super.key, this.onTap, required this.title, this.subTitle, required this.image, this.status, this.pageName});

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
                child: status=="OK"||(status==""||status==null)?const SizedBox() :
                  Align(
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
                SizedBox(height: 10.r),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(status==""||status==null)
                      Text("Verification Pending",style: fontBold.copyWith(
                        color: AllColors.red.withOpacity(0.7),
                        fontSize: 14.r,
                        letterSpacing: 0.2,
                      ),
                      ),
                    if(status!=""&&status!=null)
                      if(status=="OK")
                        if(pageName!="unassignedLead")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(Images.ok, height: 20.r, width: 20.r, fit: BoxFit.cover,),
                            Text("Verify",style: fontBold.copyWith(
                              color: AllColors.green,
                              fontSize: 14.r,
                              letterSpacing: 0.2,
                            ),
                            ),
                          ],
                        ),
                    if(status!=""&&status!=null)
                      if(status=="NOT OK")
                        if(pageName!="unassignedLead")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(Images.notOk, height: 20.r, width: 20.r, fit: BoxFit.cover),
                            SizedBox(width: 3.r),
                            Text("ReUpload",style: fontBold.copyWith(
                              color: AllColors.red.withOpacity(0.7),
                              fontSize: 14.r,
                              letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}