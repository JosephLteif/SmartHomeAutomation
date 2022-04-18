import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smarthomeautomation/models/ItemModel.dart';
import 'package:smarthomeautomation/models/ThingModel.dart';
import 'package:smarthomeautomation/utils/endpoint.dart';

import 'OpenHabDio.dart';

class OpenHabService {
  Dio dio = OpenHabDio().dio;

  Future<List<Thing>> getThings() async{
    List<Thing> things = [];
    try {
      Response response = await dio.get(thingsEndpoint);
      if(response.statusCode == 200){
        response.data.forEach((thing) =>
          things.add( Thing.fromJson(thing))
        );
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
    return things;
  }

  Future<List<Item>> getItems() async{
    List<Item> items = [];
    try {
      Response response = await dio.get(itemsEndpoint);
      if(response.statusCode == 200){
        response.data.forEach((thing) =>
          items.add(Item.fromJson(thing))
        );
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
    return items;
  }

  Future<String> getItemState(String name) async{
    try {
      Response response = await dio.get(itemStateEndpoint.replaceAll('{itemname}', name));
      if(response.statusCode == 200){
        return response.data;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}