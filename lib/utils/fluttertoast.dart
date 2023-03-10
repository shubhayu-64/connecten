import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ConnecTen/utils/colors.dart';

Future<bool?> toastWidget(String text){
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: AppColor.buttoncolor,
      textColor: Colors.white,
      fontSize: 18
  );
}