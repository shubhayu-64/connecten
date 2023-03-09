import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/Providers/auth_providers.dart';
import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:ConnecTen/routes/route_path.dart';
import 'package:ConnecTen/utils/assets.dart';
import 'package:ConnecTen/utils/colors.dart';
import 'package:ConnecTen/utils/launch_urls.dart';
import 'package:ConnecTen/utils/size_config.dart';

import 'drawer_item.dart';

class Menu extends ConsumerWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authService = ref.watch(authServicesProvider);
    final _userDetails = ref.watch(userDetailsProvider);
    return Drawer(
      child: Material(
        color: AppColor.secbgcolor,
        child: Container(
          margin: EdgeInsets.fromLTRB(
              30, screenHeight! * 0.12, screenWidth! * 0.05, 0),
          child: Column(
            children: [
              HeaderWidget(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight! * 0.03),
                child: const Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.grey,
                ),
              ),
              DrawerItem(
                name: 'Nearby Connects',
                icon: Icons.people_rounded,
                onPressed: () => onItemPressed(context, index: 0),
              ),
              SizedBox(
                height: screenHeight! * 0.03,
              ),
              DrawerItem(
                name: 'Connections',
                icon: Icons.people,
                onPressed: () => onItemPressed(context, index: 1),
              ),
              SizedBox(
                height: screenHeight! * 0.03,
              ),
              DrawerItem(
                  name: 'Profile',
                  icon: Icons.manage_accounts,
                  onPressed: () => onItemPressed(context, index: 2)),
              SizedBox(
                height: screenHeight! * 0.03,
              ),
              DrawerItem(
                  name: 'Scan QR',
                  icon: Icons.qr_code_scanner_rounded,
                  onPressed: () => onItemPressed(context, index: 3)),

              // DrawerItem(
              //     name: 'Upcoming Events',
              //     icon: Icons.event_available,
              //     onPressed: () => onItemPressed(context, index: 3)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight! * 0.03),
                child: const Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.grey,
                ),
              ),
              DrawerItem(
                  name: 'Log out',
                  icon: Icons.logout,
                  onPressed: () {
                    _authService.signOut();
                    Navigator.pushReplacementNamed(
                        context, RoutePath.routeToLoginScreen);
                  }),

              Padding(
                padding: EdgeInsets.only(top: screenHeight! * 0.05, bottom:20),
                child: Image.network("https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=${_userDetails.value!.uid}"),
              ),
              Text("Scan to build connections", style: TextStyle(fontSize: 14),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_copy,
                    color: Colors.black,
                    size: 16,
                  ),
                  TextButton(
                      onPressed: () {
                        showLicensePage(
                            context: context,
                            applicationIcon: Image.asset(
                              ImageAsset.applogo,
                              height: 70,
                            ),
                            applicationVersion: "1.2.1",
                            applicationLegalese: "Copyright CodingReboot");
                      },
                      child: Text(
                        "Licenses",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        launchExternalUrl(
                            "https://pages.flycricket.io/connecten/terms.html");
                      },
                      child: Text(
                        "Terms & Conditions",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 10),
                      )),
                  SizedBox(width: screenWidth! * 0.02),
                  TextButton(
                      onPressed: () async {
                        launchExternalUrl(
                            "https://pages.flycricket.io/connecten/privacy.html");
                      },
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 10),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    // final sp = context.read<SignInProvider>();
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, RoutePath.routeToNearbyScreen);
        break;
      case 1:
        Navigator.pushReplacementNamed(
            context, RoutePath.routeToConnectionScreen);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, RoutePath.routeToProfileScreen);
        break;

      case 3:
        Navigator.pushNamed(context, RoutePath.routeToQRScreen);
        break;
    }
  }
}

class HeaderWidget extends ConsumerWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authUser = ref.watch(authUserProvider);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: screenWidth! * 0.1,
            backgroundImage: const AssetImage(ImageAsset.applogo),
            foregroundImage: NetworkImage(_authUser.photoURL!),
          ),
          SizedBox(
            width: screenHeight! * 0.02,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_authUser.displayName ?? "Coding Reboot",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                SizedBox(
                  height: 10,
                ),
                Text(_authUser.email ?? "test@mail.com",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.black))
              ],
            ),
          )
        ],
      ),
    );
  }
}
