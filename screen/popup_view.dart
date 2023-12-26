import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/Utils/colors.dart';
import 'package:web_app/Utils/custom_button.dart';
import 'package:web_app/Utils/text_field_module.dart';
import 'package:web_app/provider_function/logic_function.dart';

// ***************************************************************//
// ####################   PopUp Item    ##########################//
Future<bool?> popUpItem(BuildContext context, {required String itemUrl}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        backgroundColor: Colors.black,
        shadowColor: MyColor.myGreen,
        content: Container(
          height: 300,
          width: 300,
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

// ***************************************************************//
// ####################   PopUp Order    ##########################//
Future<bool?> popupOrder({
  required BuildContext context,
  required TextEditingController userNameEditingController,
  required TextEditingController userPhoneNunberEditingController,
  required TextEditingController userPostalCodeEditingController,
  required TextEditingController userAddrassEditingController,
}) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              backgroundColor: Colors.black,
              content: SizedBox(
                width: 400,
                child: Consumer<TextFieldChanger>(
                    builder: (context, value, chaild) {
                  return Column(
                    children: <Widget>[
                      custemInputField(
                          inputFieldName: "Your Name",
                          inputEditingController: userNameEditingController,
                          isNumberTypeKeybord: false,
                          isValidate: value.getUserNameValidate,
                          keyBordType: TextInputType.name),
                      custemInputField(
                          inputFieldName: "Telephone Number",
                          inputEditingController:
                              userPhoneNunberEditingController,
                          isNumberTypeKeybord: true,
                          isValidate: value.getUserTelNumberValidate,
                          keyBordType: TextInputType.number),
                      custemInputField(
                          inputFieldName: "Postal Code",
                          inputEditingController:
                              userPostalCodeEditingController,
                          isNumberTypeKeybord: true,
                          isValidate: value.getUserPostalCodeValidate,
                          keyBordType: TextInputType.number),
                      custemInputField(
                          inputFieldName: "your Address",
                          inputEditingController: userAddrassEditingController,
                          isNumberTypeKeybord: false,
                          isValidate: value.getUserAddressValidate,
                          keyBordType: TextInputType.multiline,
                          maxLine: 5),
                      reUsableButton(
                          onPressed: () {
                            value.orderSendScreen(
                                bUserNameValidate:
                                    userNameEditingController.text.isEmpty,
                                bUserTelNumberValidate:
                                    userPhoneNunberEditingController
                                        .text.isEmpty,
                                bUserPostalCodeValidate:
                                    userPostalCodeEditingController
                                        .text.isEmpty,
                                bUserAddressValidate:
                                    userAddrassEditingController.text.isEmpty);

                            if (userNameEditingController.text.isEmpty ||
                                userPhoneNunberEditingController.text.isEmpty ||
                                userPostalCodeEditingController.text.isEmpty ||
                                userAddrassEditingController.text.isEmpty) {
                              print("not ok something is wrong");
                              return;
                            }

                            Navigator.of(context).pop(true);
                          },
                          buttonName: "Send",
                          borderSideColor: MyColor.myGreen)
                    ],
                  );
                }),
              ),
            ));
