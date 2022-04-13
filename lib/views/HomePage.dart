import 'dart:math';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'dart:math' as math;
import 'package:smarthomeautomation/utils/colors.dart';
import 'package:smarthomeautomation/widgets/CardElement.dart';
import 'package:smarthomeautomation/widgets/DataInfoBar.dart';
import 'package:smarthomeautomation/widgets/testChart.dart';
import 'package:thermostat/thermostat.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AppearanceState>(
      builder: ((context, appearanceState, child) => Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DataInfoBar(icon1: Icons.thermostat,
                    icon2: Icons.water_drop_outlined,
                    icon3: Icons.power,
                    text1: "24°C",
                    text2: "48%",
                    text3: "ON"),
                  ),
                  Thermostat(
                    setPoint: 25,
                    curVal: 20,
                    minVal: 18,
                    maxVal: 38,
                    themeType : appearanceState.isDarkMode ? ThermostatThemeType.dark : ThermostatThemeType.light,
                    onChanged: (value) {
                      if (kDebugMode) {
                        print('Selected value : $value');
                      }
                    },
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                     itemCount: 10,
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context, index) {
                       return Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                         child: CardElement(
                            title: 'Temperature',
                            value: Random().nextInt(99).toString(),
                            unit: '°C',
                            icon: Icons.thermostat,
                            color: lightColorTheme,
                            device: "Air Conditioner",
                          ),
                       );
                      },
                     ),
                  ),
                  const SizedBox(height: 10,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: LineChartSample2(),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Provider.of<AppearanceState>(context, listen: false).toggleDarkMode();
        },)
      )
      ),
    );

  }
}
