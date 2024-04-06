import 'package:bank_bay/models/get_lead_details_model.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/images.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils/app_constants.dart';
import 'package:bank_bay/utils_method/custom_image_view.dart';
import 'package:bank_bay/controllers/partner_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyLoanHistoryDetailsDocument extends StatefulWidget {
  final LeadDetailsData leadDetailsData;
  const MyLoanHistoryDetailsDocument({super.key, required this.leadDetailsData});

  @override
  State<MyLoanHistoryDetailsDocument> createState() => _MyLoanHistoryDetailsDocumentState();
}

class _MyLoanHistoryDetailsDocumentState extends State<MyLoanHistoryDetailsDocument> {
var controller = Get.find<PartnerController>();
  @override
  Widget build(BuildContext context) {
    RxString detailsOwnerValue = (widget.leadDetailsData.propertyOwnerType.toString()=="2"?"Family Proof":"My Proof").obs;
    return GetBuilder<PartnerController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(10.r),
          child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Validate Document", style: fontBold.copyWith(fontSize: 13.r),)),
                Center(child: Text("Update or Get document upload as needed", style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.6),fontStyle: FontStyle.italic),)),
                SizedBox(height: 20.r),
                LoanDetailsDocumentView(
                  title: "Borrower's Photo".tr,
                  image: widget.leadDetailsData.custLoanSelfie.toString(),
                  status: controller.getLeadDetails.value.data.custLoanSelfieVerifyStatus,
                  no: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"profile", "NOT OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                    }
                  },
                  yes: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"profile", "OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                    }
                  },
                ),
                SizedBox(height: 15.r),
                LoanDetailsDocumentView(
                  title: "Pan Card".tr,
                  image: widget.leadDetailsData.docPan.toString(),
                  status: controller.getLeadDetails.value.data.docPanVerifyStatus,
                  no: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"pan", "NOT OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                    }
                  },
                  yes:  ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"pan", "OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                    }
                  },
                ),
                SizedBox(height: 15.r),
                LoanDetailsDocumentView(
                  title: "Aadhaar (both sides)".tr,
                  subTitle: "single PDF file".tr,
                  status: controller.getLeadDetails.value.data.docAadharVerifyStatus,
                  image: widget.leadDetailsData.docAadhar.toString(),
                  no: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"aadhar", "NOT OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                    }
                  },
                  yes: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"aadhar", "OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                    }
                  },
                ),
                SizedBox(height: 15.r),
                LoanDetailsDocumentView(
                  title: "Salary Slips".tr,
                  subTitle: "latest 3 months".tr,
                  status: controller.getLeadDetails.value.data.docSalaryslipVerifyStatus,
                  image: widget.leadDetailsData.docSalaryslip.toString(),
                  no: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"salary_slip", "NOT OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                    }
                  },
                  yes: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"salary_slip", "OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                    }
                  },
                ),
                SizedBox(height: 15.r),
                LoanDetailsDocumentView(
                  title: "Bank Statement".tr,
                  subTitle: "latest 6 months".tr,
                  image: widget.leadDetailsData.docBanking.toString(),
                  status: controller.getLeadDetails.value.data.docBankingVerifyStatus,
                  no: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"bank_statement", "NOT OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                    }
                  },
                  yes: ()async{
                    bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"bank_statement", "OK");
                    if(status==true){
                      controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                    }
                  },
                  ),
                SizedBox(height: 30.r),
                Text("Property ownership Proof", style: fontBold.copyWith(),),
                SizedBox(height: 20.r),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 20.r,
                            width: 20.r,
                            child: Radio(
                              value: "My Proof",
                              groupValue: detailsOwnerValue.value,
                              onChanged: (value) {
                                detailsOwnerValue.value = value.toString();
                                print("object ${detailsOwnerValue.value}");
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
                              groupValue: detailsOwnerValue.value,
                              onChanged: (value) {
                                detailsOwnerValue.value = value.toString();
                                print("object ${detailsOwnerValue.value}");
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
                    ],
                  ),
                ),
                if(detailsOwnerValue.value=="My Proof"||detailsOwnerValue.value=="Family Proof")
                  SizedBox(height: 20.r),
                if(detailsOwnerValue.value=="My Proof"||detailsOwnerValue.value=="Family Proof")
                  LoanDetailsDocumentView(
                    title: "Ownership Proof".tr,
                    subTitle: "Electric bill/ holding tax/ Sale deed any One".tr,
                    image: widget.leadDetailsData.docOhp.toString(),
                    status: controller.getLeadDetails.value.data.docOhpVerifyStatus,
                    no: ()async{
                      bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"ownership_proof", "NOT OK");
                      if(status==true){
                        controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                      }
                    },
                    yes: ()async{
                      bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"ownership_proof", "OK");
                      if(status==true){
                        controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                      }
                    },
                    ),
                if(detailsOwnerValue.value=="Family Proof")
                  SizedBox(height: 20.r),
                if(detailsOwnerValue.value=="Family Proof")
                  LoanDetailsDocumentView(
                    title: "Relationship proof".tr,
                    subTitle: "Marriage certificate that shows relationship with property owner".tr,
                    image: widget.leadDetailsData.docRelationProof.toString(),
                    status: controller.getLeadDetails.value.data.docRelationProofVerifyStatus,
                    no: ()async{
                      bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"relationship_proof", "NOT OK");
                      if(status==true){
                        controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                      }
                    },
                    yes: ()async{
                      bool status = await controller.updateLeadDocumentStatusNetworkApi(widget.leadDetailsData.leadId,"relationship_proof", "OK");
                      if(status==true){
                        controller.getLeadDetailsNetworkApi(widget.leadDetailsData.id);
                      }
                    },
                  ),
                SizedBox(height: 20.r),
              ],
            ),
          ),
        );
      }
    );
  }
}

class LoanDetailsDocumentView extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? status;
  final String image;
  final GestureTapCallback? no;
  final GestureTapCallback? yes;
  const LoanDetailsDocumentView({super.key, required this.title, this.subTitle, required this.image, this.no, this.yes, this.status=""});
  @override
  Widget build(BuildContext context) {
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
                if(status==""||status==null)
                  SizedBox(
                    child: Text("Verification Pending",style: fontBold.copyWith(
                      color: AllColors.red.withOpacity(0.7),
                      fontSize: 13.r,
                      letterSpacing: 0.2,
                    ),
                    ),
                  ),
                if(status!=""&&status!=null)
                  if(status=="OK")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(Images.ok, height: 20.r, width: 20.r, fit: BoxFit.cover,),
                        Text("Verify",style: fontBold.copyWith(
                          color: AllColors.green,
                          fontSize: 14.r,
                          letterSpacing: 0.2,
                        ),
                        ),
                      ],
                    ),
                if(status!=""&&status!=null)
                if(status=="NOT OK")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(Images.notOk, height: 20.r, width: 20.r, fit: BoxFit.cover,),
                      SizedBox(width: 3.r),
                      Text("ReUpload",style: fontBold.copyWith(
                        color: AllColors.red.withOpacity(0.7),
                        fontSize: 14.r,
                        letterSpacing: 0.2,
                      ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
