import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/widgets/Profile/Model/user_details_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PartnerDetailsDocsScreen extends StatefulWidget {
  final UserDetailsData partnerDetails;
  const PartnerDetailsDocsScreen({super.key, required this.partnerDetails});

  @override
  State<PartnerDetailsDocsScreen> createState() => _PartnerDetailsDocsScreenState();
}

class _PartnerDetailsDocsScreenState extends State<PartnerDetailsDocsScreen> {
  @override
  Widget build(BuildContext context) {
  var ownedValue = (widget.partnerDetails.partnerdetails.addressProofType.toString()=="rented"?2:1).obs;
  RxString genderValue = (widget.partnerDetails.partnerdetails.propertyOwnerType.toString()=="2"?"Family Proof":"My Proof").obs;
    return GetBuilder<LoginController>(
      builder: (controller){
        return Column(
          children: [
            SizedBox(height: 20.r),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChooseImageDocument(
                    title: "PAN Card".tr,
                    image: widget.partnerDetails.partnerdetails.docPan??"",
                  ),
                  SizedBox(height: 20.r),
                  ChooseImageDocument(
                    title: "Aadhaar (both sides)".tr,
                    image:  widget.partnerDetails.partnerdetails.docAadhar??"",
                    subTitle: "Single PDF File",
                  ),
                  SizedBox(height: 20.r),
                  ChooseImageDocument(
                    title: "Bank Statement".tr,
                    image: widget.partnerDetails.partnerdetails.docBanking??"",
                    subTitle: "Latest month salary credit",
                    optional: true,
                  ),
                  SizedBox(height: 20.r),
                  ChooseImageDocument(
                    title: "Appointment Letter".tr,
                    image: widget.partnerDetails.partnerdetails.docOhp??"",
                    subTitle: "Gross by our company",
                  ),
                  SizedBox(height: 20.r),
                  Text("Address Proof",style: fontBold.copyWith(),),
                  SizedBox(height: 20.r),
                  Obx(() => Container(
                    height: 30.r,
                    width: Get.width/2,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.r, color: AllColors.blue),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              ownedValue.value = 1;
                              print("value ${ownedValue.value}");
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r),bottomLeft: Radius.circular(5.r)),
                                color:  ownedValue.value == 1?AllColors.blue.withOpacity(0.9):AllColors.white.withOpacity(0.9),
                              ),
                              child: Text("Owned", style: fontSmall.copyWith(color: ownedValue.value == 1 ?AllColors.white.withOpacity(0.9):AllColors.blue.withOpacity(0.9)),),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              ownedValue.value = 2;
                              print("value ${ownedValue.value}");
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(5.r),bottomRight: Radius.circular(5.r)),
                                color: ownedValue.value == 2?AllColors.blue.withOpacity(0.9):AllColors.white.withOpacity(0.9),
                              ),
                              child: Text("Rented", style: fontSmall.copyWith(color: ownedValue.value == 2?AllColors.white.withOpacity(0.9):AllColors.blue.withOpacity(0.9)),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(height: 20.r),
                  Obx(() {
                    return Column(
                      children: [
                        Row(
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
                                  color: Colors.black.withOpacity(0.7),wordSpacing: 0.2,letterSpacing: 0.1),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.r),
                        Row(
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
                                  color: Colors.black.withOpacity(0.7),wordSpacing: 0.2,letterSpacing: 0.1),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        if(ownedValue.value == 1 && (genderValue.value=="My Proof"||genderValue.value=="Family Proof"))
                          SizedBox(height: 20.r),
                        if(ownedValue.value == 1 && (genderValue.value=="My Proof"||genderValue.value=="Family Proof"))
                          ChooseImageDocument(
                            title: "Ownership Proof".tr,
                            image: widget.partnerDetails.partnerdetails.docOhp??"",
                            subTitle: "Electric bill/".tr,
                          ),
                       if(ownedValue.value == 2 && (genderValue.value=="My Proof"||genderValue.value=="Family Proof"))
                          SizedBox(height: 20.r),
                        if(ownedValue.value == 2 && (genderValue.value=="My Proof"||genderValue.value=="Family Proof"))
                          ChooseImageDocument(
                            title: "Rent Agreement".tr,
                            image: widget.partnerDetails.partnerdetails.docPresentAddress??"",
                            subTitle: "Rent Agreement".tr,
                          ),
                        if((ownedValue.value == 2 || ownedValue.value == 1) && genderValue.value=="Family Proof")
                          SizedBox(height: 20.r),
                        if((ownedValue.value == 2 || ownedValue.value == 1) && genderValue.value=="Family Proof")
                          ChooseImageDocument(
                            title: "Relationship Proof".tr,
                            image:widget.partnerDetails.partnerdetails.docRelationProof??"",
                            subTitle: "subtitle",
                          ),
                      ],
                    );
                  })
                ],
              ),
            ),
            // SizedBox(height: 15.r),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal:15.0.r),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       CustomButton(
            //         title: "Approve".tr,
            //         width: 120.r,
            //         bgColor: AllColors.green,
            //         background: false,
            //         height: 35.r,
            //         radius: 0,
            //         onTap: (){
            //           print("add emp type 1");
            //         },
            //       ),
            //       CustomButton(
            //         title: "Push back".tr,
            //         width: 120.r,
            //         // bgColor: AllColors.green,
            //         background: true,
            //         height: 35.r,
            //         radius: 0,
            //         onTap: ()async{
            //           print("add emp type 2");
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 20.r),
          ],
        );
      },
    );
  }
}

class ChooseImageDocument extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? fileName;
  final String image;
  final bool? optional;
  const ChooseImageDocument(
      {super.key, required this.title, this.subTitle, required this.image, this.optional=false, this.fileName=""});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              height: 100.r,
              width: 150.r,
              child: CachedNetworkImage(
                imageUrl: image!="null"?AppConstants.BASE_URL+image.toString():Images.empty,
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
                errorWidget: (context,
                    url, error) => Column(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: title.toString(),
                  style: fontSmall.copyWith(
                      color: AllColors.black.withOpacity(0.9),
                      letterSpacing: 0.2),
                  children: [
                    TextSpan(text: optional==false? " * ":"", style: fontMedium.copyWith(
                      color: AllColors.red.withOpacity(0.8),
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.r),
              Text(subTitle ?? "", style: fontExtraSmall.copyWith(
                  color: AllColors.black.withOpacity(0.5)),),
              SizedBox(height: 2.r),
              Text(fileName.toString(), style: fontExtraSmall.copyWith(
                  color: AllColors.black.withOpacity(0.5)),),
            ],
          ),
        )
      ],
    );
  }
}

