import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/Models/user_models.dart';
import 'package:ConnecTen/utils/colors.dart';
import 'package:ConnecTen/utils/fluttertoast.dart';
import 'package:ConnecTen/utils/launch_urls.dart';
import 'package:ConnecTen/utils/size_config.dart';

Future ProfileDialog(UserModel UserData, context) => showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          //title: Text(uid+" Link"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: screenWidth! * 0.1,
                  backgroundColor: AppColor.primarybgcolor,
                  backgroundImage: AssetImage("assets/Avatar.png"),
                  foregroundImage: NetworkImage(UserData.imageURL),
                  //foregroundImage: sp.imageUrl == null ? AssetImage("assets/Avatar.png") : NetworkImage(sp.imageUrl),
                  //foregroundImage: NetworkImage(sp.imageUrl!),
                ),
                SizedBox(
                  height: screenHeight! * 0.01,
                ),
                Text(
                  UserData.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth! * 0.05,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight! * 0.01),
                  child: Text(UserData.connectedList!.length.toString() +
                      " Connections"),
                ),
                SizedBox(
                  height: screenHeight! * 0.03,
                ),
                UserData.isPrivate == false
                    ? Text(
                        "Social Links",
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      )
                    : Text(""),
                UserData.isPrivate == false
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            social_link(context, 1, "assets/linkedin.png",
                                "Linkedin", UserData.linkedin),
                            social_link(context, 2, "assets/github.png",
                                "Github", UserData.github),
                            social_link(context, 3, "assets/website.png",
                                "Portfolio", UserData.portfolio),
                            social_link(context, 4, "assets/twitter.png",
                                "Twitter", UserData.twitter),
                          ],
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          "This user has made their profile private",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth! * 0.03,
                          ),
                        ),
                      ),
                UserData.isPrivate == true ?
                ConnectButton(SenderUserData: UserData):Container(),

              ],
            ),
          ));
    });

class ConnectButton extends ConsumerWidget {
  final UserModel SenderUserData;
  const ConnectButton({
    Key? key,
    required this.SenderUserData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentUserDetails = ref.watch(userDetailsProvider);
    final _databaseProvider = ref.watch(databaseProvider);

    return ElevatedButton(
      onPressed: () async {
        UserModel currentUser = _currentUserDetails.value!;
        toastWidget("Connection Request Sent");
        SenderUserData.requestList!.add(currentUser.uid);
        await _databaseProvider.updateUserData(SenderUserData);
      },
      child: Text("Connect"),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.buttoncolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}


Widget social_link(context, index, image, text, link) {
  return Container(
    width: screenWidth! * 0.3,
    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color(0xffeef7fe),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            launchExternalUrl(link);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 25,
                width: 25,
              ),
              SizedBox(height: screenHeight! * 0.01),
              Text(
                text,
                //textAlign: TextAlign.start,
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
