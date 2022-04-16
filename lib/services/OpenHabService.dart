import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smarthomeautomation/models/ThingModel.dart';
import 'package:smarthomeautomation/utils/endpoint.dart';

class OpenHabService {
  Dio dio = Dio();

  Future<List<Thing>> getThings() async{
    List<Thing> things = [];
    try {
      Response response = await dio.get(thingsEndpoint,
      options: Options(
        headers: {
          'X-OPENHAB-TOKEN': 'eyJraWQiOm51bGwsImFsZyI6IlJTMjU2In0.eyJpc3MiOiJvcGVuaGFiIiwiYXVkIjoib3BlbmhhYiIsImV4cCI6MTY1MDE0MTcyMCwianRpIjoianF6ZjI2RmxndEVHeDVMYXdkM0tXUSIsImlhdCI6MTY1MDEzODEyMCwibmJmIjoxNjUwMTM4MDAwLCJzdWIiOiJhZG1pbiIsImNsaWVudF9pZCI6Imh0dHBzOi8vaG9tZS5teW9wZW5oYWIub3JnIiwic2NvcGUiOiJhZG1pbiIsInJvbGUiOlsiYWRtaW5pc3RyYXRvciJdfQ.VF62JhW7kj3w83ZjO36w7oJsINhOKomcQTRUBd54ZixrJjFhGAzNa7zxlKHci05MdrwXIYy8DJiauSH7rJXPeum0XW8NfQWuS6aAgGmKjuT1OIAd4sHJMKTG-L1ToyT11MLBc4sX9YKhyohieOG25Bovw55RHSnKN9RN8leJR7KVrpWQKrc0Ve7bfH0VNBIKMVHyKFqKz3YxRO3DeZw1eaftNvzwHDOBXLKXdzTwiiSZngMbraSF5IWuBv06RYENLIjn22lOfYPd89bExAu2NiYKkGcGeq7Jo2yk2xp_1LqHZDg4JB1j6rqTzTo5nXu9IN-RByAbDkluNgLqz0XdDw',
        },
      ),
      );
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