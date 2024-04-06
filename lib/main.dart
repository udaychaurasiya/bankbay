// ignore_for_file: use_build_context_synchronously

import 'package:bank_bay/Controller%20Binding/binding.dart';
import 'package:bank_bay/Login/firebase_option.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:screen_loader/screen_loader.dart';
import 'style/colors.dart';
import 'utils/app_constants.dart';
import 'utils_method/indicator.dart';
import 'widgets/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

var controller = Get.put(PermissionController());
var partnerController = Get.put(PartnerController());

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init();
  if(GetStorage().read(AppConstant.cust_id).toString().startsWith("E10")==true){
    partnerController.getEmployeeDetailsGetAmountNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
    controller.userPermissionNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
  }
  else if(GetStorage().read(AppConstant.cust_id).toString().startsWith("C10")==true){
    partnerController.getUserDetailsApi(GetStorage().read(AppConstant.cust_id).toString());
    controller.userPermissionNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
  }
  else{
    partnerController.getEmployeeDetailsGetAmountNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
    partnerController.getUserDetailsApi(GetStorage().read(AppConstant.cust_id).toString());
    controller.userPermissionNetworkApi(GetStorage().read(AppConstant.cust_id).toString());
  }
  configScreenLoader(
    loader: const AlertDialog(
      title: Text('Global Loader..'),
    ),
    bgBlur: 20.0,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const UserApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  print("message title : ${message.notification!.title.toString()}");
  print("message body : ${message.notification!.body.toString()}");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
}

class UserApp extends StatefulWidget {
  const UserApp({super.key});

  @override
  State<UserApp> createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayOpacity: 0.8,
          overlayColor: AllColors.none,
          overlayWidget: const CustomCircularProgressIndicator(),
          // child: OverlaySupport.global(
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppConstants.APP_NAME,
              themeMode: ThemeMode.system,
              initialBinding: ControllerBinding(),
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Colors.blue.withOpacity(0.8),
              ),
              // home: const SplashScreen(),
              home: const SplashScreen(),
            ),
          // ),
        );
      },
    );
  }
}

