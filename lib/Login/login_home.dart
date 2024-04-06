// ignore_for_file: avoid_print

import 'package:bank_bay/Login/Pan%20Aadhaar/aadhaar_password.dart';
import 'package:bank_bay/Login/Pan%20Aadhaar/create_new_password.dart';
import 'package:bank_bay/Login/Pan%20Aadhaar/create_password_number.dart';
import 'package:bank_bay/Login/Pan%20Aadhaar/create_password_otp.dart';
import 'package:bank_bay/Login/Pan%20Aadhaar/pan_login.dart';
import 'package:bank_bay/controllers/auth_conroller.dart';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/notification_service.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/widgets/Apply%20Loan/create_customer.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

RxInt pinValue = 1.obs;
RxInt passwordValue = 1.obs;
class LoginScreen extends StatefulWidget {
  final String value;
  const LoginScreen({super.key, required this.value});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  NotificationServices notificationServices = NotificationServices();
  var controller = Get.find<LoginController>();
  var authController = Get.find<AuthController>();
  RxInt loginTab = 1.obs;

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        controller.FCM_TOKEN.value = value;
        print('device token key ssbxsx ======>>>>>>>>>  ${controller.FCM_TOKEN.value}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Get.offAll(()=> const DashboardScreen());
        controller.index.value=0;
        indexValue.value=1;
        return true;
      },
      child: Scaffold(
        backgroundColor: AllColors.themeColor,
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            55.0.r,
          ),
          child: CustomAppBar(
            title: "BankBay".tr,
            leadingBool: false,
            back: true,
            onTab: () {
              Get.off(()=> const DashboardScreen());
              controller.index.value=0;
              indexValue.value=1;
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 1.r,
              width: Get.width,
              color: AllColors.white.withOpacity(0.2),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0.r),
              child: Image.asset(
                Images.logo,
                fit: BoxFit.cover,
                height: 80.r,
                width: 80.r,
              ),
            ),
            Obx(() => loginTab.value!=-1 ?
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      loginTab.value=1;
                      passwordValue.value =1;
                    },
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 8.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: loginTab.value==1?Colors.yellow:AllColors.none))
                      ),
                      child: Text("PAN".tr,
                        style:  fontBold.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: loginTab.value==1?AllColors.white.withOpacity(0.8):AllColors.white.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      loginTab.value=2;
                      passwordValue.value =1;
                    },
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 8.r),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.r, color: loginTab.value==2?Colors.yellow:AllColors.none))
                      ),
                      child: Text("Aadhaar".tr,
                        style:  fontBold.copyWith(fontSize: 14.r, wordSpacing: 0,letterSpacing: 0.4,color: loginTab.value==2?AllColors.white.withOpacity(0.8):AllColors.white.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ],
              ) :
              const SizedBox(),
            ),
            Container(
              height: 1.r,
              width: Get.width,
              color: AllColors.white.withOpacity(0.2),
            ),
            Obx(() => Expanded(
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    // SingleChildScrollView(
                    //   child: Column(
                    //     children: [
                    //       SizedBox(height: 20.r),
                    //       if (pinValue.value == 1)
                    //         LoginPin(value: value),
                    //       if (pinValue.value == 2)
                    //         const CreatePin(),
                    //       if (pinValue.value == 3)
                    //         const CreatePinNumber(),
                    //       if (pinValue.value == 4)
                    //         const CreatePinOtp(),
                    //       SizedBox(height: 15.r),
                    //       Padding(
                    //         padding: EdgeInsets.only(right:8.0.r),
                    //         child: Image.asset(Images.bird,height: 30.r, width: 30.r),
                    //       ),
                    //       SizedBox(height: 15.r),
                    //       RichText(
                    //         text: TextSpan(
                    //           text: "Haven't registered ",
                    //           style: fontRegular.copyWith(
                    //               color: AllColors.white.withOpacity(0.8)),
                    //           children: [
                    //             TextSpan(
                    //               text: "Sign Up now",
                    //               style: fontRegular.copyWith(
                    //                   color: AllColors.white),
                    //               recognizer: TapGestureRecognizer()..onTap = () {
                    //                 Get.offAll(()=> const DashboardScreen());
                    //                 controller.index.value=0;
                    //                 indexValue.value=2;
                    //               },
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(height: 25.r),
                    //       Text(
                    //         "--OR--",
                    //         style: fontMedium.copyWith(
                    //             color: AllColors.white.withOpacity(0.8),
                    //             wordSpacing: 2,
                    //             letterSpacing: 2,
                    //             fontSize: 18.r),
                    //       ),
                    //       SizedBox(height: 25.r),
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 20.r),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Expanded(
                    //               child: Container(
                    //                 padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 5.r),
                    //                 decoration: BoxDecoration(
                    //                   color: AllColors.white.withOpacity(0.9),
                    //                   borderRadius: BorderRadius.circular(5.r),
                    //                 ),
                    //                 child: Row(
                    //                   children: [
                    //                     SizedBox(width: 5.r),
                    //                     CircleAvatar(
                    //                       radius: 12.r,
                    //                       backgroundColor: AllColors.none,
                    //                       backgroundImage:
                    //                       const AssetImage(Images.facebook),
                    //                     ),
                    //                     SizedBox(width: 10.r),
                    //                     Text(
                    //                       "Sign in Facebook",
                    //                       style: fontSmall.copyWith(
                    //                           wordSpacing: 0.0,
                    //                           letterSpacing: 0.0),
                    //                     )
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(width: 20.r),
                    //             Expanded(
                    //               child: Container(
                    //                 padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 5.r),
                    //                 decoration: BoxDecoration(
                    //                   color: AllColors.white.withOpacity(0.9),
                    //                   borderRadius: BorderRadius.circular(5.r),
                    //                 ),
                    //                 child: Row(
                    //                   children: [
                    //                     SizedBox(width: 5.r),
                    //                     CircleAvatar(
                    //                       radius: 12.r,
                    //                       backgroundColor: AllColors.none,
                    //                       backgroundImage:
                    //                       const AssetImage(Images.google),
                    //                     ),
                    //                     SizedBox(width: 10.r),
                    //                     Text(
                    //                       "Sign in Google",
                    //                       style: fontSmall.copyWith(
                    //                           wordSpacing: 0.0,
                    //                           letterSpacing: 0.0),
                    //                     )
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(height: 20.r),
                    //     ],
                    //   ),
                    // ),
                    /// Pan login
                    if(loginTab.value==1)
                    Column(
                      children: [
                        SizedBox(height: 25.r),
                        if (passwordValue.value == 1)
                          PanLogin(value: widget.value),
                      ],
                    ),
                    /// Aadhaar login
                    if(loginTab.value==2)
                    Column(
                      children: [
                        SizedBox(height: 25.r),
                        if (passwordValue.value == 1)
                          LoginPassword(value: widget.value),
                      ],
                    ),
                    if (passwordValue.value == 2)
                      const CreatePasswordNumber(),
                    if (passwordValue.value == 3)
                      const CreatePasswordOtp(),
                    if (passwordValue.value == 4)
                      const CreateNewPassword(),
                    SizedBox(height: 15.r),
                    Padding(
                      padding: EdgeInsets.only(right:8.0.r),
                      child: Image.asset(Images.bird,height: 30.r, width: 30.r),
                    ),
                    SizedBox(height: 15.r),
                    RichText(
                      text: TextSpan(
                        text: "Haven't registered ",
                        style: fontRegular.copyWith(
                            color: AllColors.white.withOpacity(0.8)),
                        children: [
                          TextSpan(
                            text: "Sign Up now",
                            style: fontRegular.copyWith(
                                color: AllColors.white),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Get.to(()=> const CreateCustomerWidget(addLoan: false));
                              // Get.offAll(()=> const DashboardScreen());
                              // controller.index.value=0;
                              // indexValue.value=2;
                            },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25.r),
                    InkWell(
                      onTap: ()async{
                        await authController.googleSignOut();
                      },
                      child: Text(
                        "--OR--",
                        style: fontMedium.copyWith(
                            color: AllColors.white.withOpacity(0.8),
                            wordSpacing: 2,
                            letterSpacing: 2,
                            fontSize: 18.r),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 25.r),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                print("facebook login");
                                authController.signInWithFacebookLogin();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 5.r),
                                decoration: BoxDecoration(
                                  color: AllColors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 5.r),
                                    CircleAvatar(
                                      radius: 12.r,
                                      backgroundColor: AllColors.none,
                                      backgroundImage:
                                      const AssetImage(Images.facebook),
                                    ),
                                    SizedBox(width: 10.r),
                                    Text(
                                      "Sign in Facebook",
                                      style: fontSmall.copyWith(
                                          wordSpacing: 0.0,
                                          letterSpacing: 0.0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.r),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                print("google login");
                                await authController.googleSignInLogin();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 5.r),
                                decoration: BoxDecoration(
                                  color: AllColors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 5.r),
                                    CircleAvatar(
                                      radius: 12.r,
                                      backgroundColor: AllColors.none,
                                      backgroundImage:
                                      const AssetImage(Images.google),
                                    ),
                                    SizedBox(width: 10.r),
                                    Text(
                                      "Sign in Google",
                                      style: fontSmall.copyWith(
                                          wordSpacing: 0.0,
                                          letterSpacing: 0.0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.r),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
