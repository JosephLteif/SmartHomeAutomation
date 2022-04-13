import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';

class CardElement extends StatelessWidget {
  String title, unit, value, device;
  IconData icon;
  Color color;
  
  CardElement({required this.color, required this.icon, required this.title, required this.unit, required this.value, required this.device});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<AppearanceState>(context, listen: false).isDarkMode;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: !isDarkMode?LinearGradient(
          colors: [
            color,
            Color.fromARGB(255, 242, 242, 243),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 2.5),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp):
          LinearGradient(
          colors: [
            Color.fromARGB(255, 26, 26, 26),
            color
          ],
          begin: const FractionalOffset(0.0, -.5),
          end: const FractionalOffset(0.0, 1.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp)
          ,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            offset: const Offset(1, 3),
            blurRadius: 10,
            // spreadRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white),),
              Icon(icon, color: Colors.white)
            ],
          ),
          const Spacer(),
          Text("$value$unit", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40)),
          Text(device, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}