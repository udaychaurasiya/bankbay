// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use, use_build_context_synchronously, unnecessary_null_comparison

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/custom_image.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/utils_method/loading_more_widget.dart';
import 'package:bank_bay/utils_method/underline_dropdown.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:bank_bay/widgets/Customer%20details/customer_loan_list_details.dart';
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

class ApproveAssignLeadsScreen extends StatefulWidget {
  const ApproveAssignLeadsScreen({super.key});

  @override
  State<ApproveAssignLeadsScreen> createState() => _ApproveAssignLeadsScreenState();
}

class _ApproveAssignLeadsScreenState extends State<ApproveAssignLeadsScreen> {
  var controller = Get.find<LoginController>();
  var partnerController = Get.find<PartnerController>();
  RxBool calender=false.obs;
  var selectedDay = DateTime.now().obs;
  var monthYear = DateTime.now().obs;
  var selectLoanType = "All Loan".obs;
  var selectedMenu = "Set Follow-up".obs;
  TextEditingController remarks = TextEditingController();


  @override
  void initState() {
    controller.approveAssignNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: Obx((){
        final List<RxBool> isExpandedList = List.generate(controller.approve_assign_model.value.data.leads.length, (index) => RxBool(false));
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0.r),
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
                        selectLoanType.value == value;
                        controller.approveAssignNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value));
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          color: AllColors.blue.withOpacity(0.4),
                          child: Icon(Icons.unfold_more,size: 16.r,color: AllColors.black,),
                        ),
                        SizedBox(width: 8.r),
                        Obx(() => Text(selectLoanType.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                      ],
                    ),
                  ),
                  SizedBox(width: selectLoanType.value=="All Loan"?25.r:15.r),
                  InkWell(
                    onTap: () {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromSize(Rect.fromCircle(center: const Offset(80, 150), radius: 5), const Size(150, 300)),
                        items: <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: 'All Source'.tr,
                            child: Text('All Source',style: fontMedium.copyWith()),
                          ),
                          PopupMenuItem(
                            value: 'Employee'.tr,
                            child: Text('Employee',style: fontMedium.copyWith()),
                          ),
                          PopupMenuItem(
                            value: 'Partner'.tr,
                            child: Text('Partner',style: fontMedium.copyWith()),
                          ),
                          PopupMenuItem(
                            value: 'Customer'.tr,
                            child: Text('Customer',style: fontMedium.copyWith()),
                          ),

                        ],
                      ).then((value) {
                        controller.filterTypeSelected.value = value??"All Source";
                        controller.allLeadsDataNetworkApi("","","",partnerController.loanTypeDecode(value.toString()),"","","",controller.leadsPageName.value, controller.filterTypeSelected.value,partnerController.leadStatusNameFilter(controller.selectEmployeePartnerValue.value));
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          color: AllColors.blue.withOpacity(0.4),
                          child: Icon(Icons.unfold_more,size: 15.r,color: AllColors.black,),
                        ),
                        SizedBox(width: 8.r),
                        Obx(() => Text(controller.filterTypeSelected.value,style: fontSmall.copyWith(letterSpacing: 0,wordSpacing: 0),)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
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
                      SizedBox(width: 15.r),
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
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5.r,right: 10.r),
              height: 18.r,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildRadioButtonEMP("All", "All"),
                  SizedBox(width: 20.r),
                  buildRadioButtonEMP("Direct", "Direct"),
                  SizedBox(width: 20.r),
                  buildRadioButtonEMP("Indirect", "Indirect"),
                ],
              ),
            ),
            SizedBox(height: 12.r),
            if(calender.value==true)
              SizedBox(height: 5.r),
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
                      child: Obx(()=> WeeklyDatePicker(
                        selectedDay: selectedDay.value, // DateTime
                        changeDay: (value)async{
                          selectedDay.value = value;
                          monthYear.value = value;
                          await controller.approveAssignNetworkApi(DateFormat('yyy-MM-dd').format(value).toString(),DateFormat('yyy-MM').format(value),partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value));
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
                      ),),
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
                child: Container(
                  margin: EdgeInsets.only(left:10.0.r, right: 10.r, bottom: 8.r),
                  padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 8.r),
                  color: AllColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left:8.0.r),
                        child: Text("Approve Assign Leads", style: fontBold.copyWith(),),
                      ),
                      SizedBox(height: 15.r),
                      GetBuilder<LoginController>(builder: (controller) {
                        return controller.approve_assign_loader.value?
                        ListView.builder(
                            itemCount: controller.approve_assign_model.value.data.leads.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 5.r),
                            itemBuilder: (context, index){
                              var data = controller.approve_assign_model.value.data.leads[index];
                              bool isLastItem = index == controller.approve_assign_model.value.data.leads.length - 1;
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+data.custLoanSelfie.toString())),
                                          child: CircleAvatar(
                                            radius: 18.r,
                                            backgroundColor: AllColors.lightTeal.withOpacity(0.6),
                                            child: CustomImage(
                                              image: data.custLoanSelfie.toString(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.r),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        InkWell(
                                                          onTap:  ()async{
                                                            Get.to(()=> CustomerLoanListDetails(leadId: "${data.id??""}",customerId: data.custId??"",apiLeadId: data.leadId));
                                                          },
                                                          child: RichText(
                                                            text: TextSpan(
                                                              text: data.custName??"NA",
                                                              style: fontSmall.copyWith(fontWeight: FontWeight.w500),
                                                              children: [
                                                                TextSpan(text: "(${data.leadId??"NA"})", style: fontSmall.copyWith()),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Text(data.custPermanentAddress??"Lucknow, Utter Pradesh", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                                        Text(data.leadDateTime??"NA", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: ()=> launch("tel://+91${data.custPhone}"),
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
                                                      if(data.leadSource.toString()!=GetStorage().read(AppConstant.cust_id)&&GetStorage().read(AppConstant.assignment_change_approval).toString().toLowerCase() == "yes")
                                                        SizedBox(
                                                          height: 20.r,
                                                          width: 20.r,
                                                          child: Obx(()=> PopupMenuButton(
                                                            initialValue: selectedMenu.value,
                                                            onSelected: (value) {
                                                              selectedMenu.value = value.toString();
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
                                                            padding: EdgeInsets.zero,
                                                            constraints: BoxConstraints(
                                                              minHeight: 50.r,
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
                                                child: Obx(()=> isExpandedList[index].value ?
                                                  InkWell(
                                                    onTap: ()async{
                                                      isExpandedList[index].value = false;
                                                    },
                                                    child: Container(
                                                      width: 90.r,
                                                      height: 22.r,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(2.r),
                                                          color: AllColors.white,
                                                          border: Border.all(width: 0.5.r, color: AllColors.themeColor.withOpacity(0.8))
                                                      ),
                                                      child: Text( "Hide Details",style: fontMedium.copyWith(fontSize: 12.r, color: AllColors.themeColor),),
                                                    ),
                                                  ):
                                                  InkWell(
                                                    onTap: ()async{
                                                      isExpandedList[index].value = true;
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
                                                ),
                                                ),
                                              ),
                                              Obx(() => isExpandedList[index].value ?
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 20.r),
                                                    ApproveDetailsData(
                                                      titleNameHint: "Tele".tr,
                                                      fromEmpName: "${data.leadAssignTeleFrom.empFname??"NA"} ${data.leadAssignTeleFrom.empLname??""}",
                                                      fromEmpId: "${data.leadAssignTeleFrom.eid??0}",
                                                      fromAddress: data.leadAssignTeleFrom.empPermanentAddress??"Address : NA",
                                                      fromSupName: data.leadAssignTeleFrom.supName??"NA",
                                                      fromSupId: "${data.leadAssignTeleFrom.supId??""}",
                                                      fromFunction: data.leadAssignTeleFrom.empFunction??"NA",
                                                      toEmpName: "${data.leadAssignTeleTo.empFname??"NA"} ${data.leadAssignTeleTo.empLname??""}",
                                                      toEmpId: "${data.leadAssignTeleTo.eid??0}",
                                                      toAddress: data.leadAssignTeleTo.empPermanentAddress??"Address : NA",
                                                      toSupName: data.leadAssignTeleTo.supName??"NA",
                                                      toSupId: "${data.leadAssignTeleTo.supId??""}",
                                                      toFunction: data.leadAssignTeleTo.empFunction??"NA",
                                                      border: true,
                                                      fromValue: data.leadAssignTeleFrom.eid!=null&&data.leadAssignTeleFrom.eid!=""?true:false,
                                                      toValue: data.leadAssignTeleTo.eid!=null&&data.leadAssignTeleTo.eid!=""?true:false,
                                                    ),
                                                  if((data.leadAssignFosTo.eid!=null&&data.leadAssignFosTo.eid!="")&&(data.leadAssignFosTo.empFname!=null&&data.leadAssignFosTo.empFname!=""))
                                                    ApproveDetailsData(
                                                      titleNameHint: "Fos".tr,
                                                      fromEmpName: "${data.leadAssignFosFrom.empFname??"NA"} ${data.leadAssignFosFrom.empLname??""}",
                                                      fromEmpId: "${data.leadAssignFosFrom.eid??0}",
                                                      fromAddress: data.leadAssignFosFrom.empPermanentAddress??"Address : NA",
                                                      fromSupName: data.leadAssignFosFrom.supName??"NA",
                                                      fromSupId: "${data.leadAssignFosFrom.supId??""}",
                                                      fromFunction: data.leadAssignFosFrom.empFunction??"NA",
                                                      toEmpName: "${data.leadAssignFosTo.empFname??"NA"} ${data.leadAssignFosTo.empLname??""}",
                                                      toEmpId: "${data.leadAssignFosTo.eid??0}",
                                                      toAddress: data.leadAssignFosTo.empPermanentAddress??"Address : NA",
                                                      toSupName: data.leadAssignFosTo.supName??"NA",
                                                      toSupId: "${data.leadAssignFosTo.supId??""}",
                                                      toFunction: data.leadAssignFosTo.empFunction??"NA",
                                                      fromValue: data.leadAssignFosFrom.eid!=null&&data.leadAssignFosFrom.eid!=""?true:false,
                                                      toValue: data.leadAssignFosTo.eid!=null&&data.leadAssignFosTo.eid!=""?true:false,
                                                    ),
                                                  SizedBox(height: 15.r),
                                                  TextField(
                                                    controller: remarks,
                                                    keyboardType: TextInputType.multiline,
                                                    maxLines: 2,
                                                    decoration: InputDecoration(
                                                      hintText: "Mention reason for assignment change",
                                                      isDense: true,
                                                      // filled: true,
                                                      // fillColor: AllColors.white.withOpacity(0.9),
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
                                                      hintStyle: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6), fontStyle: FontStyle.italic, fontSize: 13.r, wordSpacing: 0.3, letterSpacing: 0.5),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                                                      ),
                                                      focusedBorder:  OutlineInputBorder(
                                                          borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                                                      ),
                                                      errorBorder:   OutlineInputBorder(
                                                          borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                                                      ),
                                                      focusedErrorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color:  AllColors.black.withOpacity(0.2))
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 15.r),
                                                  Row(
                                                    children: [
                                                      CustomButton(
                                                        height: 30.r,
                                                        width: 70.r,
                                                        title: "Accept".tr,
                                                        bgColor: AllColors.green,
                                                        radius: 30.r,
                                                        miniFont: true,
                                                        background: false,
                                                        onTap: () async{
                                                          bool status = await partnerController.assignmentChangeApprovalNetworkApi(
                                                              data.leadId.toString(),
                                                              "Approve",
                                                              "",remarks.text
                                                          );
                                                          if(status==true){
                                                            controller.approveAssignNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value));
                                                          }
                                                        },
                                                      ),
                                                      SizedBox(width: 15.r),
                                                      CustomButton(
                                                        height: 30.r,
                                                        width: 70.r,
                                                        title: "Reject".tr,
                                                        miniFont: true,
                                                        bgColor: AllColors.red.withOpacity(0.6),
                                                        radius: 30.r,
                                                        background: false,
                                                        onTap: () async{
                                                          bool status = await partnerController.assignmentChangeApprovalNetworkApi(
                                                            data.leadId.toString(),"Reject", "",remarks.text
                                                          );
                                                          if(status==true){
                                                            controller.approveAssignNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value));
                                                          }
                                                        },
                                                      ),
                                                      SizedBox(width: 18.r),
                                                      InkWell(
                                                        onTap: (){
                                                          isExpandedList[index].value = false;
                                                        },
                                                        child: Container(
                                                          height: 25.r,
                                                          width: 90.r,
                                                          padding: EdgeInsets.symmetric(horizontal: 8.r),
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(2.r),
                                                              color: AllColors.white,
                                                              border: Border.all(width: 0.5.r, color: AllColors.themeColor.withOpacity(0.8)),
                                                          ),
                                                          child: Text("Hide details", style: fontMedium.copyWith(color: AllColors.blue, fontSize: 12.r)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                                ):
                                                const SizedBox(),
                                                ),
                                              isLastItem ? const SizedBox():
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
                                    SizedBox(height: index==0?0:10.r),
                                    Obx(() => isExpandedList[index].value?
                                      ListView.builder(
                                        itemCount: data.assignAuth.length,
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(horizontal: 8.r, vertical: 6.r),
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
                                                          text: data.assignAuth[index].updateByName??"NA",
                                                          style: fontSmall.copyWith(fontWeight: FontWeight.w500, color: AllColors.themeColor, fontSize: 12.5.r,wordSpacing: 0, letterSpacing: 0,),
                                                          children: [
                                                            TextSpan(text: " (${data.assignAuth[index].remarkUpdateBy??"NA"})", style: fontSmall.copyWith(fontWeight: FontWeight.w400,  fontSize: 12.r,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, overflow: TextOverflow.ellipsis,)),
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
                                                            TextSpan(text: data.assignAuth[index].remarkDateTime??"", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0, fontSize: 11.r, overflow: TextOverflow.ellipsis)),
                                                          ],
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      SizedBox(width: 1.r),
                                                      Text(data.assignAuth[index].remark??"", style: fontSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6),wordSpacing: 0, letterSpacing: 0),),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },) :
                                      const SizedBox(),
                                    ),
                                  ],
                                ),
                              );
                            }) :
                        ListView.builder(
                            itemCount: 12,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 5.r),
                            itemBuilder: (context, index){
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0.r),
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
                                              SizedBox(width: 30.r),
                                              Row(
                                                children: [
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade300,
                                                    highlightColor: Colors.grey.shade100,
                                                    enabled: true,
                                                    child: Container(
                                                      width: 40.r,
                                                      height: 20.r,
                                                      decoration: BoxDecoration(
                                                        color: AllColors.white,
                                                        borderRadius: BorderRadius.circular(100.r),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.r),
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade300,
                                                    highlightColor: Colors.grey.shade100,
                                                    enabled: true,
                                                    child: CircleAvatar(
                                                      radius: 12.r,
                                                      backgroundColor: AllColors.white,
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
                      if(controller.approve_assign_model.value.message.toString()=="Data Not Found.")
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 10.r),
                            child: Text("Data not found !!",style: fontRegular.copyWith(letterSpacing: 0,color: AllColors.black.withOpacity(0.7)),)
                        ),
                      Obx(() => controller.isLoadMore.value? const LoadingMoreData() : const SizedBox()),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.r),
          ],
        );
      },
      ),
    );
  }

  Widget buildRadioButtonEMP(String title, String value) {
    return Obx(() => Row(
      children: [
        SizedBox(
          height: 22.r,
          width: 25.r,
          child: Radio(
            value: value,
            groupValue: controller.leadsPageName.value,
            onChanged: (selectedValue) {
              controller.leadsPageName.value = selectedValue??"All";
              controller.leadsPageName.refresh();
              controller.approveAssignNetworkApi("","",partnerController.loanTypeDecode(controller.selectLoanType.value.toString()),"","","","",partnerController.leadStatusNameFilter(controller.leadsPageName.value));
            },
          ),
        ),
        SizedBox(width: 5.r),
        Text(title),
      ],
    ),
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
                            controller.approveAssignNetworkApi("","","",controller.customerPan.text, controller.customerPhone.text, controller.loanType.value, controller.leadStartDate.text, controller.leadEndDate.text);
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

class ApproveDetailsData extends StatelessWidget {
  final String titleNameHint;
  final String fromEmpName;
  final String fromEmpId;
  final String fromAddress;
  final String fromSupName;
  final String fromSupId;
  final String fromFunction;
  final String toEmpName;
  final String toEmpId;
  final String toAddress;
  final String toSupName;
  final String toSupId;
  final String toFunction;
  final bool? border;
  final bool fromValue;
  final bool toValue;
  const ApproveDetailsData({super.key, required this.fromEmpName, required this.fromEmpId, required this.fromAddress,
    required this.fromSupName, required this.fromSupId, required this.fromFunction, required this.titleNameHint,
    required this.toEmpName, required this.toEmpId, required this.toAddress, required this.toSupName, required this.toSupId,
    required this.toFunction, this.border=false, required this.fromValue, required this.toValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// from data
        RichText(
          text: TextSpan(
            text: "Present Assignment",
            style: fontMedium.copyWith(),
            children: [
              TextSpan(text: " ($titleNameHint)",style: fontMedium.copyWith(color: AllColors.black, fontSize: 14.r,),),
            ],
          ),
        ),
        SizedBox(height: 15.r),
        fromValue==true?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: fromEmpName,
                style: fontMedium.copyWith(fontSize: 13.r,color: AllColors.black.withOpacity(0.7)),
                children: [
                  TextSpan(text: " ($fromEmpId)",style: fontMedium.copyWith(fontSize: 12.5.r,color: AllColors.black.withOpacity(0.7))),
                ],
              ),
            ),
            SizedBox(height: 4.r),
            Text(fromAddress,style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7), fontSize: 12.5.r,),),
            SizedBox(height: 4.r),
            RichText(
              text: TextSpan(
                text: 'Sup ID : ',
                style: fontMedium.copyWith(color: AllColors.grey,fontSize: 13.r,),
                children: [
                  TextSpan(text: fromSupName,style: fontMedium.copyWith(color: AllColors.black, fontSize: 12.5.r,),),
                  TextSpan(text: " ($fromSupId)",style: fontMedium.copyWith(color: AllColors.black, fontSize: 12.5.r,),),
                ],
              ),
            ),
            SizedBox(height: 4.r),
            RichText(
              text: TextSpan(
                text: 'Function : ',
                style: fontMedium.copyWith(color: AllColors.grey,fontSize: 13.r,),
                children: [
                  TextSpan(text: fromFunction==""?"NA":fromFunction,style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                ],
              ),
            ),
          ],
        ) :
        Text("Unassigned",style: fontMedium.copyWith(color: AllColors.red.withOpacity(0.8), fontSize: 13.r,)),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 15.r, bottom: 15.r),
          child: Text( "To",style: fontMedium.copyWith(color: AllColors.red.withOpacity(0.5), fontSize: 13.r),),
        ),
        /// to data
        if(toValue==true)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: toEmpName,
                style: fontMedium.copyWith(fontSize: 13.r,color: AllColors.black.withOpacity(0.7)),
                children: [
                  TextSpan(text: " ($toEmpId)",style: fontMedium.copyWith(fontSize: 12.5.r,color: AllColors.black.withOpacity(0.7))),
                ],
              ),
            ),
            SizedBox(height: 4.r),
            Text(toAddress,style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7), fontSize: 12.5.r,),),
            SizedBox(height: 4.r),
            RichText(
              text: TextSpan(
                text: 'Sup ID : ',
                style: fontMedium.copyWith(color: AllColors.grey,fontSize: 13.r,),
                children: [
                  TextSpan(text: toSupName,style: fontMedium.copyWith(color: AllColors.black, fontSize: 12.5.r,),),
                  TextSpan(text: " ($toSupId)",style: fontMedium.copyWith(color: AllColors.black, fontSize: 12.5.r,),),
                ],
              ),
            ),
            SizedBox(height: 4.r),
            RichText(
              text: TextSpan(
                text: 'Function : ',
                style: fontMedium.copyWith(color: AllColors.grey,fontSize: 13.r,),
                children: [
                  TextSpan(text: toFunction==""?"NA":toFunction,style: fontMedium.copyWith(color: AllColors.black, fontSize: 13.r,),),
                ],
              ),
            ),
          ],
        ),
        if(border==true)
        Container(
          height: 1.r,
          color: AllColors.lightGrey,
          margin: EdgeInsets.symmetric(vertical: 20.r),
        ),

      ],
    );
  }
}