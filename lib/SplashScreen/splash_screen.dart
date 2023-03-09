import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ConnecTen/routes/route_path.dart';
import 'package:ConnecTen/utils/assets.dart';
import 'package:ConnecTen/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    routeToNextScreen();
    super.initState();
  }

  routeToNextScreen() {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(
        RoutePath.routeToLoginScreen,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Image.asset(
          ImageAsset.splashScreenGif,
          width: screenWidth! * 0.5,
          height: screenHeight! * 0.5,
        ),
      )),
    );
  }
}
