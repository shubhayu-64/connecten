import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/Providers/auth_providers.dart';
import 'package:ConnecTen/Providers/connection_provider.dart';
import 'package:sliding_switch/sliding_switch.dart';

class ToggleButton extends ConsumerStatefulWidget {
  const ToggleButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends ConsumerState<ToggleButton> {
  // bool state = true;
  @override
  Widget build(BuildContext context) {
    final cp = ref.watch(connectionProvider);
    final _authUser = ref.watch(authUserProvider);

    // if (state) {
    //   setState(() {
    //     print("-------------------------");
    //     cp.disableAdvertising();
    //     cp.enableDiscovery(_authUser.uid, context);
    //     state = false;
    //   });
    // }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      alignment: Alignment.topRight,
      child: SlidingSwitch(
        value: false,
        width: 50,
        onChanged: (bool value) {
          /// TODO: Uncomment Required

          if (value == true) {
            cp.enableAdvertising(_authUser.uid);
            cp.disableDiscovery();
          } else {
            cp.disableAdvertising();
            cp.enableDiscovery(_authUser.uid, context);
          }
        },
        height: 25,
        animationDuration: const Duration(milliseconds: 400),
        onTap: () {},
        onDoubleTap: () {},
        onSwipe: () {},
        textOff: "",
        textOn: "",
        contentSize: 17,

        /// TODO: Changes Required
        colorOn: const Color(0xff035e00),
        colorOff: const Color(0xfff00c0c),
        background: const Color(0xff25ff00),
        buttonColor: const Color(0xfff7f5f7),
        inactiveColor: const Color(0xff636f7b),
      ),
    );
  }
}

// class ToogleButton extends ConsumerWidget {
//   const ToogleButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final cp = ref.watch(connectionProvider);
//     final _authUser = ref.watch(authUserProvider);

//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//       alignment: Alignment.topRight,
//       child: SlidingSwitch(
//         value: false,
//         width: 50,
//         onChanged: (bool value) {
//           /// TODO: Uncomment Required

//           if (value == true) {
//             cp.enableAdvertising(_authUser.uid);
//             cp.disableDiscovery();
//           } else {
//             cp.disableAdvertising();
//             cp.enableDiscovery(_authUser.uid, context);
//           }
//         },
//         height: 25,
//         animationDuration: const Duration(milliseconds: 400),
//         onTap: () {},
//         onDoubleTap: () {},
//         onSwipe: () {},
//         textOff: "",
//         textOn: "",
//         contentSize: 17,

//         /// TODO: Changes Required
//         colorOn: const Color(0xff035e00),
//         colorOff: const Color(0xfff00c0c),
//         background: const Color(0xff25ff00),
//         buttonColor: const Color(0xfff7f5f7),
//         inactiveColor: const Color(0xff636f7b),
//       ),
//     );
//   }
// }
