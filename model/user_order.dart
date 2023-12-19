class UserOrder {
  late String userid;
  late final String userName;
  late final int userTotalPrice;
  late int userPhoneNumber;
  late final List<String> userOrders;

  UserOrder(
      {this.userid = "",
      required this.userName,
      required this.userTotalPrice,
      required this.userPhoneNumber,
      required this.userOrders});

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "userName": userName,
        "userTotalPrice": userTotalPrice,
        "userPhoneNumber": userPhoneNumber,
        "userOrders": userOrders,
      };

  factory UserOrder.fromMap(Map<String, dynamic> data) {
    return UserOrder(
      userid: data["userid"],
      userName: data["userName"],
      userTotalPrice: data["userTotalPrice"],
      userPhoneNumber: data["userPhoneNumber"],
      userOrders: data["userOrders"],
    );
  }
}
