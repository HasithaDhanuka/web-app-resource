//*****************************************************************************
//   Create Food Item
//*****************************************************************************
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/model/user_order.dart';

Future<bool?> createOrder({required UserOrder userOrder}) async {
  final collection = FirebaseFirestore.instance.collection("userOrders");

  print("collection:: ${collection}");
  final getDoctItem = collection.doc();
  userOrder.userid = getDoctItem.id;
  final setJson = userOrder.toJson();

  print("${setJson}");
  return getDoctItem.set(setJson).then((value) {
    print("Order send success !");
    return true;
  }).catchError((error) {
    print("Oder Error");
    return false;
  });
}
