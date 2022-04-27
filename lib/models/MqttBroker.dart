class MqttBroker {
  String host = "";
  int port = 0;
  String UID = '';

  MqttBroker();

  MqttBroker.fromJsonMap(Map<String, dynamic> json) {
    host = json['host'];
    port = json['port'];
    UID = json['UID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['host'] = host;
    data['port'] = port;
    data['UID'] = UID;
    return data;
  }
}
