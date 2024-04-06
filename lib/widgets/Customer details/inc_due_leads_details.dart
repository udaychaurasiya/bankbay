// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker_widget/flutter_holo_date_picker_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class IncDueDetailsScreen extends StatefulWidget {
  final String? leadId;
  final String? apiLeadId;
  final String? pageName;
  const IncDueDetailsScreen({super.key, required this.leadId, this.apiLeadId, this.pageName});

  @override
  State<IncDueDetailsScreen> createState() => _IncDueDetailsScreenState();
}

class _IncDueDetailsScreenState extends State<IncDueDetailsScreen> {
    RxBool addMoreValue = false.obs;
    // GlobalKey<FormState> formKeyIncDueViewDetails = GlobalKey<FormState>(debugLabel: '_homeScreenKey');
    TextEditingController bankbayAccTrxDate = TextEditingController();
    TextEditingController bankbayAccTrxID = TextEditingController();
    TextEditingController remarks = TextEditingController();
    var loginController = Get.find<LoginController>();
    var controller = Get.find<PartnerController>();
    var permissionController = Get.find<PermissionController>();

    @override
    void initState() {
      controller.getLeadDetailsNetworkApi(widget.leadId);
      addList();
      super.initState();
    }
    addList()async{
      controller.leadDetailsImageList.clear();
      controller.leadDetailsImageList.value.add({
        "attachment": null,
      });
    }

