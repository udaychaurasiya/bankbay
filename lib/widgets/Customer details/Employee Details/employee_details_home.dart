// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/utils_method/custom_image.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_details.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_push_back_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class EmployeeDetailsHome extends StatefulWidget {
  final String pageName;
  final String? employeeId;
  const EmployeeDetailsHome({super.key, required this.pageName, this.employeeId});

  @override
  State<EmployeeDetailsHome> createState() => _EmployeeDetailsHomeState();
}


class _EmployeeDetailsHomeState extends State<EmployeeDetailsHome> {
var controller = Get.find<PartnerController>();
var loginController = Get.find<LoginController>();
var permissionController = Get.find<PermissionController>();
  var statusValue = 1.obs;

  @override
  void initState() {
    controller.getEmployeeDetailsNetworkApi(widget.employeeId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          50.0.r,
        ),
        child: CustomAppBar(
          title: "Employee Details".tr,
          leadingBool: false,
          back: true,
          onTab: ()async{
            Get.back();
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.back();
          return true;
        },
        child:  Container(
          color: Colors.lightBlue.withOpacity(0.1),
          padding: EdgeInsets.symmetric(horizontal: 10.r),
          child: GetBuilder<PartnerController>(builder:(controller) {
              return ListView(
                children: [
                  SizedBox(height: 20.r),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:8.r, vertical: 8.r),
                    color: AllColors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0.r, vertical: 3.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+controller.employeeDetails.value.data.basicDetails.docProfilePic.toString())),
                            child: CircleAvatar(
                              radius: 22.r,
                              backgroundColor: AllColors.lightTeal.withOpacity(0.6),
                              child: CustomImage(
                                  image: controller.employeeDetails.value.data.basicDetails.docProfilePic.toString(),
                                ),
                            ),
                          ),
                          SizedBox(width: 10.r),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text: "${controller.employeeDetails.value.data.basicDetails.empFname??""} ${controller.employeeDetails.value.data.basicDetails.empLname??""}",
                                                  style: fontSmall.copyWith(fontWeight: FontWeight.w500),
                                                  children: [
                                                    TextSpan(text: controller.employeeDetails.value.data.basicDetails.eid!=null?"(${controller.employeeDetails.value.data.basicDetails.eid??""})":"", style: fontSmall.copyWith(fontWeight: FontWeight.w500, color: AllColors.black.withOpacity(0.7))),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 2.r),
                                              Text(controller.employeeDetails.value.data.basicDetails.empPresentAddress??"", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                              SizedBox(height: 2.r),
                                              Text("Exp : ${controller.employeeDetails.value.data.basicDetails.empJoinDate??""}", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                              SizedBox(height: 2.r),
                                              Text("Pre : ${controller.employeeDetails.value.data.basicDetails.empCreateDatetime??""}", style: fontExtraSmall.copyWith(fontWeight: FontWeight.w400,color: AllColors.black.withOpacity(0.6)),),
                                            ],
                                          ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.r),
                  (widget.pageName=="employeeRequest"||(widget.pageName.toString()=="employeePushback" || widget.pageName.toString()=="allEmployee"))?
                    EmployeeEditDetails(pageName: widget.pageName.toString(),empId: widget.employeeId.toString()):
                    EmployeeDetails(empData: controller.employeeDetails.value.data, pageName: widget.pageName.toString(),employeeId: widget.employeeId),
                  SizedBox(height: 15.r),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
