import 'package:web_app/model/food.dart';

class UserOrder {
  late String userid;
  late final String userName;
  late final String userAddruss;
  late final int userPostalCode;
  late final int userTotalPrice;
  late int userPhoneNumber;
  late final List<FoodItem> userOrders;

  UserOrder({
    this.userid = "",
    required this.userName,
    required this.userAddruss,
    required this.userPostalCode,
    required this.userTotalPrice,
    required this.userPhoneNumber,
    required this.userOrders,
  });

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "userName": userName,
        "userAddruss": userAddruss,
        "userPostalCode": userPostalCode,
        "userTotalPrice": userTotalPrice,
        "userPhoneNumber": userPhoneNumber,
        "userOrders": userOrders.map((e) => e.toJson()).toList(),

        //   userOrders.map((e) => e.toJson()).toList(),
      };

  factory UserOrder.fromMap(Map<String, dynamic> data) {
    return UserOrder(
      userid: data["userid"],
      userName: data["userName"],
      userAddruss: data["userAddruss"],
      userPostalCode: data["userPostalCode"],
      userTotalPrice: data["userTotalPrice"],
      userPhoneNumber: data["userPhoneNumber"],
      userOrders: List<FoodItem>.from(
          data["userOrders"].map((item) => FoodItem.fromMap(item))),
    );
  }
}


// .forEach((v) {
//           final orders = <FoodItem>[];
//           orders.add(FoodItem.fromMap(v));
//           print(orders[1]);
//         })






// class User {
//   String userid;
//   String userName;
//   String userAddruss;
//   int userPostalCode;
//   double userTotalPrice;
//   int userPhoneNumber;
//   List<UserOrder> userOrders;

//   User({
//     required this.userid,
//     required this.userName,
//     required this.userAddruss,
//     required this.userPostalCode,
//     required this.userTotalPrice,
//     required this.userPhoneNumber,
//     required this.userOrders,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

//   Map<String, dynamic> toJson() => _$UserToJson(this);
// }

// @JsonSerializable()
// class UserOrder {
//   String id;
//   String itemName;
//   double itemPrice;
//   String itemUrl;

//   UserOrder({
//     required this.id,
//     required this.itemName,
//     required this.itemPrice,
//     required this.itemUrl,
//   });

//   factory UserOrder.fromJson(Map<String, dynamic> json) =>
//       _$UserOrderFromJson(json);

//   Map<String, dynamic> toJson() => _$UserOrderToJson(this);
// }



