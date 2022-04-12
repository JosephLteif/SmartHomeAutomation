import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smarthomeautomation/utils/colors.dart';
import 'package:smarthomeautomation/widgets/CardElement.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 160,
          child: ListView.builder(
           itemCount: 10,
           scrollDirection: Axis.horizontal,
           itemBuilder: (context, index) {
             return Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8.0),
               child: CardElement(
                  title: 'Temperature',
                  value: '25',
                  unit: '°C',
                  icon: Icons.thermostat,
                  color: lightColorTheme,
                  device: "Air Conditioner",
                ),
             );
            },
           ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: false,
        itemCornerRadius: 24,
        curve: Curves.easeInOutCubicEmphasized,
        onItemSelected: (index) => setState(() => currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.apps),
            title: const Text('Home'),
            textAlign: TextAlign.center,
            activeColor: lightColorTheme,
            inactiveColor: navigationinactivecolor
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.people),
            title: const Text('Users'),
            textAlign: TextAlign.center,
            activeColor: lightColorTheme,
            inactiveColor: navigationinactivecolor
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.message),
            title: const Text(
              'Messages test for mes teset test test ',
            ),
            textAlign: TextAlign.center,
            activeColor: lightColorTheme,
            inactiveColor: navigationinactivecolor
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
            textAlign: TextAlign.center,
            activeColor: lightColorTheme,
            inactiveColor: navigationinactivecolor
          ),
        ],
      ),
    );

  }
}