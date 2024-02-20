import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/Utils/colors.dart';
import 'package:web_app/firebase/firebase_food.dart';
import 'package:web_app/model/food.dart';
import 'package:web_app/provider_function/logic_function.dart';
import 'package:web_app/widgets/network_image_render.dart';
import 'package:web_app/widgets/text_field_module.dart';

class FoodUpdateView extends StatefulWidget {
  const FoodUpdateView({super.key, required this.foodItem});
  final FoodItem foodItem;

  @override
  State<FoodUpdateView> createState() => _FoodUpdateViewState();
}

class _FoodUpdateViewState extends State<FoodUpdateView> {
  final _itemNameController = TextEditingController();
  final _itemPriceController = TextEditingController();
  final _itemUrlController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _itemNameController.dispose();
    _itemPriceController.dispose();
    _itemUrlController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
      child: Card(
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                height: 100,
                width: 100,
                child: netImageView(imgURL: widget.foodItem.itemUrl)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  "ID :${widget.foodItem.id}",
                  style: TextStyle(color: MyColor.myRed),
                  maxFontSize: 30,
                ),
                AutoSizeText(
                  "DataBasePath :${widget.foodItem.collectionPath}",
                  style: TextStyle(color: MyColor.myRed),
                  maxFontSize: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //      Edite Button  *********************************************
                    editItemButton(
                      foodItem: widget.foodItem,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    //       Delete Button  *********************************************
                    deleteButton(
                        itemID: widget.foodItem.id,
                        collectionPath: widget.foodItem.collectionPath!),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//*****************************************************************************
//   Delete Button
//*****************************************************************************
  IconButton deleteButton(
      {required String itemID, required String collectionPath}) {
    return IconButton(
      onPressed: () {
        DeleteItem(itemID: itemID, collectionPath: collectionPath);
      },
      icon: Icon(
        Icons.delete,
        size: 50,
        color: MyColor.myRed,
      ),
    );
  }

//*****************************************************************************
//   Edit Button
//*****************************************************************************
  IconButton editItemButton({
    required FoodItem foodItem,
  }) {
    return IconButton(
      onPressed: () async {
        context.read<FoodItemProperty>().setItemProperty(
              itemName: foodItem.itemName,
              itemPrice: foodItem.itemPrice,
              itemUrl: foodItem.itemUrl,
              itemID: foodItem.id,
            );

        final itemUpdate = await itemEditeField();
        String getItemName = itemUpdate![0];
        String getItemPrice = itemUpdate[1];
        String getItemUrl = itemUpdate[2];
        if (getItemName.isEmpty && getItemPrice.isEmpty && getItemUrl.isEmpty) {
          return;
        }

        getItemName.isEmpty ? getItemName = foodItem.itemName : getItemName;
        getItemPrice.isEmpty
            ? getItemPrice = foodItem.itemPrice.toString()
            : getItemPrice;
        getItemUrl.isEmpty ? getItemUrl = foodItem.itemUrl : getItemUrl;

        EditItem(
            item_ID: foodItem.id,
            itemName: getItemName,
            itemPrice: int.parse(getItemPrice),
            itemUrl: getItemUrl,
            collectionPath: foodItem.collectionPath!);
      },
      icon: Icon(
        Icons.edit,
        color: MyColor.myGreen,
        size: 50,
      ),
    );
  }

//*****************************************************************************
//   Dialog Edit View
//*****************************************************************************{required BuildContext context}
  Future<List<String>?> itemEditeField() => showDialog<List<String>>(
        context: context,
        builder: (context) => AlertDialog(
          shadowColor: MyColor.myOrange,
          backgroundColor: Colors.black,
          title: Text(
            "Change Item Details",
            style: TextStyle(color: MyColor.myOrange),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 300,
              width: 400,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Consumer<FoodItemProperty>(
                        builder: (context, value, child) {
                      return customInputField(
                          inputFieldName: value.getItemName,
                          inputEditingController: _itemNameController,
                          isNumberTypeKeybord: false,
                          isValidate: false,
                          keyBordType: TextInputType.name);
                    }),
                    Consumer<FoodItemProperty>(
                        builder: (context, value, child) {
                      return customInputField(
                          inputFieldName: "${value.getItemPrice} ￥",
                          inputEditingController: _itemPriceController,
                          isNumberTypeKeybord: true,
                          isValidate: false,
                          keyBordType: TextInputType.number);
                    }),
                    Consumer<FoodItemProperty>(
                        builder: (context, value, child) {
                      return customInputField(
                          inputFieldName: value.getItemUrl,
                          inputEditingController: _itemUrlController,
                          isNumberTypeKeybord: false,
                          isValidate: false,
                          keyBordType: TextInputType.name);
                    }),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                List<String> itemUpdate = [
                  _itemNameController.text,
                  _itemPriceController.text,
                  _itemUrlController.text,
                ];

                Navigator.of(context).pop(itemUpdate);
                _itemNameController.clear();
                _itemPriceController.clear();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: const StadiumBorder(),
                  side: BorderSide(color: MyColor.myGreen, width: 4)),
              child: Text(
                "UPDATE",
                style: TextStyle(color: MyColor.myOrange),
              ),
            ),
          ],
        ),
      );
}
