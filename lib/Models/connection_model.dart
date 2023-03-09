class ConnectionModel {
  List<String>? connections;

  ConnectionModel({
    this.connections,
  });

  factory ConnectionModel.fromMap(Map<String, dynamic>? map) {
    return ConnectionModel(
      connections: map!['connections'],
    );
  }

  Map<String, dynamic> ToMap(ConnectionModel connectionData) {
    Map<String, dynamic> map = {
      "connections": connectionData.connections,
    };

    return map;
  }
}
