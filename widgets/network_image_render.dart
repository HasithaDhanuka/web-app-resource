import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
import 'dart:html' as html;

class NetImageView extends StatelessWidget {
  const NetImageView({super.key, required this.imgURL, this.onTap});

  final String imgURL;

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory(
        imgURL,
        (int _) => html.ImageElement()
          ..src = imgURL
          ..style.width = "100%"
          ..style.height = "100%"
          ..style.objectFit = "cover"
        //..onClick.listen((_) => onTap!()),
        );
    return InkWell(
      onTap: onTap,
      child: Stack(children: [
        HtmlElementView(viewType: imgURL),
        Container(
          color: Colors.transparent,
        ),
      ]),
    );
  }
}
