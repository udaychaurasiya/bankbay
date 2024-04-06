import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/widgets/Employee/all_employee.dart';
import 'package:bank_bay/widgets/Employee/employee_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'employee_push_back.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

  RxInt employeeHomeTab = 2.obs;
class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
    final GlobalKey<ScaffoldState> scaffoldKeyAddEMP = GlobalKey<ScaffoldState>(debugLabel: "_employeeHome");
    var controller = Get.find<LoginController>();

  @override
  void initState() {
    /*if(GetStorage().read(AppConstant.add_emp).toString().toLowerCase() == "no"&& GetStorage().read(AppConstant.emp_pending_approval).toString().toLowerCase() == "yes"){
    }else*/ if(GetStorage().read(AppConstant.add_emp).toString().toLowerCase() == "no"&& GetStorage().read(AppConstant.emp_push_back).toString().toLowerCase() == "yes"){
      employeeHomeTab.value=3;
    }else if(GetStorage().read(AppConstant.add_emp).toString().toLowerCase() == "no"&& GetStorage().read(AppConstant.emp_view_all).toString().toLowerCase() == "yes"){
      employeeHomeTab.value=4;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    employeeHomeTab.value=2;
    return Scaffold(
      key: scaffoldKeyAddEMP,
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: ((GetStorage().read(AppConstant.add_emp).toString().toLowerCase() == "no"&&
            GetStorage().read(AppConstant.emp_pending_approval).toString().toLowerCase() == "no")&&
            (GetStorage().read(AppConstant.emp_push_back).toString().toLowerCase() == "no"&&
             GetStorage().read(AppConstant.emp_view_all).toString().toLowerCase() == "no"))?
          defaultEmployeeWidget(context)  :
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40.r,
                color: AllColors.blue,
                padding: EdgeInsets.symmetric(horizontal: 5.r),
                child: Obx(() => ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // if(GetStorage().read(AppConstant.add_emp).toString().toLowerCase() == "yes")
                    //   InkWell(
                    //     onTap: (){
                    //       employeeHomeTab.value=1;
                    //       addEMPTab.value=1;
                    //     },
                    //     child: AnimatedContainer(
                    //       curve: Curves.linearToEaseOut,
                    //       duration: const Duration(milliseconds: 200),
                    //       alignment: Alignment.center,
                    //       padding: EdgeInsets.symmetric(horizontal: 10.r),
                    //       decoration: BoxDecoration(
                    //           border: Border(bottom: BorderSide(width: 3.r, color: employeeHomeTab.value==1?AllColors.yellow:AllColors.none))
                    //       ),
                    //       child: Text("Add Employee".tr,
                    //         style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: employeeHomeTab.value==1?AllColors.white:AllColors.white.withOpacity(0.6)),
                    //       ),
                    //     ),
                    //   ),
                    // SizedBox(width: 5.r),
                    // if(GetStorage().read(AppConstant.emp_approve).toString().toLowerCase() == "yes")
                    // InkWell(
                    //   onTap: ()=> employeeHomeTab.value=2,
                    //   child: AnimatedContainer(
                    //     curve: Curves.linearToEaseOut,
                    //     duration: const Duration(milliseconds: 200),
                    //     alignment: Alignment.center,
                    //     padding: EdgeInsets.symmetric(horizontal: 10.r),
                    //     decoration: BoxDecoration(
                    //         border: Border(bottom: BorderSide(width: 3.r, color: employeeHomeTab.value==2?AllColors.yellow:AllColors.none))
                    //     ),
                    //     child: Text("Direct Request".tr,
                    //       style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: employeeHomeTab.value==2?AllColors.white:AllColors.white.withOpacity(0.6)),
                    //     ),
                    //   ),
                    // ),
                    if(GetStorage().read(AppConstant.emp_pending_approval).toString().toLowerCase() == "yes")
                      InkWell(
                        onTap: ()=> employeeHomeTab.value=2,
                        child: AnimatedContainer(
                          curve: Curves.linearToEaseOut,
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.r),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 3.r, color: employeeHomeTab.value==2?AllColors.yellow:AllColors.none))
                          ),
                          child: Text("Approval".tr,
                            style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: employeeHomeTab.value==2?AllColors.white:AllColors.white.withOpacity(0.6)),
                          ),
                        ),
                      ),
                    SizedBox(width: 5.r),
                    if(GetStorage().read(AppConstant.emp_push_back).toString().toLowerCase() == "yes")
                      InkWell(
                        onTap: ()=> employeeHomeTab.value=3,
                        child: AnimatedContainer(
                          curve: Curves.linearToEaseOut,
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.r),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 3.r, color: employeeHomeTab.value==3?AllColors.yellow:AllColors.none))
                          ),
                          child: Text("PushBack".tr,
                            style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: employeeHomeTab.value==3?AllColors.white:AllColors.white.withOpacity(0.6)),
                          ),
                        ),
                      ),
                    SizedBox(width: 5.r),
                    if(GetStorage().read(AppConstant.emp_view_all).toString().toLowerCase()== "yes")
                      InkWell(
                        onTap: ()=> employeeHomeTab.value=4,
                        child: AnimatedContainer(
                          curve: Curves.linearToEaseOut,
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.r),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 3.r, color: employeeHomeTab.value==4?AllColors.yellow:AllColors.none))
                          ),
                          child: Text("All Employee".tr,
                            style:  fontSmall.copyWith(wordSpacing: 0,letterSpacing: 0.4,color: employeeHomeTab.value==4?AllColors.white:AllColors.white.withOpacity(0.6)),
                          ),
                        ),
                      ),
                  ],
                ),
                ),
              ),
              Expanded(
                child: Obx((){
                  /*if(employeeHomeTab.value==1){
                    return const AddEmployeeScreen();
                  }else*/ if(employeeHomeTab.value==2){
                    return const EmployeeRequest();
                  }else if(employeeHomeTab.value==3){
                    return const PushBackScreen();
                  }else if(employeeHomeTab.value==4){
                    return const AllEmployee();
                  }else{
                    return const EmployeeRequest();
                  }
                }),
              ),
            ],
        ),
    );
  }

  Padding defaultEmployeeWidget(BuildContext context) {
    return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.r),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical:30.0.r),
                    child: Text("Employee permission",style: fontBold.copyWith(fontSize: 18.r)),
                  ),
                  SizedBox(height: 20.r),
                  Text("It seems like your question is a bit unclear. If you're asking about employees not having permission for a specific title or subtitle, it could pertain to various scenarios, such as access to certain documents, systems, or areas within a company."
                      "\n\nIf you could provide more details or context, I'd be happy to help you with a more specific and accurate answer. "
                      "\n\nAre you referring to permissions within a particular software system, access to certain information, or something else? "
                      "\n\nClarifying your question will enable me to provide you with more targeted assistance.", style: fontRegular.copyWith(fontSize: 12.r, color: AllColors.black.withOpacity(0.7))),
                  SizedBox(height: 60.r),
                  CustomButton(
                    title: "You have not any employee permission!!".tr,
                    background: true,
                    miniFont: true,
                    // width: Get.width-5,
                  ),
                ],
              ),
            );
  }

}
