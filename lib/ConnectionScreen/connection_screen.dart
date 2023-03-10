
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:ConnecTen/utils/size_config.dart';
import 'package:ConnecTen/widgets/appbar.dart';
import 'package:ConnecTen/widgets/drawer.dart';
import 'package:ConnecTen/widgets/profile_dialog.dart';

class Connections extends ConsumerWidget {
  const Connections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _userdata = ref.watch(userDetailsProvider);
    final _databaseProvider =
    ref.watch(nearbyConnectionsProvider(_userdata.value!.connectedList!));

    return _databaseProvider.when(loading: () {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      );
    },
      error: (err, stack) => Text('Error: $err'),
      data: (connectedUserData){
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
                  "Connections",
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight! * .02),
                SingleChildScrollView(
                  child: Container(
                      height: screenHeight! * 0.6,
                      child: ListView.builder(
                        itemCount: connectedUserData!.length,
                        itemBuilder: (context, i) {
                          return ConnectBox(
                              connectedUserData[i],
                              connectedUserData[i].name,
                              connectedUserData[i].designation, context);
                        },
                      )),
                ),
              ],
            ),
          ));
      },
    );
  }
}


Widget ConnectBox(allUserData, name, designation, context) {
  return InkWell(
    onTap: () {
      ProfileDialog(allUserData, context);
    },
    child: Container(
        alignment: Alignment.centerLeft,
        height: screenHeight! * 0.1,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Color(0xffEEF7FE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
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
        )
    ),
  );
}
