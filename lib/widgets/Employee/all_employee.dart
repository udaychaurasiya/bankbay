import 'package:bank_bay/controllers/login_controller.dart';
import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/emp_partner_view_list.dart';
import 'package:bank_bay/utils_method/loading_more_widget.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_details.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_details_home.dart';
import 'package:bank_bay/widgets/Customer%20details/Employee%20Details/employee_push_back_details.dart';
import 'package:bank_bay/widgets/Customer%20details/employee_details_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AllEmployee extends StatefulWidget {
  const AllEmployee({super.key});

  @override
  State<AllEmployee> createState() => _AllEmployeeState();
}

class _AllEmployeeState extends State<AllEmployee> {
  var controller = Get.find<LoginController>();

  @override
  void initState() {
    controller.allEmpNext = 10;
    controller.allEmployeeNetworkApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.1),
      body: SingleChildScrollView(
        controller: controller.allEmployeeController,
        child: Container(
          width: width,
          margin: EdgeInsets.only(top: 20.r,left: 10.r, right: 10.r ,bottom: 45.r),
          padding: EdgeInsets.symmetric(horizontal: 10.0.r),
          color: Colors.white,
          child: Column(
                children: [
                  GetBuilder<LoginController>(
                    builder: (controller) {
                      return controller.all_employee_loader.value?
                        ListView.builder(
                          itemCount: controller.all_employee_model.value.data.empdata.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: controller.all_employee_model.value.data.empdata.isNotEmpty?EdgeInsets.only(top: 10.r):EdgeInsets.zero,
                          itemBuilder: (context, index){
                            var allEmployeeData = controller.all_employee_model.value.data.empdata[index];
                            return Container(
                              margin: EdgeInsets.only(top: index==0?0:8.r),
                              padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 3.r),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1.r, color: AllColors.lightGrey)
                              ),
                              child:  EmpPartnerViewCard(
                                userId: allEmployeeData.eid??"NA",
                                title: "${allEmployeeData.empFname??"NA"} ${allEmployeeData.empLname??"NA"}",
                                profileImage: allEmployeeData.docProfilePic??"NA",
                                address: allEmployeeData.empPresentAddress??"NA",
                                expireDate: allEmployeeData.empJoinDate??"NA",
                                preDate: allEmployeeData.empCreateDatetime??"NA",
                                status: allEmployeeData.empStatus??"",
                                star: false,
                                onTap: (){
                                  employeePushBackDetailsTab.value = 1;
                                  employeeDetailsTab.value = 1;
                                  Get.to(()=>EmployeeDetailsHome(pageName: "allEmployee", employeeId: allEmployeeData.eid.toString()));
                                },
                                nameTap: ()=> Get.to(()=> EmployeeDetailsList(pageName: "allEmployee",employeeId: allEmployeeData.eid)),
                                // nameTap: ()=> Get.to(()=> CustomerLoanListDetails(leadId: "${data.id??""}",customerId: data.custId??"" ,apiLeadId: data.leadId)),

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
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  ),
                  Obx(() => controller.all_employee_model.value.message.toString()=="Data Not Found."?
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: Get.height/2.85),
                      child: Text("Data not found !!", style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.6)),),
                    ) : const SizedBox(),
                  ),
                  if(controller.all_employee_model.value.message.toString()!="Data Not Found.")
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0.r),
                      child: Text("Hooray !!! All Caught up", style: fontRegular.copyWith(color: AllColors.grey),),
                    ),
                  Obx(() => controller.isLoadMore.value? const LoadingMoreData():const SizedBox()),
                ],
              ),
        ),
      ),
    );
  }
}
