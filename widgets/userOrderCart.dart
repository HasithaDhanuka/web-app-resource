import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:web_app/Utils/colors.dart';
import 'package:web_app/Utils/timedate_conventer.dart';
import 'package:web_app/Utils/view_wrapper.dart';
import 'package:web_app/firebase/firebase_userOrder.dart';
import 'package:web_app/model/food.dart';
import 'package:web_app/model/user_order.dart';
import 'package:web_app/provider_function/logic_function.dart';
import 'package:web_app/screen/foodItems_view.dart';
import 'package:web_app/screen/popup_view.dart';
import 'package:web_app/widgets/reusable_widget.dart';
import 'package:web_app/widgets/rounded_border.dart';

class UserOrderCarts extends StatefulWidget {
  const UserOrderCarts({
    super.key,
    required this.tittleName,
    required this.streamer,
    required this.collectionPath,
  });
  final String tittleName;
  final String collectionPath;
  final Stream<List<UserOrder>> streamer;
  @override
  State<UserOrderCarts> createState() => _UserOrderCartsState();
}

class _UserOrderCartsState extends State<UserOrderCarts> {
  final userPhoneNunberEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    userPhoneNunberEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserOrder>>(
        stream: widget.streamer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive(
              strokeWidth: 4,
              semanticsLabel: "Lording",
            );
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

            context
                .read<UserOrdersFind>()
                .getUserOrder(ordersLength: userOrdersData.length);

            return ViewWrapper(
                desktopView: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: roundedBorder(
                      height: null,
                      widget: orderViewSelection(
                          isSlideView: false, userOrdersData: userOrdersData),
                      title: widget.tittleName),
                ),
                mobileView: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: roundedBorder(
                      height: 300,
                      widget: orderViewSelection(
                          isSlideView: true, userOrdersData: userOrdersData),
                      title: widget.tittleName),
                ));
          } else {
            return isItemOrder();
          }
        });
  }

// ***************************************************************//
// ####################   Order View Selection    ##########################//
  Widget orderViewSelection(
      {required bool isSlideView, required List<UserOrder> userOrdersData}) {
    return isSlideView
        ? CarouselSlider.builder(
            itemCount: userOrdersData.length,
            options: CarouselOptions(
              enableInfiniteScroll: false,
              height: 300,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              autoPlay: false,
              scrollDirection: Axis.vertical,
              // autoPlayInterval: Duration(seconds: timeDuration!),
              aspectRatio: 4 / 3,
              viewportFraction: 0.3,
            ),
            itemBuilder: (context, index, realIndex) {
              final orderDetails = userOrdersData[index];

              return orderCart(
                userID: orderDetails.userid,
                userName: orderDetails.userName,
                userTelephoneNumber: orderDetails.userPhoneNumber,
                userPostalCode: orderDetails.userPostalCode,
                userAddress: orderDetails.userAddruss,
                itemPrice: orderDetails.userTotalPrice,
                timeOfOrder: orderDetails.timestamp!,
                orders: orderDetails.userOrders,
              );
            })
        : ListView.builder(
            physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: userOrdersData.length,
            itemBuilder: (BuildContext context, int index) {
              final orderDetails = userOrdersData[index];

              return orderCart(
                userID: orderDetails.userid,
                userName: orderDetails.userName,
                userTelephoneNumber: orderDetails.userPhoneNumber,
                userPostalCode: orderDetails.userPostalCode,
                userAddress: orderDetails.userAddruss,
                itemPrice: orderDetails.userTotalPrice,
                timeOfOrder: orderDetails.timestamp!,
                orders: orderDetails.userOrders,
              );
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
    required int userTelephoneNumber,
    required int userPostalCode,
    required String userAddress,
    required int itemPrice,
    required Timestamp timeOfOrder,
    required List<FoodItem> orders,
  }) {
// ***************************************************************//
// ###################   Tap ON CART    ##########################//
    return InkWell(
      onTap: () async {
        final isOrderFinished = await orderDetails(
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
              subTitle: "$userTelephoneNumber",
              icon: const Icon(Icons.phone)),
          addressWidget: titleSubtitle(
              title: "Address",
              subTitle: "$userPostalCode \n $userAddress",
              icon: const Icon(Icons.location_on)),
          userPhoneNumber: userTelephoneNumber,
          textEditingController: userPhoneNunberEditingController,
        );
        if (isOrderFinished == true) {
          //   print("order is finished :: $isOrderFinished");

          final removeDatabase = await deleteOrder(
              orderID: userID, collectionPath: widget.collectionPath);

          if (removeDatabase == true) {
            // ignore: use_build_context_synchronously
            isSuccessPopup(
                context: context,
                title: "Order Remove Success",
                msg: "This Order Is Remove In The Data Base",
                function: () {},
                isSuccess: removeDatabase!);

            debugPrint("Order is finished :: $isOrderFinished");
          } else {
            // ignore: use_build_context_synchronously
            isSuccessPopup(
                context: context,
                title: "ERROR",
                msg: "Cannot Remove This Order",
                function: () {},
                isSuccess: false);
          }
        }
      },
      // ***************************************************************//
      // ##################   Design of Order Cart  ####################//
      child: Slidable(
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              ///*************************************************************************************** */

              onTapDrag(
                context,
                userTelephoneNumber: userTelephoneNumber,
                userPhoneNunberEditingController:
                    userPhoneNunberEditingController,
                userID: userID,
                collectionPath: widget.collectionPath,
              );
            },
            backgroundColor: MyColor.myRed,
            foregroundColor: MyColor.myWhite,
            icon: Icons.delete,
            label: 'Delete',
          )
        ]),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Name : $userName",
                        style: TextStyle(color: MyColor.myGreen, fontSize: 15),
                      ),
                      Text(
                        "TP    : $userTelephoneNumber",
                        style: TextStyle(color: MyColor.myGreen, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Date - ${TimeDateConventor().date(timeStamp: timeOfOrder)}\nTime - ${TimeDateConventor().time(timeStamp: timeOfOrder)}\n$itemPrice 円",
                      style: TextStyle(color: MyColor.myGreen, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void onTapDrag(
  BuildContext context, {
  required int userTelephoneNumber,
  required TextEditingController userPhoneNunberEditingController,
  required String userID,
  required String collectionPath,
}) async {
  final isOrderFinished = await orderFinished(
      context: context,
      userPhoneNumber: userTelephoneNumber,
      textEditingController: userPhoneNunberEditingController);

  if (isOrderFinished == true) {
    final removeDatabase =
        await deleteOrder(orderID: userID, collectionPath: collectionPath);

    if (removeDatabase == true) {
      print("remove Done");
    }

    // print("context 01");
    // if (removeDatabase == true) {
    //   print("context 02");
    //   // ignore: use_build_context_synchronously
    //    isSuccessPopup(
    //       context: context,
    //       title: "Order Remove Success",
    //       msg: "This Order Is Remove In The Data Base",
    //       function: () {},
    //       isSuccess: removeDatabase!);
    // } else {
    //   // ignore: use_build_context_synchronously
    //   isSuccessPopup(
    //       context: context,
    //       title: "ERROR",
    //       msg: "Cannot Remove This Order",
    //       function: () {},
    //       isSuccess: false);
    // }
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
