import 'package:cloud_firestore/cloud_firestore.dart';

class FoodItem {
  late String id;
  late String? collectionPath;
  late final String itemName;
  late final int itemPrice;
  late final String itemUrl;
  late Timestamp? timestamp;
  FoodItem({
    this.id = "",
    this.collectionPath = "",
    required this.itemName,
    required this.itemPrice,
    required this.itemUrl,
    this.timestamp,
  });
// send json
  Map<String, dynamic> toJson() => {
        "id": id,
        "collectionPath": collectionPath,
        "itemName": itemName,
        "itemPrice": itemPrice,
        "itemUrl": itemUrl,
        // "timeStamp": FieldValue.serverTimestamp(),
      };

  factory FoodItem.fromMap(Map<String, dynamic> data) {
    return FoodItem(
      id: data["id"],
      collectionPath: data["collectionPath"],
      itemName: data["itemName"],
      itemPrice: data["itemPrice"],
      itemUrl: data["itemUrl"],
      //  timestamp: data["timeStamp"],
    );
  }
}
