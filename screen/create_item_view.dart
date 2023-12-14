import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:web_app/Utils/colors.dart';
import 'package:web_app/Utils/text_field_module.dart';
import 'package:web_app/model/firebase_model.dart';
import 'package:web_app/model/itemjson.dart';
import 'package:web_app/provider_function/logic_function.dart';
import 'package:web_app/screen/foodItem_frame_view.dart';

class CreateItem extends StatefulWidget {
  const CreateItem({super.key});

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> with TickerProviderStateMixin {
  late AnimationController create_button_anim;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    create_button_anim =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
  }

  final itemNameController = TextEditingController();
  final itemPricesController = TextEditingController();
  final itemURLController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    create_button_anim.dispose();
    itemNameController.dispose();
    itemPricesController.dispose();
    itemURLController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColor.myGreen),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          Consumer<TextFieldChanger>(builder: (context, value, child) {
            return custemInputField(
                inputFieldName: "Item Name",
                inputEditingController: itemNameController,
                isNumberTypeKeybord: false,
                isValidate: value.bItemNameValidate,
                keyBordType: TextInputType.name);
          }),
          Consumer<TextFieldChanger>(builder: (context, value, child) {
            return custemInputField(
                inputFieldName: "Item Price",
                inputEditingController: itemPricesController,
                isNumberTypeKeybord: true,
                isValidate: value.bItemPriceValidate,
                keyBordType: TextInputType.number);
          }),
          Consumer<TextFieldChanger>(builder: (context, value, child) {
            return custemInputField(
                inputFieldName: "Item URL",
                inputEditingController: itemURLController,
                isNumberTypeKeybord: false,
                isValidate: value.bItemUrlValidate,
                keyBordType: TextInputType.multiline);
          }),
          //     Create button()
          createButton(
            buttonName: "Create",
            modifyFunction: () {
              //     set provider function

              context.read<TextFieldChanger>().itemNameChanger(
                  itemNameController.value.text.isEmpty ? true : false);

              context.read<TextFieldChanger>().itemPriceChanger(
                  itemPricesController.value.text.isEmpty ? true : false);

              context.read<TextFieldChanger>().itemUrlChanger(
                  itemURLController.value.text.isEmpty ? true : false);

              if (itemNameController.value.text.isEmpty ||
                  itemPricesController.value.text.isEmpty ||
                  itemURLController.value.text.isEmpty) {
                return;
              }

              CreateItemModule(
                  foodItem: FoodItem(
                      itemName: itemNameController.text,
                      itemPrice: int.parse(itemPricesController.text),
                      itemUrl: itemURLController.text));
              Future.delayed(const Duration(milliseconds: 200), () async {
                itemNameController.clear();
                itemPricesController.clear();
                itemURLController.clear();
              });
            },
          ), //   Create button end
          Consumer<TextFieldChanger>(
            builder: (context, value, child) {
              return Container(
                child: itemNameController.value.text.isEmpty ||
                        itemPricesController.value.text.isEmpty ||
                        itemURLController.value.text.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              child: Lottie.asset("assets/c1.json",
                                  controller: create_button_anim,
                                  height: 200,
                                  // width: 200,
                                  fit: BoxFit.cover)),
                          Text(
                            "Still Not Setup The Item",
                            style: TextStyle(color: MyColor.myOrange),
                          ),
                        ],
                      )
                    : Center(
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: FoodTile(
                              itemName: itemNameController.text,
                              itemPrice: int.parse(itemPricesController.text),
                              itemUrl: itemURLController.text),
                        ),
                      ),
              );
            },
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Padding createButton({required String buttonName, required modifyFunction}) {
    return Padding(
        padding: EdgeInsets.only(top: 40),
        child: ElevatedButton(
          onPressed: modifyFunction,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(),
              side: BorderSide(color: MyColor.myGreen, width: 4)),
          child: SizedBox(
              width: 200,
              height: 50,
              child: Center(
                  child: Text(
                buttonName,
                style: TextStyle(color: MyColor.myRed),
              ))),
        ));
  }
}
