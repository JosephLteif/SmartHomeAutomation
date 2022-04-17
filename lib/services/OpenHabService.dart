import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smarthomeautomation/models/ThingModel.dart';
import 'package:smarthomeautomation/utils/endpoint.dart';

import 'OpenHabDio.dart';

class OpenHabService {
  Dio dio = OpenHabDio().dio;


  Future<List<Thing>> getThings() async{
    List<Thing> things = [];
    try {
      Response response = await dio.get(thingsEndpoint,);
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
}