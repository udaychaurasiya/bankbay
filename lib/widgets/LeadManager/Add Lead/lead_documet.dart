import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/document_upload_widget.dart';
import 'package:bank_bay/widgets/LeadManager/add_lead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

LoginController controller = Get.find<LoginController>();
class LeadDocument extends StatelessWidget {
  const LeadDocument({super.key});

  @override
  Widget build(BuildContext context) {
    RxString genderValue = "My Proof".obs;
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
      color: AllColors.white.withOpacity(0.9),
      child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Awesome, ",
                    style: fontSmall.copyWith(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Phone is validated.",
                    style:
                    fontSmall.copyWith(color: Colors.black.withOpacity(0.7)),
                  ),
                ],
              ),
              SizedBox(height: 2.r),
              Text(
                "Please upload below documents",
                style: fontSmall.copyWith(color: Colors.black.withOpacity(0.7)),
              ),
              SizedBox(height: 25.r),
              Obx(() => ChooseImageWidget(
                  title: "Profile Image".tr,
                  image: controller.leadProfileSelfie.value,
                  subTitle: controller.leadProfileSelfieName.value != ""
                      ? controller.leadProfileSelfieName.value
                      : "",
                  onTap: () => customerDocumentProofImageBox(context, 7),
                ),
              ),
              SizedBox(height: 20.r),
              Obx(() => ChooseImageWidget(
                  title: "PAN Card".tr,
                  image: controller.panCardImage.value,
                  subTitle: controller.panCardImageName.value != ""
                      ? controller.panCardImageName.value
                      : "",
                  onTap: () => customerDocumentProofImageBox(context, 1),
                ),
              ),
              SizedBox(height: 20.r),
              Obx(
                    () => ChooseImageWidget(
                  image: controller.aadhaarCardImage.value,
                  subTitle: controller.aadhaarCardImageName.value != ""
                      ? controller.aadhaarCardImageName.value
                      : "Single PDF file",
                  title: "AADHAAR (both sides)".tr,
                  onTap: () => customerDocumentProofImageBox(context, 2),
                ),
              ),
              SizedBox(height: 20.r),
              Obx(
                    () => ChooseImageWidget(
                  image: controller.salarySlipsImage.value,
                  subTitle: controller.salarySlipsImageName.value != ""
                      ? controller.salarySlipsImageName.value
                      : "latest 3 months",
                  title: "Salary Slips".tr,
                  onTap: () => customerDocumentProofImageBox(context, 3),
                ),
              ),
              SizedBox(height: 20.r),
              Obx(() => ChooseImageWidget(
                  image: controller.bankStatementImage.value,
                  subTitle: controller.bankStatementImageName.value != ""
                      ? controller.bankStatementImageName.value
                      : "latest 6 months",
                  title: "Bank Statement".tr,
                  onTap: () => customerDocumentProofImageBox(context, 4),
                )),
              SizedBox(height: 30.r),
              Text(
                "Property ownership Proof",
                style: fontBold.copyWith(),
              ),
              SizedBox(height: 20.r),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        controller.ownerShipProof.value="";
                        controller.ownerShipProofName.value="";
                        controller.relationshipProof.value="";
                        controller.relationshipProofName.value="";
                        genderValue.value = "My Proof";
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            height: 20.r,
                            width: 20.r,
                            child: Radio(
                              value: "My Proof",
                              groupValue: genderValue.value,
                              onChanged: (value) {
                                genderValue.value = value.toString();
                                print("object ${genderValue.value}");
                              },
                            ),
                          ),
                          SizedBox(width: 10.r),
                          Text(
                            "Property proof is in my name",
                            style: fontSmall.copyWith(
                                color: Colors.black.withOpacity(0.7),
                                wordSpacing: 0.2,
                                letterSpacing: 0.1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.r),
                    InkWell(
                      onTap: (){
                        controller.ownerShipProof.value="";
                        controller.ownerShipProofName.value="";
                        controller.relationshipProof.value="";
                        controller.relationshipProofName.value="";
                        genderValue.value = "Family Proof";
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.r,
                            width: 20.r,
                            child: Radio(
                              value: "Family Proof",
                              groupValue: genderValue.value,
                              onChanged: (value) {
                                genderValue.value = value.toString();
                                print("object ${genderValue.value}");
                              },
                            ),
                          ),
                          SizedBox(width: 10.r),
                          Text(
                            "Property proof is in my family member's name",
                            style: fontSmall.copyWith(
                                color: Colors.black.withOpacity(0.7),
                                wordSpacing: 0.2,
                                letterSpacing: 0.1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (genderValue.value == "My Proof"||genderValue.value == "Family Proof") SizedBox(height: 20.r),
              if (genderValue.value == "My Proof"||genderValue.value == "Family Proof")
              Obx(() => ChooseImageWidget(
                  image: controller.ownerShipProof.value,
                  subTitle: controller.ownerShipProofName.value != ""
                      ? controller.ownerShipProofName.value
                      : "Electric bill/ Holding tax / Sale deep any ONE",
                  title: "Ownership Proof".tr,
                  onTap: () => customerDocumentProofImageBox(context, 5),
                )),
              if(genderValue.value == "Family Proof")
              SizedBox(height: 20.r),
              if(genderValue.value == "Family Proof")
              Obx(() => ChooseImageWidget(
                  image: controller.relationshipProof.value,
                  subTitle: controller.relationshipProofName.value != ""
                      ? controller.relationshipProofName.value
                      : "Aadhaar/PAN/DL or Marriage certificate that shows relationship with property owner",
                  title: "Relationship proof".tr,
                  onTap: () => customerDocumentProofImageBox(context, 6),
                )),
              SizedBox(height: 30.r),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LightCustomButton(
                    title: "Back".tr,
                    height: 28.r,
                    width: 100.r,
                    background: false,
                    onTap: () => screenValue.value = 5,
                  ),
                  SizedBox(width: 15.r),
                  CustomButton(
                    title: "Next".tr,
                    background: true,
                    radius: 30.r,
                    height: 30.r,
                    width: Get.width - 240,
                    onTap: () async {
                      if (controller.panCardImage.value != "" ||
                          controller.aadhaarCardImage.value != "" ||
                          controller.salarySlipsImage.value != "" ||
                          controller.bankStatementImage.value != "" ||
                          controller.ownerShipProof.value != "" ||
                          controller.relationshipProof.value != "") {
                        bool status =
                        await controller.leadUploadDocumentNetworkApi(
                            "1", genderValue.value != "Family Proof" ? 1 : 2);
                        if (status == true) {
                          screenValue.value = 1;
                        }
                      } else {
                        BaseController().errorSnack("Please choose all document images");
                      }
                    },
                  ),
                ],
            ),
          ],
        ),
      ),
    );
  }
  customerDocumentProofImageBox(BuildContext context, type) {
    showDialog(
      context: context,
      builder: (
          BuildContext context,
          ) {
        return AlertDialog(
          content: SizedBox(
            height: 180.r,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.r, right: 25.r, top: 20.r),
                  child: Column(
                    children: [
                      Text(
                        "Choose Image",
                        style: fontBold.copyWith(fontSize: 18.r),
                      ),
                      SizedBox(height: 15.r),
                      Container(
                        height: 2.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AllColors.lightGrey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        controller.documentImages(false, type);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              Images.gallery,
                              height: 50.r,
                              width: 50.r,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5.r),
                            Text(
                              "Gallery",
                              style: fontMedium.copyWith(fontSize: 15.r),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1.r,
                      height: 40.r,
                      color: AllColors.lightGrey.withOpacity(0.8),
                      margin: EdgeInsets.symmetric(vertical: 5.r),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        controller.documentImages(true, type);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              Images.camera,
                              height: 50.r,
                              width: 50.r,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5.r),
                            Text(
                              "Camera",
                              style: fontMedium.copyWith(fontSize: 15.r),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.zero,
          actionsOverflowButtonSpacing: 0,
          actionsOverflowDirection: VerticalDirection.down,
          actions: [
            Container(
              color: Colors.red,
            )
          ],
        );
      },
    );
  }
}
