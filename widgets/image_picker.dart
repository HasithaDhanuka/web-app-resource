import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<XFile?> getImageLocal() async {
  late final XFile? imgFile;

  print("function entering of Img picker");
  final ImagePicker picker = ImagePicker();

  //  kIsWeb?await picker.pickImage(source: ImageSource.gallery):
  var permissionStatus = Permission.photos.request();

  // MOBILE
  if (!kIsWeb && await permissionStatus.isGranted) {
    final ImagePicker _picker = ImagePicker();
    imgFile = await _picker.pickImage(source: ImageSource.gallery);
  } else {
    imgFile = (await picker.pickImage(source: ImageSource.gallery))!;
    print("deskop web");
  }
  // if (kIsWeb) {
  //   imgFile = (await picker.pickImage(source: ImageSource.gallery))!;
  //   print("deskop web");
  // } else {
  //   var permissionState = await Permission.photos.request();
  //   if (permissionState.isGranted) {
  //     imgFile = await picker.pickImage(source: ImageSource.gallery);
  //     print("mobile web");
  //   } else {
  //     print("err");
  //   }
  // }
  return imgFile;
}






// class ImagePicking extends StatefulWidget {
//   const ImagePicking({super.key});

//   @override
//   State<ImagePicking> createState() => _ImagePickingState();
// }

// class _ImagePickingState extends State<ImagePicking> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
