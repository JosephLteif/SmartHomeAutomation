import 'package:flutter/cupertino.dart';
import 'package:smarthomeautomation/models/ThingModel.dart';
import 'package:smarthomeautomation/services/OpenHabService.dart';

class ThingsState extends ChangeNotifier{
  List<Thing> _things = [];
  List<Thing> get things => _things;

  ThingsState(){
    Fetchthings();
  }

  void Fetchthings() async{
    _things.clear();
    _things = await OpenHabService().getThings();
    notifyListeners();
  }
}