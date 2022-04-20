import 'package:flutter/cupertino.dart';
import 'package:smarthomeautomation/models/ItemModel.dart';
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
}
