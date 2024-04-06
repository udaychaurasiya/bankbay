import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

class UserStatusTimeLine extends StatelessWidget {
  const UserStatusTimeLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lead Status time line"),
      ),
      body: Timeline.tileBuilder(
        builder: TimelineTileBuilder.fromStyle(
          contentsAlign: ContentsAlign.alternating,
          contentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.r),
              height: 90.r,
              width: Get.width/2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AllColors.lightGrey.withOpacity(0.6),
                border: Border.all(width: 1.r, color: AllColors.black.withOpacity(0.5))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Lead Stage - ',
                      style: fontBold.copyWith(color: AllColors.black, fontSize: 11.r),
                      children: [
                        TextSpan(text: 'Unassigned', style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.7), fontSize: 11.r),),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Stage - ',
                      style: fontBold.copyWith(color: AllColors.black, fontSize: 11.r),
                      children: [
                        TextSpan(text: 'Submitted', style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.7), fontSize: 11.r),),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Assigned to - ',
                      style: fontBold.copyWith(color: AllColors.black, fontSize: 11.r),
                      children: [
                        TextSpan(text: 'E100292', style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.7), fontSize: 11.r),),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Assigned by - ',
                      style: fontBold.copyWith(color: AllColors.black, fontSize: 11.r),
                      children: [
                        TextSpan(text: 'Rahul Aurora', style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.7), fontSize: 11.r),),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Assigned date - ',
                      style: fontBold.copyWith(color: AllColors.black, fontSize: 11.r),
                      children: [
                        TextSpan(text: '2024-02-22', style: fontRegular.copyWith(color: AllColors.black.withOpacity(0.7), fontSize: 11.r),),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                ],
              ),
            ),
          ),
          itemCount: 10,
        ),
      ),

      /*ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.r),
        children: [
          MyTimeLineStatus(
            isFirst: true,
            isLast: false,
            isPast: true,
            statusName: "Lead Status Hold".tr,
          ),
          MyTimeLineStatus(
            isPast: true,
            isLast: false,
            isFirst: false,
            statusName: "Lead Status Verified".tr,
          ),
          MyTimeLineStatus(
            isPast: true,
            isLast: false,
            isFirst: false,
            statusName: "Lead Status Login".tr,
          ),
          MyTimeLineStatus(
            isPast: true,
            isLast: false,
            isFirst: false,
            statusName: "Lead Status Sanctioned".tr,
          ),
          MyTimeLineStatus(
            isPast: true,
            isLast: false,
            isFirst: false,
            statusName: "Lead Status Disbursed".tr,
          ),
          MyTimeLineStatus(
            isPast: false,
            isLast: false,
            isFirst: false,
            statusName: "Lead Status Inc Approval".tr,
          ),
          MyTimeLineStatus(
            isLast: true,
            isFirst: false,
            isPast: false,
            statusName: "Lead Status Successfully".tr,
          ),
        ],
      )*/
    );
  }
}


// class MyTimeLineStatus extends StatelessWidget {
//   final String statusName;
//   final bool isFirst;
//   final bool isPast;
//   final bool isLast;
//   const MyTimeLineStatus({super.key, required this.isFirst, required this.isPast, required this.isLast, required this.statusName});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60.r,
//       child: TimelineTile(
//         isFirst: isFirst,
//         isLast: isLast,
//         beforeLineStyle: LineStyle(
//           color: isPast?AllColors.green:Colors.red.shade200,
//         ),
//         indicatorStyle: IndicatorStyle(
//           width: 20.r,
//           color: isPast?AllColors.green:Colors.red.shade200,
//           iconStyle: IconStyle(iconData: isPast? Icons.done: Icons.timelapse_outlined,fontSize: 14.r,
//             color: isPast ? AllColors.white:Colors.red,)
//         ),
//         endChild: EventCard(
//           isPast: isPast,
//           child: Text(statusName, style: fontSmall.copyWith()),
//         ),
//       ),
//     );
//   }
// }
//
// class EventCard extends StatelessWidget {
//   final bool isPast;
//   final Widget? child;
//   const EventCard({super.key, required this.isPast, this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(15.r),
//       padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 5.r),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5.r),
//         color: isPast? AllColors.green.withOpacity(0.8): Colors.red.shade300,
//       ),
//       child: child,
//     );
//   }
// }
