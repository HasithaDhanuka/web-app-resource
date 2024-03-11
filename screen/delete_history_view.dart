import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/Utils/colors.dart';
import 'package:web_app/firebase/firebase_userOrder.dart';
import 'package:web_app/provider_function/logic_function.dart';
import 'package:web_app/widgets/userOrderCart.dart';

class DeleteHistoryView extends StatefulWidget {
  const DeleteHistoryView({super.key});

  @override
  State<DeleteHistoryView> createState() => _DeleteHistoryViewState();
}

class _DeleteHistoryViewState extends State<DeleteHistoryView> {
  bool isShowDeleteUserHistory = false;
  @override
  // bool isDeleteHistoryView = false;
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   "Delete Income Order IS ${context.watch<DeleteOrdersIncome>().getTotalPrice}",
        //   style: TextStyle(color: MyColor.myOrange),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "User Order Delete History ",
              style: TextStyle(
                  color: MyColor.myOrange, fontWeight: FontWeight.bold),
            ),
            Switch(
                value: isShowDeleteUserHistory,
                onChanged: (value) {
                  setState(() {
                    isShowDeleteUserHistory = value;
                  });
                }),
          ],
        ),
        isShowDeleteUserHistory
            ? UserOrderCarts(
                isRequiredCount: false,
                tittleName: "Delete History View",
                streamer: readDeleteHistoryOrders(),
                collectionPath: "removeOrders",
              )
            : Container(),
      ],
    );
  }
}
