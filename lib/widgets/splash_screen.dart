// ignore_for_file: file_names

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/indicator.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // @override
  // void initState() {
  //   super.initState();
  //   InternetConnectionChecker().onStatusChange.listen((status) {
  //     // final connected = status == InternetConnectionStatus.connected;
  //     // showSimpleNotification(Text(connected ? "CONNECTED TO INTERNET" : "NO INTERNET") ,background: Colors.green);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.logo,fit: BoxFit.cover, height: 150.r, width: 150.r,),
                  SizedBox(height: 5.r),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0.r),
                    child: Text(
                      AppConstants.APP_NAME,
                      style: fontBold.copyWith(
                          fontSize: 40.r, color: AllColors.white.withOpacity(0.9)),
                    ),
                  ),
                  SizedBox(height: 20.r),
                  const CustomCircularProgressIndicator(),
            ],
          ),
        ),
        backgroundColor: AllColors.darkBlue,
        // duration: 290000000,
        nextScreen: const DashboardScreen(),
        splashIconSize: 450.h,
    );
  }
}
