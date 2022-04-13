import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/utils/colors.dart';

import 'HomePage.dart';
import 'PlaceHolderPage.dart';
import 'RoomsPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const RoomsPage(),
    const PlaceHolderPage(),
    const PlaceHolderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppearanceState>(
      builder: ((context, value, child) => Scaffold(
        body: pages[currentIndex],
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
              inactiveColor: value.isDarkMode?Colors.white:navigationinactivecolor
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.people),
              title: const Text('Users'),
              textAlign: TextAlign.center,
              activeColor: lightColorTheme,
              inactiveColor: value.isDarkMode?Colors.white:navigationinactivecolor
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.message),
              title: const Text(
                'Messages test for mes teset test test ',
              ),
              textAlign: TextAlign.center,
              activeColor: lightColorTheme,
              inactiveColor: value.isDarkMode?Colors.white:navigationinactivecolor
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Settings'),
              textAlign: TextAlign.center,
              activeColor: lightColorTheme,
              inactiveColor: value.isDarkMode?Colors.white:navigationinactivecolor
            ),
          ],
        ),
      )
      ),
    );
  }
}