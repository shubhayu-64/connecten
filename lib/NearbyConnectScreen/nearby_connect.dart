import 'dart:async';
import 'package:ConnecTen/NearbyConnectScreen/widgets/nearby_connect_item.dart';
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


class NearbyConnect extends ConsumerStatefulWidget {
  const NearbyConnect({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NearbyConnectState();
}

class _NearbyConnectState extends ConsumerState<NearbyConnect> {
  @override
  Widget build(BuildContext context) {
    final cp = ref.watch(connectionProvider);
    final _databaseProvider = ref.watch(nearbyConnectionsProvider(cp.connections));
    // final _userData = ref.watch(userDetailsProvider);
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
        print(userData!.length);
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
                  // Center(child: ToggleButton()),
                  // _userData.when(
                  //   loading: () {
                  //     return const Scaffold(
                  //       body: Center(
                  //         child: CircularProgressIndicator(
                  //           color: Colors.blue,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   error: (err, stack) => Text('Error: $err'),
                  //   data: (currentUser) => ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: currentUser.coins >= 500
                  //             ? Colors.blue
                  //             : Colors.grey,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //       ),
                  //       onPressed: () {
                  //         _showMyDialog(context);
                  //       },
                  //       child: Text("BURST")),
                  // ),
                  // SizedBox(height: screenHeight! * .02),
                  SingleChildScrollView(
                    child: Container(
                        height: screenHeight! * 0.6,
                        //height: Get.height*0.5,
                        child: ListView.builder(
                            itemCount: cp.connections.length,
                            itemBuilder: (context, i) {
                              print("object");
                              print(i);
                              //return Connect(userdata["fullname"], userdata["designation"]);

                              // return Connect(userData[i], context);
                              return NearbyConnectItem(
                                senderUserData: userData[i],
                              );
                            })),
                  ),
                ],
              ),
            ));
      },
    );
  }

  // Future<void> _showMyDialog(BuildContext context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: true, // user must tap button!
  //     builder: (BuildContext context) {
  //       return Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: AlertDialog(
  //           title: const Text('Burster Alert'),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: const <Widget>[
  //                 Text('This is a demo alert dialog.'),
  //                 Text('Would you like to approve of this message?'),
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //               child: const Text('Approve'),
  //               onPressed: () {
  //                 /// TODO: Add logic to approve the message
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             TextButton(
  //               child: const Text('Deny'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}




// Widget Connect(UserModel userData, context) {
//   print(userData.name);
//   return InkWell(
//       onTap: () {
//         ProfileDialog(userData, context);
//       },
//       child: Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//           margin: EdgeInsets.only(bottom: 20),
//           height: screenHeight! * 0.15,
//           decoration: BoxDecoration(
//             color: Color(0xffEEF7FE),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     userData.name,
//                     //textAlign: TextAlign.start,
//                     style: TextStyle(
//                       letterSpacing: 1,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(
//                     height: screenHeight! * 0.01,
//                   ),
//                   Text(
//                     userData.designation!,
//                     //textAlign: TextAlign.start,
//                     style: TextStyle(
//                       letterSpacing: 1,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Align(
//                       alignment: Alignment.centerRight,
//                       child: AddConnectionWidget(
//                         uid: userData.uid,
//                       )),
//                 ],
//               )
//             ],
//           )));
// }

