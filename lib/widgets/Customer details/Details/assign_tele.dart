// ignore_for_file: use_build_context_synchronously

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AssignTele extends StatefulWidget {
  final String? leadId;
  final String? apiLeadId;
  final String? leadTransferName;
  final String? pageName;
  const AssignTele({super.key, this.leadId, this.apiLeadId, this.leadTransferName, this.pageName});

  @override
  State<AssignTele> createState() => _AssignTeleState();
}

  var controller = Get.find<PartnerController>();
  var loginController = Get.find<LoginController>();
  var permissionController = Get.find<PermissionController>();
class _AssignTeleState extends State<AssignTele> {
  @override
  Widget build(BuildContext context) {
    RxString findValue = "UID".obs;
    return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnderLineTextField(
            controller: controller.teleCheckID,
            labelText: findValue.value=="Pan"?"Lead owner PAN Number":findValue.value=="phone"?"Lead owner Phone":findValue.value=="UID"?"Lead owner UID":"Lead owner PAN Number",
            hint: findValue.value=="Pan"?"Lead owner PAN Number":findValue.value=="phone"?"Lead owner Phone":findValue.value=="UID"?"Lead owner UID":"Lead owner PAN Number",
            label: true,
            suffixIcon: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: (){
                controller.checkOwnerExistTeleNetworkApi(
                    findValue.value=="Pan"?"pan":findValue.value=="phone"?"phone":
                    findValue.value=="UID"?"UID":"",  controller.teleCheckID.text);
                controller.check_owner_exist_tele.refresh();
              },
              child: Text("Check", style:  fontBold.copyWith(color: AllColors.themeColor),),
            ),
            icon: true,
            type: TextInputType.text,
            length: 10,
          ),
          SizedBox(height: 10.r),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  controller.teleCheckID.clear();
                  findValue.value="phone";
                },
                child: Text("Find By Phone ", style: fontBold.copyWith(color: AllColors.themeColor)),
              ),
              SizedBox(width: 20.r),
              InkWell(
                onTap: (){
                  controller.teleCheckID.clear();
                  findValue.value="pan";
                },
                child: Text("Find By Pan ", style: fontBold.copyWith(color: AllColors.themeColor)),
              ),
            ],
          ),
          SizedBox(height: 20.r),
          controller.check_owner_exist_tele.value.data.isNotEmpty?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${controller.check_owner_exist_tele.value.data[0].empFname??"NA"} ${controller.check_owner_exist_tele.value.data[0].empLname} (${controller.check_owner_exist_tele.value.data[0].eid??"NA"})" ,style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 13.r,),),
              SizedBox(height: 4.r),
              Text("${controller.check_owner_exist_tele.value.data[0].empPresentAddress??"NA"} " ,style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
              SizedBox(height: 4.r),
              RichText(
                text: TextSpan(
                  text: 'Sup ID : ',
                  style: fontMedium.copyWith(color: AllColors.grey),
                  children: [
                    TextSpan(text: "${controller.check_owner_exist_tele.value.data[0].supId??"NA"} (${controller.check_owner_exist_tele.value.data[0].supId} )",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                  ],
                ),
              ),
              SizedBox(height: 4.r),
              RichText(
                text: TextSpan(
                  text: 'Function : ',
                  style: fontMedium.copyWith(color: AllColors.grey),
                  children: [
                    TextSpan(text: "${controller.check_owner_exist_tele.value.data[0].empFunction??"NA"} ",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                  ],
                ),
              )
            ],
          ) :
          Text("No data found !!",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
          // SizedBox(height: 30.r),
          // Center(
          //   child: CustomButton(
          //     title: "Assign Lead",
          //     height: 40.r,
          //     radius: 8.r,
          //     width: Get.width-160,
          //     background: false,
          //     bgColor: AllColors.green,
          //     onTap: ()async{
          //       if(controller.check_owner_exist_tele.value.data.isNotEmpty && controller.check_owner_exist_tele.value.data!="null"){
          //         bool status = await controller.updateLeadAssignTeleNetworkApi(controller.getLeadDetails.value.data.leadId,
          //             controller.check_owner_exist_tele.value.data[0].eid, controller.getLeadDetails.value.data.lockedBy.toString());
          //         if(status==true) {
          //           Navigator.pop(context);
          //           controller.check_assign_approval_exist_model.value.data.clear();
          //           _showDisbursedEditTeleBottomSheet(context);
          //         }
          //       }else{
          //         BaseController().errorSnack("details not found this Id !!");
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  // void _showDisbursedEditTeleBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     isDismissible: false,
  //     enableDrag: false,
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(16.0), // Adjust the left radius
  //         topRight: Radius.circular(16.0), // Adjust the right radius
  //       ),
  //     ),
  //     builder: (BuildContext context) {
  //       return WillPopScope(
  //         onWillPop: Future.value,
  //         child: Container(
  //           padding: EdgeInsets.only(right: 15.r,  left: 15.r, bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
  //           child: SingleChildScrollView(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(height: 10.r),
  //                 Center(
  //                   child: Container(
  //                     height: 4.r,
  //                     width: 60.r,
  //                     decoration: BoxDecoration(
  //                       color: AllColors.grey.withOpacity(0.7),
  //                       borderRadius: BorderRadius.circular(30.r),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 15.r),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     const SizedBox(),
  //                     Text("Assignment change Approval",style: fontBold.copyWith(fontSize: 14.sp),textAlign: TextAlign.center,),
  //                     InkWell(onTap: ()=> Get.back(),
  //                       child: Icon(Icons.clear,size: 25.sp,color: AllColors.red),),
  //                   ],
  //                 ),
  //                 SizedBox(height: 20.r),
  //                 Form(
  //                   key: formKeyAssignChangeApproval,
  //                   child: TextFormField(
  //                     controller: controller.employeeId,
  //                     keyboardType: TextInputType.text,
  //                     maxLength: 10,
  //                     validator: (value) {
  //                       if (value == null || value.isEmpty) {
  //                         return  "Please fill approver ID";
  //                       }
  //                       return null;
  //                     },
  //                     maxLines: 1,
  //                     minLines: 1,
  //                     decoration: InputDecoration(
  //                       hintText: "Enter Approver ID",
  //                       labelText: "Enter Approver ID",
  //                       hintStyle: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 13.r, wordSpacing: 0, letterSpacing: 0),
  //                       isDense: true,
  //                       // filled: true,
  //                       // fillColor: AllColors.white.withOpacity(0.9),
  //                       contentPadding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 8.h),
  //                       labelStyle: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontSize: 13.r, wordSpacing: 0, letterSpacing: 0),
  //                       enabledBorder: OutlineInputBorder(
  //                           borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
  //                       ),
  //                       focusedBorder:  OutlineInputBorder(
  //                           borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
  //                       ),
  //                       errorBorder:   OutlineInputBorder(
  //                           borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
  //                       ),
  //                       focusedErrorBorder: OutlineInputBorder(
  //                           borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
  //                       ),
  //                       suffixIconConstraints: BoxConstraints(
  //                         minHeight: 35.r,
  //                         maxHeight: 35.r,
  //                       ),
  //                       suffixIcon: TextButton(
  //                         style: TextButton.styleFrom(
  //                           padding: EdgeInsets.zero,
  //                         ),
  //                         onPressed: (){
  //                           if (formKeyAssignChangeApproval.currentState != null && formKeyAssignChangeApproval.currentState!.validate()) {
  //                             controller.checkAssignmentApprovalExistNetworkApi(controller.employeeId.text);
  //                           }
  //                         },
  //                         child: Text("Check", style: fontBold.copyWith(color: AllColors.themeColor),),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Obx(() => controller.check_assign_approval_exist_model.value.data.isNotEmpty?
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       SizedBox(height: 5.r),
  //                       Text("${controller.check_assign_approval_exist_model.value.data[0].empFname} ${controller.check_assign_approval_exist_model.value.data[0].empLname} (${controller.check_assign_approval_exist_model.value.data[0].eid})" ,style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
  //                       SizedBox(height: 4.r),
  //                       Text(controller.check_assign_approval_exist_model.value.data[0].empPresentAddress??"NA",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
  //                       SizedBox(height: 4.r),
  //                       RichText(
  //                         text: TextSpan(
  //                           text: 'Sup ID : ',
  //                           style: fontMedium.copyWith(color: AllColors.grey),
  //                           children: [
  //                             TextSpan(text: "${controller.check_assign_approval_exist_model.value.data[0].supName??"NA"} (${controller.check_assign_approval_exist_model.value.data[0].supId??0})",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(height: 4.r),
  //                       RichText(
  //                         text: TextSpan(
  //                           text: 'Function : ',
  //                           style: fontMedium.copyWith(color: AllColors.grey),
  //                           children: [
  //                             TextSpan(text:  controller.check_assign_approval_exist_model.value.data[0].empFunction??"NA",style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ) :
  //                   const SizedBox(),
  //                 ),
  //                 SizedBox(height: 20.r),
  //                 TextField(
  //                   controller: controller.approvalReason,
  //                   keyboardType: TextInputType.multiline,
  //                   maxLines: 4,
  //                   decoration: InputDecoration(
  //                     hintText: "Mention reason for assignment change",
  //                     isDense: true,
  //                     // filled: true,
  //                     // fillColor: AllColors.white.withOpacity(0.9),
  //                     contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
  //                     hintStyle: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontStyle: FontStyle.italic, fontSize: 13.r, wordSpacing: 0.3, letterSpacing: 0.5),
  //                     enabledBorder: OutlineInputBorder(
  //                         borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
  //                     ),
  //                     focusedBorder:  OutlineInputBorder(
  //                         borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
  //                     ),
  //                     errorBorder:   OutlineInputBorder(
  //                         borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
  //                     ),
  //                     focusedErrorBorder: OutlineInputBorder(
  //                         borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 30.r),
  //                 Center(
  //                   child: CustomButton(
  //                     title: "Request Approve",
  //                     height: 40.r,
  //                     radius: 8.r,
  //                     width: Get.width-160,
  //                     background: false,
  //                     bgColor: AllColors.deepPurple,
  //                     onTap: ()async{
  //                       if(controller.check_assign_approval_exist_model.value.data.isNotEmpty){
  //                         bool status = await controller.assignmentChangeApprovalNetworkApi(
  //                           controller.getLeadDetails.value.data.leadId.toString(),
  //                           "Request",
  //                           controller.check_assign_approval_exist_model.value.data[0].eid.toString(),
  //                           controller.approvalReason.text,
  //                           controller.getLeadDetails.value.data.lockedBy.toString(),
  //                         );
  //                         if(status==true) {
  //                           Navigator.of(context).pop();
  //                           if(widget.leadTransferName=="transferLead"){
  //                             bool status = await permissionController.lockUnlockLeadNetworkApi(widget.apiLeadId, "false");
  //                             if(status==true){
  //                               print("page Name ${widget.pageName}");
  //                               switch (widget.pageName) {
  //                                 case "freshLeads":
  //                                   loginController.freshLeadNetworkApi();
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=2;
  //                                   break;
  //                                 case "assignedLeads":
  //                                   loginController.getMyLeadNetworkApi("","","","","","","","");
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=2;
  //                                   break;
  //                                 case "teamLeads":
  //                                   loginController.teamLeadsNetworkApi("","","","","","","","");
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=4;
  //                                   break;
  //                                 case "unassignedLead":
  //                                   loginController.unassignedNetworkApi("","","","","","","","");
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=5;
  //                                   break;
  //                                 case "allLeads":
  //                                   loginController.allLeadsNetworkApi("","","","","","","","");
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=6;
  //                                   break;
  //                                 case "newLeads":
  //                                   loginController.newLeadsNetworkApi("","","","","","","","");
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=7;
  //                                   break;
  //                                 case "holdLeads":
  //                                   loginController.holdLeadsNetworkApi("","","","","","","","");
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=8;
  //                                   break;
  //                                 case "verifyLeads":
  //                                   loginController.verifiedLeadsNetworkApi("","","","","","","","");
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=9;
  //                                   break;
  //                                 case "loginLeads":
  //                                   loginController.loginLeadsNetworkApi("","","","","","","","");
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=10;
  //                                   break;
  //                                 case "sanctionedLeads":
  //                                   loginController.sanctionedLeadsNetworkApi("","","","","","","","");
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=11;
  //                                   break;
  //                                 case "incDueLeads":
  //                                   loginController.incDueLeadsNetworkApi("","","","","","","","");
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=12;
  //                                   break;
  //                                 case "incApprovalLeads":
  //                                   loginController.incApprovalLeadsNetworkApi("","","","","","","","");
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=13;
  //                                   break;
  //                                 case "incPaidLeads":
  //                                   loginController.incPaidLeadsNetworkApi("","","","","","","","");
  //                                   Get.off(()=> const DashboardScreen());
  //                                   leadManagerTab.value=14;
  //                                   break;
  //                               }
  //                             }
  //                           }
  //                         }
  //                       }else{
  //                         BaseController().errorSnack("details data not found this id !!");
  //                       }
  //                     },
  //                   ),
  //                 ),
  //                 SizedBox(height: 20.r)
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
