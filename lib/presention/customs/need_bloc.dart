import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../resorces/color_app.dart';


class NeedBloc{
  static showshowSnackBar(String msg) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorManager.appbarColor,
      textColor: Colors.white,
      fontSize: 16.0,
  );

}