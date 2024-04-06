// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use, use_build_context_synchronously

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/custom_image.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/utils_method/custom_leads_details.dart';
import 'package:bank_bay/utils_method/loading_more_widget.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:bank_bay/widgets/Customer%20details/customer_details.dart';
import 'package:bank_bay/widgets/Customer%20details/customer_loan_list_details.dart';
import 'package:bank_bay/widgets/LeadManager/Add%20Lead/default_my_leads.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class MyLeadsScreen extends StatefulWidget {
  const MyLeadsScreen({super.key});

  @override
  State<MyLeadsScreen> createState() => _MyLeadsScreenState();
}

class _MyLeadsScreenState extends State<MyLeadsScreen> {
  var controller = Get.find<LoginController>();
  final _controller = Get.find<PartnerController>();
  var permissionController = Get.find<PermissionController>();
  var partnerController = Get.find<PartnerController>();
  var selectedDay = DateTime.now().obs;
  var monthYear = DateTime.now().obs;
  var selectedMenu = "Set Follow-up".obs;
  RxBool freshLead=true.obs;
  RxBool calender=false.obs;

  @override
  void initState() {
    controller.myLeadNext = 10;
    _controller.getProfileCompleteApi();
    controller.freshLeadNetworkApi();
    controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: Obx(() {
        if(_controller.profileComplete.value.data.popupStatus.toString()=="true"){
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.r, vertical:10.0.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(0, 130.r, 0, 10.r), // Adjust the position of the popup menu
                          items: <PopupMenuEntry<String>>[
                            PopupMenuItem(
                              value: 'All Loan'.tr,
                              child: Text('All Loan',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Personal Loan'.tr,
                              child: Text('Personal Loan',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Business Loan'.tr,
                              child: Text('Business Loan',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Self-Employee Loan'.tr,
                              child: Text('Self-Employee Loan',style: fontMedium.copyWith()),
                            ),
                          ],
                        ).then((value) {
                          controller.selectLoanType.value=value??"All Loan";
                          controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            color: AllColors.blue.withOpacity(0.4),
                            child: Icon(Icons.unfold_more,size: 16.r,color: AllColors.black,),
                          ),
                          SizedBox(width: 8.r),
                          Obx(() => Text(controller.selectLoanType.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                        ],
                      ),
                    ),
                    SizedBox(width: controller.selectLoanType.value=="All Loan"?25.r:15.r),
                    InkWell(
                      onTap: () {
                        showMenu(
                          context: context,
                          position: RelativeRect.fromSize(Rect.fromCircle(center: const Offset(70, 150), radius: 5), const Size(150, 300)),
                          items: <PopupMenuEntry<String>>[
                            PopupMenuItem(
                              value: 'All Stage'.tr,
                              child: SizedBox(
                                width: 150.r,
                                child: Text('All Stage',style: fontMedium.copyWith()),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'Draft'.tr,
                              child: Text('Draft',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Submitted'.tr,
                              child: Text('Submitted',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Hold'.tr,
                              child: Text('Hold',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Released'.tr,
                              child: Text('Released',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Verified'.tr,
                              child: Text('Verified',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Login'.tr,
                              child: Text('Login',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Sanction'.tr,
                              child: Text('Sanction',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Disbursed'.tr,
                              child: Text('Disbursed',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Inc Due'.tr,
                              child: Text('Inc Due',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Inc Paid'.tr,
                              child: Text('Inc Paid',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Rejected'.tr,
                              child: Text('Rejected',style: fontMedium.copyWith()),
                            ),

                          ],
                        ).then((value) {
                          controller.selectStageType.value=value??"All Stage";
                          controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            color: AllColors.blue.withOpacity(0.4),
                            child: Icon(Icons.unfold_more,size: 16.r,color: AllColors.black,),
                          ),
                          SizedBox(width: 8.r),
                          Obx(() => Text(controller.selectStageType.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                        ],
                      ),
                    ),
                    SizedBox(width: controller.selectStageType.value=="All Stage"?25.r:15.r),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => calender.value=true,
                          child: Text(
                            DateFormat('yyy-MM-dd').format(selectedDay.value)!=DateFormat('yyy-MM-dd').format(DateTime.now())? DateFormat('MMMM - yyy').format(selectedDay.value).toString() :"All Time",
                            style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),),
                        ),
                        SizedBox(width: 5.r),
                        InkWell(
                          onTap: () => calender.value=true,
                          child: Icon(
                            Icons.calendar_month_outlined,
                            size: 16.r,color: AllColors.black,
                          ),
                        ),
                        SizedBox(width: 16.r),
                        InkWell(
                          onTap: (){
                            controller.loanType.value="All Loan";
                            controller.customerPan.clear();
                            controller.customerPhone.clear();
                            controller.leadStartDate.clear();
                            controller.leadEndDate.clear();
                            _showBottomSheetFilter(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(5.0.r),
                            child: Icon(
                              Icons.tune,
                              size: 16.r,color: AllColors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if(calender.value==true)
                Container(
                  margin: EdgeInsets.symmetric(horizontal:10.0.r),
                  padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 8.r),
                  color: AllColors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Icon(Icons.arrow_back_ios, size: 15.r, color: AllColors.black,),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            WeeklyDatePicker(
                              selectedDay: selectedDay.value, // DateTime
                              changeDay: (value)async{
                                selectedDay.value = value;
                                monthYear.value = value;
                                await controller.getMyLeadNetworkApi(DateFormat('yyy-MM-dd').format(value).toString(),DateFormat('yyy-MM').format(value),partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","","");
                              },
                              enableWeeknumberText: false,
                              weeknumberColor: AllColors.lightTeal.withOpacity(0.8),
                              weeknumberTextColor: Colors.white,
                              backgroundColor: AllColors.white,
                              weekdayTextColor: AllColors.black,
                              digitsColor: AllColors.black.withOpacity(0.6),
                              // selectedBackgroundColor: AllColors.lightTeal.withOpacity(0.8),
                              weekdays: const ["S", "M", "T", "W", "T","F", "S"],
                              daysInWeek: 7,
                            ),
                            InkWell(
                              onTap: ()async{
                                bool status = await  controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                if(status==true){
                                  selectedDay.value=DateTime.now();
                                  calender.value=false;
                                }
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text("Reset", style: fontBold.copyWith(fontSize: 12.r, color: AllColors.red.withOpacity(0.7)),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: Icon(Icons.arrow_forward_ios, size: 15.r, color: AllColors.black,),
                      ),
                    ],
                  ),
                ),
              if(calender.value==true)
                SizedBox(height: 5.r),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller.myLeadController,
                  child: Column(
                    children: [
                      /// fresh lead code
                      if(controller.fresh_lead_model.value.data.freshLead.isNotEmpty)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal:10.0.r),
                          padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 8.r),
                          color: AllColors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left:8.0.r),
                                child: Text("Fresh Leads", style: fontBold.copyWith()),
                              ),
                              SizedBox(height: 10.r),
                              Obx(() {
                                return /*controller.fresh_lead_loader.value?*/
                                  ListView.builder(
                                      itemCount: controller.fresh_lead_model.value.data.freshLead.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(bottom: 5.r),
                                      itemBuilder: (context, index){
                                        var freshLeadData= controller.fresh_lead_model.value.data.freshLead[index];
                                        return controller.fresh_lead_model.value.data.freshLead.isNotEmpty?
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5.0.r),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+freshLeadData.custLoanSelfie.toString())),
                                                child: CircleAvatar(
                                                  radius: 18.r,
                                                  backgroundColor: AllColors.lightTeal.withOpacity(0.6),
                                                  child: CustomImage(
                                                    image: freshLeadData.custLoanSelfie.toString(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.r),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              InkWell(
                                                                onTap: ()=> Get.to(()=> CustomerLoanListDetails(leadId: "${freshLeadData.id??""}",customerId: freshLeadData.custId??"")),
                                                                child: RichText(
                                                                  text: TextSpan(
                                                                    text: freshLeadData.custName??"NA",
                                                                    style: fontSmall.copyWith(fontWeight: FontWeight.w500),
                                                                    children: [
                                                                      TextSpan(text: " (${freshLeadData.leadId??"NA"})", style: fontSmall.copyWith()),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(freshLeadData.leadStatus??"NA", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                                              Text(freshLeadData.leadDateTime??"NA", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: ()=> launch("tel://+91${freshLeadData.custPhone??00}"),
                                                              child: Container(
                                                                padding: EdgeInsets.symmetric(horizontal: 14.r,vertical: 3.r),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(100.r),
                                                                    border: Border.all(width: 0.5, color: AllColors.grey.withOpacity(0.6))
                                                                ),
                                                                child: Icon(
                                                                  Icons.call,
                                                                  size: 12.r,
                                                                  color: AllColors.red.withOpacity(0.6),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: 10.r),
                                                            if(freshLeadData.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")
                                                              SizedBox(
                                                                height: 20.r,
                                                                width: 20.r,
                                                                child: Obx(()=> PopupMenuButton(
                                                                  padding: EdgeInsets.zero,
                                                                  position: PopupMenuPosition.over,
                                                                  offset: Offset.zero,
                                                                  initialValue: selectedMenu.value,
                                                                  onSelected: (value) async {
                                                                    selectedMenu.value = value.toString();
                                                                    if(value == "Transfer Lead"){
                                                                      bool checkStatus = await controller.freshLeadNetworkApi();
                                                                      if(checkStatus==true){
                                                                        if(controller.fresh_lead_model.value.data.freshLead[index].leadLockStatus=="false") {
                                                                          bool status = await permissionController.lockUnlockLeadNetworkApi(freshLeadData.leadId, "true");
                                                                          if(status==true) {
                                                                            CustomerDetails(leadId: "${freshLeadData.id??""}",customerId: freshLeadData.custId??"",value: "leadDetails", apiLeadId: freshLeadData.leadId,pageName: "myLead",leadTransferName: "transferLead",);
                                                                            controller.freshLeadNetworkApi();
                                                                          }
                                                                        }else{
                                                                          BaseController().errorSnack("Already details View on ${controller.fresh_lead_model.value.data.freshLead[index].lockedBy.toString()}");
                                                                          controller.freshLeadNetworkApi();
                                                                        }
                                                                      }
                                                                    }else{
                                                                      bool checkStatus = await controller.freshLeadNetworkApi();
                                                                      if(checkStatus==true){
                                                                        if(controller.fresh_lead_model.value.data.freshLead[index].leadLockStatus=="false") {
                                                                          bool status = await permissionController.lockUnlockLeadNetworkApi(freshLeadData.leadId, "true");
                                                                          if(status==true) {
                                                                            CustomerDetails(leadId: "${freshLeadData.id??""}",customerId: freshLeadData.custId??"",value: "leadDetails", apiLeadId: freshLeadData.leadId,pageName: "myLead");
                                                                            controller.freshLeadNetworkApi();
                                                                          }
                                                                        }else{
                                                                          BaseController().errorSnack("Already details View on ${controller.fresh_lead_model.value.data.freshLead[index].lockedBy.toString()}");
                                                                          controller.freshLeadNetworkApi();
                                                                        }
                                                                      }
                                                                    }
                                                                  },
                                                                  itemBuilder: (BuildContext context) => [
                                                                    PopupMenuItem(
                                                                      value: 'Set Follow-up'.tr,
                                                                      child: Text('Set Follow-up',style: fontMedium.copyWith()),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      value: 'Mark Hot Lead'.tr,
                                                                      child: Text('Mark Hot Lead',style: fontMedium.copyWith()),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      value: 'Transfer Lead'.tr,
                                                                      child: Text('Transfer Lead',style: fontMedium.copyWith()),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      value: 'Delete Lead'.tr,
                                                                      child: RichText(
                                                                        text: TextSpan(
                                                                          text: 'Delete Lead ',
                                                                          style: fontMedium.copyWith(),
                                                                          children: [
                                                                            TextSpan(text: '(Draft)', style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5))),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      // child: Text('Delete Lead',style: fontMedium.copyWith()),
                                                                    ),
                                                                  ],
                                                                  icon: Container(
                                                                    padding: EdgeInsets.all(2.r),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(100.r),
                                                                        border: Border.all(width: 0.5, color: AllColors.grey.withOpacity(0.6))
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.keyboard_arrow_down_sharp,
                                                                      size: 16.r,
                                                                      color: AllColors.black.withOpacity(0.6),
                                                                    ),
                                                                  ),
                                                                ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 10.0.r),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          GetBuilder<LoginController>(builder: (controller){
                                                            return controller.fresh_lead_model.value.data.freshLead[index].leadLockStatus=="true"?
                                                            Container(
                                                              width: 80.r,
                                                              height: 22.r,
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(2.r),
                                                                  color: AllColors.lightGrey.withOpacity(0.6),
                                                                  border: Border.all(width: 0.5.r, color: AllColors.black.withOpacity(0.5))
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Icon(Icons.lock_open_outlined,size: 15.r, color: AllColors.black.withOpacity(0.6)),
                                                                  SizedBox(width: 5.r),
                                                                  Obx(() => Text(controller.fresh_lead_model.value.data.freshLead[index].lockedBy.toString(),style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.6)),textAlign: TextAlign.end,)),
                                                                ],
                                                              ),
                                                            ):
                                                            InkWell(
                                                              onTap: ()async{
                                                                bool checkStatus = await controller.unassignedNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                                                if(checkStatus==true){
                                                                  if(controller.fresh_lead_model.value.data.freshLead[index].leadLockStatus=="false") {
                                                                    bool status = await permissionController.lockUnlockLeadNetworkApi(freshLeadData.leadId, true);
                                                                    if(status==true) {
                                                                      Get.to(()=> CustomerDetails(leadId: "${freshLeadData.id??""}",customerId: freshLeadData.custId??"",value: "leadDetails", apiLeadId: freshLeadData.leadId,pageName: "myLead",));
                                                                      controller.freshLeadNetworkApi();
                                                                    }
                                                                  }else{
                                                                    BaseController().errorSnack("Already details View on ${controller.fresh_lead_model.value.data.freshLead[index].lockedBy.toString()}");
                                                                    controller.unassignedNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                                                  }
                                                                }
                                                              },
                                                              child: Container(
                                                                width: 90.r,
                                                                height: 22.r,
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(2.r),
                                                                  color: AllColors.themeColor,
                                                                ),
                                                                child: Text( "View Details",style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.white.withOpacity(0.8)),),
                                                              ),
                                                            );
                                                          }),
                                                          if(freshLeadData.leadStatus.toString().toLowerCase()=="verified")
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Image.asset(Images.ok, height: 20.r, width: 20.r, fit: BoxFit.cover,),
                                                                SizedBox(width: 1.r),
                                                                Text("Verify",style: fontMedium.copyWith(
                                                                  color: AllColors.green,
                                                                  fontSize: 13.r,
                                                                  letterSpacing: 0.2,
                                                                ),
                                                                ),
                                                              ],
                                                            ),
                                                          if(freshLeadData.leadStatus.toString().toLowerCase()=="new")
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Image.asset(Images.ok, height: 20.r, width: 20.r, fit: BoxFit.cover,),
                                                                SizedBox(width: 1.r),
                                                                Text("Fresh",style: fontMedium.copyWith(
                                                                  color: AllColors.green,
                                                                  fontSize: 13.r,
                                                                  letterSpacing: 0.2,
                                                                ),
                                                                ),
                                                              ],
                                                            ),
                                                          if(freshLeadData.leadStatus.toString().toLowerCase()!="verified"&&freshLeadData.leadStatus.toString().toLowerCase()!="new")
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Image.asset(Images.rejected, height: 20.r, width: 20.r, fit: BoxFit.cover),
                                                                SizedBox(width: 1.r),
                                                                Text("${freshLeadData.leadStatus.toString().capitalize}", style: fontMedium.copyWith(
                                                                  color: AllColors.red.withOpacity(0.7),
                                                                  fontSize: 13.r,
                                                                  letterSpacing: 0.2,
                                                                ),
                                                                ),
                                                              ],
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    if(index < controller.fresh_lead_model.value.data.freshLead.length - 1)
                                                      Container(
                                                        height: 1.r,
                                                        margin: EdgeInsets.symmetric(vertical: 12.r),
                                                        color: AllColors.lightGrey.withOpacity(0.8),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ) :
                                        Container(
                                            alignment: Alignment.center,
                                            height: 40.r,
                                            child: Text("No data available",style: fontRegular.copyWith(letterSpacing: 0,),)
                                        );
                                      });
                              }),

                            ],
                          ),
                        ),
                      if(controller.fresh_lead_model.value.data.freshLead.isNotEmpty)
                        SizedBox(height: freshLead.value==true?15.r:0),
                      /// all lead data list code
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0.r),
                        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
                        color: AllColors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /// counts list widget
                            Container(
                              height: 60.r,
                              padding: EdgeInsets.symmetric(vertical: 8.r),
                              child: Row(
                                children: [
                                  InkWell(
                                    child: Icon(
                                      Icons.keyboard_arrow_left_rounded,
                                      size: 22.r,color:
                                    AllColors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: Obx((){
                                      return controller.get_my_lead_model.value.data.counts.isNotEmpty?
                                      ListView.builder(
                                        itemCount: controller.get_my_lead_model.value.data.counts.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index){
                                          var data1 = controller.get_my_lead_model.value.data.counts[index];
                                          return Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left: 25.r, right: 25.r,),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(data1.title??"NA",style: fontSmall.copyWith(),),
                                                    Text("${data1.count??0}",style: fontRegular.copyWith(fontSize: 16.r),),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 1.r,
                                                color: AllColors.lightGrey.withOpacity(0.8),
                                              )
                                            ],
                                          );
                                        },
                                      ):
                                      ListView.builder(
                                        itemCount: 5,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index){
                                          return Row(
                                            children: [
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  width: 90.r,
                                                  color: AllColors.white,
                                                  margin: EdgeInsets.only(right: 5.r),
                                                ),
                                              ),
                                              Container(
                                                width: 1.r,
                                                color: AllColors.lightGrey.withOpacity(0.8),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    ),
                                  ),
                                  InkWell(
                                    child: Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 22.r,color:
                                    AllColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if(controller.get_my_lead_model.value.data.allLead.isNotEmpty||controller.get_my_lead_model.value.data.allLead!="null")
                              SizedBox(height: 10.r),
                            GetBuilder<LoginController>(builder:(controller) {
                              return controller.get_my_lead_loader.value?
                              ListView.builder(
                                    itemCount: controller.get_my_lead_model.value.data.allLead.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(bottom: 5.r),
                                    itemBuilder: (context, index){
                                      var myLeadData= controller.get_my_lead_model.value.data.allLead[index];
                                      bool isLastItem = index == controller.get_my_lead_model.value.data.allLead.length - 1;
                                      return CustomLeadsDetails3(
                                        pageName: "myLead",
                                        name: myLeadData.custName??"NA",
                                        leadId: myLeadData.leadId??"",
                                        leadTypeName: myLeadData.leadSource??"",
                                        address: myLeadData.custPermanentAddress??"NA",
                                        createDate: myLeadData.leadDateTime??"NA",
                                        image: myLeadData.custLoanSelfie.toString(),
                                        number: myLeadData.custPhone??"",
                                        leadLockStatus: myLeadData.leadLockStatus??"false",
                                        leadStatus: myLeadData.leadStatus??"",
                                        holdCount: myLeadData.holdCount,
                                        lockedBy: myLeadData.lockedBy??"",
                                        leadDateTime: myLeadData.leadDateTime??"NA",
                                        index: isLastItem,
                                        detailsTap: ()async{
                                        bool checkStatus = await controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                        if(checkStatus==true){
                                          if(controller.get_my_lead_model.value.data.allLead[index].leadLockStatus=="false") {
                                            bool status = await permissionController.lockUnlockLeadNetworkApi(myLeadData.leadId, "true");
                                            if(status==true) {
                                              Get.to(()=> CustomerDetails(leadId: "${myLeadData.id}",customerId: "${myLeadData.custId}",value: "leadDetails", apiLeadId: myLeadData.leadId, pageName: "myLead",));
                                              controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                            }
                                          }else{
                                            BaseController().errorSnack("Already details View on ${controller.get_my_lead_model.value.data.allLead[index].lockedBy.toString()}");
                                            controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                          }
                                        }
                                        },
                                        nameTap: ()=> Get.to(()=> CustomerLoanListDetails(leadId: "${myLeadData.id??""}",customerId: myLeadData.custId??"")),
                                        transferLeadStatus: myLeadData.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes"?true:false,
                                        child: Obx(()=> PopupMenuButton(
                                          padding: EdgeInsets.symmetric(horizontal: 0.r),
                                          position: PopupMenuPosition.over,
                                          offset: Offset.zero,
                                          initialValue: selectedMenu.value,
                                          onSelected: (value) async {
                                            selectedMenu.value = value.toString();
                                            if(value == "Transfer Lead"){
                                              bool checkStatus = await controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                              if(checkStatus==true){
                                                if(controller.get_my_lead_model.value.data.allLead[index].leadLockStatus=="false") {
                                                  bool status = await permissionController.lockUnlockLeadNetworkApi(myLeadData.leadId, "true");
                                                  if(status==true) {
                                                    Get.to(()=> CustomerDetails(leadId: "${myLeadData.id??""}",customerId: myLeadData.custId??"",value: "leadDetails",apiLeadId: myLeadData.leadId, pageName: "myLead",leadTransferName: "transferLead",));
                                                    controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                                  }
                                                }else{
                                                  BaseController().errorSnack("Already details View on ${controller.get_my_lead_model.value.data.allLead[index].lockedBy.toString()}");
                                                  controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                                }
                                              }
                                            }else{
                                              bool checkStatus = await controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                              if(checkStatus==true){
                                                if(controller.get_my_lead_model.value.data.allLead[index].leadLockStatus=="false") {
                                                  bool status = await permissionController.lockUnlockLeadNetworkApi(myLeadData.leadId, "true");
                                                  if(status==true) {
                                                    Get.to(()=> CustomerDetails(leadId: "${myLeadData.id}",customerId: "${myLeadData.custId}",value: "leadDetails", apiLeadId: myLeadData.leadId, pageName: "myLead",));
                                                    controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                                  }
                                                }else{
                                                  BaseController().errorSnack("Already details View on ${controller.get_my_lead_model.value.data.allLead[index].lockedBy.toString()}");
                                                  controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                                }
                                              }
                                            }
                                            print("object $value");
                                            // controller.getMyLeadNetworkApi("","",value=="Personal Loan"?"PL":value=="Business Loan"?"BL":value=="Self-Employee Loan"?"SEL":"Pl");
                                          },
                                          itemBuilder: (BuildContext context) => [
                                            PopupMenuItem(
                                              value: 'Set Follow-up'.tr,
                                              child: Text('Set Follow-up',style: fontMedium.copyWith()),
                                            ),
                                            PopupMenuItem(
                                              value: 'Mark Hot Lead'.tr,
                                              child: Text('Mark Hot Lead',style: fontMedium.copyWith()),
                                            ),
                                            PopupMenuItem(
                                              value: 'Transfer Lead'.tr,
                                              child: Text('Transfer Lead',style: fontMedium.copyWith()),
                                            ),
                                            PopupMenuItem(
                                              value: 'Delete Lead'.tr,
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Delete Lead ',
                                                  style: fontMedium.copyWith(),
                                                  children: [
                                                    TextSpan(text: '(Draft)', style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5))),
                                                  ],
                                                ),
                                              ),
                                              // child: Text('Delete Lead',style: fontMedium.copyWith()),
                                            ),
                                          ],
                                          icon: Container(
                                            padding: EdgeInsets.all(2.r),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100.r),
                                                border: Border.all(width: 0.5, color: AllColors.grey.withOpacity(0.6))
                                            ),
                                            child: Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              size: 16.r,
                                              color: AllColors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        )),
                                      );
                                    }) :
                              ListView.builder(
                                  itemCount: 12,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                                  itemBuilder: (context, index){
                                    return Container(
                                      padding: EdgeInsets.only(left: 5.0.r,right: 5.0.r, top: index==0?8.r:0),
                                      color: AllColors.white,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.grey.shade100,
                                            enabled: true,
                                            child: CircleAvatar(
                                              radius: 18.r,
                                              backgroundColor: AllColors.white,
                                            ),
                                          ),
                                          SizedBox(width: 10.r),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Shimmer.fromColors(
                                                          baseColor: Colors.grey.shade300,
                                                          highlightColor: Colors.grey.shade100,
                                                          enabled: true,
                                                          child: Container(
                                                            width: 150.r,
                                                            height: 15.r,
                                                            color: AllColors.white,
                                                            margin: EdgeInsets.only(right: 5.r),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5.r),
                                                        Shimmer.fromColors(
                                                          baseColor: Colors.grey.shade300,
                                                          highlightColor: Colors.grey.shade100,
                                                          enabled: true,
                                                          child: Container(
                                                            width: 80.r,
                                                            height: 10.r,
                                                            color: AllColors.white,
                                                            margin: EdgeInsets.only(right: 5.r),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5.r),
                                                        Shimmer.fromColors(
                                                          baseColor: Colors.grey.shade300,
                                                          highlightColor: Colors.grey.shade100,
                                                          enabled: true,
                                                          child: Container(
                                                            width: 120.r,
                                                            height: 10.r,
                                                            color: AllColors.white,
                                                            margin: EdgeInsets.only(right: 5.r),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                if(index!=11)
                                                  Container(
                                                    height: 1.r,
                                                    margin: EdgeInsets.symmetric(vertical: 10.r),
                                                    color: AllColors.lightGrey,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }),
                            if(controller.get_my_lead_model.value.message.toString()=="Data Not Found.")
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(bottom: 10.r),
                                  child: Text("Data not found !!",style: fontRegular.copyWith(letterSpacing: 0,color: AllColors.black.withOpacity(0.7)),)
                              ),
                            Obx(() => controller.isLoadMore.value? const LoadingMoreData():const SizedBox()),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.r),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.r),
            ],
          );
        }
        else if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")==true){
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.r, vertical:10.0.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(0, 130.r, 0, 10.r), // Adjust the position of the popup menu
                          items: <PopupMenuEntry<String>>[
                            PopupMenuItem(
                              value: 'All Loan'.tr,
                              child: Text('All Loan',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Personal Loan'.tr,
                              child: Text('Personal Loan',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Business Loan'.tr,
                              child: Text('Business Loan',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Self-Employee Loan'.tr,
                              child: Text('Self-Employee Loan',style: fontMedium.copyWith()),
                            ),
                          ],
                        ).then((value) {
                          controller.selectLoanType.value=value??"All Loan";
                          controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            color: AllColors.blue.withOpacity(0.4),
                            child: Icon(Icons.unfold_more,size: 16.r,color: AllColors.black,),
                          ),
                          SizedBox(width: 8.r),
                          Obx(() => Text(controller.selectLoanType.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                        ],
                      ),
                    ),
                    SizedBox(width: controller.selectLoanType.value=="All Loan"?25.r:15.r),
                    InkWell(
                      onTap: () {
                        showMenu(
                          context: context,
                          position: RelativeRect.fromSize(Rect.fromCircle(center: const Offset(70, 150), radius: 5), const Size(150, 300)),
                          items: <PopupMenuEntry<String>>[
                            PopupMenuItem(
                              value: 'All Stage'.tr,
                              child: SizedBox(
                                width: 150.r,
                                child: Text('All Stage',style: fontMedium.copyWith()),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'Draft'.tr,
                              child: Text('Draft',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Submitted'.tr,
                              child: Text('Submitted',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Hold'.tr,
                              child: Text('Hold',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Released'.tr,
                              child: Text('Released',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Verified'.tr,
                              child: Text('Verified',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Login'.tr,
                              child: Text('Login',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Sanction'.tr,
                              child: Text('Sanction',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Disbursed'.tr,
                              child: Text('Disbursed',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Inc Due'.tr,
                              child: Text('Inc Due',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Inc Paid'.tr,
                              child: Text('Inc Paid',style: fontMedium.copyWith()),
                            ),
                            PopupMenuItem(
                              value: 'Rejected'.tr,
                              child: Text('Rejected',style: fontMedium.copyWith()),
                            ),

                          ],
                        ).then((value) {
                          controller.selectStageType.value=value??"All Stage";
                          controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            color: AllColors.blue.withOpacity(0.4),
                            child: Icon(Icons.unfold_more,size: 16.r,color: AllColors.black,),
                          ),
                          SizedBox(width: 8.r),
                          Obx(() => Text(controller.selectStageType.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                        ],
                      ),
                    ),
                    SizedBox(width: controller.selectStageType.value=="All Stage"?25.r:15.r),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => calender.value=true,
                          child: Text(
                            DateFormat('yyy-MM-dd').format(selectedDay.value)!=DateFormat('yyy-MM-dd').format(DateTime.now())? DateFormat('MMMM - yyy').format(selectedDay.value).toString() :"All Time",
                            style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),),
                        ),
                        SizedBox(width: 5.r),
                        InkWell(
                          onTap: () => calender.value=true,
                          child: Icon(
                            Icons.calendar_month_outlined,
                            size: 16.r,color: AllColors.black,
                          ),
                        ),
                        SizedBox(width: 16.r),
                        InkWell(
                          onTap: (){
                            controller.loanType.value="All Loan";
                            controller.customerPan.clear();
                            controller.customerPhone.clear();
                            controller.leadStartDate.clear();
                            controller.leadEndDate.clear();
                            _showBottomSheetFilter(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(5.0.r),
                            child: Icon(
                              Icons.tune,
                              size: 16.r,color: AllColors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if(calender.value==true)
                Container(
                  margin: EdgeInsets.symmetric(horizontal:10.0.r),
                  padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 8.r),
                  color: AllColors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Icon(Icons.arrow_back_ios, size: 15.r, color: AllColors.black,),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            WeeklyDatePicker(
                              selectedDay: selectedDay.value, // DateTime
                              changeDay: (value)async{
                                selectedDay.value = value;
                                monthYear.value = value;
                                await controller.getMyLeadNetworkApi(DateFormat('yyy-MM-dd').format(value).toString(),DateFormat('yyy-MM').format(value),partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","","");
                              },
                              enableWeeknumberText: false,
                              weeknumberColor: AllColors.lightTeal.withOpacity(0.8),
                              weeknumberTextColor: Colors.white,
                              backgroundColor: AllColors.white,
                              weekdayTextColor: AllColors.black,
                              digitsColor: AllColors.black.withOpacity(0.6),
                              // selectedBackgroundColor: AllColors.lightTeal.withOpacity(0.8),
                              weekdays: const ["S", "M", "T", "W", "T","F", "S"],
                              daysInWeek: 7,
                            ),
                            InkWell(
                              onTap: ()async{
                                bool status = await  controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                if(status==true){
                                  selectedDay.value=DateTime.now();
                                  calender.value=false;
                                }
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text("Reset", style: fontBold.copyWith(fontSize: 12.r, color: AllColors.red.withOpacity(0.7)),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: Icon(Icons.arrow_forward_ios, size: 15.r, color: AllColors.black,),
                      ),
                    ],
                  ),
                ),
              if(calender.value==true)
                SizedBox(height: 5.r),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller.myLeadController,
                  child: Column(
                    children: [
                      /// fresh lead code
                      if(controller.fresh_lead_model.value.data.freshLead.isNotEmpty)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal:10.0.r),
                          padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 8.r),
                          color: AllColors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left:8.0.r),
                                child: Text("Fresh Leads", style: fontBold.copyWith()),
                              ),
                              SizedBox(height: 10.r),
                              Obx(() {
                                return /*controller.fresh_lead_loader.value?*/
                                  ListView.builder(
                                      itemCount: controller.fresh_lead_model.value.data.freshLead.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(bottom: 5.r),
                                      itemBuilder: (context, index){
                                        var freshLeadData= controller.fresh_lead_model.value.data.freshLead[index];
                                        return controller.fresh_lead_model.value.data.freshLead.isNotEmpty?
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5.0.r),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+freshLeadData.custLoanSelfie.toString())),
                                                child: CircleAvatar(
                                                  radius: 18.r,
                                                  backgroundColor: AllColors.lightTeal.withOpacity(0.6),
                                                  child: CustomImage(
                                                    image: freshLeadData.custLoanSelfie.toString(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.r),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              InkWell(
                                                                onTap: ()=> Get.to(()=> CustomerLoanListDetails(leadId: "${freshLeadData.id??""}",customerId: freshLeadData.custId??"")),
                                                                child: RichText(
                                                                  text: TextSpan(
                                                                    text: freshLeadData.custName??"NA",
                                                                    style: fontSmall.copyWith(fontWeight: FontWeight.w500),
                                                                    children: [
                                                                      TextSpan(text: " (${freshLeadData.leadId??"NA"})", style: fontSmall.copyWith()),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(freshLeadData.leadStatus??"NA", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                                              Text(freshLeadData.leadDateTime??"NA", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: ()=> launch("tel://+91${freshLeadData.custPhone??00}"),
                                                              child: Container(
                                                                padding: EdgeInsets.symmetric(horizontal: 14.r,vertical: 3.r),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(100.r),
                                                                    border: Border.all(width: 0.5, color: AllColors.grey.withOpacity(0.6))
                                                                ),
                                                                child: Icon(
                                                                  Icons.call,
                                                                  size: 12.r,
                                                                  color: AllColors.red.withOpacity(0.6),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: 10.r),
                                                            if(freshLeadData.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")
                                                              SizedBox(
                                                                height: 20.r,
                                                                width: 20.r,
                                                                child: Obx(()=> PopupMenuButton(
                                                                  padding: EdgeInsets.zero,
                                                                  position: PopupMenuPosition.over,
                                                                  offset: Offset.zero,
                                                                  initialValue: selectedMenu.value,
                                                                  onSelected: (value) async {
                                                                    selectedMenu.value = value.toString();
                                                                    if(value == "Transfer Lead"){
                                                                      bool checkStatus = await controller.freshLeadNetworkApi();
                                                                      if(checkStatus==true){
                                                                        if(controller.fresh_lead_model.value.data.freshLead[index].leadLockStatus=="false") {
                                                                          bool status = await permissionController.lockUnlockLeadNetworkApi(freshLeadData.leadId, "true");
                                                                          if(status==true) {
                                                                            CustomerDetails(leadId: "${freshLeadData.id??""}",customerId: freshLeadData.custId??"",value: "leadDetails", apiLeadId: freshLeadData.leadId,pageName: "myLead",leadTransferName: "transferLead",);
                                                                            controller.freshLeadNetworkApi();
                                                                          }
                                                                        }else{
                                                                          BaseController().errorSnack("Already details View on ${controller.fresh_lead_model.value.data.freshLead[index].lockedBy.toString()}");
                                                                          controller.freshLeadNetworkApi();
                                                                        }
                                                                      }
                                                                    }else{
                                                                      bool checkStatus = await controller.freshLeadNetworkApi();
                                                                      if(checkStatus==true){
                                                                        if(controller.fresh_lead_model.value.data.freshLead[index].leadLockStatus=="false") {
                                                                          bool status = await permissionController.lockUnlockLeadNetworkApi(freshLeadData.leadId, "true");
                                                                          if(status==true) {
                                                                            CustomerDetails(leadId: "${freshLeadData.id??""}",customerId: freshLeadData.custId??"",value: "leadDetails", apiLeadId: freshLeadData.leadId,pageName: "myLead");
                                                                            controller.freshLeadNetworkApi();
                                                                          }
                                                                        }else{
                                                                          BaseController().errorSnack("Already details View on ${controller.fresh_lead_model.value.data.freshLead[index].lockedBy.toString()}");
                                                                          controller.freshLeadNetworkApi();
                                                                        }
                                                                      }
                                                                    }
                                                                  },
                                                                  itemBuilder: (BuildContext context) => [
                                                                    PopupMenuItem(
                                                                      value: 'Set Follow-up'.tr,
                                                                      child: Text('Set Follow-up',style: fontMedium.copyWith()),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      value: 'Mark Hot Lead'.tr,
                                                                      child: Text('Mark Hot Lead',style: fontMedium.copyWith()),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      value: 'Transfer Lead'.tr,
                                                                      child: Text('Transfer Lead',style: fontMedium.copyWith()),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      value: 'Delete Lead'.tr,
                                                                      child: RichText(
                                                                        text: TextSpan(
                                                                          text: 'Delete Lead ',
                                                                          style: fontMedium.copyWith(),
                                                                          children: [
                                                                            TextSpan(text: '(Draft)', style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5))),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      // child: Text('Delete Lead',style: fontMedium.copyWith()),
                                                                    ),
                                                                  ],
                                                                  icon: Container(
                                                                    padding: EdgeInsets.all(2.r),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(100.r),
                                                                        border: Border.all(width: 0.5, color: AllColors.grey.withOpacity(0.6))
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.keyboard_arrow_down_sharp,
                                                                      size: 16.r,
                                                                      color: AllColors.black.withOpacity(0.6),
                                                                    ),
                                                                  ),
                                                                ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 10.0.r),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          GetBuilder<LoginController>(builder: (controller){
                                                            return controller.fresh_lead_model.value.data.freshLead[index].leadLockStatus=="true"?
                                                            Container(
                                                              width: 80.r,
                                                              height: 22.r,
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(2.r),
                                                                  color: AllColors.lightGrey.withOpacity(0.6),
                                                                  border: Border.all(width: 0.5.r, color: AllColors.black.withOpacity(0.5))
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Icon(Icons.lock_open_outlined,size: 15.r, color: AllColors.black.withOpacity(0.6)),
                                                                  SizedBox(width: 5.r),
                                                                  Obx(() => Text(controller.fresh_lead_model.value.data.freshLead[index].lockedBy.toString(),style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.6)),textAlign: TextAlign.end,)),
                                                                ],
                                                              ),
                                                            ):
                                                            InkWell(
                                                              onTap: ()async{
                                                                bool checkStatus = await controller.unassignedNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                                                if(checkStatus==true){
                                                                  if(controller.fresh_lead_model.value.data.freshLead[index].leadLockStatus=="false") {
                                                                    bool status = await permissionController.lockUnlockLeadNetworkApi(freshLeadData.leadId, true);
                                                                    if(status==true) {
                                                                      Get.to(()=> CustomerDetails(leadId: "${freshLeadData.id??""}",customerId: freshLeadData.custId??"",value: "leadDetails", apiLeadId: freshLeadData.leadId,pageName: "myLead",));
                                                                      controller.freshLeadNetworkApi();
                                                                    }
                                                                  }else{
                                                                    BaseController().errorSnack("Already details View on ${controller.fresh_lead_model.value.data.freshLead[index].lockedBy.toString()}");
                                                                    controller.unassignedNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                                                  }
                                                                }
                                                              },
                                                              child: Container(
                                                                width: 90.r,
                                                                height: 22.r,
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(2.r),
                                                                  color: AllColors.themeColor,
                                                                ),
                                                                child: Text( "View Details",style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.white.withOpacity(0.8)),),
                                                              ),
                                                            );
                                                          }),
                                                          if(freshLeadData.leadStatus.toString().toLowerCase()=="verified")
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Image.asset(Images.ok, height: 20.r, width: 20.r, fit: BoxFit.cover,),
                                                                SizedBox(width: 1.r),
                                                                Text("Verify",style: fontMedium.copyWith(
                                                                  color: AllColors.green,
                                                                  fontSize: 13.r,
                                                                  letterSpacing: 0.2,
                                                                ),
                                                                ),
                                                              ],
                                                            ),
                                                          if(freshLeadData.leadStatus.toString().toLowerCase()=="new")
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Image.asset(Images.ok, height: 20.r, width: 20.r, fit: BoxFit.cover,),
                                                                SizedBox(width: 1.r),
                                                                Text("Fresh",style: fontMedium.copyWith(
                                                                  color: AllColors.green,
                                                                  fontSize: 13.r,
                                                                  letterSpacing: 0.2,
                                                                ),
                                                                ),
                                                              ],
                                                            ),
                                                          if(freshLeadData.leadStatus.toString().toLowerCase()!="verified"&&freshLeadData.leadStatus.toString().toLowerCase()!="new")
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Image.asset(Images.rejected, height: 20.r, width: 20.r, fit: BoxFit.cover),
                                                                SizedBox(width: 1.r),
                                                                Text("${freshLeadData.leadStatus.toString().capitalize}", style: fontMedium.copyWith(
                                                                  color: AllColors.red.withOpacity(0.7),
                                                                  fontSize: 13.r,
                                                                  letterSpacing: 0.2,
                                                                ),
                                                                ),
                                                              ],
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    if(index < controller.fresh_lead_model.value.data.freshLead.length - 1)
                                                      Container(
                                                        height: 1.r,
                                                        margin: EdgeInsets.symmetric(vertical: 12.r),
                                                        color: AllColors.lightGrey.withOpacity(0.8),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ) :
                                        Container(
                                            alignment: Alignment.center,
                                            height: 40.r,
                                            child: Text("No data available",style: fontRegular.copyWith(letterSpacing: 0,),)
                                        );
                                      });
                              }),

                            ],
                          ),
                        ),
                      if(controller.fresh_lead_model.value.data.freshLead.isNotEmpty)
                        SizedBox(height: freshLead.value==true?15.r:0),
                      /// all lead data list code
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0.r),
                        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
                        color: AllColors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /// counts list widget
                            Container(
                              height: 60.r,
                              padding: EdgeInsets.symmetric(vertical: 8.r),
                              child: Row(
                                children: [
                                  InkWell(
                                    child: Icon(
                                      Icons.keyboard_arrow_left_rounded,
                                      size: 22.r,color:
                                    AllColors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: Obx((){
                                      return controller.get_my_lead_model.value.data.counts.isNotEmpty?
                                      ListView.builder(
                                        itemCount: controller.get_my_lead_model.value.data.counts.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index){
                                          var data1 = controller.get_my_lead_model.value.data.counts[index];
                                          return Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left: 25.r, right: 25.r,),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(data1.title??"NA",style: fontSmall.copyWith(),),
                                                    Text("${data1.count??0}",style: fontRegular.copyWith(fontSize: 16.r),),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 1.r,
                                                color: AllColors.lightGrey.withOpacity(0.8),
                                              )
                                            ],
                                          );
                                        },
                                      ):
                                      ListView.builder(
                                        itemCount: 5,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index){
                                          return Row(
                                            children: [
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  width: 90.r,
                                                  color: AllColors.white,
                                                  margin: EdgeInsets.only(right: 5.r),
                                                ),
                                              ),
                                              Container(
                                                width: 1.r,
                                                color: AllColors.lightGrey.withOpacity(0.8),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    ),
                                  ),
                                  InkWell(
                                    child: Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 22.r,color:
                                    AllColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if(controller.get_my_lead_model.value.data.allLead.isNotEmpty||controller.get_my_lead_model.value.data.allLead!="null")
                              SizedBox(height: 10.r),
                            GetBuilder<LoginController>(builder:(controller) {
                              return controller.get_my_lead_loader.value?
                              ListView.builder(
                                  itemCount: controller.get_my_lead_model.value.data.allLead.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: 5.r),
                                  itemBuilder: (context, index){
                                    var myLeadData= controller.get_my_lead_model.value.data.allLead[index];
                                    bool isLastItem = index == controller.get_my_lead_model.value.data.allLead.length - 1;
                                    return CustomLeadsDetails3(
                                      name: myLeadData.custName??"NA",
                                      leadId: myLeadData.leadId??"",
                                      leadTypeName: myLeadData.leadSource??"",
                                      address: myLeadData.custPermanentAddress??"NA",
                                      createDate: myLeadData.leadDateTime??"NA",
                                      image: myLeadData.custLoanSelfie.toString(),
                                      number: myLeadData.custPhone??"",
                                      leadLockStatus: myLeadData.leadLockStatus??"false",
                                      leadStatus: myLeadData.leadStatus??"",
                                      holdCount: myLeadData.holdCount,
                                      lockedBy: myLeadData.lockedBy??"",
                                      leadDateTime: myLeadData.leadDateTime??"NA",
                                      index: isLastItem,
                                      detailsTap: ()async{
                                        bool checkStatus = await controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                        if(checkStatus==true){
                                          if(controller.get_my_lead_model.value.data.allLead[index].leadLockStatus=="false") {
                                            bool status = await permissionController.lockUnlockLeadNetworkApi(myLeadData.leadId, "true");
                                            if(status==true) {
                                              Get.to(()=> CustomerDetails(leadId: "${myLeadData.id}",customerId: "${myLeadData.custId}",value: "leadDetails", apiLeadId: myLeadData.leadId, pageName: "myLead",));
                                              controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                            }
                                          }else{
                                            BaseController().errorSnack("Already details View on ${controller.get_my_lead_model.value.data.allLead[index].lockedBy.toString()}");
                                            controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                          }
                                        }
                                      },
                                      nameTap: ()=> Get.to(()=> CustomerLoanListDetails(leadId: "${myLeadData.id??""}",customerId: myLeadData.custId??"")),
                                      transferLeadStatus: myLeadData.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes"?true:false,
                                      child: Obx(()=> PopupMenuButton(
                                        padding: EdgeInsets.symmetric(horizontal: 0.r),
                                        position: PopupMenuPosition.over,
                                        offset: Offset.zero,
                                        initialValue: selectedMenu.value,
                                        onSelected: (value) async {
                                          selectedMenu.value = value.toString();
                                          if(value == "Transfer Lead"){
                                            bool checkStatus = await controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                            if(checkStatus==true){
                                              if(controller.get_my_lead_model.value.data.allLead[index].leadLockStatus=="false") {
                                                bool status = await permissionController.lockUnlockLeadNetworkApi(myLeadData.leadId, "true");
                                                if(status==true) {
                                                  Get.to(()=> CustomerDetails(leadId: "${myLeadData.id??""}",customerId: myLeadData.custId??"",value: "leadDetails",apiLeadId: myLeadData.leadId, pageName: "myLead",leadTransferName: "transferLead",));
                                                  controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                                }
                                              }else{
                                                BaseController().errorSnack("Already details View on ${controller.get_my_lead_model.value.data.allLead[index].lockedBy.toString()}");
                                                controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                              }
                                            }
                                          }else{
                                            bool checkStatus = await controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                            if(checkStatus==true){
                                              if(controller.get_my_lead_model.value.data.allLead[index].leadLockStatus=="false") {
                                                bool status = await permissionController.lockUnlockLeadNetworkApi(myLeadData.leadId, "true");
                                                if(status==true) {
                                                  Get.to(()=> CustomerDetails(leadId: "${myLeadData.id}",customerId: "${myLeadData.custId}",value: "leadDetails", apiLeadId: myLeadData.leadId, pageName: "myLead",));
                                                  controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                                }
                                              }else{
                                                BaseController().errorSnack("Already details View on ${controller.get_my_lead_model.value.data.allLead[index].lockedBy.toString()}");
                                                controller.getMyLeadNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value),"","","","",partnerController.leadStageStatusDecode(controller.selectStageType.value));
                                              }
                                            }
                                          }
                                          print("object $value");
                                          // controller.getMyLeadNetworkApi("","",value=="Personal Loan"?"PL":value=="Business Loan"?"BL":value=="Self-Employee Loan"?"SEL":"Pl");
                                        },
                                        itemBuilder: (BuildContext context) => [
                                          PopupMenuItem(
                                            value: 'Set Follow-up'.tr,
                                            child: Text('Set Follow-up',style: fontMedium.copyWith()),
                                          ),
                                          PopupMenuItem(
                                            value: 'Mark Hot Lead'.tr,
                                            child: Text('Mark Hot Lead',style: fontMedium.copyWith()),
                                          ),
                                          PopupMenuItem(
                                            value: 'Transfer Lead'.tr,
                                            child: Text('Transfer Lead',style: fontMedium.copyWith()),
                                          ),
                                          PopupMenuItem(
                                            value: 'Delete Lead'.tr,
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Delete Lead ',
                                                style: fontMedium.copyWith(),
                                                children: [
                                                  TextSpan(text: '(Draft)', style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.5))),
                                                ],
                                              ),
                                            ),
                                            // child: Text('Delete Lead',style: fontMedium.copyWith()),
                                          ),
                                        ],
                                        icon: Container(
                                          padding: EdgeInsets.all(2.r),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100.r),
                                              border: Border.all(width: 0.5, color: AllColors.grey.withOpacity(0.6))
                                          ),
                                          child: Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            size: 16.r,
                                            color: AllColors.black.withOpacity(0.6),
                                          ),
                                        ),
                                      )),
                                    );
                                  }) :
                              ListView.builder(
                                  itemCount: 12,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                                  itemBuilder: (context, index){
                                    return Container(
                                      padding: EdgeInsets.only(left: 5.0.r,right: 5.0.r, top: index==0?8.r:0),
                                      color: AllColors.white,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.grey.shade100,
                                            enabled: true,
                                            child: CircleAvatar(
                                              radius: 18.r,
                                              backgroundColor: AllColors.white,
                                            ),
                                          ),
                                          SizedBox(width: 10.r),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Shimmer.fromColors(
                                                          baseColor: Colors.grey.shade300,
                                                          highlightColor: Colors.grey.shade100,
                                                          enabled: true,
                                                          child: Container(
                                                            width: 150.r,
                                                            height: 15.r,
                                                            color: AllColors.white,
                                                            margin: EdgeInsets.only(right: 5.r),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5.r),
                                                        Shimmer.fromColors(
                                                          baseColor: Colors.grey.shade300,
                                                          highlightColor: Colors.grey.shade100,
                                                          enabled: true,
                                                          child: Container(
                                                            width: 80.r,
                                                            height: 10.r,
                                                            color: AllColors.white,
                                                            margin: EdgeInsets.only(right: 5.r),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5.r),
                                                        Shimmer.fromColors(
                                                          baseColor: Colors.grey.shade300,
                                                          highlightColor: Colors.grey.shade100,
                                                          enabled: true,
                                                          child: Container(
                                                            width: 120.r,
                                                            height: 10.r,
                                                            color: AllColors.white,
                                                            margin: EdgeInsets.only(right: 5.r),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                if(index!=11)
                                                  Container(
                                                    height: 1.r,
                                                    margin: EdgeInsets.symmetric(vertical: 10.r),
                                                    color: AllColors.lightGrey,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }),
                            if(controller.get_my_lead_model.value.message.toString()=="Data Not Found.")
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(bottom: 10.r),
                                  child: Text("Data not found !!",style: fontRegular.copyWith(letterSpacing: 0,color: AllColors.black.withOpacity(0.7)),)
                              ),
                            Obx(() => controller.isLoadMore.value? const LoadingMoreData():const SizedBox()),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.r),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.r),
            ],
          );
        }
        else{
          return const DefaultMyLeads();
        }
      }),
    );
  }

  void _showBottomSheetFilter(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            bottomLeft: Radius.circular(10.r),
            topRight: Radius.zero,
            bottomRight:  Radius.zero,
          )
        ),
        insetPadding: EdgeInsets.only(left: 80.r,top: 40.r),
        child: Container(
          width: Get.width-80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              bottomLeft: Radius.circular(10.r),
              topRight: Radius.zero,
              bottomRight:  Radius.zero,
            )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: ()=> Navigator.pop(context),
                    icon: CircleAvatar(
                      radius: 10.r,
                      backgroundColor: AllColors.grey.withOpacity(0.7),
                      child: Icon(Icons.close,size: 15.r,color: AllColors.white,),
                    ),
                  ),
                ),
                Container(
                  height: 3.r,
                  color: AllColors.lightGrey,
                ),
                SizedBox(height: 20.r),
                Container(
                  padding: EdgeInsets.only(right: 10.r, left: 15.r),
                  child: Form(
                    // key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Customer PAN",
                          style: fontMedium.copyWith(
                              color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        UnderLineTextField(
                          hint: "type here...".tr,
                          controller: controller.customerPan,
                          label: false,
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter permanent account number (PAN)';
                            }else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
                              return 'Please enter valid PAN card';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.r),
                        Text(
                          "Customer Phone or Email ID",
                          style: fontMedium.copyWith(
                              color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        UnderLineTextField(
                          hint: "type here...".tr,
                          label: false,
                          controller: controller.customerPhone,
                          onTap: () {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.r),
                        Text(
                          "Loan owner PAN",
                          style: fontMedium.copyWith(
                              color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        UnderLineTextField(
                          hint: "type here...".tr,
                          label: false,
                          controller: controller.loanOwnerPan,
                          onTap: () {},
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter permanent account number (PAN)';
                            }else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
                              return 'Please enter valid PAN card';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.r),
                        Text(
                          "Loan owner Phone",
                          style: fontMedium.copyWith(
                              color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        UnderLineTextField(
                          hint: "type here...".tr,
                          label: false,
                          controller: controller.loanOwnerPhone,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          length: 10,
                          type: TextInputType.number,
                          onTap: () {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.r),
                        Text(
                          "All Loan",
                          style: fontMedium.copyWith(
                              color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        CustomUnderlineDropdownField(
                          items: ["Personal loan", "Business loan", "Self-Employee Loan"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: (){
                                print("value $value");
                                controller.loanType.value=value;
                              },
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            controller.gender.value = newValue ?? "Personal loan";
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please select gender';
                          //   }
                          //   return null;
                          // },
                          // value: controller.gender.value,
                          hint: "select All Loan",
                        ),
                        SizedBox(height: 20.r),
                        Text(
                          "Lead updated time",
                          style: fontMedium.copyWith(
                              color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        SizedBox(height: 5.r),
                        Row(
                          children: [
                            Expanded(
                              child:  UnderLineTextField(
                                hint: 'Start Date'.tr,
                                label: false,
                                isRead: true,
                                icon: true,
                                controller: controller.leadStartDate,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2800));

                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    controller.leadStartDate.text = formattedDate;
                                    print(formattedDate);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter start date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 15.r),
                            Expanded(
                              child:  UnderLineTextField(
                                hint: 'End Date'.tr,
                                label: false,
                                isRead: true,
                                icon: true,
                                controller: controller.leadEndDate,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2800));

                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    print(formattedDate);
                                    controller.leadEndDate.text = formattedDate;
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter end date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.r),
                        Text(
                          "Lead updated time",
                          style: fontMedium.copyWith(
                              color: Colors.black.withOpacity(0.8),
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                        SizedBox(height: 5.r),
                        Row(
                          children: [
                            Expanded(
                              child:  UnderLineTextField(
                                hint: 'Start Date'.tr,
                                label: false,
                                isRead: true,
                                icon: true,
                                // controller: controller.etDob,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2800));
                                  if (pickedDate != null) {
                                    print(pickedDate);
                                    String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                    print(formattedDate);
                                    // controller.etDob.text = formattedDate;
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter start date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 15.r),
                            Expanded(
                              child:  UnderLineTextField(
                                hint: 'End Date'.tr,
                                label: false,
                                isRead: true,
                                icon: true,
                                // controller: controller.etDob,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2800));

                                  if (pickedDate != null) {
                                    print(pickedDate);
                                    String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                    print(formattedDate);
                                    // controller.etDob.text = formattedDate;
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter end date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.r),
                        CustomButton(
                          title: "Search now".tr,
                          background: false,
                          radius: 5.r,
                          height: 35.r,
                          bgColor: AllColors.green,
                          width: Get.width,
                          onTap: () async {
                            Navigator.pop(context);
                            controller.getMyLeadNetworkApi("","","",controller.customerPan.text, controller.customerPhone.text, controller.loanType.value, controller.leadStartDate.text, controller.leadEndDate.text);
                            controller.loanType.value="All Loan";
                            controller.customerPan.clear();
                            controller.customerPhone.clear();
                            controller.leadStartDate.clear();
                            controller.leadEndDate.clear();
                          },
                        ),
                        SizedBox(height: 15.r),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
