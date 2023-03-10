import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/Models/user_models.dart';
import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:ConnecTen/utils/fluttertoast.dart';
import 'package:ConnecTen/utils/size_config.dart';

class social extends ConsumerWidget {
  final int index;
  final String image;
  final String text;

  const social({
    Key? key,
    required this.index,
    required this.image,
    required this.text,
  }) : super(key: key);

  openDialog(image, text, index, context) => showDialog(
        context: context,
        builder: (context) {
          return LinkDialog(index: index, image: image, text: text);
        },
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () {
          UserModel userData = openDialog(image, text, index, context);
          // _databaseUser.updateUserData(userData);
        },
        child: Container(
          width: screenWidth! * 0.32,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xffeef7fe),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
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
                    style: const TextStyle(
                      letterSpacing: 1,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class LinkDialog extends ConsumerWidget {
  final String text;
  final String image;
  final int index;
  const LinkDialog({
    Key? key,
    required this.text,
    required this.image,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentUser = ref.watch(userDetailsProvider);
    final _databaseUser = ref.watch(databaseProvider);
    UserModel userDetails = _currentUser.value!;
    final myController = TextEditingController();
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 200,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                    child: Column(children: [
                      Text(
                        "$text Link",
                        style: const TextStyle(
                          letterSpacing: 1,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        controller: myController,
                        autofocus: true,
                        decoration: InputDecoration(
                            hintText: index == 1
                                ? userDetails.linkedin
                                : index == 2
                                    ? userDetails.github
                                    : index == 3
                                        ? userDetails.portfolio
                                        : userDetails.twitter),
                      ),
                      TextButton(
                          onPressed: () {
                            if (hasValidUrl(myController.text)) {
                              Navigator.pop(context);

                              //Navigator.of(context).pop();

                              /// TODO: Add link to database
                              // UserModel userDetails = _currentUser.value!;
                              switch (index) {
                                case 1:
                                  userDetails.linkedin = myController.text;
                                  break;
                                case 2:
                                  userDetails.github = myController.text;
                                  break;
                                case 3:
                                  userDetails.portfolio = myController.text;
                                  break;
                                case 4:
                                  userDetails.twitter = myController.text;
                                  break;
                              }
                              _databaseUser.updateUserData(userDetails);
                            } else {
                              toastWidget("Please enter a valid link");
                            }

                            // toastWidget("Link Added");
                          },
                          child: const Text(
                            'SUBMIT',
                            style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ))
                    ]))),
            Positioned(
              top: -50,
              child: CircleAvatar(
                backgroundColor: const Color(0xffced5ff),
                radius: 50,
                child: Image.asset(
                  image,
                  height: 40,
                  width: 40,
                ),
              ),
            )
          ],
        ));
  }

  bool hasValidUrl(String value) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
