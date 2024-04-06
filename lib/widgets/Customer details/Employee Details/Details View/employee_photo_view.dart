import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/employee_profile.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmployeePhotoView extends StatefulWidget {
  final String? empId;
  final String pageName;
  const EmployeePhotoView({super.key, required this.empId, required this.pageName});

  @override
  State<EmployeePhotoView> createState() => _EmployeePhotoViewState();
}

class _EmployeePhotoViewState extends State<EmployeePhotoView> {
  var partnerController = Get.find<PartnerController>();

  @override
  void initState() {
    partnerController.getEmployeeDetailsNetworkApi(widget.empId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      color: AllColors.white.withOpacity(0.9),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: ()=> employeeProfileTab.value=3,
              child: Text("SKIP",
                style: fontMedium.copyWith(
                  color: Colors.black.withOpacity(0.9),
                ),
              ),
            ),
          ),
          Text(
            "Selfie",
            style: fontBold.copyWith(fontSize: 22.r, color: Colors.black),
          ),
          SizedBox(height: 2.r),
          Text(
            "Let's take a s/elfie",
            style: fontSmall.copyWith(color: Colors.black.withOpacity(0.6)),
          ),
          SizedBox(height: 50.r),
          Obx(() => DottedBorder(
            borderType: BorderType.Circle,
            radius: Radius.circular(100.r),
            strokeWidth: 1.5.r,
            dashPattern: const [5, 4],
            color: AllColors.black.withOpacity(0.5),
            child: InkWell(
              // onTap: () {
              //   imageDialogBox(context);
              // },
              child: CircleAvatar(
                radius: 80.r,
                backgroundColor: AllColors.white,
                backgroundImage: NetworkImage(AppConstants.BASE_URL+partnerController.employeeDetails.value.data.basicDetails.docProfilePic.toString()),
              ),
            ),
          ),
          ),
          SizedBox(height: 50.r),
          Text(
            "Be sure to sit in full light area. \nMake sure your face is visible within area",
            style: fontRegular.copyWith(
                color: AllColors.black.withOpacity(0.7), fontSize: 13.r),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25.r),
          SizedBox(height: 40.r),
        ],
      ),
    );
  }
}