    @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0.r),
      color: AllColors.white,
      width: Get.width,
      child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 10.r),
              child: Text("Lead History", style: fontMedium.copyWith(wordSpacing: 0,letterSpacing: 0,color: AllColors.grey,fontSize: 13.r)),
            ),
            SizedBox(height: 5.r),
            DetailsView(
              title1: "Verified by".tr,
              value1: controller.getLeadDetails.value.data.verifiedName!=null&&
                  controller.getLeadDetails.value.data.verifiedName!=""?
                 controller.getLeadDetails.value.data.verifiedName:"NA",
              id1: controller.getLeadDetails.value.data.verifiedName!=null&&
                  controller.getLeadDetails.value.data.verifiedName!=""?
                  controller.getLeadDetails.value.data.verifiedId:"00",
              color1: AllColors.blue,
              title2: "Verification date".tr,
              value2: "${controller.getLeadDetails.value.data.leadDateTime??""}",
            ),
            DetailsView(
              title1: "Requested amount".tr,
              value1: "${controller.getLeadDetails.value.data.disbAmt??"0"} INR",
              title2: "Login amount".tr,
              value2:  "${controller.getLeadDetails.value.data.loginAmount??"0"} INR",
            ),
            DetailsView(
              title1: "Login bank".tr,
              value1:  "${controller.getLeadDetails.value.data.loginBankName??"NA"} INR",
              title2: "Login date".tr,
              value2: controller.getLeadDetails.value.data.bankLoginDate??"NA",
            ),
            DetailsView(
              title1: "Sanction amount".tr,
              value1:  "${controller.getLeadDetails.value.data.sancAmt??"0"} INR",
              title2: "Disburse amount".tr,
              value2:  "${controller.getLeadDetails.value.data.disbAmt??"0"} INR",
            ),
            DetailsView(
              title1: "Borrower's bank".tr,
              value1: controller.getLeadDetails.value.data.disbBankName??"NA",
              title2: "Borrower's bank name".tr,
              value2: controller.getLeadDetails.value.data.disbBankAccountName??"0000",
            ),
            DetailsView(
              title1: "Borrower's Acc No".tr,
              value1: controller.getLeadDetails.value.data.disbBankAccountNo??"NA",
              title2: "Disburse date".tr,
              value2: controller.getLeadDetails.value.data.disbDate??"NA",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.r),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width/2.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bankbay Acc Trx date", style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5), fontSize: 11.5.r)),
                        SizedBox(height: 3.r),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0.r),
                          child: TextField(
                            controller: bankbayAccTrxDate,
                            minLines: 1,
                            maxLines: 1,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "select date",
                              isDense: true,
                              filled: true,
                              fillColor: AllColors.white.withOpacity(0.9),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.h),
                              hintStyle: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5), fontStyle: FontStyle.italic, fontSize: 13.r, wordSpacing: 0.3, letterSpacing: 0.5),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                              ),
                              focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                              ),
                              errorBorder:   OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                              ),
                              suffixIcon: InkWell(
                                child: Icon(Icons.calendar_month_outlined,size: 16.r),
                                onTap: ()async {
                                  var datePicked = await DatePicker.showSimpleDatePicker(
                                    context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    dateFormat: "yyyy-MM-dd",
                                    locale: DateTimePickerLocale.en_us,
                                    looping: true,
                                  );
                                  bankbayAccTrxDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString())).toString();
                                },
                              ),
                              suffixIconConstraints: BoxConstraints(
                                maxHeight: 20.r,
                                minHeight: 20.r,
                                minWidth: 20.r,
                                maxWidth: 20.r,
                              )
                            ),
                            style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.8), fontSize: 13.r, wordSpacing: 0.3, letterSpacing: 0.5),
                            onTap: ()async {
                              var datePicked = await DatePicker.showSimpleDatePicker(
                                context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                dateFormat: "yyyy-MM-dd",
                                locale: DateTimePickerLocale.en_us,
                                looping: true,
                              );
                              bankbayAccTrxDate.text = DateFormat("yyyy-MM-dd").format(DateTime.parse(datePicked.toString())).toString();
                             },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.r),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Bankbay Acc Trx ID", style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5), fontSize: 11.5.r)),
                          SizedBox(height: 3.r),
                          Padding(
                            padding: EdgeInsets.only(right: 2.0.r),
                            child: TextField(
                              controller: bankbayAccTrxID,
                              minLines: 1,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  hintText: "transaction ID...",
                                  isDense: true,
                                  filled: true,
                                  fillColor: AllColors.white.withOpacity(0.9),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.h),
                                  hintStyle: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5), fontStyle: FontStyle.italic, fontSize: 13.r, wordSpacing: 0.3, letterSpacing: 0.5),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                                  ),
                                  focusedBorder:  OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                                  ),
                                  errorBorder:   OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                                  ),
                              ),
                              style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.8), fontSize: 13.r, wordSpacing: 0.3, letterSpacing: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DetailsView(
              title1: "Partner name".tr,
              value1: controller.getLeadDetails.value.data.createdByName??"NA",
              id1: controller.getLeadDetails.value.data.leadSource??"00",
              color1: AllColors.blue,
              title2: "Partner Inc due".tr,
              value2: "${controller.getLeadDetails.value.data.partnerIncDue??"0"} INR",
            ),
            DetailsView(
              title1: "Tele name".tr,
              value1: controller.getLeadDetails.value.data.teleAssignEmpName??"NA",
              id1: controller.getLeadDetails.value.data.teleAssignEmpId??"00",
              color1: AllColors.blue,
              title2: "Tele Inc due".tr,
              value2: "${controller.getLeadDetails.value.data.teleIncDue??"0"} INR",
            ),
            DetailsView(
              title1: "FOS name".tr,
              value1: controller.getLeadDetails.value.data.fosAssignEmpName??"NA",
              id1: controller.getLeadDetails.value.data.fosAssignEmpId??"00",
              color1: AllColors.blue,
              title2: "FOS Inc due".tr,
              value2: "${controller.getLeadDetails.value.data.fosIncDue??"0"} INR",
            ),
            SizedBox(height: 15.r),
            TextField(
              controller: remarks,
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Authorizer's remark...",
                isDense: true,
                // filled: true,
                // fillColor: AllColors.white.withOpacity(0.9),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
                hintStyle: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontStyle: FontStyle.italic, fontSize: 13.r, wordSpacing: 0.3, letterSpacing: 0.5),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                ),
                focusedBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                ),
                errorBorder:   OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                ),
              ),
            ),
            SizedBox(height: 15.r),
            GetBuilder<PartnerController>(
                builder: (controller) {
                  return GridView.builder(
                    itemCount: controller.leadDetailsImageList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8.r,
                      crossAxisSpacing: 8.r,
                    ),
                    itemBuilder: (context, index) {
                      return Obx(() => Container(
                        height: 150.r,
                        width: 150.r,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5.r, color: AllColors.black.withOpacity(0.5)),
                          image: controller.leadDetailsImageList.value[index]["attachment"]==null?null:
                          DecorationImage(image: FileImage(File(controller.leadDetailsImageList.value[index]["attachment"].path))
                          ),
                        ),
                        child: Stack(
                          children: [
                            index==0? const SizedBox():
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: ()=> controller.leadDetailsImageListDeleteField(index),
                                child: CircleAvatar(
                                  radius: 15.r,
                                  backgroundColor: AllColors.none,
                                  child: Icon(Icons.close_outlined, size: 20.r, color: AllColors.red,),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: InkWell(
                                onTap: ()=> imageDialogBox(context,index),
                                child: Container(
                                  height: 20.r,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AllColors.black.withOpacity(0.2),
                                  ),
                                  child: Text("Upload Image", style: fontExtraSmall.copyWith(),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      );
                    },
                  );
                }
            ),
            SizedBox(height: 20.r),
            InkWell(
              onTap: (){
                controller.leadDetailsImageListAddField();
              },
              child: Container(
                width: 120.r,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  color: AllColors.green,
                ),
                child: Text("Add More Image",
                  style: fontExtraSmall.copyWith(
                    color: AllColors.white.withOpacity(0.9),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.r),
            // CustomButton(
            //   height: 40,
            //   radius: 0.r,
            //   background: false,
            //   bgColor: AllColors.themeColor.withOpacity(0.9),
            //   title: "Request Incentive Approval".tr,
            //   miniFont: true,
            //   iconColor: AllColors.white,
            //   onTap: ()async{
            //     bool checkStatus = await controller.updateIncDueNetworkApi(controller.getLeadDetails.value.data.leadId, "Request", bankbayAccTrxDate.text,
            //           bankbayAccTrxID.text, remarks.text, controller.getLeadDetails.value.data.lockedBy,controller.getLeadDetails.value.data.custId.toString());
            //     if(checkStatus==true){
            //       bool status = await permissionController.lockUnlockLeadNetworkApi(widget.apiLeadId, "false");
            //       if(status==true){
            //         print("page Name ${widget.pageName}");
            //         switch (widget.pageName) {
            //          case "incDueLeads":
            //             loginController.incDueLeadsNetworkApi("","","","","","","","");
            //             Get.off(()=> const DashboardScreen());
            //             leadManagerTab.value=12;
            //             break;
            //           case "incApprovalLeads":
            //             loginController.incApprovalLeadsNetworkApi("","","","","","","","");
            //             Get.off(()=> const DashboardScreen());
            //             leadManagerTab.value=13;
            //             break;
            //           case "incPaidLeads":
            //             loginController.incPaidLeadsNetworkApi("","","","","","","","");
            //             Get.off(()=> const DashboardScreen());
            //             leadManagerTab.value=14;
            //             break;
            //         }
            //       }
            //     // }
            //     }
            //   },
            // ),
            if(controller.getLeadDetails.value.data.leadStatus=="disbursed")
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: "Inc Assigned".tr,
                      background: false,
                      bgColor: AllColors.green,
                      height: 36.r,
                      width: Get.width/2,
                    ),
                  ),
                  SizedBox(width: 15.r),
                  Expanded(
                    child: CustomButton(
                      title: "Inc Validated".tr,
                      background: false,
                      bgColor: AllColors.themeColor,
                      height: 36.r,
                      width: Get.width/2,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 15.r),
            ListView.builder(
              itemCount: controller.getLeadDetails.value.data.incHistory.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var remarksData = controller.getLeadDetails.value.data.incHistory[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15.r),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.r, color: AllColors.grey.withOpacity(0.7)),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10.r),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: remarksData.updateByName??"NA",
                                style: fontSmall.copyWith(fontWeight: FontWeight.w500, color: AllColors.themeColor, fontSize: 12.5.r,wordSpacing: 0, letterSpacing: 0,),
                                children: [
                                  TextSpan(text: " (${remarksData.remarkUpdateBy??"NA"})", style: fontSmall.copyWith(fontWeight: FontWeight.w400,  fontSize: 12.r,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.r),
                            RichText(
                              text: TextSpan(
                                text: "Date : ",
                                style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis),
                                children: [
                                  TextSpan(text: "${remarksData.remarkDateTime??""}", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 1.r),
                            Text(remarksData.remark??"", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0),),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },),
            SizedBox(height: 20.r),
          ],
        ),
      ),
    );
  }

    void imageDialogBox(BuildContext context, int index) {
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
                          controller.multipleChooseImage(false, index);
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
                          controller.multipleChooseImage(true, index);
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

class DetailsView extends StatelessWidget {
  final String title1;
  final String? value1;
  final String? id1;
  final String title2;
  final String? value2;
  final Color? color1;
  final Color? color2;
  const DetailsView({super.key, required this.title1, required this.title2, this.color1, this.color2, this.value1, this.value2, this.id1=""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.r),
      child: Row(
        children: [
          SizedBox(
            width: Get.width/2.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title1.toString(), style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5), fontSize: 11.5.r)),
                SizedBox(height: 3.r),
                RichText(
                  text: TextSpan(
                    text: "${value1.toString()} ",
                    style: fontMedium.copyWith(color: color1??AllColors.black.withOpacity(0.8), fontSize: 12.r,overflow: TextOverflow.ellipsis),
                    children: [
                      if(id1!="")
                        TextSpan(text: "(${id1.toString()})", style: fontMedium.copyWith(color: AllColors.grey, fontSize: 12.r),),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 5.r),
          Expanded(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title2.toString(), style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5), fontSize: 11.5.r)),
                  SizedBox(height: 3.r),
                  Text(value2.toString(), style: fontMedium.copyWith(color: color2??AllColors.black.withOpacity(0.8), fontSize: 12.r,overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
