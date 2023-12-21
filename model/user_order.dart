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
      };

  factory UserOrder.fromMap(Map<String, dynamic> data) {
    return UserOrder(
      userid: data["userid"],
      userName: data["userName"],
      userAddruss: data["userAddruss"],
      userPostalCode: data["userPostalCode"],
      userTotalPrice: data["userTotalPrice"],
      userPhoneNumber: data["userPhoneNumber"],
      userOrders: data["userOrders"],
    );
  }
}
