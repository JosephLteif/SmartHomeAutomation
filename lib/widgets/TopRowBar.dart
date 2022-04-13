import 'package:flutter/material.dart';

class TopRowBar extends StatelessWidget {
  String title;
  TopRowBar({Key? key,  required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(title)),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_rounded))),
      ],
    );
  }
}