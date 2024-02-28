import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/model/user_order.dart';

//*****************************************************************************
//   Create Food Item Order
//*****************************************************************************

Future<bool?> createOrder({required UserOrder userOrder}) async {
  final collection = FirebaseFirestore.instance.collection("userOrders");

  final getDoctItem = collection.doc();
  userOrder.userid = getDoctItem.id;
  final setJson = userOrder.toJson();

//  print("${setJson}");
  return getDoctItem.set(setJson).then((value) {
    //   print("Order send success !");
    return true;
  }).catchError((error) {
    //   print("Oder Error");
    return false;
  });
}

//*****************************************************************************
//   Read User Food Order
//*****************************************************************************
Stream<List<UserOrder>> readUserOrders() {
  final firestoreUserOrders = FirebaseFirestore.instance
      .collection("userOrders")
      .orderBy('timeStamp')
      .snapshots();

  return firestoreUserOrders.map((snapshot) =>
      snapshot.docs.map((doc) => UserOrder.fromMap(doc.data())).toList());
}

//*****************************************************************************
//   Read Of Delete User Order
//*****************************************************************************
Stream<List<UserOrder>> readDeleteHistoryOrders() {
  final firestoreUserOrders = FirebaseFirestore.instance
      .collection("removeOrders")
      .orderBy('timeStamp')
      .snapshots();

  return firestoreUserOrders.map((snapshot) =>
      snapshot.docs.map((doc) => UserOrder.fromMap(doc.data())).toList());
}

//*****************************************************************************
//   Delete Food Item Order
//*****************************************************************************
Future<bool?> deleteOrder(
    {required String collectionPath, required String orderID}) async {
  final orderDelete =
      FirebaseFirestore.instance.collection(collectionPath).doc(orderID);

/////////               History User Order Delete                //////////
  if (collectionPath == "removeOrders") {
    print("history delete   ${collectionPath}");
    return orderDelete
        .delete()
        .then((value) => true)
        .catchError((err) => false);
  }

  final DocumentSnapshot snapshot = await orderDelete.get();
  final getOrder = snapshot.data() as Map<String, dynamic>;
  UserOrder getUserOrder = UserOrder.fromMap(getOrder);

/////////    remove Order Collection and Creating Delete History //////////
  final removeCollection =
      FirebaseFirestore.instance.collection("removeOrders").doc();
  getUserOrder.userid = removeCollection.id;

  final json = getUserOrder.toJson();

  return removeCollection.set(json).then((value) {
    return orderDelete
        .delete()
        .then((value) => true)
        .catchError((err) => false);

    //   print("Order send success !");
  }).catchError((error) {
    //   print("Oder Error");
    return false;
  });
}
