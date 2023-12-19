import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:web_app/Utils/colors.dart';
import 'package:web_app/model/food.dart';
import 'package:web_app/provider_function/logic_function.dart';
import 'package:web_app/screen/popup_view.dart';

class FoodTile extends StatelessWidget {
  const FoodTile(
      {super.key,
      required this.itemName,
      required this.itemPrice,
      required this.itemUrl});
  final String itemName;
  final int itemPrice;
  final String itemUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          header: Container(
            color: const Color.fromARGB(151, 7, 7, 7),
            height: 30,
            child: Center(
              child: AutoSizeText(
                itemName,
                maxFontSize: 15,
                style: TextStyle(
                    fontSize: 16,
                    color: MyColor.myOrange,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          footer: Container(
            height: 20,
            color: const Color.fromARGB(151, 0, 0, 0),
            child: Center(
              child: AutoSizeText(
                "$itemPrice 円",
                maxFontSize: 14,
                style: TextStyle(
                    fontSize: 14,
                    color: MyColor.myGreen, //Color.fromARGB(206, 226, 230, 6),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          child: InkResponse(
            onTap: () async {
              final orderComplete = await popUpItem(context, itemUrl: itemUrl);

              if (orderComplete == null || orderComplete == false) {
                return;
              } else {
                // ignore: use_build_context_synchronously
                context.read<OrderFoodItems>().getOrder(
                    foodItem: FoodItem(
                        itemName: itemName,
                        itemPrice: itemPrice,
                        itemUrl: itemUrl));
                // ignore: use_build_context_synchronously
                context
                    .read<OrderFoodItems>()
                    .currentPrice(currentPrice: itemPrice);
              }
            },
            child: Image.network(
              itemUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}






// class Foods extends StatelessWidget {
//   const Foods({super.key});

//   // final String foodName;
//   // final String foodPrise;


//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Container(
//             //  width: 200,
//             height: 200,
//             decoration: BoxDecoration(
//                 color: Colors.amber, borderRadius: BorderRadius.circular(18.0)),
//           ),
//         ),
//         ItemName(),
//         FoodPrise(),
//       ],
//     );
//   }

//   Widget ItemName() {
//     return AutoSizeText(
//       "Food Name XXXXXXXX",
//       style: TextStyle(fontSize: 18),
//       maxLines: 2,
//       minFontSize: 5,
//     );
//   }

//   Widget FoodPrise() {
//     return AutoSizeText(
//       "\$ xxxx",
//       style: TextStyle(fontSize: 15),
//       maxLines: 2,
//       minFontSize: 5,
//     );
//   }
// }

// class FoodTile extends StatelessWidget {
//   const FoodTile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: GridTile(
//           header: Container(
//             color: const Color.fromARGB(31, 99, 98, 98),
//             height: 30,
//             child: const Center(
//               child: Text(
//                 "Name of Item xxx",
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ),
//           footer: Container(
//             height: 20,
//             color: const Color.fromARGB(31, 105, 105, 105),
//             child: const Center(
//               child: Text(
//                 "Item price \$",
//                 style: TextStyle(fontSize: 14),
//               ),
//             ),
//           ),
//           child: Container(
//             color: Colors.amber,
//           ),
//         ),
//       ),
//     );
//   }
// }
