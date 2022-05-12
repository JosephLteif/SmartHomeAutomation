import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/models/ChartDataModel.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/providers/OpenHabState.dart';
import 'package:smarthomeautomation/views/TestCategoryPage.dart';

class CardElement extends StatefulWidget {
  String title, unit, value, device;
  IconData icon;
  Color color;

  CardElement(
      {Key? key,
      required this.color,
      required this.icon,
      required this.title,
      required this.unit,
      required this.value,
      required this.device})
      : super(key: key);

  @override
  State<CardElement> createState() => _CardElementState();
}

class _CardElementState extends State<CardElement> {
      List<ChartDataModel> dataItems = [];
      late Timer timer;

    init() async {
      dataItems = await Provider.of<OpenHabState>(context, listen: false).getPersistenceByName(widget.title);
      setState(() {
        
      });
    }

    @override
    initState() {
      super.initState();
      init();
      timer = Timer.periodic(Duration(seconds: 10), (timer) {
        init();
      });
    }

    @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
  }


  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<AppearanceState>(context, listen: false).isDarkMode;
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => TestCategoryPage(title: widget.title)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: 150,
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
            const Spacer(
              flex: 1,
            ),
            dataItems.length!=0?
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
                maxY: dataItems.reduce((current, next) => current.y > next.y ? current : next).y.toDouble() , //highest value in the y axis
                lineBarsData: [
                  LineChartBarData(
                    // spots: const [
                    //   FlSpot(0, 8),
                    //   FlSpot(2.6, 1),
                    //   FlSpot(4.9, 20),
                    //   FlSpot(6.8, 12),
                    //   FlSpot(8, 4),
                    //   FlSpot(9.5, 20),
                    //   FlSpot(11, 4),
                    // ],
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
            ):Container(),
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
            Text(widget.device, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
