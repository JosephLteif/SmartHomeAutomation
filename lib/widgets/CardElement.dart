import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/models/ChartDataModel.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/providers/OpenHabState.dart';

class CardElement extends StatefulWidget {
  String title, unit, value, device;
  IconData icon;
  Color color;
  bool isRoom;
  String topic;
  bool canSendData;

  CardElement(
      {Key? key,
      required this.color,
      required this.icon,
      required this.title,
      required this.unit,
      required this.value,
      required this.device,
      this.canSendData = false,
      this.isRoom = false,
      this.topic = "",
      })
      : super(key: key);

  @override
  State<CardElement> createState() => _CardElementState();
}

class _CardElementState extends State<CardElement> {
  List<ChartDataModel> dataItems = List.generate(60, (index) => ChartDataModel(x: '0', y: 0.0));
  late Timer timer;
  bool isFirstTime = true;
  bool isDarkMode = false;
  bool tempbool = false;
  double maxy = 0.0;

  init() async {
    dataItems = await Provider.of<OpenHabState>(context, listen: false)
        .getPersistenceByName(widget.title);
    dataItems = dataItems.isEmpty
        ? List.generate(60, (index) => ChartDataModel(x: '0', y: 0.0))
        : dataItems.length<60?dataItems:dataItems.sublist(dataItems.length);
    maxy = dataItems.reduce((current, next) => current.y > next.y ? current : next).y.toDouble() + 2;
        print(maxy);
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    if (!widget.isRoom) {
      init();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      if (!widget.isRoom) {
        timer = Timer.periodic(
            Duration(seconds: Provider.of<OpenHabState>(context).RefreshRate),
            (timer) {
          init();
        });
      }
      isFirstTime = false;
      isDarkMode =
          Provider.of<AppearanceState>(context, listen: false).isDarkMode;
          
      tempbool = double.parse(widget.value) !=0.0?true:false;
    }

    return Consumer<OpenHabState>(
      builder: (context, openhabState, child) => GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => TestCategoryPage(title: widget.title)));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: 180,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: !isDarkMode
                ? LinearGradient(
                    colors: [
                      widget.color,
                      const Color.fromARGB(255, 242, 242, 243),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 2.5),
                    stops: const [0.0, 1.0],
                    tileMode: TileMode.clamp)
                : LinearGradient(
                    colors: [const Color.fromARGB(255, 26, 26, 26), widget.color],
                    begin: const FractionalOffset(0.0, -.5),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: const [0.0, 1.0],
                    tileMode: TileMode.clamp),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(isDarkMode ? 0.6 : 0.0),
                offset: const Offset(1, 3),
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Icon(widget.icon, color: Colors.white)
                ],
              ),
              if (!widget.isRoom)
                Flexible(
                child: LineChart(LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: false,
                  ),
                  borderData: FlBorderData(
                      show: false,
                      border:
                          Border.all(color: const Color(0xff37434d), width: 1)),
                  minX: 0, //lowest value in the x axis
                  maxX: dataItems.length.toDouble(), //highest value in the x axis
                  minY: 0, //lowest value in the y axis
                  maxY: maxy , //highest value in the y axis
                  lineBarsData: [
                    LineChartBarData(
                      spots: dataItems
                          .map((e) => FlSpot(dataItems.indexOf(e).toDouble(), e.y))
                          .toList(),
                      isCurved: true,
                      gradient: const LinearGradient(
                        colors: [Colors.white, Colors.white],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      barWidth: 5,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: false,
                        gradient: const LinearGradient(
                          colors: [Colors.transparent, Colors.transparent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              if (widget.isRoom)
                if (widget.title == 'Temperature' ||
                    widget.device == 'Temperature')
                  Expanded(
                      child: Center(
                          child: double.parse(widget.value) > 30
                              ? const Icon(
                                  Icons.sunny,
                                  size: 50,
                                  color: Colors.white,
                                )
                              : double.parse(widget.value) < 23
                                  ? const Icon(
                                      Icons.cloudy_snowing,
                                      size: 50,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.cloud,
                                      size: 50,
                                      color: Colors.white,
                                    )))
                else if (widget.title == 'Light' || widget.device == 'Light')
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: int.parse(widget.value),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5),
                      itemBuilder: (context, index) => const Icon(
                            Icons.light,
                            color: Colors.white,
                          ))
                else if (widget.title == 'Security' ||
                    widget.device == 'Security')
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: int.parse(widget.value),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5),
                      itemBuilder: (context, index) => const Icon(
                            Icons.camera,
                            color: Colors.white,
                          )),
              const Spacer(
                flex: 2,
              ),
              Text("${widget.value} ${widget.unit}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
              const Spacer(
                flex: 1,
              ),
              Row(
                children: [
                  Text(widget.device,
                      style: const TextStyle(color: Colors.white)),
                widget.canSendData ?
                  Switch(
                    activeColor: Colors.white,
                      value: tempbool,
                      onChanged: (value) {
                        tempbool = value;
                        if (tempbool) {
                          openhabState.publishMessage(
                              widget.topic,
                              "U");
                        } else {
                          openhabState.publishMessage(
                                  widget.topic,
                              "D");
                        }
                        print(tempbool);
                        setState(() {});
                      })
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
