import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/providers/OpenHabState.dart';
import 'package:smarthomeautomation/utils/colors.dart';
import 'package:smarthomeautomation/widgets/CardElement.dart';

import 'AddSensorPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool didUpdate = false;
  List<Color> colors = [
    const Color(0xFF6f5eff),
    const Color(0xFF14c3b5),
    const Color(0xFFf26889),
    const Color(0xFFe27061),
    Color.fromARGB(255, 255, 199, 31),
  ];
  List<IconData> icons = [
    Icons.home,
    Icons.water_drop_outlined,
    Icons.thermostat,
    Icons.camera,
    Icons.light
  ];
  List<String> titles = [
    "Home",
    "WaterLevel",
    "Temperature",
    "Security",
    "Light"
  ];
  List<String> units = ["Rooms", "Liters", "°C", "CCTV Cameras", "Lights"];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppearanceState>(
      builder: ((context, appearanceState, child) => Consumer<OpenHabState>(
            builder: (context, openhabState, child) => Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Smart ",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: appearanceState.isDarkMode
                                          ? darkColorTheme
                                          : lightColorTheme)),
                              const Text("Home",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Provider.of<AppearanceState>(context,
                                        listen: false)
                                    .toggleDarkMode();
                              },
                              icon: Icon(Provider.of<AppearanceState>(context,
                                          listen: false)
                                      .isDarkMode
                                  ? Icons.dark_mode
                                  : Icons.light_mode)),
                          CircleAvatar(
                            backgroundColor: appearanceState.isDarkMode
                                ? darkColorTheme
                                : lightColorTheme,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("My ",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold)),
                              Text("Home",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: appearanceState.isDarkMode
                                          ? darkColorTheme
                                          : lightColorTheme)),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            color: appearanceState.isDarkMode
                                ? darkColorTheme
                                : lightColorTheme,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CompleteProfileWidget()),
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 18,
                        crossAxisSpacing: 18,
                        children: [
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.3,
                            child: CardElement(
                              isRoom: true,
                              device: "",
                              value: openhabState.items.isEmpty
                                  ? '0'
                                  : openhabState.items
                                      .where((element) =>
                                          element.category ==
                                          titles.elementAt(2).toLowerCase())
                                      .toList()
                                      .map((e) => double.parse(
                                          e.state.toString() == "NULL"
                                              ? '0'
                                              : e.state.toString()))
                                      .reduce(
                                          (value, element) => value + element)
                                      .toString(),
                              unit: units.elementAt(2),
                              title: titles.elementAt(2),
                              icon: icons.elementAt(2),
                              color: colors.elementAt(2),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.5,
                            child: CardElement(
                              isRoom: true,
                              device: "",
                              value: openhabState.items.isEmpty
                                  ? '0'
                                  : openhabState.items
                                      .where((element) =>
                                          element.category ==
                                          titles.elementAt(4).toLowerCase())
                                      .toList()
                                      .length
                                      .toString(),
                              unit: units.elementAt(4),
                              title: titles.elementAt(4),
                              icon: icons.elementAt(4),
                              color: colors.elementAt(4),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.5,
                            child: CardElement(
                              isRoom: true,
                              device: "",
                              value: openhabState.items.isEmpty
                                  ? '0'
                                  : openhabState.items
                                      .where((element) =>
                                          element.category ==
                                          titles.elementAt(3).toLowerCase())
                                      .toList()
                                      .length
                                      .toString(),
                              unit: units.elementAt(3),
                              title: titles.elementAt(3),
                              icon: icons.elementAt(3),
                              color: colors.elementAt(3),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.3,
                            child: CardElement(
                              isRoom: true,
                              device: "",
                              value: openhabState.items.isEmpty
                                  ? '0'
                                  : openhabState.items
                                      .where((element) =>
                                          element.category ==
                                          titles.elementAt(2).toLowerCase())
                                      .toList()
                                      .map((e) => double.parse(
                                          e.state.toString() == "NULL"
                                              ? '0'
                                              : e.state.toString()))
                                      .reduce(
                                          (value, element) => value + element)
                                      .toString(),
                              unit: units.elementAt(1),
                              title: titles.elementAt(1),
                              icon: icons.elementAt(1),
                              color: colors.elementAt(1),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
