class Item {
  String? type;
  String? name;
  String? label;
  String? category;
  List<String>? tags;
  List<String>? groupNames;
  String? link;
  String? state;
  String? transformedState;
  StateDescription? stateDescription;

  Item(
      {this.type,
      this.name,
      this.label,
      this.category,
      this.tags,
      this.groupNames,
      this.link,
      this.state,
      this.transformedState,
      this.stateDescription});

  Item.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    label = json['label'];
    category = json['category'];
    tags = json['tags'].cast<String>();
    groupNames = json['groupNames'].cast<String>();
    link = json['link'];
    state = json['state'];
    transformedState = json['transformedState'];
    stateDescription = json['stateDescription'] != null
        ? StateDescription.fromJson(json['stateDescription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['label'] = label;
    data['category'] = category;
    data['tags'] = tags;
    data['groupNames'] = groupNames;
    data['link'] = link;
    data['state'] = state;
    data['transformedState'] = transformedState;
    if (stateDescription != null) {
      data['stateDescription'] = stateDescription!.toJson();
    }
    return data;
  }
}

class StateDescription {
  int? minimum;
  int? maximum;
  int? step;
  String? pattern;
  bool? readOnly;
  List<Options>? options;

  StateDescription(
      {this.minimum,
      this.maximum,
      this.step,
      this.pattern,
      this.readOnly,
      this.options});

  StateDescription.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    maximum = json['maximum'];
    step = json['step'];
    pattern = json['pattern'];
    readOnly = json['readOnly'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minimum'] = minimum;
    data['maximum'] = maximum;
    data['step'] = step;
    data['pattern'] = pattern;
    data['readOnly'] = readOnly;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String? value;
  String? label;

  Options({this.value, this.label});

  Options.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['label'] = label;
    return data;
  }
}