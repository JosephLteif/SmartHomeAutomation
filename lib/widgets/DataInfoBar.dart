import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/utils/colors.dart';

class DataInfoBar extends StatelessWidget {
  IconData icon1, icon2, icon3;
  String text1, text2, text3;
  
  DataInfoBar({ Key? key, required this.icon1, required this.icon2, required this.icon3, required this.text1, required this.text2, required this.text3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<AppearanceState>(context, listen: false).isDarkMode;
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: isDarkMode?const LinearGradient(
          colors: [
            Color(0xFF2b2c44),
            Color(0xFF213249)
          ],
          begin: FractionalOffset(0.0, -.5),
          end: FractionalOffset(0.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp):
          const LinearGradient(
          colors: [
            Colors.white,
            Colors.white
          ],
          begin: FractionalOffset(0.0, -.5),
          end: FractionalOffset(0.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? darkColorTheme : Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 3
          ),
        ],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElementInfoBar(icon1, text1, isDarkMode: isDarkMode, lightModeColor: lightColorTheme),
          ElementInfoBar(icon2, text2, isDarkMode: isDarkMode, lightModeColor: darkColorTheme),
          ElementInfoBar(icon3, text3, isDarkMode: isDarkMode, lightModeColor: Colors.red),
        ],
      ),
    );
  }
}

Widget ElementInfoBar(IconData icon, String value, {bool isDarkMode = false, required Color lightModeColor}) {
  return Row(
    children: [
      Icon(icon, size: 35, color: isDarkMode?Colors.white:lightModeColor,),
      Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ],
  );
}