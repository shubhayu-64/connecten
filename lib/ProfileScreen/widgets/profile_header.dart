import 'package:ConnecTen/Models/user_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/Providers/database_provider.dart';
import 'package:ConnecTen/utils/assets.dart';
import 'package:ConnecTen/utils/size_config.dart';

class ProfileHeaderWidget extends ConsumerWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _databaseUser = ref.watch(userDetailsProvider);
    return _databaseUser.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text(error.toString()),
        data: (userData) {
          return Container(
            padding: EdgeInsets.all(screenHeight! * 0.05),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                CircleAvatar(
                  radius: screenWidth! * 0.12,
                  foregroundImage: NetworkImage(userData.imageURL),
                  backgroundImage: AssetImage(ImageAsset.splashScreenGif),
                ),
                SizedBox(
                  height: screenHeight! * 0.01,
                ),
                Text(
                  userData.name,
                  // "hello",
                  style: const TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: screenHeight! * 0.01,
                ),
                Text(
                  userData.designation!,
                  // "designation",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: screenHeight! * 0.01,
                ),
                Text(
                  userData.bio!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: screenHeight! * 0.01,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    _showQRDialog(context, userData);
                  },
                  child: Container(
                    padding: EdgeInsets.all(screenHeight! * 0.01),
                    width: screenWidth! * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code_scanner_rounded,
                            size: 14, color: Colors.black87),
                        SizedBox(
                          width: screenWidth! * 0.005,
                        ),
                        const Text(
                          "Show QR Code",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
  Future<void> _showQRDialog(BuildContext context, UserModel userData) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: AlertDialog(
            title: const Text("Your QR Code"),
            content: SizedBox(
              height: screenHeight! * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Image.network("https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=${userData.uid}",
                    height: screenHeight!*0.25,
                    fit: BoxFit.fitHeight,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Scan to build connections", style: TextStyle(fontSize: 14),),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          ),
        );
      },
    );
  }
}
