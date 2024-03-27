import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewScreen extends StatelessWidget {
  const PdfViewScreen({super.key, required this.pdfData});
  final Uint8List pdfData;
  @override
  Widget build(BuildContext context) {
    final pdfController =
        PdfController(document: PdfDocument.openData(pdfData));
    return Container(
      child: PdfView(controller: pdfController),
    );
  }
}
