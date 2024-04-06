import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:bank_bay/widgets/Profile/Model/user_details_model.dart';

class LoanListDocument extends StatelessWidget {
  final AllLeade allLeade;
  const LoanListDocument({super.key, required this.allLeade});

  @override
  Widget build(BuildContext context) {
    RxString loanListOwnerValue = (allLeade.propertyOwnerType.toString()=="2"?"Family Proof":"My Proof").obs;
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Validate Document", style: fontBold.copyWith(fontSize: 13.r),)),
            Center(child: Text("Update or Get document upload as needed", style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.6),fontStyle: FontStyle.italic),)),
            SizedBox(height: 20.r),
            LoanListDocumentView(
              title: "Borrower's Photo".tr,
              image: allLeade.docPan.toString(),
              no: ()=> Get.back(),
              yes: ()=> Get.back(),
            ),
            SizedBox(height: 15.r),
            LoanListDocumentView(
              title: "Pan Card".tr,
              image: allLeade.docPan.toString(),
              no: ()=> Get.back(),
              yes: ()=> Get.back(),
            ),
            SizedBox(height: 15.r),
            LoanListDocumentView(
              title: "Aadhaar (both sides)".tr,
              subTitle: "single PDF file".tr,
              image: allLeade.docAadhar.toString(),
              no: ()=> Get.back(),
              yes: ()=> Get.back(),
            ),
            SizedBox(height: 15.r),
            LoanListDocumentView(
              title: "Salary Slips".tr,
              subTitle: "latest 3 months".tr,
              image: allLeade.docSalaryslip.toString(),
              no: ()=> Get.back(),
              yes: ()=> Get.back(),
            ),
            SizedBox(height: 15.r),
            LoanListDocumentView(
              title: "Bank Statement".tr,
              subTitle: "latest 6 months".tr,
              image: allLeade.docBanking.toString(),
              no: ()=> Get.back(),
              yes: ()=> Get.back(),
            ),
            SizedBox(height: 30.r),
            Text("Property ownership Proof", style: fontBold.copyWith(),),
            SizedBox(height: 20.r),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: ()=> loanListOwnerValue.value = "My Proof",
                    child: Row(
                      children: [
                        SizedBox(
                          height: 20.r,
                          width: 20.r,
                          child: Radio(
                            value: "My Proof",
                            groupValue: loanListOwnerValue.value,
                            onChanged: (value) {
                              loanListOwnerValue.value = value.toString();
                              print("object ${loanListOwnerValue.value}");
                            },
                          ),
                        ),
                        SizedBox(width: 10.r),
                        Text(
                          "Property proof is in my name",
                          style: fontSmall.copyWith(
                              color: Colors.black.withOpacity(0.7),wordSpacing: 0.2,letterSpacing: 0.1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.r),
                  InkWell(
                    onTap: ()=> loanListOwnerValue.value = "Family Proof",
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.r,
                          width: 20.r,
                          child: Radio(
                            value: "Family Proof",
                            groupValue: loanListOwnerValue.value,
                            onChanged: (value) {
                              loanListOwnerValue.value = value.toString();
                              print("object ${loanListOwnerValue.value}");
                            },
                          ),
                        ),
                        SizedBox(width: 10.r),
                        Text(
                          "Property proof is in my family member's name",
                          style: fontSmall.copyWith(
                              color: Colors.black.withOpacity(0.7),wordSpacing: 0.2,letterSpacing: 0.1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if(loanListOwnerValue.value=="My Proof"||loanListOwnerValue.value=="Family Proof")
              SizedBox(height: 20.r),
            if(loanListOwnerValue.value=="My Proof"||loanListOwnerValue.value=="Family Proof")
              LoanListDocumentView(
                title: "Ownership Proof".tr,
                subTitle: "Electric bill/ holding tax/ Sale deed any One".tr,
                image: allLeade.docOhp.toString(),
                no: ()=> Get.back(),
                yes: ()=> Get.back(),
              ),
            if(loanListOwnerValue.value=="Family Proof")
              SizedBox(height: 20.r),
            if(loanListOwnerValue.value=="Family Proof")
              LoanListDocumentView(
                title: "Relationship proof".tr,
                subTitle: "Marriage certificate that shows relationship with property owner".tr,
                image: allLeade.docRelationProof.toString(),
                no: ()=> Get.back(),
                yes: ()=> Get.back(),
              ),
            SizedBox(height: 20.r),
          ],
        ),
      ),
    );
  }
}

class LoanListDocumentView extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String image;
  final String? status;
  final GestureTapCallback? no;
  final GestureTapCallback? yes;
  const LoanListDocumentView({super.key, required this.title, this.subTitle, required this.image, this.no, this.yes, this.status=""});
  @override
  Widget build(BuildContext context) {
    print("suh ${AppConstants.BASE_URL+image}");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DottedBorder(
          borderType: BorderType.Rect,
          radius: Radius.circular(5.r),
          strokeWidth: 1.5.r,
          dashPattern: const [5, 4],
          color: AllColors.black.withOpacity(0.5),
          child: InkWell(
            onTap: ()=> Get.to(()=> CustomImageView(imageUrls: AppConstants.BASE_URL+image.toString())),
            child: SizedBox(
              height: 90.r,
              width: 150.r,
              child: CachedNetworkImage(
                imageUrl: AppConstants.BASE_URL+image,
                fadeOutDuration: const Duration(seconds: 3),
                imageBuilder: (context,
                    imageProvider) =>
                    Container(
                      decoration:
                      BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter:
                            const ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
                      ),
                    ),
                placeholder: (context, url) =>
                    Center(
                      child: SizedBox(
                        height: 45.r,
                        width: 45.r,
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                errorWidget: (context, url, error) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 40.r, color: AllColors.orange.withOpacity(0.7),),
                    SizedBox(height: 3.r),
                    Text("Image not found!", style: fontExtraSmall.copyWith(color: AllColors.black.withOpacity(0.7)),)
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 15.r),
        Expanded(
          child: SizedBox(
            height: 90.r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(title.toString(),style: fontBold.copyWith(
                          color: AllColors.black.withOpacity(0.9),
                          fontSize: 13.r,
                          letterSpacing: 0.2),
                      ),
                      Text(subTitle ?? "", style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.5),fontSize: 11.r),),
                    ],
                  ),
                ),
                const SizedBox(),
                // if(status==""||status==null)
                //   SizedBox(
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         CustomButton(
                //           title: "Ok".tr,
                //           width: 55.r,
                //           height: 26.r,
                //           radius: 0,
                //           bgColor: AllColors.green.withOpacity(0.8),
                //           background: false,
                //           onTap: yes,
                //         ),
                //         CustomButton(
                //           title: "Not Ok".tr,
                //           width: 70.r,
                //           height: 26.r,
                //           radius: 0,
                //           bgColor: AllColors.red.withOpacity(0.6),
                //           background: false,
                //           onTap: no,
                //         ),
                //       ],
                //     ),
                //   ),
                // if(status!="")
                //   Padding(
                //     padding: EdgeInsets.only(top: 10.0.r),
                //     child: Text(title.toString(),style: fontBold.copyWith(
                //         color: AllColors.black.withOpacity(0.9),
                //         fontSize: 13.r,
                //         letterSpacing: 0.2,
                //     ),
                //     ),
                //   ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
