import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/widgets/CardElement.dart';
import 'package:smarthomeautomation/widgets/DataInfoBar.dart';
import 'package:smarthomeautomation/widgets/TopRowBar.dart';
import 'package:thermostat/thermostat.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({ Key? key }) : super(key: key);

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  double currentTemp = 0;
  List<Color> colors = [
    const Color(0xFF6f5eff),
    const Color(0xFF14c3b5),
    const Color(0xFFf26889),
    const Color(0xFFe27061),
    ];
  List<IconData> icons = [
    Icons.home,
    Icons.water_drop_outlined,
    Icons.thermostat,
    Icons.camera,
    ];
  List<String> titles = [
    "Home",
    "Water Level",
    "Temperature",
    "Security",
    ];
  List<String> units = [
    "Rooms",
    "Liters",
    "°C",
    "CCTV Cameras",
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopRowBar(title: "Living room"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DataInfoBar(
                text1: "24°C",
                text2: "48%",
                text3: "ON",
                icon1: Icons.thermostat,
                icon2: Icons.water_drop_outlined,
                icon3: Icons.power,
              ),
            ),
            Spacer(flex: 1,),
            Thermostat(curVal: currentTemp, setPoint: currentTemp, minVal: 0, maxVal: 100, onChanged: (value) => setState(() {
              currentTemp = value;
            }),
            themeType: Provider.of<AppearanceState>(context, listen: false).isDarkMode?ThermostatThemeType.dark:ThermostatThemeType.light,
            size: 350,
            ),
            Spacer(flex: 2,),
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: 10,
                
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  int number = Random().nextInt(colors.length);
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CardElement(color: colors[number], icon: icons[number], title: titles[number], unit: units[number], value: Random().nextInt(100).toString(), device: titles[number]),
                  );
                }),
            ),
            Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}