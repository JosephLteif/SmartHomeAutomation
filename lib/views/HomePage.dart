import 'dart:math';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'dart:math' as math;
import 'package:smarthomeautomation/utils/colors.dart';
import 'package:smarthomeautomation/widgets/CardElement.dart';
import 'package:thermostat/thermostat.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Thermostat(
              setPoint: 25,
              curVal: 20,
              minVal: 18,
              maxVal: 38,
              onChanged: (value) {
                print('Selected value : $value');
              },
            ),
            SizedBox(
              height: 160,
              child: ListView.builder(
               itemCount: 10,
               scrollDirection: Axis.horizontal,
               itemBuilder: (context, index) {
                 return Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Provider.of<AppearanceState>(context, listen: false).isDarkMode?Provider.of<AppearanceState>(context, listen: false).setDarkMode(false):Provider.of<AppearanceState>(context, listen: false).setDarkMode(true);
      },)
    );

  }
}