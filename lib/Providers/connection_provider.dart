import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/utils/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nearby_connections/nearby_connections.dart';

// Future<bool> getLocationPermission() async {
//   if (await Nearby().checkLocationPermission() == false) {
//     await Nearby().askLocationPermission();
//   }
//   // notifyListeners();
//   return Nearby().checkLocationEnabled();
// }

// Future<bool> getBluetoothPermission() async {
//   if (await Nearby().checkBluetoothPermission() == false) {
//     Nearby().askBluetoothPermission();
//   }
//   return Nearby().checkBluetoothPermission();
// }

// final locationPermissionProvider = FutureProvider<bool>(((ref) {
//   return getLocationPermission();
// }));

// final bluetoothPermissionProvider = FutureProvider<bool>(((ref) {
//   return getBluetoothPermission();
// }));

class ConnectionNotifier extends ChangeNotifier {
  final Strategy strategy = Strategy.P2P_STAR;

  List<String> _connections = [];
  List<String> get connections => _connections;

  ConnectionNotifier() {
    checkPermissions();
  }

  Future checkPermissions() async {
    await getLocationPermission();
    await getBluetoothPermission();
    await checkLocationEnabled();
    notifyListeners();
  }

  Future setConnectionData() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setStringList("connections", _connections);
    notifyListeners();
  }

  Future getConnectionData() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    _connections = shared.getStringList("connections") ?? [];
    notifyListeners();
  }

  Future enableDiscovery(String? uid, context) async {
    try {
      bool a = await Nearby().startDiscovery(
        uid!,
        strategy,
        onEndpointFound: (id, name, serviceId) {
          if (_connections.contains(name) == false) {
            _connections.add(name);
          }
          // TODO: Add New Connection Snackbar
          toastWidget("New Connection Found");
        },
        onEndpointLost: (id) {},
      );
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future disableDiscovery() async {
    await Nearby().stopDiscovery();
    notifyListeners();
  }

  Future enableAdvertising(String? uid) async {
    try {
      bool a = await Nearby().startAdvertising(
        uid!,
        strategy,
        onConnectionInitiated: onConnectionInit,
        onConnectionResult: (id, status) {
          print(status);
        },
        onDisconnected: (id) {
          print("Disconnected: id $id");
        },
      );
    } catch (exception) {
      print(exception);
    }
    notifyListeners();
  }

  void onConnectionInit(String id, ConnectionInfo info) {
    print(id);
  }

  Future disableAdvertising() async {
    await Nearby().stopAdvertising();
    notifyListeners();
  }

  Future getLocationPermission() async {
    if (await Nearby().checkLocationPermission() == false) {
      await Nearby().askLocationPermission();
    }
    notifyListeners();
  }

  Future getBluetoothPermission() async {
    if (await Nearby().checkBluetoothPermission() == false) {
      Nearby().askBluetoothPermission();
    }
    notifyListeners();
  }

  Future checkLocationEnabled() async {
    if (await Nearby().checkLocationEnabled() == false) {
      await Nearby().enableLocationServices();
    }
    notifyListeners();
  }
}

final connectionProvider =
    ChangeNotifierProvider((ref) => ConnectionNotifier());
