import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var controller = Get.find<LoginController>();

  @override
  void initState() {
    controller.getNotificationsNetworkApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors.themeColor,
        title: const Text("Notifications"),
      ),
      body: Obx(() => ListView.builder(
        padding: EdgeInsets.only(top: 10.r),
          itemCount: controller.getNotificationData.value.data.length,
          itemBuilder: (context, index) {
            var notifications = controller.getNotificationData.value.data[index];
            return Container(
              padding: EdgeInsets.all(10.r),
              margin: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0.r, color: AllColors.grey.withOpacity(0.6)),
                borderRadius: BorderRadius.circular(5.r)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notifications.title??"", style: fontBold.copyWith(), overflow: TextOverflow.ellipsis,),
                  Text(notifications.subject??"", style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7),fontSize: 13.r), overflow: TextOverflow.ellipsis,),
                  Text(notifications.datetime??"", style: fontMedium.copyWith(color: AllColors.black.withOpacity(0.7),fontSize: 13.r), overflow: TextOverflow.ellipsis,),
                  Text(notifications.message??"", style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.7))),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
