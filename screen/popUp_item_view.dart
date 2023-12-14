import 'package:flutter/material.dart';
import 'package:web_app/Utils/colors.dart';
import 'package:web_app/Utils/custom_button.dart';
import 'package:web_app/Utils/text_field_module.dart';

// ***************************************************************//
// ####################   PopUp Item    ##########################//
Future popUpItem(BuildContext context, {required String itemUrl}) => showDialog(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(50.0),
        child: AlertDialog(
          backgroundColor: Colors.black,
          shadowColor: MyColor.myGreen,
          content: Container(
            decoration: BoxDecoration(
              border: Border.all(color: MyColor.myGreen),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                itemUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buttonOfPopUp(context,
                    isOrder: true,
                    borderSideColor: MyColor.myGreen,
                    buttonName: "Order"),
                buttonOfPopUp(context,
                    isOrder: false,
                    borderSideColor: MyColor.myRed,
                    buttonName: "Cancel"),
              ],
            )
          ],
        ),
      ),
    );

Widget buttonOfPopUp(BuildContext context,
    {required bool isOrder,
    required Color borderSideColor,
    required String buttonName}) {
  return reUsableButton(
    onPressed: () {
      Navigator.of(context).pop(isOrder);
    },
    buttonName: buttonName,
    borderSideColor: borderSideColor,
  );
}

Future popupOrder(
        {required BuildContext context,
        required TextEditingController inputEditingController}) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.black,
              content: Column(
                children: <Widget>[
                  custemInputField(
                      inputFieldName: "your Name",
                      inputEditingController: inputEditingController,
                      isNumberTypeKeybord: false,
                      isValidate: true,
                      keyBordType: TextInputType.name),
                  custemInputField(
                      inputFieldName: "Telephone Number",
                      inputEditingController: inputEditingController,
                      isNumberTypeKeybord: true,
                      isValidate: true,
                      keyBordType: TextInputType.number),
                  custemInputField(
                      inputFieldName: "Postal Code",
                      inputEditingController: inputEditingController,
                      isNumberTypeKeybord: true,
                      isValidate: true,
                      keyBordType: TextInputType.number),
                  custemInputField(
                      inputFieldName: "your Addruss",
                      inputEditingController: inputEditingController,
                      isNumberTypeKeybord: false,
                      isValidate: true,
                      keyBordType: TextInputType.multiline,
                      maxLine: 5),
                ],
              ),
            ));
