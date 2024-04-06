import 'package:bank_bay/controllers/auth_conroller.dart';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/Profile.dart';
import 'package:bank_bay/widgets/Profile/employee_profile.dart';
import 'package:bank_bay/Login/chnage_password.dart';
import 'package:bank_bay/widgets/cookie_policy.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:bank_bay/widgets/my_loan_history.dart';
import 'package:bank_bay/widgets/terms_conditions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'splash_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}
  var controller = Get.find<LoginController>();
  var permissionController = Get.find<PermissionController>();
  var authController = Get.find<AuthController>();

class _DrawerScreenState extends State<DrawerScreen> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width-90,
      backgroundColor: AllColors.themeColor,
      child: SizedBox(
        height: Get.height,
        child: Column(
          children: [
            SizedBox(height: 35.r),
            Padding(
              padding: EdgeInsets.only(left: 15.r, right: 5.r),
              child: GetStorage().read(AppConstant.name).toString() !="null"?
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")){
                        employeeProfileTab.value=2;
                        Get.to(()=> const EmployeeProfile());
                      }else if(GetStorage().read(AppConstant.cust_id).toString().startsWith("C10")||GetStorage().read(AppConstant.cust_id).toString().startsWith("P10")){
                        profileIndex.value=1;
                        Get.to(()=> const Profile());
                      }
                    },
                    borderRadius: BorderRadius.circular(100.r),
                    child: CircleAvatar(
                      radius: 40.r,
                      backgroundColor: AllColors.white.withOpacity(0.8),
                      child: CachedNetworkImage(
                        imageUrl: GetStorage().read(AppConstant.profile)==null
                            ?"https://wallpapercave.com/wp/wp3781055.jpg":
                            AppConstants.BASE_URL+GetStorage().read(AppConstant.profile).toString(),
                        fadeOutDuration:
                        const Duration(seconds: 3),
                        imageBuilder: (context,
                            imageProvider) =>
                            Container(
                              decoration:
                              BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(500.r),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter:
                                    const ColorFilter
                                        .mode(Colors.white, BlendMode.colorBurn)),
                              ),
                            ),
                        placeholder:
                            (context, url) =>
                            Padding(
                              padding:
                              EdgeInsets.all(10.0.r),
                              child:
                              const CircularProgressIndicator(),
                            ),
                        errorWidget: (context,
                            url, error) =>
                            Icon(
                              Icons.error,
                              size: 25.r,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.r),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(GetStorage().read(AppConstant.name)??"Your Name", style: fontBold.copyWith(fontSize: 16.r, color: AllColors.white.withOpacity(0.9)),overflow: TextOverflow.ellipsis,),
                        GetStorage().read(AppConstant.pId)!=""&&GetStorage().read(AppConstant.pId)!=null ?
                        Text("ID-${GetStorage().read(AppConstant.pId)??GetStorage().read(AppConstant.cust_id).toString()}", style: fontBold.copyWith(fontSize: 14.r, color:  AllColors.white.withOpacity(0.7)),overflow: TextOverflow.ellipsis,)
                        : Text("ID-${GetStorage().read(AppConstant.cust_id).toString()}", style: fontBold.copyWith(fontSize: 14.r, color:  AllColors.white.withOpacity(0.7)),overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                ],
              ) :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.logo,height: 80.r, width: 80.r,),
                  SizedBox(width: 15.r),
                  Text("BankBay",style: fontBold.copyWith(fontSize: 25.r, color: AllColors.white.withOpacity(0.9)),),
                  SizedBox(width: 20.r),
                ],
              ),
            ),
            SizedBox(height: 25.r),
            Container(
              height: 1.r,
              color: AllColors.white.withOpacity(0.2),
            ),
            SizedBox(height: 10.r),
            CustomTitle(
              title: "Home".tr,
              image: Images.home.toString(),
              onTap: (){
                Navigator.pop(context);
                permissionController.userPermissionNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
                Get.off(()=> const DashboardScreen());
                indexValue.value=1;
                controller.index.value=0;
              },
            ),
            if(GetStorage().read(AppConstant.name)!=null)
            CustomTitle(
              title: "My Profile".tr,
              image: Images.user.toString(),
              onTap: ()async{
                if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")){
                  employeeProfileTab.value=1;
                  Get.to(()=> const EmployeeProfile());
                }else if(GetStorage().read(AppConstant.cust_id).toString().startsWith("C10")||GetStorage().read(AppConstant.cust_id).toString().startsWith("P10")){
                  profileIndex.value=1;
                  Get.to(()=> const Profile());
                }
              },
            ),
            if(GetStorage().read(AppConstant.name)!=null)
            CustomTitle(
              title: "Change Password".tr,
              image: Images.settings.toString(),
              onTap: () {
                Navigator.pop(context);
                Get.to(()=> const ChangePasswordScreen());
              },
            ),
            if(GetStorage().read(AppConstant.name)!=null)
            if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")==false)
            CustomTitle(
              title: "My Loan History".tr,
              image: Images.history.toString(),
              onTap: () {
                Navigator.pop(context);
                Get.to(()=> const MyLoanHistory());
              },
            ),
            CustomTitle(
              title: "Terms & Condition".tr,
              image: Images.terms_condition.toString(),
              onTap: () {
                Navigator.pop(context);
                Get.to(()=> const TermsConditionsScreen());
              },
            ),
            CustomTitle(
              title: "Privacy Policy".tr,
              image: Images.privacy_policy.toString(),
              onTap: (){},
            ),
            CustomTitle(
              title: "Cookie Policy".tr,
              image: Images.cookie.toString(),
              onTap: () {
                Navigator.pop(context);
                Get.to(()=> const CookiePolicyScreen());
              },
            ),
            CustomTitle(
              title: "Notification".tr,
              image: Images.notification.toString(),
              onTap: () {},
            ),
            const Spacer(),
            Container(
              height: 1.r,
              color: AllColors.white.withOpacity(0.2),
            ),
            if(GetStorage().read(AppConstant.name)!=null)
            CustomTitle(
              title: "Log Out".tr,
              image: Images.logout.toString(),
              onTap: (){
                Navigator.pop(context);
                logOutAlertDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  logOutAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log Out", style:fontBold.copyWith(fontSize: 18.r),),
      content: Text("Are you sure?, Do you want to exit this app?", style: fontMedium.copyWith(fontSize: 15.r, wordSpacing: 0, letterSpacing: 0.2),),
      actions: [
        CustomButton(
          title: "No".tr,
          width: 70.r,
          background: false,
          border:false,
          bgColor: null,
          onTap:  () => Get.back(),
        ),
        CustomButton(
          title: "Yes".tr,
          width: 70.r,
          border:false,
          bgColor: null,
          background: false,
          onTap: (){
            GetStorage().remove(AppConstant.name);
            GetStorage().remove(AppConstant.email);
            GetStorage().remove(AppConstant.id);
            GetStorage().remove(AppConstant.name);
            GetStorage().remove(AppConstant.Pin);
            GetStorage().remove(AppConstant.loan_id);
            GetStorage().remove(AppConstant.cust_id);
            GetStorage().remove(AppConstant.sup_id);
            GetStorage().remove(AppConstant.lead_id);
            GetStorage().remove(AppConstant.lead_loan_id);
            GetStorage().remove(AppConstant.lead_cust_id);
            GetStorage().remove(AppConstant.partner_id);
            GetStorage().remove(AppConstant.partner_loan_id);
            GetStorage().remove(AppConstant.partner_cust_id);
            GetStorage().remove(AppConstant.partner_sup_id);
            GetStorage().remove(AppConstant.emp_id);
            GetStorage().remove(AppConstant.emp_sup_id);
            GetStorage().remove(AppConstant.emp_name);
            GetStorage().remove(AppConstant.emp_eId);
            GetStorage().remove(AppConstant.emp_eMail);
            GetStorage().remove(AppConstant.pId);
            GetStorage().remove(AppConstant.pid);
            GetStorage().remove(AppConstant.cust_email);
            GetStorage().remove(AppConstant.cust_address);
            GetStorage().remove(AppConstant.cust_pan);
            GetStorage().remove(AppConstant.cust_dob);
            GetStorage().remove(AppConstant.cust_link);
            GetStorage().remove(AppConstant.cust_pin);
            GetStorage().remove(AppConstant.address);
            GetStorage().remove(AppConstant.fcm_token);
            GetStorage().remove(AppConstant.email);
            GetStorage().remove(AppConstant.profile);
            GetStorage().remove(AppConstant.password);
            GetStorage().remove(AppConstant.emp_view_all);
            GetStorage().remove(AppConstant.add_emp);
            GetStorage().remove(AppConstant.update_emp);
            GetStorage().remove(AppConstant.emp_push_back);
            GetStorage().remove(AppConstant.emp_approve);
            GetStorage().remove(AppConstant.emp_pending_approval);
            GetStorage().remove(AppConstant.partner_view_all);
            GetStorage().remove(AppConstant.partner_add);
            GetStorage().remove(AppConstant.partner_update);
            GetStorage().remove(AppConstant.partner_push_back);
            GetStorage().remove(AppConstant.partner_pending_approval);
            GetStorage().remove(AppConstant.unassigned_leads);
            GetStorage().remove(AppConstant.assign_all_lead);
            GetStorage().remove(AppConstant.assign_my_lead);
            GetStorage().remove(AppConstant.assign_my_team_lead);
            GetStorage().remove(AppConstant.assign_my_partner_lead);
            GetStorage().remove(AppConstant.add_lead);
            GetStorage().remove(AppConstant.my_lead);
            GetStorage().remove(AppConstant.my_team_lead);
            GetStorage().remove(AppConstant.my_partner_lead);
            GetStorage().remove(AppConstant.all_cust);
            GetStorage().remove(AppConstant.my_cust);
            GetStorage().remove(AppConstant.my_team_cust);
            GetStorage().remove(AppConstant.my_partner_cust);
            GetStorage().remove(AppConstant.my_sales);
            GetStorage().remove(AppConstant.incentive_mgmt_view);
            GetStorage().remove(AppConstant.incentive_mgmt_edit);
            GetStorage().remove(AppConstant.apply_self_loan);
            GetStorage().remove(AppConstant.panel_manage_employee);
            GetStorage().remove(AppConstant.panel_manage_partner);
            GetStorage().remove(AppConstant.panel_manage_customer);
            GetStorage().remove(AppConstant.assignment_change_approval);
            authController.googleSignOut();
            controller.selectCountry=null;
            controller.selectState=null;
            Get.delete<LoginController>();
            Get.delete<PartnerController>();
            Get.offAll(()=> const SplashScreen());
            controller.index.value=0;
            indexValue.value = 1;
          },
          ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: Future.value,
            child: alert,
        );
      },
    );
  }
}

class CustomTitle extends StatelessWidget {
  final String title;
  final String image;
  final GestureTapCallback? onTap;
  const CustomTitle({super.key, required this.title, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.r, right: 5.r),
      child: InkWell(
        onTap: onTap,
        hoverColor: AllColors.lightRed.withOpacity(0.3),
        child: Padding(
          padding: EdgeInsets.only(left: 15.0.r, bottom: 10.r,top: 10.r),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: AllColors.white.withOpacity(0.8),
                child: Image.asset(image, height:20.r, width: 20.r, color: AllColors.themeColor,),
              ),
              SizedBox(width: 15.r),
              Expanded(
                child: Text(title.toString(),style: fontBold.copyWith(fontSize: 16.r, color: AllColors.white.withOpacity(0.9)),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
