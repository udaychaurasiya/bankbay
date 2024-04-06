import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/controllers/permission_controller.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PermissionController());
    Get.lazyPut(() => PartnerController());
    Get.lazyPut(() => LoginController());
  }
}