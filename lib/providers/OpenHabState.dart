import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smarthomeautomation/models/ItemModel.dart';
import 'package:smarthomeautomation/models/MqttBroker.dart';
import 'package:smarthomeautomation/models/ThingModel.dart';
import 'package:smarthomeautomation/services/OpenHabService.dart';

class OpenHabState extends ChangeNotifier{
  List<Thing> _things = [];
  List<Thing> get things => _things;

  List<Item> _items = [];
  List<Item> get items => _items;

  final List<String> _rooms = [];
  List<String> get rooms => _rooms;

  MqttBroker mqttBroker = MqttBroker();
  
  late MqttServerClient client;

  OpenHabState(){
    update();
  }

  update(){
    Fetchthings();
    Fetchitems();
  }

  void Fetchthings() async{
    _things.clear();
    _rooms.clear();
    _things = await OpenHabService().getThings();
    for (var thing in _things) {
      String location = thing.location??'';
      if(location!=''){
        if(!_rooms.contains(location)){
          _rooms.add(location);
        }
      }
      if(thing.label == "MQTT Broker"){
        dynamic temp = thing.configuration;
        mqttBroker.host = '${temp["host"]}';
        mqttBroker.port = temp["port"];
        client = MqttServerClient.withPort(mqttBroker.host, 'client-1', mqttBroker.port, maxConnectionAttempts: 10);
      }
    }
    notifyListeners();
  }
  void Fetchitems() async{
    _items.clear();
    _items = await OpenHabService().getItems();
    notifyListeners();
  }

  Future<MqttServerClient> connect() async {
    client.logging(on: false);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.onUnsubscribed = onUnsubscribed;
    client.autoReconnect = true;

    final connMessage = MqttConnectMessage()
    .startClean()
    .withClientIdentifier('client-1');
    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {   
      MqttPublishMessage temp = c[0].payload as MqttPublishMessage;
      dynamic _temp = MqttPublishPayload.bytesToStringAsString(temp.payload.message);
      List<Thing> tempthings = [];
      for (var thing in things) {
        if(thing.label!="MQTT Broker" && thing.channels!.first.configuration['stateTopic'] == c[0].topic){
          tempthings.add(thing);
        }
      }
      for (var thing in tempthings) {
        for (var channels in thing.channels!) {
          for (var linkeditem in channels.linkedItems) {
            for (var item in items) {
              if(linkeditem == item.name){
                print('_temp: $_temp');
                item.state = _temp;
                notifyListeners();
              }
            }
          }
        }
      }
      print('Received message:${_temp} from topic: ${c[0].topic}>');
    });
    
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
}