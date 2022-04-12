import 'package:flutter/material.dart';

class TopRowBar extends StatelessWidget {
  const TopRowBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back_ios_new))
        ],
      ),
    );
  }
}