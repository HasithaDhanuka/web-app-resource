import 'package:flutter/material.dart';
import 'package:web_app/firebase/firebase_userOrder.dart';
import 'package:web_app/widgets/userOrderCart.dart';

class DeleteHistoryView extends StatefulWidget {
  const DeleteHistoryView({super.key});

  @override
  State<DeleteHistoryView> createState() => _DeleteHistoryViewState();
}

class _DeleteHistoryViewState extends State<DeleteHistoryView> {
  @override
  // bool isDeleteHistoryView = false;
  Widget build(BuildContext context) {
    return UserOrderCarts(
      tittleName: "Delete History View",
      streamer: readDeleteHistoryOrders(),
      collectionPath: "removeOrders",
    );
  }
}
