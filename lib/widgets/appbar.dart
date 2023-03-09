import 'package:flutter/material.dart';
import 'package:ConnecTen/utils/colors.dart';
import 'package:ConnecTen/utils/size_config.dart';

Widget CustomAppbar(BuildContext context){
  return AppBar(
    toolbarHeight: screenHeight! * 0.12,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    shadowColor: AppColor.primarybgcolor,
    elevation: 0.0,
    leading: Builder(
      builder: (context) => IconButton(
        splashRadius: 1,
        padding: const EdgeInsets.fromLTRB(30, 40, 0, 25),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(Icons.menu, color: AppColor.arrowcolor),
        alignment: Alignment.centerLeft,
      ),
    ),
  );
}