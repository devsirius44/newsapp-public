import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Global {

  static const bool TEST_MODE = true;
  static const bool OFFLINE_MODE = false;

  static hideSoftKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color.fromRGBO(30, 30, 30, 0.6),
        textColor: Colors.white
    );
  }

  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static List<String> markTableTempList = [
    'Template1',
    'Template2',
    'Template3',
    'Template4',
    'Template5'
  ];

  static List<String> languageList = ['English', 'Arabic'];

}