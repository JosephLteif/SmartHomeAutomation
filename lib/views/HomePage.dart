import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    // if(!didUpdate) {
    //   Provider.of<OpenHabState>(context).update();
    //   didUpdate = true;
    // }
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
                              device: "Thermometer",
                              value: "24",
                              unit: "°C",
                              title: "Living Room",
                              icon: Icons.home,
                              color: const Color(0xFF6f5eff),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.5,
                            child: CardElement(
                              device: "Thermometer",
                              value: "24",
                              unit: "°C",
                              title: "Living Room",
                              icon: Icons.home,
                              color: const Color(0xFF14c3b5),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.5,
                            child: CardElement(
                              device: "Thermometer",
                              value: "24",
                              unit: "°C",
                              title: "Living Room",
                              icon: Icons.home,
                              color: const Color(0xFFf26889),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.3,
                            child: CardElement(
                              device: "Thermometer",
                              value: "24",
                              unit: "°C",
                              title: "Living Room",
                              icon: Icons.home,
                              color: const Color(0xFFe27061),
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
