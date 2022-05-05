import 'package:flutter/cupertino.dart';

class AddSensorState extends ChangeNotifier{
  String topic = '';
  String label = '';
  String type = '';

  void setTopic(String topic){
    this.topic = topic;
    notifyListeners();
  }

  void setLabel(String label){
    this.label = label;
    notifyListeners();
  }

  void setType(String type){
    this.type = type;
    notifyListeners();
  }

  String getTopic(){
    return this.topic;
  }

  String getLabel(){
    return this.label;
  }

  String getType(){
    return this.type;
  }


  FillFromQRCode(dynamic data){
    setTopic(data['topic']);
    setLabel(data['label']);
    setType(data['type']);
  }

  clear(){
    setTopic('');
    setLabel('');
    setType('');
  }
}