
import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:ConnecTen/routes/app_route.dart';
import 'package:ConnecTen/routes/route_path.dart';
import 'package:ConnecTen/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:ConnecTen/utils/colors.dart';
import 'package:ConnecTen/utils/size_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        icon: const Icon(Icons.menu, color: AppColor.buttoncolor),
        alignment: Alignment.centerLeft,
      ),
    ),
    actions: [
      DisplayCoin(),
    ],
  );
}

class DisplayCoin extends ConsumerWidget {
  const DisplayCoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _databaseUser = ref.watch(userDetailsProvider);

    return _databaseUser.when(
      data: (data) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, RoutePath.routeToCoinScreen);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: SizedBox(
              // width: screenWidth!*0.19,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight!*0.045, bottom: screenHeight!*0.035),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: AppColor.cardcolor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left:5.0),
                          child: CircleAvatar(
                            radius: 11,
                            backgroundColor: AppColor.buttoncolor,
                            foregroundImage: AssetImage(ImageAsset.coinlogo, ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(data.coins.toString(), style: TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                          ),),
                        ),
                      ],
                    )
                ),
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => const Center(child: Text('Error')),
    );
  }
}
