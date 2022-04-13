import 'package:flutter/material.dart';
import 'package:smarthomeautomation/widgets/TopRowBar.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopRowBar(title: "Living room"),
          ],
        ),
      ),
    );
  }
}