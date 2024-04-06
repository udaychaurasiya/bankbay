// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/models/firebase_model.dart';
import 'package:bank_bay/utils/BaseClient.dart';
import 'package:bank_bay/utils/app_constant.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:bank_bay/widgets/home_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:local_auth/local_auth.dart';
import 'permission_controller.dart';

class AuthController extends GetxController{
  var controller = Get.put(PermissionController());
  var loginController = Get.put(LoginController());
  GetStorage storage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Create an instance of google login
  Future<void> googleSignInLogin()async{
    try{
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if(googleUser!=null){
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        if (kDebugMode) {
          print("google name : ${_googleSignIn.currentUser!.displayName}");
          print("google email : ${_googleSignIn.currentUser!.email}");
          print("google photo : ${_googleSignIn.currentUser!.photoUrl}");
          print("google id : ${_googleSignIn.currentUser!.id}");
        }
        googleFacebookSignInNetworkApi(_googleSignIn.currentUser!.displayName,_googleSignIn.currentUser!.email);
        await _auth.signInWithCredential(credential);
      }
    }catch (e){
      if (kDebugMode) {
        print("Error Sign in with google $e");
      }
    }
  }

  Future<void> googleSignOut() async {
    try{
      await _auth.signOut();
      await _googleSignIn.signOut();
    }catch (e){
      if (kDebugMode) {
        print("Error google sign in out");
      }
    }
  }

  /// Create an instance of FacebookLogin
  Future<Resource?> signInWithFacebookLogin() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential = FacebookAuthProvider.credential(result.accessToken!.token);
          final userCredential = await _auth.signInWithCredential(facebookCredential);
          print("userCredential $userCredential");
          return Resource(status: Status.Success);
        case LoginStatus.cancelled:
          return Resource(status: Status.Cancelled);
        case LoginStatus.failed:
          return Resource(status: Status.Error);
        default:
          return null;
      }
    } on FirebaseAuthException {
      rethrow;
    }
  }


  /// fingerprint auth login
  final LocalAuthentication _localAuth = LocalAuthentication();
  RxBool isAuthenticated = false.obs;
  Future<void> fingerprintSignInLogin() async {
    try {
      bool isBiometricAvailable = await _localAuth.canCheckBiometrics;
      if (isBiometricAvailable) {
        isAuthenticated.value = await _localAuth.authenticate(
          localizedReason: 'Authenticate to access the app',
          options: const AuthenticationOptions(
            biometricOnly: false,
          )
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during biometric authentication: $e');
      }
    }
  }

  Future<bool> googleFacebookSignInNetworkApi(name, email) async {
    var bodyRequest = {
      "cust_name": name.toString(),
      "cust_email": email.toString(),
    };
    print("request ====================>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(AppConstants.GOOGLE_FACEBOOK_SIGN_IN, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response  ================>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == "1") {
      storage.write(AppConstant.name, jsonDecode(response)["data"]["cust_name"]??"");
      storage.write(AppConstant.id, jsonDecode(response)["data"]["id"]??"");
      storage.write(AppConstant.phone, jsonDecode(response)["data"]["cust_phone"]??"");
      storage.write(AppConstant.email, jsonDecode(response)["data"]["cust_email"]??"");
      storage.write(AppConstant.cust_id, jsonDecode(response)["data"]["cust_id"]??"");
      storage.write(AppConstant.profile, jsonDecode(response)["data"]["cust_profile_pic"]??"");
      loginController.sendFCMTokenNetworkApi(jsonDecode(response)["data"]["cust_id"],loginController.FCM_TOKEN.value.toString());
      bool status = await controller.userPermissionNetworkApi(jsonDecode(response)["data"]["cust_id"].toString());
      if (status == true) {
        Get.offAll(() => const DashboardScreen());
        loginController.index.value=0;
        indexValue.value=1;
      }
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }


}