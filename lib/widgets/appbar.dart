import 'package:ConnecTen/utils/assets.dart';
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
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 30),
        child: SizedBox(
          width: screenWidth!*0.19,
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight!*0.045, bottom: screenHeight!*0.035),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: AppColor.cardcolor.withOpacity(0.5),
  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.black,
                      foregroundImage: AssetImage(ImageAsset.coinlogo, ),
                    ),
                  ),
                  Text("1234", style: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                  ),),
                ],
              )
            ),
          ),
        ),
      )
    ],
  );
}