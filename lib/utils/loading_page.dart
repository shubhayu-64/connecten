import 'package:flutter/material.dart';
import 'package:ConnecTen/utils/colors.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primarybgcolor,
      body: Center(
          child: CircularProgressIndicator(
        color: Colors.blue,
      )),
    );
  }
}
