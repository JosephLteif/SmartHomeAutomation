import 'dart:math';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/models/ChartDataModel.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/widgets/CardElement.dart';
import 'package:smarthomeautomation/widgets/TopRowBar.dart';

class TestCategoryPage extends StatelessWidget {
  String title;
  TestCategoryPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<AppearanceState>(context, listen: false).isDarkMode;
    List<ChartDataModel> dataItems = List.generate(
      10,
      (i) => ChartDataModel(
        x: i,
        y: Random().nextInt(100).toDouble(),
      ),
    );
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TopRowBar(
              title: title,
              backArrow: true,
            ),
            SizedBox(
              height: height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: BarChart(BarChartData(
                  borderData: FlBorderData(
                    border: Border(
                      bottom: BorderSide(
                        color: isDarkMode ? Colors.white : Colors.black,
                        width: 4,
                      ),
                    ),
                  ),
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: false),
                  groupsSpace: 10,
                  barGroups: dataItems
                      .map((e) => BarChartGroupData(x: e.x, barRods: [
                            BarChartRodData(
                                toY: e.y,
                                width: 15,
                                gradient: LinearGradient(
                                  begin: const FractionalOffset(0.0, 1.0),
                                  end: const FractionalOffset(0.0, -.5),
                                  colors: isDarkMode
                                      ? e.x % 2 == 0
                                          ? [
                                              const Color.fromARGB(
                                                  255, 23, 118, 165),
                                              const Color(0xFF1c4a66),
                                            ]
                                          : [
                                              const Color.fromARGB(
                                                  255, 27, 164, 119),
                                              const Color(0xFF1e5b4c),
                                            ]
                                      : [
                                          const Color(0xFFaceae4),
                                          const Color(0xFFaceae4),
                                        ],
                                )),
                          ]))
                      .toList())),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: height * 0.3,
                  child: CardElement(
                    device: "Thermometer",
                    value: "24",
                    unit: "°C",
                    title: "Living Room",
                    icon: Icons.home,
                    color: const Color(0xFFf26889),
                  ),
                ),
                SizedBox(
                  height: height * 0.3,
                  child: CardElement(
                    device: "Thermometer",
                    value: "24",
                    unit: "°C",
                    title: "Living Room",
                    icon: Icons.home,
                    color: const Color(0xFFf26889),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
