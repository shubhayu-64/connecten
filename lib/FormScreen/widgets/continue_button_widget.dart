import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/Models/user_models.dart';
import 'package:ConnecTen/Providers/auth_providers.dart';
import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:ConnecTen/routes/route_path.dart';
import 'package:ConnecTen/utils/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ConnecTen/utils/fluttertoast.dart';

class ContinueButtonWidget extends ConsumerWidget {
  const ContinueButtonWidget({
    Key? key,
    required this.nameController,
    required this.designationController,
    required this.bioController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController designationController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ToastContext().init(context);

    final _authState = ref.watch(authUserProvider);
    final _databaseService = ref.watch(databaseProvider);
    return Material(
      elevation: 5,
      color: AppColor.buttoncolor,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: () async {
          // Toast.show("Profile Created",
          //     duration: Toast.lengthShort, gravity: Toast.bottom);
          if (nameController.text.isNotEmpty &&
              designationController.text.isNotEmpty &&
              bioController.text.isNotEmpty) {
            UserModel userDetails = UserModel(
              uid: _authState.uid,
              name: nameController.text,
              designation: designationController.text,
              bio: bioController.text,
              email: _authState.email!,
              imageURL: _authState.photoURL!,
              connectedList: [],
              github: "",
              linkedin: "",
              twitter: "",
              portfolio: "",
              isPrivate: false,
            );
            bool state = await _databaseService.addUserData(userDetails);
            print(state);
            if (state) {
              Navigator.pushReplacementNamed(
                  context, RoutePath.routeToForceProfileScreen);
            }
          } else {
            toastWidget("Please fill all the fields");
          }
        },
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width * 0.5,
        child: const Text(
          " Continue ",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
