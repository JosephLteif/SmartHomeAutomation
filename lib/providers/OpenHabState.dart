import 'package:flutter/cupertino.dart';
import 'package:smarthomeautomation/models/ItemModel.dart';
import 'package:smarthomeautomation/models/ThingModel.dart';
import 'package:smarthomeautomation/services/OpenHabService.dart';

class OpenHabState extends ChangeNotifier{
  List<Thing> _things = [];
  List<Thing> get things => _things;

  List<Item> _items = [];
  List<Item> get items => _items;

  final List<String> _rooms = [];
  List<String> get rooms => _rooms;
  

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
    _things.forEach((thing) => _rooms.add(thing.location!));
    notifyListeners();
  }
  void Fetchitems() async{
    _items.clear();
    _items = await OpenHabService().getItems();
    notifyListeners();
  }
}