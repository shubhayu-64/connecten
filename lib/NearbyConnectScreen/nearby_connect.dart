import 'dart:async';

import 'package:ConnecTen/ProfileScreen/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/Models/user_models.dart';
import 'package:ConnecTen/Providers/connection_provider.dart';
import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:ConnecTen/utils/fluttertoast.dart';
import 'package:ConnecTen/utils/size_config.dart';
import 'package:ConnecTen/widgets/appbar.dart';
import 'package:ConnecTen/widgets/drawer.dart';
import 'package:ConnecTen/widgets/profile_dialog.dart';

class NearbyConnect extends ConsumerWidget {
  const NearbyConnect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cp = ref.watch(connectionProvider);
    final _databaseProvider =
        ref.watch(nearbyConnectionsProvider(cp.connections));
    final _userData = ref.watch(userDetailsProvider);
    print("-------Connection IDs-------");
    print(cp.connections);

    return _databaseProvider.when(
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        );
      },
      error: (err, stack) => Text('Error: $err'),
      data: (userData) {
        return Scaffold(
            drawer: const Menu(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(screenHeight! * 0.12),
              child: CustomAppbar(context),
            ),
            body: Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 25),
              child: Column(
                children: [
                  const Text(
                    "Nearby Connections",
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Center(child: ToggleButton()),
                  _userData.when(
                    loading: () {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      );
                    },
                    error: (err, stack) => Text('Error: $err'),
                    data: (currentUser) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: currentUser.coins > 500
                              ? Colors.blue
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          _showMyDialog(context);
                        },
                        child: Text("BURST")),
                  ),
                  SizedBox(height: screenHeight! * .02),
                  SingleChildScrollView(
                    child: Container(
                        height: screenHeight! * 0.6,
                        //height: Get.height*0.5,
                        child: ListView.builder(
                            itemCount: userData!.length,
                            itemBuilder: (context, i) {
                              print("object");
                              //return Connect(userdata["fullname"], userdata["designation"]);

                              return Connect(userData[i], userData[i].name,
                                  userData[i].designation, context);
                            })),
                  ),
                ],
              ),
            ));
      },
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: AlertDialog(
            title: const Text('Burster Alert'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  /// TODO: Add logic to approve the message
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Deny'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// class NearbyConnect extends ConsumerStatefulWidget {
//   const NearbyConnect({Key? key}) : super(key: key);

//   @override
//   ConsumerState<NearbyConnect> createState() => _NearbyConnectState();
// }

// class _NearbyConnectState extends ConsumerState<NearbyConnect> {
//   // List<Map<String, String?>> allUserData = [];
//   // bool isDone = false;

//   // Future<Map<String, String?>> fetchUserData(String uid) async {
//   //   var userData = new Map<String, String?>();
//   //   List<String?> connectedList = [];
//   //
//   //   await FirebaseFirestore.instance
//   //       .collection("users")
//   //       .doc(uid)
//   //       .get()
//   //       .then((DocumentSnapshot snapshot) async {
//   //     userData["uid"] = snapshot["uid"];
//   //     userData["fullname"] = snapshot["fullname"];
//   //     userData["designation"] = snapshot["designation"];
//   //     userData["bio"] = snapshot["bio"];
//   //     userData["imageUrl"] = snapshot["imageUrl"];
//   //     userData["linkedIn"] = snapshot["linkedIn"];
//   //     userData["github"] = snapshot["github"];
//   //     userData["portfolio"] = snapshot["portfolio"];
//   //     userData["twitter"] = snapshot["twitter"];
//   //     // userData["connectedList"] = snapshot["connectedList"];
//   //     var connectedData = snapshot["connectedList"];
//   //     connectedList= List<String?>.from(connectedData);
//   //   });
//   //
//   //   return userData;
//   // }

//   // void getallData(List<String> uidList) async {
//   //   List<Map<String, String?>> allData = [];
//   //
//   //   for (var uid in uidList) {
//   //     // Get.snackbar("Uid", uid);
//   //     final alphanumeric = RegExp(r'^[a-zA-Z0-9_]*$');
//   //     print("Before if "+ uid);
//   //     if(alphanumeric.hasMatch(uid) == true){
//   //       print(uid);
//   //       await fetchUserData(uid).then((value) {
//   //         // "^[a-zA-Z0-9_]*$"
//   //
//   //         allData.add(value);
//   //       });
//   //     }
//   //     //print(uid);
//   //
//   //   }
//   //   setState(() {
//   //     isDone = true;
//   //     allUserData = allData;
//   //   });
//   // }

//   // @override
//   // void initState() {
//   //   final cp = context.read<ConnectionProvider>();
//   //   if (isDone == false) {
//   //     getallData(cp.connections);
//   //   }
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final cp = ref.watch(connectionProvider);
//     final _databaseProvider =
//         ref.watch(nearbyConnectionsProvider(cp.connections));
//     // final _userdata = ref.watch(nearbyConnectionsProvider);
//     print("-------Connection IDs-------");
//     print(cp.connections);
//     // List<UserModel>? nearbyUsers =
//     //     _databaseProvider.getNearbyData(cp.connections);

//     // // nearbyUsers = _userdatavoid
//     // Future<void> fetchData() async {
//     //   nearbyUsers = await _databaseProvider.getNearbyData(cp.connections);
//     // }

//     // setState(() async {
//     //   print("Set State");
//     //   await fetchData();
//     //   print(nearbyUsers!.length);
//     // });

//     // @override
//     // void initState() {
//     //   print("Init State");
//     //   // fetchData();
//     //   print(nearbyUsers!.length);
//     //   super.initState();
//     // }

//     _databaseProvider.when(
//       loading: () => const CircularProgressIndicator(),
//       error: (err, stack) => Text('Error: $err'),
//       data: (userData) {
//         return Scaffold(
//             drawer: const Menu(),
//             appBar: PreferredSize(
//               preferredSize: Size.fromHeight(screenHeight! * 0.12),
//               child: CustomAppbar(context),
//             ),
//             body: Container(
//               margin: EdgeInsets.fromLTRB(30, 0, 30, 25),
//               child: Column(
//                 children: [
//                   Text(
//                     "Nearby Connections",
//                     style: TextStyle(
//                       letterSpacing: 1,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(height: screenHeight! * .02),
//                   SingleChildScrollView(
//                     child: Container(
//                         height: screenHeight! * 0.6,
//                         //height: Get.height*0.5,
//                         child: ListView.builder(
//                             itemCount: userData!.length,
//                             itemBuilder: (context, i) {
//                               //return Connect(userdata["fullname"], userdata["designation"]);

//                               return Connect(userData[i], userData[i].name,
//                                   userData[i].designation, context);
//                             })),
//                   ),
//                 ],
//               ),
//             ));
//       },
//     );

//     // return Scaffold(
//     //     drawer: const Menu(),
//     //     appBar: PreferredSize(
//     //       preferredSize: Size.fromHeight(screenHeight! * 0.12),
//     //       child: CustomAppbar(context),
//     //     ),
//     //     body: Container(
//     //       margin: EdgeInsets.fromLTRB(30, 0, 30, 25),
//     //       child: Column(
//     //         children: [
//     //           Text(
//     //             "Nearby Connections",
//     //             style: TextStyle(
//     //               letterSpacing: 1,
//     //               fontSize: 20,
//     //               fontWeight: FontWeight.w600,
//     //             ),
//     //           ),
//     //           SizedBox(height: screenHeight! * .02),
//     //           SingleChildScrollView(
//     //             child: Container(
//     //                 height: screenHeight! * 0.6,
//     //                 //height: Get.height*0.5,
//     //                 child: ListView.builder(
//     //                     itemCount: nearbyUsers!.length,
//     //                     itemBuilder: (context, i) {
//     //                       //return Connect(userdata["fullname"], userdata["designation"]);

//     //                       return Connect(nearbyUsers![i], nearbyUsers![i].name,
//     //                           nearbyUsers![i].designation, context);
//     //                     })),
//     //           ),
//     //         ],
//     //       ),
//     //     ));
//   }
// }

Widget Connect(UserModel userData, name, designation, context) {
  return InkWell(
      onTap: () {
        ProfileDialog(userData, context);
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
                    name,
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
                    designation,
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
                        uid: userData.uid,
                      )),
                ],
              )
            ],
          )));
}

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
