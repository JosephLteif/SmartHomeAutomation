import 'package:flutter/cupertino.dart';
import 'package:smarthomeautomation/models/ThingModel.dart';
import 'package:smarthomeautomation/services/OpenHabService.dart';

class OpenHabState extends ChangeNotifier{
  List<Thing> _things = [];
  List<Thing> get things => _things;

  

  OpenHabState(){
    Fetchthings();
  }

  void Fetchthings() async{
    _things.clear();
    _things = await OpenHabService().getThings();
    notifyListeners();
  }
}