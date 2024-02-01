import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:web_app/Utils/colors.dart';

import 'package:web_app/Utils/view_wrapper.dart';
import 'package:web_app/Animation/bullet_list.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView>
    with SingleTickerProviderStateMixin {
  late double screenWidth;
  late double screenHeight;

  static const String contactYouSinhala =
      "ඔන්ලයින් ඇනවුමක්  යැවීමෙන් පසුව අපි ඔබව  සම්බන්ඳ කරගන්නෙමු.";
  static const String contactYouJapanese = "ネット注文後、ご連絡させていただきます。";
  static const String aboutContactNumberSinhala =
      "ඔන්ලයින් ඇනවුමකදී දැනට භාවිතයේ පවතින දුරකථන අංකය පමණක් බාවිතාකරන්න.";
  static const String aboutContactNumberJapanese =
      "オンラインでご注文の際は、現在使用されている電話番号のみをご使用ください。";

  static const String japanese = "松山市内で配達しています。オーダーから200円ご利用頂きます。";
  static const String sinhala =
      "අපි Matsuyama නගරය තුළ බෙදාහරින්නෙමු. ඇණවුමෙන් යෙන් 200 ක් අය කෙරේ.";
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return ViewWrapper(
      desktopView: desktopView(),
      mobileView: mobileView(),
    );
  }

  // ###########################################################################
//  ********************       Desktop View Of About   ************************
  Widget desktopView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 3,
          child: infoSection(),
        ),
        const Spacer(
          flex: 1,
        ),
        const Expanded(
            flex: 3,
            child: BulletList(
              strings: [
                contactYouSinhala,
                contactYouJapanese,
                sinhala,
                japanese,
                aboutContactNumberSinhala,
                aboutContactNumberJapanese
              ],
            ))
      ],
    );
  }

// ###########################################################################
//  ********************       Mobile View Of About   ************************
  Widget mobileView() {
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.05,
        ),
        infoSection(),
        SizedBox(
          height: screenHeight * 0.01,
        ),
      ],
    );
  }

  Widget infoSection() {
    return Container(
      width: screenWidth * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          profilePicture(),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          infoText(),
        ],
      ),
    );
  }

  Widget profilePicture() {
    return Container(
      height: getImageSize(),
      width: getImageSize(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(getImageSize() / 2),
        child: Container(
          color: Colors.grey,
          child: Center(
              child: Lottie.asset("assets/elepent.json",
                  //controller: create_button_anim,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }

  double getImageSize() {
    if (screenWidth > 1600 && screenHeight > 800) {
      return 350;
    } else if (screenWidth > 1300 && screenHeight > 600) {
      return 300;
    } else if (screenWidth > 1000 && screenHeight > 400) {
      return 200;
    } else {
      return 150;
    }
  }

  Widget infoText() {
    return Text("$japanese \n\n$sinhala",
        style: TextStyle(color: MyColor.myYellow), overflow: TextOverflow.clip);
  }
}
