class Thing {
  String? label;
  String? bridgeUID;
  dynamic configuration;
  dynamic properties;
  String? uID;
  String? thingTypeUID;
  List<Channels>? channels;
  String? location;

  Thing(
      {this.label,
      this.bridgeUID,
      this.configuration,
      this.properties,
      this.uID,
      this.thingTypeUID,
      this.channels,
      this.location});

  Thing.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    bridgeUID = json['bridgeUID'];
    configuration = json['configuration'];
    properties = json['properties'];
    uID = json['UID'];
    thingTypeUID = json['thingTypeUID'];
    if (json['channels'] != null) {
      channels = <Channels>[];
      json['channels'].forEach((v) {
        channels!.add(Channels.fromJson(v));
      });
    }
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['bridgeUID'] = bridgeUID;
    if (configuration != null) {
      data['configuration'] = configuration!.toJson();
    }
    if (properties != null) {
      data['properties'] = properties!.toJson();
    }
    data['UID'] = uID;
    data['thingTypeUID'] = thingTypeUID;
    if (channels != null) {
      data['channels'] = channels!.map((v) => v.toJson()).toList();
    }
    data['location'] = location;
    return data;
  }
}

class Channels {
  late List<String> linkedItems;
  String? uid;
  String? id;
  String? channelTypeUID;
  String? itemType;
  String? kind;
  String? label;
  String? description;
  List<String>? defaultTags;
  dynamic properties;
  dynamic configuration;

  Channels(
      {this.linkedItems = const [],
      this.uid,
      this.id,
      this.channelTypeUID,
      this.itemType,
      this.kind,
      this.label,
      this.description,
      this.defaultTags,
      this.properties,
      this.configuration});

  Channels.fromJson(Map<String, dynamic> json) {
    if(json['linkedItems'] != null) {
      linkedItems = [];
      json['linkedItems'].forEach((v) {
        linkedItems.add(v.toString());
      });
    } else {
      linkedItems = [];
    }
    uid = json['uid'];
    id = json['id'];
    channelTypeUID = json['channelTypeUID'];
    itemType = json['itemType'];
    kind = json['kind'];
    label = json['label'];
    description = json['description'];
    defaultTags = json['defaultTags'].cast<String>();
    properties = json['properties'];
    configuration = json['configuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['linkedItems'] = linkedItems;
    data['uid'] = uid;
    data['id'] = id;
    data['channelTypeUID'] = channelTypeUID;
    data['itemType'] = itemType;
    data['kind'] = kind;
    data['label'] = label;
    data['description'] = description;
    data['defaultTags'] = defaultTags;
    if (properties != null) {
      data['properties'] = properties!.toJson();
    }
    if (configuration != null) {
      data['configuration'] = configuration!.toJson();
    }
    return data;
  }
}
