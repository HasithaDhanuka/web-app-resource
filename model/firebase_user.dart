//*****************************************************************************
//   Create Food Item
//*****************************************************************************
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/model/user_order.dart';

Future createOrderModule({required UserOrder userOrder}) async {
  final collection = FirebaseFirestore.instance.collection("userOrders");

  // QuerySnapshot itemCount = await collection.get();
  // newItem = itemCount.size + 1;

  final getDoctItem = collection.doc();
  userOrder.userid = getDoctItem.id;
  final setJson = userOrder.toJson();
  await getDoctItem.set(setJson);
}
