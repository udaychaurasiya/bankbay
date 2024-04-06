import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils/utilmethode.dart';
import 'package:bank_bay/utils_method/custom_button.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/widgets/Customer%20details/Partner%20Details/partner_pushback_details.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:bank_bay/widgets/Profile/Employee%20Details/employee_docs_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PartnerPushbackDocsScreen extends StatefulWidget {
  final String partnerId;
  const PartnerPushbackDocsScreen({super.key, required this.partnerId});

  @override
  State<PartnerPushbackDocsScreen> createState() => _PartnerPushbackDocsScreenState();
}
final PartnerController controller = Get.find<PartnerController>();

class _PartnerPushbackDocsScreenState extends State<PartnerPushbackDocsScreen> {
  var pan = "".obs;
  var aadhar = "".obs;
  var banking = "".obs;
  var ownerShip = "".obs;
  var rentAgreement = "".obs;
  var relationShip = "".obs;
  @override
  void initState() {
    controller.getCustomerDetailsNetworkApi(widget.partnerId.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  var address_proof_type = (controller.customerDetails.value.data.partnerdetails.addressProofType.toString()=="rented"?"rented":"owned").obs;
  RxString property_owner_type = (controller.customerDetails.value.data.partnerdetails.propertyOwnerType.toString()=="2"?"Family Proof":"My Proof").obs;
  pan.value = controller.customerDetails.value.data.partnerdetails.docPan.toString();
  aadhar.value = controller.customerDetails.value.data.partnerdetails.docAadhar.toString();
  banking.value = controller.customerDetails.value.data.partnerdetails.docBanking.toString();
  ownerShip.value = controller.customerDetails.value.data.partnerdetails.docOhp.toString();
  rentAgreement.value = controller.customerDetails.value.data.partnerdetails.docRentAgreement.toString();
  relationShip.value = controller.customerDetails.value.data.partnerdetails.docRelationProof.toString();
    return Padding(
      padding:  EdgeInsets.only(left: 10.w,right: 10.w),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Obx(() {
            return Column(
              children: [
                SizedBox(height: 15.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.r),
                    Obx(() => controller.pPanCardImage.value!=""?
                      ChooseImageDocument(
                        title: "PAN Card".tr,
                        image: controller.pPanCardImage.value,
                        subTitle: controller.pPanCardImageName.value!=""?controller.pPanCardImageName.value:"",
                        onTap: () => profileDocsProofImageBox(context, 1),
                      ) :
                      ChooseImageDocumentView(
                        title: "PAN Card".tr,
                        image: pan.value,
                        subTitle: controller.pPanCardImageName.value!=""?controller.pPanCardImageName.value:"",
                        onTap: () => profileDocsProofImageBox(context, 1),
                      ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => controller.pAadhaarCardImage.value!=""?
                    ChooseImageDocument(
                      image: controller.pAadhaarCardImage.value,
                      subTitle: controller.pAadhaarCardImageName.value!=""?controller.pAadhaarCardImageName.value:"Single PDF file",
                      title: "AADHAAR (both sides)".tr,
                      onTap: () => profileDocsProofImageBox(context, 2),
                    ):
                    ChooseImageDocumentView(
                      image: aadhar.value,
                      subTitle: controller.pAadhaarCardImageName.value!=""?controller.pAadhaarCardImageName.value:"Single PDF file",
                      title: "AADHAAR (both sides)".tr,
                      onTap: () => profileDocsProofImageBox(context, 2),
                    ),
                    ),
                    SizedBox(height: 20.r),
                    Obx(() => controller.pBankStatementImage.value!=""?
                    ChooseImageDocument(
                      image: controller.pBankStatementImage.value,
                      subTitle: controller.pBankStatementImageName.value!=""?controller.pBankStatementImageName.value:"latest 6 months",
                      title: "Bank Statement".tr,
                      onTap: () => profileDocsProofImageBox(context, 4),
                    ):
                    ChooseImageDocumentView(
                      image: banking.value,
                      subTitle: controller.pBankStatementImageName.value!=""?controller.pBankStatementImageName.value:"latest 6 months",
                      title: "Bank Statement".tr,
                      onTap: () => profileDocsProofImageBox(context, 4),
                    ),
                    ),
                    SizedBox(height: 30.r),
                    Text("Address Proof", style: fontBold.copyWith(),),
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
                                address_proof_type.value = "owned";
                                property_owner_type.value = "My Proof";
                                print("value ${address_proof_type.value}");
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r),bottomLeft: Radius.circular(5.r)),
                                  color:  address_proof_type.value == "owned"?AllColors.blue.withOpacity(0.9):AllColors.white.withOpacity(0.9),
                                ),
                                child: Text("Owned", style: fontBold.copyWith(fontSize: 12.r, color: address_proof_type.value == "owned"?AllColors.white.withOpacity(0.9):AllColors.blue.withOpacity(0.9)),),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                address_proof_type.value = "rented";
                                property_owner_type.value = "My Proof";
                                print("value ${address_proof_type.value}");
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(5.r),bottomRight: Radius.circular(5.r)),
                                  color: address_proof_type.value == "rented"?AllColors.blue.withOpacity(0.9):AllColors.white.withOpacity(0.9),
                                ),
                                child: Text("Rented", style: fontBold.copyWith(fontSize: 12.r,color: address_proof_type.value == "rented"?AllColors.white.withOpacity(0.9):AllColors.blue.withOpacity(0.9)),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Padding(
                      padding: EdgeInsets.only(top:20.0.r),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (){
                                    property_owner_type.value = "My Proof";
                                    print("object ${property_owner_type.value}");
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 20.r,
                                        width: 20.r,
                                        child: Radio(
                                          value: "My Proof",
                                          groupValue: property_owner_type.value,
                                          onChanged: (value) {
                                            property_owner_type.value = value.toString();
                                            print("object ${property_owner_type.value}");
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
                                  onTap: (){
                                    property_owner_type.value = "Family Proof";
                                    print("object ${property_owner_type.value}");
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20.r,
                                        width: 20.r,
                                        child: Radio(
                                          value: "Family Proof",
                                          groupValue: property_owner_type.value,
                                          onChanged: (value) {
                                            property_owner_type.value = value.toString();
                                            print("object ${property_owner_type.value}");
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
                          if(property_owner_type.value=="My Proof" && address_proof_type.value == "owned" || property_owner_type.value=="Family Proof" && address_proof_type.value == "owned")
                            SizedBox(height: 20.r),
                          if(property_owner_type.value=="My Proof" && address_proof_type.value == "owned" || property_owner_type.value=="Family Proof" && address_proof_type.value == "owned")
                            Obx(() => controller.pOwnerShipProof.value!=""?
                            ChooseImageDocument(
                              image: controller.pOwnerShipProof.value,
                              subTitle: controller.pOwnerShipProofName.value!=""?controller.pOwnerShipProofName.value:"Electric bill/ Holding tax / Sale deep any ONE",
                              title: "Ownership Proof".tr,
                              onTap: () => profileDocsProofImageBox(context, 5),
                            ):
                            ChooseImageDocumentView(
                              image: ownerShip.value,
                              subTitle: controller.pOwnerShipProofName.value!=""?controller.pOwnerShipProofName.value:"Electric bill/ Holding tax / Sale deep any ONE",
                              title: "Ownership Proof".tr,
                              onTap: () => profileDocsProofImageBox(context, 5),
                            ),
                            ),
                          if(address_proof_type.value == "rented"&&property_owner_type.value=="My Proof" || property_owner_type.value=="Family Proof" && address_proof_type.value == "rented")
                            SizedBox(height: 20.r),
                          if(address_proof_type.value == "rented"&&property_owner_type.value=="My Proof" || property_owner_type.value=="Family Proof" && address_proof_type.value == "rented")
                            Obx(() => controller.pRentAgreement.value!=""?
                            ChooseImageDocument(
                              image: controller.pRentAgreement.value,
                              subTitle: controller.pRentAgreementName.value!=""?controller.pRentAgreementName.value: "latest 3 months",
                              title: "Rent Agreement".tr,
                              onTap: () => profileDocsProofImageBox(context, 3),
                            ):
                            ChooseImageDocumentView(
                              image: rentAgreement.value,
                              subTitle: controller.pRentAgreementName.value!=""?controller.pRentAgreementName.value: "latest 3 months",
                              title: "Rent Agreement".tr,
                              onTap: () => profileDocsProofImageBox(context, 3),
                            ),
                            ),
                          if(property_owner_type.value=="Family Proof" && address_proof_type.value == "owned"||property_owner_type.value=="Family Proof" && address_proof_type.value == "rented")
                            SizedBox(height: 20.r),
                          if(property_owner_type.value=="Family Proof" && address_proof_type.value == "owned"||property_owner_type.value=="Family Proof" && address_proof_type.value == "rented")
                            Obx(() => controller.pRelationshipProof.value!=""?
                            ChooseImageDocument(
                              image: controller.pRelationshipProof.value,
                              subTitle: controller.pRelationshipProofName.value!=""?controller.pRelationshipProofName.value:"Aadhaar/PAN/DL or Marriage certificate that shows relationship with property owner",
                              title: "Relationship proof".tr,
                              onTap: () => profileDocsProofImageBox(context, 6),
                            ):
                            ChooseImageDocumentView(
                              image: relationShip.value,
                              subTitle: controller.pRelationshipProofName.value!=""?controller.pRelationshipProofName.value:"Aadhaar/PAN/DL or Marriage certificate that shows relationship with property owner",
                              title: "Relationship proof".tr,
                              onTap: () => profileDocsProofImageBox(context, 6),
                            ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.r),
                InkWell(
                  onTap: () async{
                    if (controller.pPanCardImage.value != "" || controller.pAadhaarCardImage.value != ""
                        ||controller.pBankStatementImage.value != "" ||controller.pOwnerShipProof.value != ""
                        ||controller.pRentAgreement.value != "" ||controller.pRelationshipProof.value != ""
                        || pan.value != ""|| aadhar.value != "" || banking.value != "" || ownerShip.value != ""
                        || rentAgreement.value != "" || relationShip.value != ""
                    ) {
                      bool status = await controller.partnerPushbackDocsNetworkApi(
                          controller.customerDetails.value.data.partnerdetails.custId,
                          property_owner_type.value=="Family Proof"?2:1, address_proof_type.value);
                      if(status==true){
                        partnerPushbackDetailsTab.value = 4;
                      }
                    }else{
                      BaseController().errorSnack("Please choose all document images");
                    }
                  },
                  child: Container(
                    height: 38.r,
                    decoration: BoxDecoration(
                        color: AllColors.green,
                    ),
                    child: Center(
                      child: Text("Next",style: fontBold.copyWith(color: Colors.white),),
                    ),
                  ),
                ),
                SizedBox(height: 20.r),
              ],
            );
          },
          ),
        ),
      ),
    );
  }

  profileDocsProofImageBox(BuildContext context, type) {
    showDialog(
      context: context,
      builder: (BuildContext context,) {
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
                        controller.profileDocumentImages(false,type);
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
                        controller.profileDocumentImages(true,type);
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

class ChooseImageDocumentView extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String? subTitle;
  final String? fileName;
  final String image;
  final bool? optional;
  const ChooseImageDocumentView(
      {super.key, this.onTap, required this.title, this.subTitle, required this.image, this.optional=false, this.fileName=""});

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
              child: Container(
                height: 100.r,
                width: 150.r,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.BASE_URL+image.toString(),
                      )
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    title: "Browser Files".tr,
                    height: 22.r,
                    radius: 0,
                    onTap: onTap,
                    bgColor: AllColors.black.withOpacity(0.5),
                    background: false,
                    border: false,
                    miniFont: true,
                  ),
                ),
              ),
            )
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