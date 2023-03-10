import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnecTen/utils/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nearby_connections/nearby_connections.dart';

List<dynamic> parseString(String str) {
  List<String> parts = str.split(',');
  String name = parts[0];
  bool flag = parts[1].toLowerCase() == 'true';
  int? value = parts[2] != 'null' ? int.parse(parts[2]) : null;

  return [name, flag, value];
}

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
    print("----------------------------> $uid");
    try {
      bool a = await Nearby().startDiscovery(
        uid!,
        strategy,
        onEndpointFound: (id, name, serviceId) {
          print("ID: $id, Name: $name, ServiceID: $serviceId");
          final decodeBody = parseString(name);
          if (_connections.contains(decodeBody[1]) == false) {
            _connections.add(decodeBody[1]);
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
    try {
      await Nearby().stopDiscovery();
      print("Discovery Stopped");
      notifyListeners();
    } on PlatformException catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future enableAdvertising(String? uid, bool? burst, int? level) async {
    print("Data aa gya: $uid");
    if (burst == true) {
      final encodeData = "$uid,true,$level";
      print(encodeData);
      try {
        bool a = await Nearby().startAdvertising(
          encodeData,
          strategy,
          onConnectionInitiated: onConnectionInit,
          onConnectionResult: (id, status) {
            print(status);
          },
          onDisconnected: (id) {
            print("Disconnected: id $id");
          },
        );
        if (a == true) {
          print("Advertising Started");
        }
      } on PlatformException catch (exception) {
        print(exception);
      }
    } else {
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
        if (a == true) {
          print("Advertising Started");
        }
      } on PlatformException catch (exception) {
        print(exception);
      }
    }

    notifyListeners();
  }

  void onConnectionInit(String id, ConnectionInfo info) {
    print(id);
  }

  Future disableAdvertising() async {
    try {
      await Nearby().stopAdvertising();
      print("Advertising Stopped");
      notifyListeners();
    } on PlatformException catch (e) {
      print(e);
    }
    // await Nearby().stopAdvertising();
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
