import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/Providers/auth_providers.dart';

class ProfileImageWidget extends ConsumerWidget {
  const ProfileImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authUser = ref.watch(authUserProvider);
    return SizedBox(
      height: 150,
      child: _authUser.photoURL == null
          ? Image.asset("assets/animation.gif")
          : CircleAvatar(
              radius: 75,
              backgroundImage: NetworkImage(_authUser.photoURL!),
            ),
      // child: Image.asset("assets/animation.gif"),
    );
  }
}
