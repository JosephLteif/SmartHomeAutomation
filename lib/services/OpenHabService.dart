import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:smarthomeautomation/models/ChartDataModel.dart';
import 'package:smarthomeautomation/models/ItemModel.dart';
import 'package:smarthomeautomation/models/ThingModel.dart';
import 'package:smarthomeautomation/models/ThingModelAdd.dart';
import 'package:smarthomeautomation/models/addSensorModel.dart';
import 'package:smarthomeautomation/utils/endpoint.dart';

import '../models/ItemModelAdd.dart';
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

  Future createProcess(addSensorModel sensor) async {
    // ignore: unnecessary_new
    ThingAdd thing = new ThingAdd(
        label: sensor.Label,
        bridgeUID: "mqtt:broker:3a7d3daa6f",
        thingTypeUID: "mqtt:topic",
        location: sensor.Location,
        channels: []);
    ChannelsAdd channel = ChannelsAdd();
    AddItem item = AddItem();
    List<String> x = thing.bridgeUID!.split(":");
    Configuration conf = Configuration();
    Functions fun = Functions();
    List<String> s = ["stuff"];

    channel.uid = thing.thingTypeUID! +
        ":" +
        x[2] +
        ":" +
        sensor.Label! +
        ":" +
        sensor.Label! +
        "item";
    channel.channelTypeUID = "mqtt:string";
    channel.label = sensor.Label;
    channel.id = sensor.Label;
    channel.description = "stuff";
    channel.defaultTags = s;
    conf.stateTopic = sensor.Topic;
    channel.configuration = conf;
    channel.kind = "STATE";
    channel.itemType = "String";
    thing.uID = thing.thingTypeUID! + ":" + x[2] + ":" + sensor.Label!;

    thing.channels!.add(channel);
    if (await OpenHabService().postThing(thing) == 201) {
      item.label = sensor.Label!;
      item.type = "Number";
      item.name = sensor.Label;
      item.category = sensor.Type!.toLowerCase();
      item.groupNames = ["string"];
      item.tags = ["string"];
      item.groupType = "string";
      fun.name = "string";
      fun.params = ["string"];
      item.function = fun;

      print(item.toJson());
      if (await OpenHabService().putItem(item) == 201) {
        if (await OpenHabService().putLink(channel.uid!, item.name!) == 200) {
          return true;
        }
      }
    }
  }

  Future postThing(ThingAdd thing) async {
    try {
      d.Response response = await dio.post(
        thingsEndpoint,
        options: d.Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: thing.toJson(),
      );
      if (response.statusCode == 201) {
        return response.statusCode;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future putItem(AddItem item) async {
    try {
      d.Response response = await dio.put(
        itemsEndpoint + "/" + item.name!,
        options: d.Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: item.toJson(),
      );
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
    var link = {
      "itemName": itemName,
      "channelUID": uuid,
    };
    try {
      d.Response response = await dio.put(
        linksEndpoint + "/" + itemName + "/" + uuid,
        options: d.Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(link),
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ChartDataModel>> getPersistenceByName(String itemName) async {
    List<ChartDataModel> chartData = [];
    try {
      d.Response response =
          await dio.get(persistenceEndpoint.replaceAll('{itemname}', itemName));
      if (response.statusCode == 200) {
        for (var item in response.data['data']) {
          chartData.add(ChartDataModel.fromJson(item));
        }
        return chartData;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
