import 'package:ConnecTen/Models/user_models.dart';
import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:ConnecTen/utils/fluttertoast.dart';
import 'package:ConnecTen/utils/size_config.dart';
import 'package:ConnecTen/widgets/appbar.dart';
import 'package:ConnecTen/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectReqScreen extends ConsumerWidget {
  const ConnectReqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentuserdata = ref.watch(userDetailsProvider);
    final _databaseProvider = ref.watch(
        nearbyConnectionsProvider(_currentuserdata.value!.requestList!));
    return _databaseProvider.when(
        loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            ),
        error: (err, stack) => Text('Error: $err'),
        data: (userdata) => Scaffold(
            drawer: const Menu(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(screenHeight! * 0.12),
              child: CustomAppbar(context),
            ),
            body: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Connection Requests",
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: screenHeight! * .02),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth! * 0.05),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: userdata!.length,
                          itemBuilder: (context, i) {
                            return ConnectReqItem(userData: userdata[i]);

                          },
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}

class ConnectReqItem extends ConsumerWidget{
  final UserModel userData;
  // final UserModel currentuserdata;

  const ConnectReqItem({
    Key? key,
    required this.userData,
    // required this.currentuserdata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _databaseProvider = ref.watch(databaseProvider);
    final _currentuserdata = ref.watch(userDetailsProvider);
    return Container(
        alignment: Alignment.centerLeft,
        height: screenHeight! * 0.1,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Color(0xffEEF7FE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData.name,
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
                  userData.designation!,
                  //textAlign: TextAlign.start,
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
                onPressed: () async {
                  UserModel currentuserdata = _currentuserdata.value!;
                  print("Test");
                  // currentuserdata.requestList!.remove(userData.uid);
                  if(currentuserdata.connectedList!.contains(userData.uid)== true) {
                    toastWidget("Already Connected");
                  } else {
                    currentuserdata.connectedList!.add(userData.uid);
                    currentuserdata.requestList!.remove(userData.uid);
                    toastWidget("Added to Connections");
                    await _databaseProvider.updateUserData(currentuserdata);
                  }
                }, icon: Icon(Icons.check_circle_rounded)),
            IconButton(onPressed: () async {
              UserModel currentuserdata = _currentuserdata.value!;
              currentuserdata.requestList!.remove(userData.uid);
              await _databaseProvider.updateUserData(currentuserdata);
            }, icon: Icon(Icons.cancel_rounded)),
          ],
        ));
  }
}
