import 'package:bank_bay/style/colors.dart';
import 'package:bank_bay/style/text_style.dart';
import 'package:bank_bay/utils_method/custom_appbar.dart';
import 'package:bank_bay/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CookiePolicyScreen extends StatelessWidget {
  const CookiePolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController listScrollController = ScrollController();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          55.0.r,
        ),
        child: CustomAppBar(
          title: "Cookie Policy".tr,
          leadingBool: false,
          onTab: () {
            Navigator.pop(context);
            Get.off(()=> const DashboardScreen());
          },
          back: true,
          // centerTitle: true,
        ),
      ),
      body: ListView(
        controller: listScrollController,
        padding: EdgeInsets.only(left: 15.r,right: 10.r),
        children: [
            SizedBox(height: 10.r),
            CookieDetails(
              title: "What are cookies?".tr,
              value: "Cookies are small data files that are placed on your computer or mobile device when you visit a website. Cookies are widely used by website owners in order to make their websites work, or to work more efficiently, as well as to provide reporting information."
                  "Cookies set by the website owner (in this case, Bankbay Fintech Private Limited) are called \"first-party cookies.\" Cookies set by parties other than the website owner are called 'third-party cookies.' "
                  "Third-party cookies enable third-party features or functionality to be provided on or through the website (e.g., advertising, interactive content, and analytics). The parties that set these third-party cookies can recognize your computer both when it visits the website in question and also when it visits certain other websites.".tr,
            ),
            SizedBox(height: 15.r),
            CookieDetails(
              title: "Why do we use cookies?".tr,
              value: "We use first- and third-party cookies for several reasons. Some cookies are required for technical reasons in order for our Website to operate, and we refer to these as \"essential\" or \"strictly necessary\" cookies. Other cookies also enable us to track and target the interests of our users to enhance the experience on our Online Properties. Third parties serve cookies through our Website for advertising, analytics, and other purposes. This is described in more detail below.",
            ),
            SizedBox(height: 15.r),
            CookieDetails(
              title: "How can I control cookies?".tr,
              value: "You have the right to decide whether to accept or reject cookies. You can exercise your cookie rights by setting your preferences in the Cookie Consent Manager. The Cookie Consent Manager allows you to select which categories of cookies you accept or reject. Essential cookies cannot be rejected as they are strictly necessary to provide you with services.\n\n"
                  "The Cookie Consent Manager can be found in the notification banner and on our website. If you choose to reject cookies, you may still use our website though your access to some functionality and areas of our website may be restricted. You may also set or amend your web browser controls to accept or refuse cookies.\n\n"
                  "The specific types of first- and third-party cookies served through our Website and the purposes they perform are described in the table below (please note that the specific cookies served may vary depending on the specific Online Properties you visit):",
            ),
            SizedBox(height: 15.r),
            CookieDetails(
              title: "How can I control cookies on my browser?".tr,
              value: "As the means by which you can refuse cookies through your web browser controls vary from browser to browser, you should visit your browser's help menu for more information. The following is information about how to manage cookies on the most popular browsers:",
            ),
            SizedBox(height: 10.r),
            TitleRadioButton(
              title: "Chrome".tr,
            ),
            TitleRadioButton(
              title: "Internet Explorer".tr,
            ),
            TitleRadioButton(
              title: "Firefox".tr,
            ),
            TitleRadioButton(
              title: "Safari".tr,
            ),
             TitleRadioButton(
              title: "Edge".tr,
            ),
            TitleRadioButton(
              title: "Opera".tr,
            ),
            CookieDetails(
              value: "In addition, most advertising networks offer you a way to opt out of targeted advertising. If you would like to find out more information, please visit:".tr,
            ),
            SizedBox(height: 10.r),
            TitleRadioButton(
              title: "Digital Advertising Alliance".tr,
            ),
            TitleRadioButton(
              title: "Digital Advertising Alliance of Canada".tr,
            ),
            TitleRadioButton(
              title: "European Interactive Digital Advertising Alliance".tr,
            ),
            SizedBox(height: 15.r),
            CookieDetails(
              title: "What about other tracking technologies, like web beacons?".tr,
              value: "Cookies are not the only way to recognize or track visitors to a website. We may use other, similar technologies from time to time, like web beacons (sometimes called 'tracking pixels\" or \"clear gifs\"). These are tiny graphics files that contain a unique identifier that enables us to recognize when someone has visited our Website or opened an email including them. This allows us, for example, to monitor the traffic patterns of users from one page within a website to another, to deliver or communicate with cookies, to understand whether you have come to the website from an online advertisement displayed on a third-party website, to improve site performance, and to measure the success of email marketing campaigns. In many instances, these technologies are reliant on cookies to function properly, and so declining cookies will impair their functioning.",
            ),
            SizedBox(height: 15.r),
            CookieDetails(
              title: "Do you use Flash cookies or Local Shared Objects?".tr,
              value: "Websites may also use so-called \"Flash Cookies\" (also known as Local Shared Objects or \"LSOs\") to, among other things, collect and store information about your use of our services, fraud prevention, and for other site operations. "
                  "\n\nIf you do not want Flash Cookies stored on your computer, you can adjust the settings of your Flash player to block Flash Cookies storage using the tools contained in the Website Storage Settings Panel. You can also control Flash Cookies by going to the Global Storage Settings Panel and following the instructions (which may include instructions that explain, for example, how to delete existing Flash Cookies (referred to \"information \" on the Macromedia site), how to prevent Flash LSOs from being placed on your computer without your being asked, and (for Flash Player 8 and later) how to block Flash Cookies that are not being delivered by the operator of the page you are on at the time)."
                  "Please note that setting the Flash Player to restrict or limit acceptance of Flash Cookies may reduce or impede the functionality of some Flash applications, induding, potentially, Flash applications used in connection with our services or online content.",
            ),
            SizedBox(height: 15.r),
            CookieDetails(
              title: "Do you serve targeted advertising?".tr,
              value: "Third parties may serve cookies on your computer or mobile device to serve advertising through our Website. These companies may use information about your visits to this and other websites in order to provide relevant advertisements about goods and services that you may be interested in. They may also employ technology that is used to measure the effectiveness of advertisements. They can accomplish this by using cookies or web beacons to collect information about your visits to this and other sites in order to provide relevant advertisements about goods and services of potential interest to you. The information collected through this process does not enable us or them to identify your name, contact details, or other details that directly identify you unless you choose to provide these.",
            ),
            SizedBox(height: 15.r),
            CookieDetails(
              title: "How often will you update this Cookie Policy?".tr,
              value: "We may update this Cookie Policy from time to time in order to reflect, for example, changes to the cookies we use or for other operational, legal, or regulatory reasons. Please therefore revisit this Cookie Policy regularly to stay informed about our use of cookies and related technologies.\n\nThe date at the top of this Cookie Policy indicates when it was last updated.",
            ),
            SizedBox(height: 15.r),
            CookieDetails(
              title: "Where can I get further information?".tr,
              value: "If you have any questions about our use of cookies or other technologies, please email us at bankbayinfo@gmail.com or by post to:"
                "\n\nBankbay Fintech Private Limited Uma Bhavan, Patel Nagar, tlarmu Ranchi, Jharkhand 834002 \nIndia \nPhone: 9304804193",
            ),
            SizedBox(height: 15.r),

          ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AllColors.themeColor.withOpacity(0.8),
        onPressed: () {
          if (listScrollController.hasClients) {
            final position = listScrollController.position.maxScrollExtent;
            listScrollController.animateTo(
              position,
              duration: const Duration(seconds: 2),
              curve: Curves.easeOut,
            );
          }
        },
        isExtended: true,
        tooltip: "Scroll to Bottom",
        child: Icon(Icons.arrow_downward,size: 25.r,),
      ),
    );
  }
}

class CookieDetails extends StatelessWidget {
  final String? title;
  final String ?value;
  const CookieDetails({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null?Text(title??"", style: fontBold.copyWith(),):const SizedBox(),
        SizedBox(height: 10.r),
        Text(value.toString(), style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.7),
            fontWeight: FontWeight.w400, fontSize: 13.r),/*textAlign: TextAlign.justify,*/)
      ],
    );
  }
}

class TitleRadioButton extends StatelessWidget {
  final String title;
  const TitleRadioButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0.r),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8.r, color: AllColors.black.withOpacity(0.8),),
          SizedBox(width: 10.r),
          Text(title.toString(), style: fontSmall.copyWith(color: AllColors.black.withOpacity(0.7)),)
        ],
      ),
    );
  }
}
