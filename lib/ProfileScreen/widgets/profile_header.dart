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
            padding: EdgeInsets.all(screenHeight!*0.05),
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
              ],
            ),
          );
        }
        );
  }
}

