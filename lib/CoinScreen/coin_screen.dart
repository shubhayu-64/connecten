import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:ConnecTen/utils/assets.dart';
import 'package:ConnecTen/utils/colors.dart';
import 'package:ConnecTen/utils/size_config.dart';
import 'package:ConnecTen/widgets/appbar.dart';
import 'package:ConnecTen/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinScreen extends ConsumerWidget {
  const CoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final _userDetails = ref.watch(userDetailsProvider);
    return _userDetails.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
      data: (userdata) => Scaffold(
      drawer: const Menu(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight! * 0.08),
        child: AppBar(
          // toolbarHeight: screenHeight! * 0.12,
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          // shadowColor: AppColor.primarybgcolor,
          elevation: 0.0,
          leading: Builder(
            builder: (context) => IconButton(
              splashRadius: 1,
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new, color: AppColor.buttoncolor),
              alignment: Alignment.centerLeft,
            ),
          ),
          centerTitle: true,
          title: Text('Coins', style: TextStyle(color: AppColor.buttoncolor, fontSize: 20, fontWeight: FontWeight.w600),),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(30, 20, 30, 25),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(AppColor.arrowcolor, BlendMode.srcIn),
                        child: Image.asset(ImageAsset.coinlogo,height: 30,)
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userdata.coins.toString(),
                        style: TextStyle(color: AppColor.arrowcolor,
                          fontSize: screenWidth!*0.1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text('Coin Balance',
                        style: TextStyle(color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth!*0.1, vertical: screenHeight!*0.02),
              child: Text("You can earn coins in the following ways: ",
                style: TextStyle(color: AppColor.arrowcolor,
                  fontSize: 18,
                ),
              ),
            ),


          ],
        )
        ),
      ));
  }
}
