class MqttBroker {
  String host = "";
  int port = 0;

  MqttBroker();

  MqttBroker.fromJsonMap(Map<String, dynamic> json) {
    host = json['host'];
    port = json['port'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['host'] = host;
    data['port'] = port;
    return data;
  }
}
