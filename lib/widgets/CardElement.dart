import 'package:flutter/material.dart';

class CardElement extends StatelessWidget {
  String title, unit, value, device;
  IconData icon;
  MaterialColor color;
  CardElement({required this.color, required this.icon, required this.title, required this.unit, required this.value, required this.device});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            color,
            Color.fromARGB(255, 242, 242, 243),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 2.5),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(5, 5),
            blurRadius: 10,
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