import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//  import 'dart:html' as html;

//##############    Canvers kit with Network Image ###############
Widget netImageView({required imgURL, onTap}) {
  return !kIsWeb
      ? InkWell(
          onTap: onTap,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imgURL,
            placeholder: (context, url) =>
                const CircularProgressIndicator.adaptive(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        )
      : InkWell(
          onTap: onTap,
          child: Image.network(
            imgURL,
            fit: BoxFit.cover,
          ),
        );
}









//########################     Some Problom founded with canvers kit    ###########################

// class NetImageView extends StatelessWidget {
//   const NetImageView({super.key, required this.imgURL, this.onTap});

//   final String imgURL;

//   final VoidCallback? onTap;
//   @override
//   Widget build(BuildContext context) {
//     ui.platformViewRegistry.registerViewFactory(
//         imgURL,
//         (int _) => html.ImageElement()
//           ..src = imgURL
//           ..style.width = "100%"
//           ..style.height = "100%"
//           ..style.objectFit = "cover"
//         //..onClick.listen((_) => onTap!()),
//         );
//     return InkWell(
//       onTap: onTap,
//       child: Stack(children: [
//         HtmlElementView(viewType: imgURL),
//         Container(
//           color: Colors.transparent,
//         ),
//       ]),
//     );
//   }
// }





