import 'package:flutter/material.dart';
import 'package:web_app/model/food.dart';

class FoodItemProperty extends ChangeNotifier {
  late String getItemName;
  late int getItemPrice;
  late String getItemUrl;
  late String getItemID;

  void setItemProperty({
    required String itemName,
    required int itemPrice,
    required String itemUrl,
    required String itemID,
    // required Future Allet,
  }) {
    getItemName = itemName;
    getItemPrice = itemPrice;
    getItemUrl = itemUrl;
    getItemID = itemID;

    notifyListeners();
  }
}

// *****************************************************************
// ##################    TEXT FIELD   ##############################
class TextFieldChanger extends ChangeNotifier {
  bool bItemNameValidate = false;
  bool bItemPriceValidate = false;
  bool bItemUrlValidate = false;

  bool getUserNameValidate = false;
  bool getUserTelNumberValidate = false;
  bool getUserPostalCodeValidate = false;
  bool getUserAddressValidate = false;

  void itemNameChanger(bool nameValidate) {
    bItemNameValidate = nameValidate;
    notifyListeners();
  }

  void itemPriceChanger(bool priceValidate) {
    bItemPriceValidate = priceValidate;
    notifyListeners();
  }

  void itemUrlChanger(bool urlValidate) {
    bItemUrlValidate = urlValidate;
    notifyListeners();
  }

  void orderSendScreen({
    bool bUserNameValidate = false,
    bool bUserTelNumberValidate = false,
    bool bUserPostalCodeValidate = false,
    bool bUserAddressValidate = false,
  }) {
    getUserNameValidate = bUserNameValidate;
    getUserTelNumberValidate = bUserTelNumberValidate;
    getUserPostalCodeValidate = bUserPostalCodeValidate;
    getUserAddressValidate = bUserAddressValidate;

    notifyListeners();
  }
}

// *****************************************************************
// ##################    ORDER CART   ##############################
class OrderFoodItems extends ChangeNotifier {
  late List<FoodItem> listOfOrder = [];
  int ntotalPrice = 0;
  void getOrder({required FoodItem foodItem}) {
    listOfOrder.add(foodItem);

    notifyListeners();
  }

  void removeOrder({required int orderIndex}) {
    ntotalPrice = ntotalPrice - listOfOrder[orderIndex].itemPrice;
    listOfOrder.removeAt(orderIndex);

    notifyListeners();
  }

  void currentPrice({required int currentPrice}) {
    ntotalPrice = ntotalPrice + currentPrice;

    notifyListeners();
  }

  void orderListClear() {
    listOfOrder.clear();
    // print(listOfOrder.length);
    //  print(listOfOrder);
    notifyListeners();
  }

  int get getTotalPrice => ntotalPrice;
  List<FoodItem> get getOrderList => listOfOrder;
}

// *****************************************************************
// ##################    USER  ORDERS   ############################

class UserOrdersFind extends ChangeNotifier {
  int lengthOfOrders = 0;
  Future<int> getUserOrder({required int ordersLength}) async {
    lengthOfOrders = await ordersLength;
    //  print("order length is ::${lengthOfOrders}");
    notifyListeners();
    return lengthOfOrders;
  }

  int get totalOrdersCount => lengthOfOrders;
}

class GetImgLocal extends ChangeNotifier {
  late String imgpath = "";
  String pickupImg({required String imgPath}) {
    imgpath = imgPath;

    notifyListeners();
    return imgpath;
  }

  //XFile get getImgPath => imgLocation!;
}
