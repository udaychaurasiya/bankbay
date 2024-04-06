import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/underline_textfield.dart';
import 'package:bank_bay/utils_method/uppercase_formate.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_push_back_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EmployeePushBackKYCScreen extends StatefulWidget {
  final String empId;
  final String pageName;
  const EmployeePushBackKYCScreen({super.key, required this.empId, required this.pageName});

  @override
  State<EmployeePushBackKYCScreen> createState() => _EmployeePushBackKYCScreenState();
}

var controller = Get.find<LoginController>();
var partnerController = Get.find<PartnerController>();
class _EmployeePushBackKYCScreenState extends State<EmployeePushBackKYCScreen> {
  TextEditingController panCard = TextEditingController();
  TextEditingController aadharCard = TextEditingController();

  @override
  void initState() {
    partnerController.getEmployeeDetailsNetworkApi(widget.empId.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    panCard.text =  partnerController.employeeDetails.value.data.basicDetails.empPan?? "";
    aadharCard.text =  partnerController.employeeDetails.value.data.basicDetails.empAadhar?? "";
    return GetBuilder<LoginController>(
      builder: (controller){
        return Column(
          children: [
            SizedBox(height: 15.r),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120.r,
                  margin: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 10.r),
                  padding: EdgeInsets.only(bottom: 10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    shape: BoxShape.rectangle,
                  ),
                  child: DottedBorder(
                    borderType: BorderType.Rect,
                    radius: Radius.circular(5.r),
                    strokeWidth: 1.5.r,
                    dashPattern: const [4,3],
                    color: AllColors.blue.withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                          child: UnderLineTextField(
                            labelText: "Enter PAN Number".tr,
                            hint: "Enter PAN Number".tr,
                            label: true,
                            controller: panCard,
                            type: TextInputType.text,
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: Get.width/4-5.r,
                  top: 12.r,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
                    color: Colors.white,
                    child: Text(
                      "PAN Authentication",
                      style: fontMedium.copyWith(fontSize: 12.r),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120.r,
                  margin: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 10.r),
                  padding: EdgeInsets.only(bottom: 10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    shape: BoxShape.rectangle,
                  ),
                  child: DottedBorder(
                    borderType: BorderType.Rect,
                    radius: Radius.circular(5.r),
                    strokeWidth: 1.5.r,
                    dashPattern: const [4,3],
                    color: AllColors.blue.withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                          child: UnderLineTextField(
                            controller: aadharCard,
                            hint: "Enter Aadhaar Number".tr,
                            label: true,
                            type: TextInputType.number,
                            length: 12,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            suffixIcon: Lottie.asset(Images.success, height: 25.r, width: 25.r,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: Get.width/4-5.r,
                  top: 12.r,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.r, left: 10.r, right: 10.r),
                    color: Colors.white,
                    child: Text(
                      "AADHAAR Authentication",
                      style: fontMedium.copyWith(fontSize: 12.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.r),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.r),
              child: CustomButton(
                title: "Next".tr,
                // bgColor: AllColors.green,
                background: true,
                height: 35.r,
                radius: 0,
                onTap: ()async{
                  bool status = await controller.employeePushBackKycUpdateNetworkApi("2", partnerController.employeeDetails.value.data.basicDetails.id,panCard.text, aadharCard.text);
                  if(status==true){
                    employeePushBackDetailsTab.value = 4;
                  }
                },
              ),
            ),
            SizedBox(height: 20.r),
          ],
        );
      },
    );
  }
}
