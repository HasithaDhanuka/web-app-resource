import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:web_app/Utils/colors.dart';

Widget typeWriteAnimKit(
    {required String inputAnimText, required int typeSpeed}) {
  return Container(
    child: DefaultTextStyle(
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w300, color: MyColor.myOrange),
      child: AnimatedTextKit(
        totalRepeatCount: 1,

        animatedTexts: [
          TypewriterAnimatedText(
            inputAnimText,
            speed: const Duration(milliseconds: 50),
          ),
        ],
        // onTap: () {
        //   print("Tap Event");
        // },
      ),
    ),
  );
}
