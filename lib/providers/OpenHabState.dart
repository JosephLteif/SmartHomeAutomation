import 'package:flutter/cupertino.dart';
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
        mqttBroker.host = temp["host"];
        mqttBroker.port = temp["port"].toString();
      }
    }
    notifyListeners();
  }
  void Fetchitems() async{
    _items.clear();
    _items = await OpenHabService().getItems();
    notifyListeners();
  }
}