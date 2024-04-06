import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/widgets/Employee/Add%20Employee/emp_access_widget.dart';
import 'package:bank_bay/widgets/Employee/Add%20Employee/emp_docs_widget.dart';
import 'package:bank_bay/widgets/Employee/Add%20Employee/emp_kyc_widget.dart';
import 'package:bank_bay/widgets/Employee/Add%20Employee/emp_payroll_widget.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Add Employee/emp_about_widget.dart';

class CreateEmployeeScreen extends StatefulWidget {
  const CreateEmployeeScreen({super.key});

  @override
  State<CreateEmployeeScreen> createState() => _CreateEmployeeScreenState();
}
  RxInt addEMPTab = 1.obs;

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  var controller = Get.find<LoginController>();
  final _controller =  Get.find<PartnerController>();

  RxInt detailsValue = 1.obs;
  @override
  Widget build(BuildContext context) {
    addEMPTab.value=1;
    controller.employeeCompleteIdUpdate="";
    _controller.employeeId.clear();
    _controller.approvalReason.clear();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Employee"),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Container(
            height: 40.r,
            color: AllColors.lightGrey,
            padding: EdgeInsets.symmetric(horizontal: 10.r),
            child: Obx(() => addEMPTab.value!=-1 ?
              ListView(
                scrollDirection: Axis.horizontal,
                children: [
                InkWell(
                  // onTap: ()=> addEMPTab.value=1,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: addEMPTab.value==1?AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("About".tr,
                      style:  fontMedium.copyWith(fontSize: 12.r, wordSpacing: 0,letterSpacing: 0.4,color: addEMPTab.value==1?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
                InkWell(
                  // onTap: ()=> addEMPTab.value=2,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: addEMPTab.value==2?AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("KYC".tr,
                      style:  fontMedium.copyWith(fontSize: 12.r, wordSpacing: 0,letterSpacing: 0.4,color: addEMPTab.value==2?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
                InkWell(
                  // onTap: ()=> addEMPTab.value=3,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: addEMPTab.value==3?AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("Docs".tr,
                      style:  fontMedium.copyWith(fontSize: 12.r, wordSpacing: 0,letterSpacing: 0.4,color: addEMPTab.value==3?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
                InkWell(
                  // onTap: ()=> addEMPTab.value=4,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: addEMPTab.value==4?AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("Payroll".tr,
                      style:  fontMedium.copyWith(fontSize: 12.r, wordSpacing: 0,letterSpacing: 0.4,color: addEMPTab.value==4?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
                InkWell(
                  // onTap: ()=> addEMPTab.value=5,
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 18.r),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3.r, color: addEMPTab.value==5?AllColors.themeColor:AllColors.none))
                    ),
                    child: Text("Access".tr,
                      style:  fontMedium.copyWith(fontSize: 12.r, wordSpacing: 0,letterSpacing: 0.4,color: addEMPTab.value==5?AllColors.black.withOpacity(0.8):AllColors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
              ],
              ) :
              const SizedBox(),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.lightBlue.withOpacity(0.1),
        padding: EdgeInsets.symmetric(horizontal: 10.0.r),
        child: Obx(() => SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10.r),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(addEMPTab.value==1) const AboutScreen(),
                if(addEMPTab.value==2) const KYCScreen(),
                if(addEMPTab.value==3) const DocsScreen(),
                if(addEMPTab.value==4) const PayrollScreen(),
                if(addEMPTab.value==5) const AccessScreen(),
              ],
            ),
        ),
        ),
      ),
    );
  }
}
