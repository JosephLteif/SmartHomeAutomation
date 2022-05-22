class ChartDataModel {
  String x = '0';
  double y = 0;
  ChartDataModel({required this.x, required this.y});

  ChartDataModel.fromJson(Map<String, dynamic> json) {
    x = json['time'].toString();
    y = double.parse(json['state'].toString());
  }
}
