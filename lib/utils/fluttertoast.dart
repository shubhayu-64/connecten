import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ConnecTen/utils/colors.dart';

Future<bool?> toastWidget(String text){
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColor.googlegrey,
      textColor: Colors.white,
      fontSize: 14);
}