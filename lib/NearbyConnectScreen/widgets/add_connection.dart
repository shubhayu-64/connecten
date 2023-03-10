import 'package:ConnecTen/Models/user_models.dart';
import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:ConnecTen/utils/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddConnectionWidget extends ConsumerWidget {
  String uid;
  AddConnectionWidget({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _userDetails = ref.watch(userDetailsProvider);
    final _databaseProvider = ref.watch(databaseProvider);
    return IconButton(
      onPressed: () async {
        UserModel userData = _userDetails.value!;
        if (userData.connectedList!.contains(uid) == false) {
          userData.connectedList!.add(uid);
          userData.coins = userData.coins + 10;

          await _databaseProvider.updateUserData(userData);

          toastWidget("Added to Connections");
        }
        toastWidget("Already in Connections");
      },
      icon: Icon(Icons.person_add_alt_1_rounded),
    );
  }
}
