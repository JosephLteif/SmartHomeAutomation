import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/utils/colors.dart';
import 'HomePage.dart';
import 'PlaceHolderPage.dart';
import 'RoomsPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

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
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              selectedItemColor:
                  value.isDarkMode ? darkColorTheme : lightColorTheme,
              unselectedItemColor:
                  value.isDarkMode ? Colors.white : Colors.black,
              selectedFontSize: 12,
              elevation: 0,
              onTap: (index) => setState(() => currentIndex = index),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.house),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.wifi),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart_sharp),
                  label: '',
                ),
              ],
            ),
          )),
    );
  }
}
