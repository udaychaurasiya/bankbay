import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Details View/employee_photo_view.dart';
import 'Details View/employee_pushback_access_view.dart';
import 'Details View/employee_pushback_docs_view.dart';
import 'Details View/employee_pushback_kyc_view.dart';
import 'Details View/employee_pushback_payroll_view.dart';
import 'Details View/pushback_about_view.dart';
import 'Push back/employee_photo_edit.dart';
import 'Push back/employee_push_back_about.dart';
import 'Push back/employee_pushback_access.dart';
import 'Push back/employee_pushback_docs.dart';
import 'Push back/employee_pushback_kyc.dart';
import 'Push back/employee_pushback_payroll.dart';

RxInt employeePushBackDetailsTab = 1.obs;
class EmployeeEditDetails extends StatefulWidget {
  final String pageName;
  final String empId;
  const EmployeeEditDetails({super.key, required this.pageName, required this.empId});

  @override
  State<EmployeeEditDetails> createState() => _EmployeeEditDetailsState();
}

final partnerController = Get.find<PartnerController>();

class _EmployeeEditDetailsState extends State<EmployeeEditDetails> {

  @override
  void initState() {
    super.initState();
    partnerController.getEmployeeDetailsNetworkApi(widget.empId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(()=> Container(
            color: AllColors.lightBlue.withOpacity(0.1),
            height: 40.r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: ()=> employeePushBackDetailsTab.value=1,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: employeePushBackDetailsTab.value==1? AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("About".tr,
                      style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()=> employeePushBackDetailsTab.value=2,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: employeePushBackDetailsTab.value==2? AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("Photo".tr,
                      style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()=> employeePushBackDetailsTab.value=3,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: employeePushBackDetailsTab.value==3? AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("KYC".tr,
                      style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color:  AllColors.themeColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()=> employeePushBackDetailsTab.value=4,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: employeePushBackDetailsTab.value==4? AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("Docs".tr,
                      style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()=> employeePushBackDetailsTab.value=5,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: employeePushBackDetailsTab.value==5?AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("Payroll".tr,
                      style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()=> employeePushBackDetailsTab.value=6,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: employeePushBackDetailsTab.value==6?AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("Access".tr,
                      style:  fontMedium.copyWith(fontSize: 13.r,wordSpacing: 0,letterSpacing: 0.4,color: AllColors.themeColor),
                    ),
                  ),
                ),
              ],
            ),
          )),
          Obx(() {
            if(employeePushBackDetailsTab.value == 1) {
              if(widget.pageName.toString()=="allEmployee"){
                if(partnerController.employeeDetails.value.data.basicDetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()||
                    partnerController.employeeDetails.value.data.basicDetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()){
                  return EmployeePushBackAboutScreen(pageName: widget.pageName.toString(),empId: widget.empId);
                }else {
                  return EmployeePushBackAboutViewScreen(empId: widget.empId, pageName: widget.pageName.toString());
                }
              }else if(widget.pageName.toString()=="employeeRequest" && partnerController.employeeDetails.value.data.basicDetails.reqApproverId==null){
                return EmployeePushBackAboutScreen(pageName: widget.pageName.toString(),empId: widget.empId);
              }else if(widget.pageName.toString()=="employeePushback" && (partnerController.employeeDetails.value.data.basicDetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString()||
                  partnerController.employeeDetails.value.data.basicDetails.empSourceId.toString()==GetStorage().read(AppConstant.cust_id).toString())){
                return EmployeePushBackAboutScreen(pageName: widget.pageName.toString(),empId: widget.empId);
              }
              else {
                return EmployeePushBackAboutViewScreen(empId: widget.empId, pageName: widget.pageName.toString());
              }
            }else if(employeePushBackDetailsTab.value == 2) {
              if(widget.pageName.toString()=="allEmployee"){
                if(partnerController.employeeDetails.value.data.basicDetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()||
                    partnerController.employeeDetails.value.data.basicDetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()){
                  return EmployeePhotoEdit(empId: widget.empId, pageName: widget.pageName);
                }else {
                  return EmployeePhotoView(empId: widget.empId, pageName: widget.pageName);
                }
              }else if(widget.pageName.toString()=="employeeRequest" && partnerController.employeeDetails.value.data.basicDetails.reqApproverId==null){
                return EmployeePhotoEdit(empId: widget.empId, pageName: widget.pageName);
              }else if(widget.pageName.toString()=="employeePushback" && (partnerController.employeeDetails.value.data.basicDetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString()||
                  partnerController.employeeDetails.value.data.basicDetails.empSourceId.toString()==GetStorage().read(AppConstant.cust_id).toString())){
                return EmployeePhotoEdit(empId: widget.empId, pageName: widget.pageName);
              }else{
                return EmployeePhotoView(empId: widget.empId, pageName: widget.pageName);
              }
            }else if(employeePushBackDetailsTab.value == 3) {
              if(widget.pageName.toString()=="allEmployee"){
                if(partnerController.employeeDetails.value.data.basicDetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()||
                    partnerController.employeeDetails.value.data.basicDetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()){
                  return EmployeePushBackKYCScreen(empId: widget.empId, pageName: widget.pageName);
                }else {
                  return EmployeePushBackKYCViewScreen(empId: widget.empId, pageName: widget.pageName);
                }
              }else if(widget.pageName.toString()=="employeeRequest" && partnerController.employeeDetails.value.data.basicDetails.reqApproverId==null){
                return EmployeePushBackKYCScreen(empId: widget.empId, pageName: widget.pageName);
              }else if(widget.pageName.toString()=="employeePushback" && (partnerController.employeeDetails.value.data.basicDetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString()||
                  partnerController.employeeDetails.value.data.basicDetails.empSourceId.toString()==GetStorage().read(AppConstant.cust_id).toString())){
                return EmployeePushBackKYCScreen(empId: widget.empId, pageName: widget.pageName);
              }else{
                return EmployeePushBackKYCViewScreen(empId: widget.empId, pageName: widget.pageName);
              }
            }else if(employeePushBackDetailsTab.value == 4) {
              if(widget.pageName.toString()=="allEmployee"){
                if(partnerController.employeeDetails.value.data.basicDetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()||
                    partnerController.employeeDetails.value.data.basicDetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()){
                  return EmployeePushBackDocsScreen(empId: widget.empId);
                }else {
                  return EmployeePushBackDocsViewScreen(empData: partnerController.employeeDetails.value.data);
                }
              }else if(widget.pageName.toString()=="employeeRequest" && partnerController.employeeDetails.value.data.basicDetails.reqApproverId==null){
                return EmployeePushBackDocsScreen(empId: widget.empId);
              }else if(widget.pageName.toString()=="employeePushback" && (partnerController.employeeDetails.value.data.basicDetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString()||
                  partnerController.employeeDetails.value.data.basicDetails.empSourceId.toString()==GetStorage().read(AppConstant.cust_id).toString())){
                return EmployeePushBackDocsScreen(empId: widget.empId);
              }else {
                return EmployeePushBackDocsViewScreen(empData: partnerController.employeeDetails.value.data);
              }
            }else if(employeePushBackDetailsTab.value == 5) {
              if(widget.pageName.toString()=="allEmployee"){
                if(partnerController.employeeDetails.value.data.basicDetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()||
                    partnerController.employeeDetails.value.data.basicDetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()){
                  return EmployeePushBackPayrollScreen(empId: widget.empId);
                }else {
                  return EmployeePushBackPayrollViewScreen(empData: partnerController.employeeDetails.value.data);
                }
              }else if(widget.pageName.toString()=="employeeRequest" && partnerController.employeeDetails.value.data.basicDetails.reqApproverId==null){
                return EmployeePushBackPayrollScreen(empId: widget.empId);
              }else if(widget.pageName.toString()=="employeePushback" && (partnerController.employeeDetails.value.data.basicDetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString()||
                  partnerController.employeeDetails.value.data.basicDetails.empSourceId.toString()==GetStorage().read(AppConstant.cust_id).toString())){
                return EmployeePushBackPayrollScreen(empId: widget.empId);
              }else{
                return EmployeePushBackPayrollViewScreen(empData: partnerController.employeeDetails.value.data);
              }
            }else if(employeePushBackDetailsTab.value == 6) {
              if(widget.pageName.toString()=="allEmployee"){
                if(partnerController.employeeDetails.value.data.basicDetails.reqApproverId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()||
                    partnerController.employeeDetails.value.data.basicDetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString().trim()){
                  return EmployeePushBackAccessScreen(empId: widget.empId, pageName: widget.pageName);
                }else {
                  return EmployeePushBackAccessViewScreen(empData: partnerController.employeeDetails.value.data);
                }
              }else if(widget.pageName.toString()=="employeePushback"||widget.pageName.toString()=="employeeRequest"){
                if(widget.pageName.toString()=="employeeRequest" && partnerController.employeeDetails.value.data.basicDetails.reqApproverId==null){
                  return EmployeePushBackAccessScreen(empId: widget.empId, pageName: widget.pageName);
                }else if(widget.pageName.toString()=="employeePushback" && (partnerController.employeeDetails.value.data.basicDetails.supId.toString()==GetStorage().read(AppConstant.cust_id).toString()||
                    partnerController.employeeDetails.value.data.basicDetails.empSourceId.toString()==GetStorage().read(AppConstant.cust_id).toString())){
                  return EmployeePushBackAccessScreen(empId: widget.empId, pageName: widget.pageName);
                }else {
                  return EmployeePushBackAccessViewScreen(empData: partnerController.employeeDetails.value.data);
                }
              }else{
                return EmployeePushBackAccessViewScreen(empData: partnerController.employeeDetails.value.data);
              }
            }else{
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }
}
