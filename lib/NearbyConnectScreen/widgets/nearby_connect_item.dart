import 'package:ConnecTen/Models/user_models.dart';
import 'package:ConnecTen/NearbyConnectScreen/nearby_connect.dart';
import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:ConnecTen/utils/size_config.dart';
import 'package:ConnecTen/widgets/profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_connection.dart';

class NearbyConnectItem extends ConsumerWidget {
  final UserModel senderUserData;

  const NearbyConnectItem({
    Key? key,
    required this.senderUserData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _userData = ref.watch(userDetailsProvider);
    UserModel currentUser = _userData.value!;

    return InkWell(
        onTap: () {
          ProfileDialog(senderUserData, currentUser, context);
        },
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: EdgeInsets.only(bottom: 20),
            height: screenHeight! * 0.15,
            decoration: BoxDecoration(
              color: Color(0xffEEF7FE),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      senderUserData.name,
                      //textAlign: TextAlign.start,
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight! * 0.01,
                    ),
                    Text(
                      senderUserData.designation!,
                      //textAlign: TextAlign.start,
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: AddConnectionWidget(
                          uid: senderUserData.uid,
                        )),
                  ],
                )
              ],
            )));
  }
}