import 'package:flutter/material.dart';

class PlaceHolderPage extends StatelessWidget {
  const PlaceHolderPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Coming Soon')
      ),
    );
  }
}