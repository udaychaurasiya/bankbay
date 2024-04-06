import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreditScore extends StatefulWidget {
  const CreditScore({super.key});

  @override
  State<CreditScore> createState() => CreditScoreState();
}

class CreditScoreState extends State<CreditScore> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          50.0.r,
        ),
        child: CustomAppBar(
          title: "Credit Score".tr,
          leadingBool: false,
          back: true,
          onTab: ()async{
            Get.back();
          },
        ),
      ),
      body: const Center(
        child: Text("Credit Score"),
      ),
    );
  }
}
