import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/emp_partner_view_list.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_details.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_details_home.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_push_back_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DirectRequestScreen extends StatefulWidget {
  const DirectRequestScreen({super.key});

  @override
  State<DirectRequestScreen> createState() => DirectRequestScreenState();
}

class DirectRequestScreenState extends State<DirectRequestScreen> {
    var controller = Get.find<LoginController>();

  @override
  void initState() {
    controller.employeeApproveNetworkApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.lightBlue.withOpacity(0.1),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            margin: EdgeInsets.only(top: 20.r,left: 10.r, right: 10.r,bottom: 50.r),
            padding: EdgeInsets.symmetric(horizontal: 10.0.r),
            color: Colors.white,
            child: GetBuilder<LoginController>(
              builder: (controller){
                return Column(
                  children: [
                    controller.employee_approve_loader.value?
                    ListView.builder(
                        itemCount: controller.employee_approve_model.value.data.empdata.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding:  controller.employee_approve_model.value.data.empdata.isNotEmpty?EdgeInsets.only(top: 10.r):EdgeInsets.zero,
                        itemBuilder: (context, index){
                          var empApproveData = controller.employee_approve_model.value.data.empdata[index];
                          return Container(
                            margin: EdgeInsets.only(top: index==0?0:5.r),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.r, color: AllColors.lightGrey)
                            ),
                            child: Container(
                              margin: EdgeInsets.only(top: index==0?0:8.r),
                              padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 3.r),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1.r, color: AllColors.lightGrey)
                              ),
                              child: EmpPartnerViewCard(
                                userId: empApproveData.eid??"NA",
                                title: "${empApproveData.empFname??"NA"} ${empApproveData.empLname??""}",
                                profileImage: empApproveData.docProfilePic??"NA",
                                address: empApproveData.empPresentAddress??"NA",
                                expireDate: empApproveData.empJoinDate??"NA",
                                preDate: empApproveData.empCreateDatetime??"NA",
                                star: true,
                                onTap: (){
                                  employeePushBackDetailsTab.value = 1;
                                  employeeDetailsTab.value = 1;
                                  Get.to(()=>EmployeeDetailsHome(pageName: "employeeApproved", employeeId: empApproveData.eid.toString()));
                                },
                              ),
                            ),
                          );
                        }) :
                    ListView.builder(
                        itemCount: 8,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10.r),
                        itemBuilder: (context, index){
                          return Container(
                            margin: EdgeInsets.only(top: index==0?0:10.0.r),
                            padding: EdgeInsets.symmetric(horizontal: 5.0.r,vertical: 10.r),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.r, color: AllColors.lightGrey)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  enabled: true,
                                  child: CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: AllColors.white,
                                  ),
                                ),
                                SizedBox(width: 10.r),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  width: 150.r,
                                                  height: 12.r,
                                                  color: AllColors.white,
                                                  margin: EdgeInsets.only(right: 5.r),
                                                ),
                                              ),
                                              SizedBox(height: 5.r),
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  width: 80.r,
                                                  height: 10.r,
                                                  color: AllColors.white,
                                                  margin: EdgeInsets.only(right: 5.r),
                                                ),
                                              ),
                                              SizedBox(height: 5.r),
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  width: 135.r,
                                                  height: 10.r,
                                                  color: AllColors.white,
                                                  margin: EdgeInsets.only(right: 5.r),
                                                ),
                                              ),
                                              SizedBox(height: 5.r),
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  width: 110.r,
                                                  height: 10.r,
                                                  color: AllColors.white,
                                                  margin: EdgeInsets.only(right: 5.r),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.grey.shade100,
                                            enabled: true,
                                            child: Icon(Icons.star_border_outlined, size: 25.r, color: AllColors.grey,)
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    Obx(() => controller.employee_approve_model.value.message.toString()=="Data Not Found."?
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: Get.height/2.85),
                        child: Text("Data not found !!", style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6)),),
                      ):const SizedBox(),
                    ),
                    if(controller.employee_approve_model.value.message.toString()!="Data Not Found.")
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0.r),
                        child: Text("Hooray !!! All Caught up", style: fontRegular.copyWith(color: AllColors.grey),),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
