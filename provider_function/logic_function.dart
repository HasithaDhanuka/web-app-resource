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
  late bool bItemNameValidate = false;
  late bool bItemPriceValidate = false;
  late bool bItemUrlValidate = false;

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

  int get getTotalPrice => ntotalPrice;
  List<FoodItem> get getOrderList => listOfOrder;
}

class OrderCount extends ChangeNotifier {
  int nCurrentItem = 1;
  void addItem({required int nItem}) {
    nItem++;
    nCurrentItem = nItem;
    notifyListeners();
  }

  void removeItem({int nItem = 1}) {
    nItem - nItem;
    nItem == 0 ? nItem = 1 : nItem;
    nCurrentItem = nItem;
    notifyListeners();
  }
}
