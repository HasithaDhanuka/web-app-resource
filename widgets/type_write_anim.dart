import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:web_app/Utils/colors.dart';

//import 'package:typewritertext/typewritertext.dart';

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




// Widget typeWriteAnim({required String inputAnimText}) {
//   final textController = TypeWriterController(
//     text: inputAnimText,
//     duration: const Duration(milliseconds: 50),
//   );
//   return TypeWriter(
//       controller: textController,
//       builder: (context, value) {
//         return Text(
//           maxLines: 5,
//           overflow: TextOverflow.visible,
//           textAlign: TextAlign.start,
//           value.text,
//           style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w300,
//               color: MyColor.myOrange),
//         );
//       });
// }
