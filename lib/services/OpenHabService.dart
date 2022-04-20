import 'dart:convert';

import 'package:dio/dio.dart' as d;
import 'package:smarthomeautomation/models/ItemModel.dart';
import 'package:smarthomeautomation/models/ThingModel.dart';
import 'package:smarthomeautomation/utils/endpoint.dart';

import 'OpenHabDio.dart';

class OpenHabService {
  d.Dio dio = OpenHabDio().dio;

  Future<List<Thing>> getThings() async {
    List<Thing> things = [];
    try {
      d.Response response = await dio.get(thingsEndpoint);
      if (response.statusCode == 200) {
        response.data.forEach((thing) => things.add(Thing.fromJson(thing)));
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
    return things;
  }

  Future<List<Item>> getItems() async {
    List<Item> items = [];
    try {
      d.Response response = await dio.get(itemsEndpoint);
      if (response.statusCode == 200) {
        response.data.forEach((thing) => items.add(Item.fromJson(thing)));
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
    return items;
  }

  Future<String> getItemState(String name) async {
    try {
      d.Response response =
          await dio.get(itemStateEndpoint.replaceAll('{itemname}', name));
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> checkAuthentication(String email, String password) async {
    var auth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
    try {
      d.Response response = await d.Dio().get(
        host + uuidEndpoint,
        options: d.Options(headers: {'authorization': auth}),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future postThing(Thing thing) async {
    try {
      d.Response response = await d.Dio().post(thingsEndpoint);
      if (response.statusCode == 201) {
        return response.statusCode;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future postItem(Item item) async {
    try {
      d.Response response = await d.Dio().put(thingsEndpoint);
      if (response.statusCode == 201) {
        return response.statusCode;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future putLink(String uuid, String itemName) async {
    try {
      d.Response response = await d.Dio().put(linksEndpoint);
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
