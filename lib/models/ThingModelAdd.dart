class ThingAdd {
  String? label;
  String? bridgeUID;
  String? uID;
  String? thingTypeUID;
  List<ChannelsAdd>? channels;
  String? location;

  ThingAdd(
      {this.label,
      this.bridgeUID,
      this.uID,
      this.thingTypeUID,
      this.channels,
      this.location});

  ThingAdd.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    bridgeUID = json['bridgeUID'];
    uID = json['UID'];
    thingTypeUID = json['thingTypeUID'];
    if (json['channels'] != null) {
      channels = <ChannelsAdd>[];
      json['channels'].forEach((v) {
        channels!.add(new ChannelsAdd.fromJson(v));
      });
    }
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['bridgeUID'] = this.bridgeUID;
    data['UID'] = this.uID;
    data['thingTypeUID'] = this.thingTypeUID;
    if (this.channels != null) {
      data['channels'] = this.channels!.map((v) => v.toJson()).toList();
    }
    data['location'] = this.location;
    return data;
  }
}

class ChannelsAdd {
  String? uid;
  String? id;
  String? channelTypeUID;
  String? itemType;
  String? kind;
  String? label;
  String? description;
  List<String>? defaultTags;
  Configuration? configuration;

  ChannelsAdd(
      {this.uid,
      this.id,
      this.channelTypeUID,
      this.itemType,
      this.kind,
      this.label,
      this.description,
      this.defaultTags,
      this.configuration});

  ChannelsAdd.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    id = json['id'];
    channelTypeUID = json['channelTypeUID'];
    itemType = json['itemType'];
    kind = json['kind'];
    label = json['label'];
    description = json['description'];
    defaultTags = json['defaultTags'].cast<String>();
    configuration = json['configuration'] != null
        ? new Configuration.fromJson(json['configuration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['id'] = this.id;
    data['channelTypeUID'] = this.channelTypeUID;
    data['itemType'] = this.itemType;
    data['kind'] = this.kind;
    data['label'] = this.label;
    data['description'] = this.description;
    data['defaultTags'] = this.defaultTags;
    if (this.configuration != null) {
      data['configuration'] = this.configuration!.toJson();
    }
    return data;
  }
}

class Configuration {
  String? stateTopic;

  Configuration({this.stateTopic});

  Configuration.fromJson(Map<String, dynamic> json) {
    stateTopic = json['stateTopic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stateTopic'] = this.stateTopic;
    return data;
  }
}
