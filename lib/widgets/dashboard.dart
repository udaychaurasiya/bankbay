// ignore_for_file: deprecated_member_use, avoid_print

import 'package:bank_bay/controllers/create_customer_controller.dart';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/Login/login_home.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/widgets/Calculator/emi_calculator.dart';
import 'package:bank_bay/widgets/Calculator/fd_calculator.dart';
import 'package:bank_bay/widgets/Calculator/sip_calculator.dart';
import 'package:bank_bay/widgets/Employee/create_employee.dart';
import 'package:bank_bay/widgets/Employee/employee_home.dart';
import 'package:bank_bay/widgets/LeadManager/add_lead.dart';
import 'package:bank_bay/widgets/Partner/create_partner.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Partner/partner_home.dart';
import 'package:bank_bay/widgets/Profile/Model/profile_complete_model.dart';
import 'package:bank_bay/widgets/Profile/Profile.dart';
import 'package:bank_bay/widgets/drawer_home.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:bank_bay/widgets/LeadManager/lead_manager.dart';
import 'package:bank_bay/widgets/my_earning.dart';
import 'package:bank_bay/widgets/notifications.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'Apply Loan/create_customer.dart';
import 'Apply Loan/cust_select_type.dart';
import 'Apply Loan/search_customer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var controller = Get.put(LoginController());
  var partnerController = Get.find<PartnerController>();
  var createCustController = Get.put(CreateCustomerController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    selectLoanType.value = "Loan for Someone else";
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: GetBuilder<LoginController>(
        builder:(controller) {
        return Scaffold(
          key: _scaffoldKey,
          extendBody: true,
          appBar: PreferredSize(
            preferredSize: Size(
              double.infinity,
              55.0.r,
            ),
            child: CustomAppBar(
              title: AppConstants.APP_NAME.tr,
              leadingBool: true,
              leadingTitle: "Loans",
              centerTitle: true,
              actions: [
                GetBuilder<LoginController>(
                  builder: (controller){
                    return Row(
                      children: [
                        if(GetStorage().read(AppConstant.name).toString() =="null")
                          InkWell(
                            radius: 100.r,
                            onTap: (){
                              Get.to(()=> const LoginScreen(value: "home",));
                              controller.index.value=0;
                            },
                            child: CircleAvatar(
                              radius: 15.r,
                              backgroundColor: AllColors.white.withOpacity(0.9),
                              child: Icon(Icons.perm_identity_outlined,size: 22.r,color: AllColors.blue,),
                            ),
                          ),
                        if(GetStorage().read(AppConstant.name).toString() !="null")
                        // if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")==false)
                          Row(
                            children: [
                              Center(child: Text("₹",style: fontMedium.copyWith(color: AllColors.white.withOpacity(0.9),fontSize: 13.r),)),
                              if(GetStorage().read(AppConstant.cust_id).toString().startsWith("C10")==true)
                              Center(
                                child: /*GetBuilder<PartnerController>(
                                  builder: (partnerController){
                                    return
                                  },
                                ),*/
                                Text(/*partnerController.formatAmount(partnerController.userdetails.value.data.details.custWalletAmt??*/"0",
                                style: fontMedium.copyWith(color: AllColors.white.withOpacity(0.9)),
                              ),
                              ),
                              if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")==true)
                              Center(
                                child: GetBuilder<PartnerController>(
                                  builder: (partnerController){
                                    return Text(partnerController.formatAmount(partnerController.employeeAmountDetails.value.data.basicDetails.empWallet??"0"),
                                      style: fontMedium.copyWith(color: AllColors.white.withOpacity(0.9)),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 5.r),
                              Icon(Icons.account_balance_wallet_outlined,size: 20.r,color: AllColors.white,),
                              SizedBox(width: 5.r),
                            ],
                          ),
                        if(GetStorage().read(AppConstant.name).toString() !="null")
                        Center(
                          child: InkWell(
                            radius: 100.r,
                            onTap: ()=> Get.to(()=> const Notifications()),
                            child: Stack(
                              children: [
                                Icon(Icons.notifications_sharp,size: 22.r,color: AllColors.white,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(width: 10.r),
              ],
              onPressed: _openEndDrawer,
            ),
          ),
          body: GetBuilder<LoginController>(
              builder: (controller) {
                return Obx(() => controller.index.value!=-1 ?
                  GetStorage().read(AppConstant.panel_manage_employee).toString().toLowerCase() == "yes"&&
                  GetStorage().read(AppConstant.panel_manage_partner).toString().toLowerCase() == "yes"?
                  LayoutBuilder(
                      builder: (BuildContext ctx, BoxConstraints constraints) {
                        switch (controller.index.value) {
                          case 0:
                            return const HomeWidget(value: 1);
                          case 1:
                            return const LeadManagerScreen();
                          case 2:
                            return const MyEarningScreen();
                          case 3:
                            return const EmployeeHomeScreen();
                          case 4:
                            return const PartnerHomeScreen();
                          default:
                            return const HomeWidget(value: 1);
                        }
                      }) :
                  GetStorage().read(AppConstant.panel_manage_employee).toString().toLowerCase() == "yes"?
                  LayoutBuilder(
                      builder: (BuildContext ctx, BoxConstraints constraints) {
                        switch (controller.index.value) {
                          case 0:
                            return const HomeWidget(value: 1);
                          case 1:
                            return const LeadManagerScreen();
                          case 2:
                            return const MyEarningScreen();
                          case 3:
                            return const EmployeeHomeScreen();
                          default:
                            return const HomeWidget(value: 1);
                        }
                      }) :
                  GetStorage().read(AppConstant.panel_manage_partner).toString().toLowerCase() == "yes"?
                  LayoutBuilder(
                      builder: (BuildContext ctx, BoxConstraints constraints) {
                        switch (controller.index.value) {
                          case 0:
                            return const HomeWidget(value: 1);
                          case 1:
                            return const LeadManagerScreen();
                          case 2:
                            return const MyEarningScreen();
                          case 3:
                            return const PartnerHomeScreen();
                          default:
                            return const HomeWidget(value: 1);
                        }
                      }) :
                  LayoutBuilder(
                    builder: (BuildContext ctx, BoxConstraints constraints) {
                      switch (controller.index.value) {
                        case 0:
                          return const HomeWidget(value: 1);
                        case 1:
                          return const LeadManagerScreen();
                        case 2:
                          return const MyEarningScreen();
                        default:
                          return const HomeWidget(value: 1);
                      }
                    },
                  ) :
                  LayoutBuilder(
                    builder: (BuildContext ctx, BoxConstraints constraints) {
                      switch (controller.index.value) {
                        case 0:
                          return const HomeWidget();
                        case 1:
                          return const LeadManagerScreen();
                        case 2:
                          return const MyEarningScreen();
                        default:
                          return const HomeWidget();
                      }
                    }),
                );
              }),
          bottomNavigationBar: SingleChildScrollView(
            key: GlobalKey(debugLabel: 'unique_dashboard_key'),
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 55.r,
              child: GetBuilder<LoginController>(
                  builder: (controller) {
                    return Obx(() => controller.index.value!=-1 ?
                      (GetStorage().read(AppConstant.panel_manage_employee).toString().toLowerCase() == "yes"&&
                      GetStorage().read(AppConstant.panel_manage_partner).toString().toLowerCase() == "yes")?
                      CustomNavigationBar(
                        backgroundColor: Colors.white,
                        elevation: 5.0,
                        items: [
                          CustomNavigationBarItem(
                            icon: Icon(Icons.home,size: 25.r,color: controller.index.value==0 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Home",style: fontExtraSmall.copyWith(color: controller.index.value==0 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.lightbulb_outline,size: 25.r,color: controller.index.value==1 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Lead Manager",style: fontExtraSmall.copyWith(color: controller.index.value==1 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.add_road,size: 25.r,color: controller.index.value==2 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("My Earnings",style: fontExtraSmall.copyWith(color: controller.index.value==2 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.account_circle,size: 25.r,color: controller.index.value==3 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Employee",style: fontExtraSmall.copyWith(color: controller.index.value==3 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.account_circle,size: 25.r,color: controller.index.value==4 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Partner",style: fontExtraSmall.copyWith(color: controller.index.value==4 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                        ],
                        currentIndex: controller.index.value,
                        onTap: (index) {
                          permissionController.userPermissionCustomNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
                          if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")==true){
                            partnerController.getEmployeeDetailsGetAmountNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
                          }
                          if(GetStorage().read(AppConstant.cust_id).toString().startsWith("C10")==true){
                            partnerController.getUserDetailsApi(GetStorage().read(AppConstant.cust_id).toString());
                          }
                          if(GetStorage().read(AppConstant.name).toString() =="null"&&index==1){
                            Get.to(()=> LoginScreen(value: index==0?"userHome":index==1?"leadScreen":"home",));
                          }else if(GetStorage().read(AppConstant.name).toString() =="null"&&index==2){
                            Get.to(()=> LoginScreen(value: index==0?"userHome":index==1?"leadScreen":"home",));
                          }
                          controller.index.value = index;
                          if(controller.index.value==0){
                            indexValue.value=1;
                          }else if(controller.index.value==1){
                            leadManagerTab.value=1;
                            screenValue.value=1;
                          }else if(controller.index.value==3){
                            employeeHomeTab.value=2;
                            addEMPTab.value=1;
                          }else if(controller.index.value==4){
                            addPartnerTab.value=1;
                            partnerTab.value=2;
                          }
                        },
                      ) :
                      GetStorage().read(AppConstant.panel_manage_employee).toString().toLowerCase() == "yes"?
                      CustomNavigationBar(
                        backgroundColor: Colors.white,
                        elevation: 5.0,
                        items: [
                          CustomNavigationBarItem(
                            icon: Icon(Icons.home,size: 25.r,color: controller.index.value==0 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Home",style: fontExtraSmall.copyWith(color: controller.index.value==0 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.lightbulb_outline,size: 25.r,color: controller.index.value==1 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Lead Manager",style: fontExtraSmall.copyWith(color: controller.index.value==1 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.add_road,size: 25.r,color: controller.index.value==2 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("My Earnings",style: fontExtraSmall.copyWith(color: controller.index.value==2 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.account_circle,size: 25.r,color: controller.index.value==3 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Employee",style: fontExtraSmall.copyWith(color: controller.index.value==3 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                        ],
                        currentIndex: controller.index.value,
                        onTap: (index) {
                          permissionController.userPermissionCustomNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
                          partnerController.getUserDetailsApi(GetStorage().read(AppConstant.cust_id).toString());
                          if(GetStorage().read(AppConstant.name).toString() =="null"&&index==1){
                            Get.to(()=> LoginScreen(value: index==0?"userHome":index==1?"leadScreen":"home",));
                          }else if(GetStorage().read(AppConstant.name).toString() =="null"&&index==2){
                            Get.to(()=> LoginScreen(value: index==0?"userHome":index==1?"leadScreen":"home",));
                          }
                          controller.index.value = index;
                          if(controller.index.value==0){
                            indexValue.value=1;
                          }else if(controller.index.value==1){
                            leadManagerTab.value=1;
                            screenValue.value=1;
                          }else if(controller.index.value==3){
                            employeeHomeTab.value=2;
                            addEMPTab.value=1;
                          }
                        },
                      ) :
                      GetStorage().read(AppConstant.panel_manage_partner).toString().toLowerCase() == "yes"?
                      CustomNavigationBar(
                        backgroundColor: Colors.white,
                        elevation: 5.0,
                        items: [
                          CustomNavigationBarItem(
                            icon: Icon(Icons.home,size: 25.r,color: controller.index.value==0 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Home",style: fontExtraSmall.copyWith(color: controller.index.value==0 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.lightbulb_outline,size: 25.r,color: controller.index.value==1 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Lead Manager",style: fontExtraSmall.copyWith(color: controller.index.value==1 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.add_road,size: 25.r,color: controller.index.value==2 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("My Earnings",style: fontExtraSmall.copyWith(color: controller.index.value==2 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.account_circle,size: 25.r,color: controller.index.value==3 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Partner",style: fontExtraSmall.copyWith(color: controller.index.value==3 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                        ],
                        currentIndex: controller.index.value,
                        onTap: (index) {
                          permissionController.userPermissionCustomNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
                          partnerController.getUserDetailsApi(GetStorage().read(AppConstant.cust_id).toString());
                          if(GetStorage().read(AppConstant.name).toString() =="null"&&index==1){
                            Get.to(()=> LoginScreen(value: index==0?"userHome":index==1?"leadScreen":"home",));
                          }else if(GetStorage().read(AppConstant.name).toString() =="null"&&index==2){
                            Get.to(()=> LoginScreen(value: index==0?"userHome":index==1?"leadScreen":"home",));
                          }
                          controller.index.value = index;
                          if(controller.index.value==0){
                            indexValue.value=1;
                          }else if(controller.index.value==1){
                            leadManagerTab.value=1;
                            screenValue.value=1;
                          }else if(controller.index.value==3){
                            addPartnerTab.value=1;
                            partnerTab.value=2;
                          }
                        },
                      ) :
                      CustomNavigationBar(
                        backgroundColor: Colors.white,
                        elevation: 5.0,
                        items: [
                          CustomNavigationBarItem(
                            icon: Icon(Icons.home,size: 25.r,color: controller.index.value==0 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Home",style: fontExtraSmall.copyWith(color: controller.index.value==0 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.lightbulb_outline,size: 25.r,color: controller.index.value==1 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Lead Manager",style: fontExtraSmall.copyWith(color: controller.index.value==1 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.add_road,size: 25.r,color: controller.index.value==2 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("My Earnings",style: fontExtraSmall.copyWith(color: controller.index.value==2 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                        ],
                        currentIndex: controller.index.value,
                        onTap: (index) {
                          permissionController.userPermissionCustomNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
                          partnerController.getUserDetailsApi(GetStorage().read(AppConstant.cust_id).toString());
                          if(GetStorage().read(AppConstant.name).toString() =="null"&&index==1){
                            Get.to(()=> LoginScreen(value: index==0?"userHome":index==1?"leadScreen":"home",));
                          }else if(GetStorage().read(AppConstant.name).toString() =="null"&&index==2){
                            Get.to(()=> LoginScreen(value: index==0?"userHome":index==1?"leadScreen":"home",));
                          }
                          controller.index.value = index;
                          if(controller.index.value==0){
                            indexValue.value=1;
                          }else if(controller.index.value==1){
                            leadManagerTab.value=1;
                            screenValue.value=1;
                          }
                        },
                      ) :
                      CustomNavigationBar(
                        backgroundColor: Colors.white,
                        elevation: 5.0,
                        items: [
                          CustomNavigationBarItem(
                            icon: Icon(Icons.home,size: 25.r,color: controller.index.value==0 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Home",style: fontExtraSmall.copyWith(color: controller.index.value==0 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.lightbulb_outline,size: 25.r,color: controller.index.value==1 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("Lead Manager",style: fontExtraSmall.copyWith(color: controller.index.value==1 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                          CustomNavigationBarItem(
                            icon: Icon(Icons.add_road,size: 25.r,color: controller.index.value==2 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5),),
                            title: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top:3.0.r),
                              child: Text("My Earnings",style: fontExtraSmall.copyWith(color: controller.index.value==2 ? AllColors.teal.withOpacity(0.8):AllColors.black.withOpacity(0.5), wordSpacing: 0, letterSpacing: 0),),
                            ),
                          ),
                        ],
                        currentIndex: controller.index.value,
                        onTap: (index) {
                          permissionController.userPermissionCustomNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
                          partnerController.getUserDetailsApi(GetStorage().read(AppConstant.cust_id).toString());
                          if(GetStorage().read(AppConstant.name).toString() =="null"&&index==1){
                            Get.to(()=> LoginScreen(value: index==0?"userHome":index==1?"leadScreen":"home",));
                          }else if(GetStorage().read(AppConstant.name).toString() =="null"&&index==2){
                            Get.to(()=> LoginScreen(value: index==0?"userHome":index==1?"leadScreen":"home",));
                          }
                          controller.index.value = index;
                          if(controller.index.value==0){
                            indexValue.value=1;
                          }else if(controller.index.value==1){
                            leadManagerTab.value=1;
                            screenValue.value=1;
                          }
                      },
                    ),
                    );
                  }
              ),
            ),
          ),
          drawer: const DrawerScreen(),
          endDrawerEnableOpenDragGesture: true,
          floatingActionButton: SpeedDial(
            childMargin: EdgeInsets.symmetric(vertical: 10.r, horizontal: 10.r),
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: AllColors.teal.withOpacity(0.8),
            childPadding: EdgeInsets.symmetric(vertical: 5.r),
            activeBackgroundColor: Colors.red.withOpacity(0.8),
            overlayColor: AllColors.black.withOpacity(0.1),
            children: [
              SpeedDialChild(
                child: Image.asset(Images.applyLoan, height: 25.r, width: 25.r),
                label: "Apply loan",
                onTap: ()=> _checkPanAlertBox(context),
              ),
              SpeedDialChild(
                child: Image.asset(Images.cibil, height: 25.r, width: 25.r),
                label: "Check Cibil score",
                onTap: (){},
              ),
              SpeedDialChild(
                child: Image.asset(Images.wallet, height: 25.r, width: 25.r),
                label: "Check balance",
                onTap: (){},
              ),
              SpeedDialChild(
                child: Image.asset(Images.emiCalculator, height: 25.r, width: 25.r),
                label: "EMI Calculator",
                onTap: ()=> Get.to(()=> const EMICalculator()),
              ),
              SpeedDialChild(
                child: Image.asset(Images.sipCalculator, height: 25.r, width: 25.r),
                label: "SIP Calculator",
                 onTap: ()=> Get.to(()=> const SIPCalculator()),
              ),
              SpeedDialChild(
                child: Image.asset(Images.fdCalculator, height: 25.r, width: 25.r),
                label: "FD Calculator",
                 onTap: ()=> Get.to(()=> const FDCalculator()),
              ),
              if(GetStorage().read(AppConstant.cust_id).toString().startsWith("C10")==true)
                SpeedDialChild(
                child: Image.asset(Images.share, height: 25.r, width: 25.r),
                label: GetStorage().read(AppConstant.pid).toString().startsWith("P10")?"Invite Partner":
                GetStorage().read(AppConstant.cust_id).toString().startsWith("C10")?"Join as Partner":"Invite Partner/Join as Partner",
                onTap: (){},
              ),
              SpeedDialChild(
                child: Image.asset(Images.customer, height: 22.r, width: 22.r),
                label: "Create customer",
                onTap: (){
                  if(GetStorage().read(AppConstant.name)!=null) {
                    Get.to(()=> const CreateCustomerWidget(addLoan: false));
                  }
                },
              ),
              if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10"))
              SpeedDialChild(
                child: Image.asset(Images.employee, height: 25.r, width: 25.r),
                label: "Create Employee",
                onTap: (){
                  Get.to(()=> const CreateEmployeeScreen());
                },
              ),
              if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10"))
              SpeedDialChild(
                child: Image.asset(Images.partner, height: 25.r, width: 25.r),
                label: "Create Partner",
                onTap: (){
                  Get.to(()=> const CreatePartnerScreen());
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  void _openEndDrawer() {
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState!.openDrawer();
    } else {
      print("Scaffold State is null. Cannot open end drawer.");
    }
  }

  var selectLoanType = "Loan for Someone else".obs;
  _checkPanAlertBox(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0), // Adjust the left radius
          topRight: Radius.circular(16.0), // Adjust the right radius
        ),
      ),
      builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.r, vertical: 20.r),
            child: SingleChildScrollView(
              child: Obx(() => Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: ()=> Navigator.pop(context),
                        child: Icon(Icons.close_outlined, size: 25.r, color: AllColors.red.withOpacity(0.9),),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(right: 10.r),
                      child: Text(
                        "Who needs this loan ?",
                        style: fontExtraBold.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(height: 25.r),
                    InkWell(
                      onTap: (){
                        if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")){
                          BaseController().errorSnack("Employees cannot apply for loan !!");
                        }
                        else {
                          selectLoanType.value = "Loan for me";
                          print("sjbs ${selectLoanType.value}");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5.r, color: AllColors.grey),
                          borderRadius: BorderRadius.circular(10.r),
                          color: selectLoanType.value == "Loan for me"?AllColors.blue:AllColors.lightGrey.withOpacity(0.5),
                        ),
                        child: Container(
                          height: 90.r,
                          padding: EdgeInsets.symmetric(horizontal: 20.r),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 35.r,
                                backgroundColor: AllColors.blue.withOpacity(0.5),
                                child: CircleAvatar(
                                  radius: 34.r,
                                  backgroundColor: AllColors.white,
                                  // child: Icon(Icons.person, size: 25.r, color: AllColors.black.withOpacity(0.6),),
                                  child: Image.asset(Images.user, height: 20.r, width: 20.r,color: AllColors.black.withOpacity(0.6),),
                                ),
                              ),
                              SizedBox(width: 15.r),
                              Text(
                                "Loan for me",
                                style: fontExtraBold.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: selectLoanType.value == "Loan for me"?AllColors.white:AllColors.black.withOpacity(0.8),
                                  fontSize: 16.r,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 15.r),
                      child: Text(
                        "--OR--",
                        style: fontRegular.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        selectLoanType.value = "Loan for Someone else";
                        print("sjbs ${selectLoanType.value}");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5.r, color: AllColors.grey),
                          borderRadius: BorderRadius.circular(10.r),
                          color: selectLoanType.value == "Loan for Someone else"?AllColors.blue:AllColors.lightGrey.withOpacity(0.5),
                        ),
                        child: Container(
                          height: 90.r,
                          padding: EdgeInsets.symmetric(horizontal: 20.r),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 35.r,
                                backgroundColor: AllColors.blue.withOpacity(0.5),
                                child: CircleAvatar(
                                  radius: 34.r,
                                  backgroundColor: AllColors.white,
                                  child: Image.asset(Images.share, height: 25.r, width: 25.r,color: AllColors.black.withOpacity(0.6),),
                                ),
                              ),
                              SizedBox(width: 15.r),
                              Text(
                                "Loan for Someone else",
                                style: fontExtraBold.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: selectLoanType.value == "Loan for Someone else"?AllColors.white:AllColors.black.withOpacity(0.8),
                                  fontSize: 16.r,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.r),
                    InkWell(
                      onTap: (){
                        createCustController.clearTextField();
                        if(GetStorage().read(AppConstant.name)!=null){
                          if(selectLoanType.value == "Loan for me"){
                            if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")){
                              BaseController().errorSnack("Please partner login !!");
                            }else{
                              Navigator.pop(context);
                              Get.to(()=> const CustSelectType(loanType: "myLoan"));
                            }
                          }else if(selectLoanType.value == "Loan for Someone else"){
                            print("object ${partnerController.profileComplete.value.data.popupStatus}");
                            if(partnerController.profileComplete.value.data.popupStatus.toString()=="true"){
                              if(partnerController.customerDetails.value.data.partnerdetails.partnerStatus.toString().toLowerCase()=="active") {
                                Navigator.pop(context);
                                Get.to(()=> const SearchCustomerWidget());
                              }else{
                                Navigator.pop(context);
                                _underProcessAccess(context);
                              }
                            } else if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")){
                              Navigator.pop(context);
                              Get.to(()=> const SearchCustomerWidget());
                            }
                            else{
                              Navigator.pop(context);
                              _profileComplete(context, partnerController.profileComplete.value.data);
                            }
                          }
                        }else{
                          BaseController().errorSnack("You are not Sign In please sign in");
                        }
                      },
                      child: Container(
                        height: 45.r,
                        width: 200.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AllColors.darkBlue,
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Text(
                          "Confirm",
                          style: fontBold.copyWith(color: AllColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }

  _underProcessAccess(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Get.back(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Waiting Approval"),
      content: Text("Your partner request was submitted successfully and is under review."
          "\n\nYou will be able to add lead sooner !!", style: fontRegular.copyWith(fontSize: 13.5.r),),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _profileComplete(BuildContext context, ProfileData profileData) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: Future.value,
        child: Dialog(
          child: Container(
            height: 350.r,
            width: double.infinity,
            padding: EdgeInsets.all(10.r),
            child: GetBuilder<PartnerController>(builder:(controller)=> Column(
              children: [
                SizedBox(height: 10.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Complete profile to add lead & earn incentive",
                        style: fontBold.copyWith(fontSize: 13.sp),
                      ),
                    ),
                    SizedBox(width: 5.r),
                    InkWell(
                      onTap: ()=> Navigator.pop(context),
                      child: Icon(Icons.close_outlined, size: 22.r, color: AllColors.red.withOpacity(0.8),),
                    ),
                  ],
                ),
                SizedBox(height: 20.r),
                ListView.builder(
                  itemCount: profileData.cmpStatus.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = profileData.cmpStatus[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${data.title}",
                          style: fontBold,
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 145,
                          animation: true,
                          lineHeight: 6.r,
                          percent: double.parse(data.count.toString()) / 100,
                          animationDuration: 2000,
                          trailing: Text(
                            "${data.count!.toStringAsFixed(0)}%",
                            style: fontBold.copyWith(color: AllColors.green),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: AllColors.green,
                          backgroundColor: Colors.amberAccent,
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 10.r,
                ),
                InkWell(
                  onTap: () {
                    profileIndex.value=1;
                    Get.to(() => const Profile());
                  },
                  child: CustomButton(
                    background: true,
                    width: 150.r,
                    height: 35.r,
                    radius: 5.r,
                    title: "Update Profile".tr,
                  ),
                ),
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }

}
