import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/utils/colors.dart';
import 'package:smarthomeautomation/widgets/CardElement.dart';
import 'package:smarthomeautomation/widgets/DataInfoBar.dart';
import 'package:smarthomeautomation/widgets/TopRowBar.dart';

class RoomsDetailsPage extends StatefulWidget {
  String title;
  RoomsDetailsPage({Key? key, required this.title}) : super(key: key);

  @override
  State<RoomsDetailsPage> createState() => _RoomsDetailsPageState();
}

class _RoomsDetailsPageState extends State<RoomsDetailsPage> {
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
    bool isDarkMode =
        Provider.of<AppearanceState>(context, listen: false).isDarkMode;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TopRowBar(title: widget.title, backArrow: true,),
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
            Container(
              height: width * 0.7,
              width: width * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 25,
                    spreadRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: SleekCircularSlider(
                // TODO change min and max for temp slider
                max: 100,
                min: 0,
                appearance: CircularSliderAppearance(
                  size: width * 0.7,
                  customWidths: CustomSliderWidths(
                      progressBarWidth: 40, trackWidth: 70, handlerSize: 22),
                  customColors: CustomSliderColors(
                      progressBarColors: [
                        Colors.red,
                        Colors.red,
                        Colors.blue,
                      ],
                      trackColor:
                          isDarkMode ? const Color(0xFF253c56) : Colors.white,
                      dotColor: Colors.white,
                      hideShadow: isDarkMode ? true : false,
                      shadowColor: Colors.black.withOpacity(0.01)),
                ),
                onChangeEnd: (double value) {
                  // TODO something about temp slider value
                },
                innerWidget: (value) => Stack(children: [
                  Center(
                    child: Container(
                      height: height * 0.22,
                      width: height * 0.22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        gradient: isDarkMode
                            ? LinearGradient(
                                colors: [
                                  const Color(0xFF2b2e46),
                                  darkColorTheme
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(0.0, 2.5),
                              )
                            : const LinearGradient(
                                colors: [Colors.white, Colors.white],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(0.0, 2.5),
                              ),
                        boxShadow: [
                          BoxShadow(
                            color: isDarkMode
                                ? darkColorTheme.withOpacity(0.3)
                                : lightColorTheme.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${value.toStringAsPrecision(3)} °C",
                            style: const TextStyle(fontSize: 30),
                          ),
                          const Text(
                            "Temp",
                            style: TextStyle(fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Spacer(flex: 1,),
            SizedBox(
              height: 180,
              child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    int number = Random().nextInt(colors.length);
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CardElement(
                          color: colors[number],
                          icon: icons[number],
                          title: titles[number],
                          unit: units[number],
                          value: Random().nextInt(100).toString(),
                          device: titles[number]),
                    );
                  }),
            ),
            Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }
}
