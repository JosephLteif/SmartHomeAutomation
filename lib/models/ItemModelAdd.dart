class AddItem {
  String? type;
  String? name;
  String? label;
  String? category;
  List<String>? tags;
  List<String>? groupNames;
  String? groupType;
  Functions? function;

  AddItem(
      {this.type,
      this.name,
      this.label,
      this.category,
      this.tags,
      this.groupNames,
      this.groupType,
      this.function});

  AddItem.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    label = json['label'];
    category = json['category'];
    tags = json['tags'].cast<String>();
    groupNames = json['groupNames'].cast<String>();
    groupType = json['groupType'];
    function = json['function'] != null
        ? new Functions.fromJson(json['function'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['name'] = this.name;
    data['label'] = this.label;
    data['category'] = this.category;
    data['tags'] = this.tags;
    data['groupNames'] = this.groupNames;
    data['groupType'] = this.groupType;
    if (this.function != null) {
      data['function'] = this.function!.toJson();
    }
    return data;
  }
}

class Functions {
  String? name;
  List<String>? params;

  Functions({this.name, this.params});

  Functions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    params = json['params'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['params'] = this.params;
    return data;
  }
}