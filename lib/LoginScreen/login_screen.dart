import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/Providers/auth_providers.dart';
import 'package:ConnecTen/utils/assets.dart';
import 'package:ConnecTen/utils/size_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Image.asset(
              ImageAsset.loginScreenBg,
              width: screenWidth!,
              scale: 0.8,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth! * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "Welcome to",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "ConnecTen",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "\nBest community connection platform \nfor all meetups and events to \nconnect hassle free.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "\nJoin For Free.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    OAuthGoogleButtonWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OAuthGoogleButtonWidget extends ConsumerWidget {
  const OAuthGoogleButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _auth = ref.watch(authServicesProvider);
    return Container(
      padding: EdgeInsets.symmetric(
        // horizontal: _width * 0.11,
        vertical: screenHeight! * 0.08,
      ),
      child: Material(
        // color: Color(0xff567DF4),
        color: Colors.red,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          onTap: () async {
            /// TODO: Handle Google Sign In
            await _auth.signInWithGoogle();
            // handleGoogleSignIn();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.center,
            height: screenWidth! * 0.12,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/google.png"),
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth! * 0.05, 0, 0, 0),
                  child: const Text(
                    "Sign in with Google",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
