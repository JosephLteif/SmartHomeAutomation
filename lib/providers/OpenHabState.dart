import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smarthomeautomation/models/ChartDataModel.dart';
import 'package:smarthomeautomation/models/ItemModel.dart';
import 'package:smarthomeautomation/models/MqttBroker.dart';
import 'package:smarthomeautomation/models/ThingModel.dart';
import 'package:smarthomeautomation/services/OpenHabService.dart';

class OpenHabState extends ChangeNotifier {
  List<Thing> _things = [];
  List<Thing> get things => _things;

  List<Thing> _selectedThings = [];
  List<Thing> get selectedThings => _selectedThings;

  List<Item> _items = [];
  List<Item> get items => _items;

  final List<String> _rooms = [];
  List<String> get rooms => _rooms;

  MqttBroker mqttBroker = MqttBroker();

  late MqttServerClient client;

  OpenHabState() {
    update();
  }

  update() {
    Fetchthings();
    Fetchitems();
  }

  void Fetchthings() async {
    _things.clear();
    _rooms.clear();
    _things = await OpenHabService().getThings();
    for (var thing in _things) {
      String location = thing.location ?? '';
      if (location != '') {
        if (!_rooms.contains(location)) {
          _rooms.add(location);
        }
      }
      if (thing.label == "MQTT Broker") {
        dynamic temp = thing.configuration;
        // mqttBroker.host = 'broker.hivemq.com';
        // mqttBroker.port = 1883;
        mqttBroker.host = '${temp["host"]}';
        mqttBroker.port = temp["port"];
        mqttBroker.UID = thing.uID.toString();
        client = MqttServerClient.withPort(
            mqttBroker.host, 'client-1', mqttBroker.port);

        await connect();
      }
    }
    notifyListeners();
  }

  void Fetchitems() async {
    _items.clear();
    _items = await OpenHabService().getItems();
    notifyListeners();
  }

  Future<void> getSensorData() async {
    for (var thing in _selectedThings) {
      for (var channels in thing.channels!) {
        for (var linkeditem in channels.linkedItems) {
          for (var item in items) {
            if (linkeditem == item.name) {
              item.state = await OpenHabService().getItemState(linkeditem);
              notifyListeners();
            }
          }
        }
      }
    }
  }

  void selectThingsByLocation(String location) {
    _selectedThings.clear();
    for (var thing in things) {
      if (thing.label != "MQTT Broker" && thing.location == location) {
        _selectedThings.add(thing);
      }
    }
    notifyListeners();
  }

  Future<MqttServerClient> connect() async {
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.onUnsubscribed = onUnsubscribed;
    client.autoReconnect = false;

    final connMessage = MqttConnectMessage()
        .authenticateAs("joe", "123")
        .withClientIdentifier('client-1');
    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    return client;
  }

  void subscribeToTopic(String topic) {
    client.subscribe(topic, MqttQos.exactlyOnce);
  }

  // connection succeeded
  void onConnected() {
    print('Connected');
  }

  // unconnected
  void onDisconnected() {
    print('Disconnected');
  }

  // subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  // subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  // unsubscribe succeeded
  void onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
    client.unsubscribe(topic!);
  }

  // PING response received
  void pong() {
    print('Ping response client callback invoked');
  }

  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  Future<List<ChartDataModel>> getPersistenceByName(String name) async {
    return await OpenHabService().getPersistenceByName(name);
  }
}
