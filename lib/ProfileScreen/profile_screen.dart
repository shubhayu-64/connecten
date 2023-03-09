import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/ProfileScreen/widgets/profile_header.dart';
import 'package:ConnecTen/ProfileScreen/widgets/social_cards.dart';
import 'package:ConnecTen/ProfileScreen/widgets/toggle_button.dart';
import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:ConnecTen/utils/colors.dart';
import 'package:ConnecTen/utils/fluttertoast.dart';
import 'package:ConnecTen/utils/size_config.dart';
import 'package:ConnecTen/widgets/appbar.dart';
import 'package:ConnecTen/widgets/drawer.dart';
import 'package:sliding_switch/sliding_switch.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Menu(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight! * 0.12),
          child: CustomAppbar(context),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 25),
                height: screenHeight! * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor.primarybgcolor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20.0,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ToggleButton(),
                    //Stack 2
                    const ProfileHeaderWidget(),
                  ],
                ),
              ),
            LockButton(),
              socialCard(context),
            ],
          ),
        ));
  }
}

class LockButton extends ConsumerWidget {
  const LockButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final _userDetails = ref.watch(userDetailsProvider);
    final _databaseUser = ref.watch(databaseProvider);

    bool profileState = _userDetails.value!.isPrivate;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "My Links",
          style: TextStyle(
            letterSpacing: 1,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
        ),
    IconButton(onPressed: (){
    _userDetails.value!.isPrivate = !_userDetails.value!.isPrivate;
    _databaseUser.updateUserData(_userDetails.value!);
    _userDetails.value!.isPrivate ? {toastWidget("Profile Locked")
    } : toastWidget("Profile Unlocked");
    },
    icon: Icon(profileState ? Icons.lock_rounded : Icons.lock_open_rounded,)),
      ],
    );
  }
}

