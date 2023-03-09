import 'package:flutter/material.dart';
import 'package:ConnecTen/ConnectionScreen/connection_screen.dart';
import 'package:ConnecTen/Handler/auth_handler.dart';
import 'package:ConnecTen/NearbyConnectScreen/nearby_connect.dart';
import 'package:ConnecTen/ProfileScreen/profile_screen.dart';
import 'package:ConnecTen/SplashScreen/splash_screen.dart';
import 'package:ConnecTen/qr_scanner/qrscanner.dart';
import 'package:ConnecTen/routes/route_path.dart';

abstract class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget currentWidget;

    switch (settings.name) {
      case RoutePath.routeInitial:
      case RoutePath.routeToSplashScreen:
        currentWidget = const SplashScreen();
        break;

      case RoutePath.routeToLoginScreen:
        currentWidget = const AuthHandler();
        break;

      case RoutePath.routeToProfileScreen:
        currentWidget = const AuthHandler();
        break;

      case RoutePath.routeToForceProfileScreen:
        currentWidget = const ProfileScreen();
        break;

      case RoutePath.routeToNearbyScreen:
        currentWidget = const NearbyConnect();
        break;

      case RoutePath.routeToConnectionScreen:
        currentWidget = const Connections();
        break;

      case RoutePath.routeToQRScreen:
        currentWidget = const QRScan();
        break;

      default:
        currentWidget = Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
    }
    return _AppRoute(screen: currentWidget, settings: settings);
  }

  static void goToEventScreen(BuildContext context) {}
}

class _AppRoute extends PageRouteBuilder {
  final Widget screen;
  // ignore: annotate_overrides
  final RouteSettings settings;

  _AppRoute({required this.screen, required this.settings})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              screen,
          settings: settings,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1, 0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
