import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:web_app/Utils/colors.dart';
import 'package:web_app/Utils/custom_button.dart';
import 'package:web_app/firebase/firebase_userOrder.dart';
import 'package:web_app/model/food.dart';
import 'package:web_app/model/user_order.dart';
import 'package:web_app/provider_function/logic_function.dart';
import 'package:web_app/screen/foodItems_view.dart';
import 'package:web_app/screen/popup_view.dart';
import 'package:web_app/widgets/reusable_widget.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _CartViewState();
}

class _CartViewState extends State<OrderView> {
  // final userNameEditingController = TextEditingController();
  // final userPhoneNunberEditingController = TextEditingController();
  // final userPostalCodeEditingController = TextEditingController();
  // final userAddrassEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // userNameEditingController.clear();
    // userPhoneNunberEditingController.clear();
    // userPostalCodeEditingController.clear();
    // userAddrassEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserOrder>>(
        stream: readUserOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          }

          if (snapshot.hasError) {
            debugPrint("orders snapshot err :: ${snapshot.hasError}");
            return Center(
                child: Text(
              "is error founded:: ${snapshot.hasError}",
              style: TextStyle(color: MyColor.myRed),
            ));
          } else if (snapshot.hasData) {
            final userOrdersData = snapshot.data!;

            return Column(children: [
              SizedBox(
                height: 400,
                child: ListView.builder(
                    itemCount: userOrdersData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final orderDetails = userOrdersData[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: orderCart(
                            userID: orderDetails.userid,
                            userName: orderDetails.userName,
                            telephoneNumber: orderDetails.userPhoneNumber,
                            userPostalCode: orderDetails.userPostalCode,
                            userAddress: orderDetails.userAddruss,
                            itemPrice: orderDetails.userTotalPrice,
                            orders: orderDetails.userOrders),
                      );
                    }),
              )
            ]);
          }

          return isItemOrder();
        });
  }
// ***************************************************************//
// ####################   Order Cart    ##########################//

  Widget isItemOrder() {
    return SizedBox(
      height: 500,
      child: Card(
        color: Colors.transparent,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Lottie.asset("assets/wating.json",
                  height: 200, width: 200, fit: BoxFit.cover)),
          Text(
            "Data is Not allow",
            style: TextStyle(color: MyColor.myRed),
          ),
        ]),
      ),
    );
  }

// ***************************************************************//
// ####################   Order Cart    ##########################//
  Widget orderCart({
    required String userID,
    required String userName,
    required int telephoneNumber,
    required int userPostalCode,
    required String userAddress,
    required int itemPrice,
    required List<FoodItem> orders,
  }) {
    return InkWell(
      onTap: () {
        orderDetails(
          context: context,
          itemViewr: gridItemViewr(
              crossAxisItemsCount: 3,
              scrollDirectionAxis: Axis.vertical,
              itemLength: orders),
          nameWidget: titleSubtitle(
              title: "Name",
              subTitle: userName,
              icon: const Icon(Icons.account_circle)),
          telPhoneWidget: titleSubtitle(
              title: "Phone Number",
              subTitle: "$telephoneNumber",
              icon: const Icon(Icons.phone)),
          addressWidget: titleSubtitle(
              title: "Address",
              subTitle: "$userPostalCode \n $userAddress",
              icon: const Icon(Icons.location_on)),
        );
      },
      child: SizedBox(
        height: 120,
        child: Card(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(color: MyColor.myGreen, fontSize: 15),
                    ),
                    Text(
                      "$telephoneNumber",
                      style: TextStyle(color: MyColor.myGreen, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Text(
                "$itemPrice 円",
                style: TextStyle(color: MyColor.myGreen, fontSize: 15),
              ),
              IconButton(
                  onPressed: () {
                    // context
                    //     .read<OrderFoodItems>()
                    //     .removeOrder(orderIndex: nOrderIndex);
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: MyColor.myRed,
                    size: 50,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// ***************************************************************//
// ###################   Total Price    ##########################//
// Widget totalPrice(
//     {required OrderFoodItems value, required VoidCallback onPressed}) {
//   return SizedBox(
//     height: 100,
//     child: Card(
//       color: Colors.transparent,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text(
//             "Total Price ",
//             style: TextStyle(color: MyColor.myOrange, fontSize: 30),
//           ),
//           Text(
//             "${value.getTotalPrice} 円",
//             style: TextStyle(color: MyColor.myGreen, fontSize: 30),
//           ),
//           reUsableButton(
//               onPressed: onPressed,
//               buttonName: "Order",
//               borderSideColor: MyColor.myRed),
//         ],
//       ),
//     ),
//   );
// }
