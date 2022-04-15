import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/utils/colors.dart';

class TopRowBar extends StatelessWidget {
  String title;
  bool backArrow;
  TopRowBar({Key? key, required this.title, this.backArrow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<AppearanceState>(context, listen: false).isDarkMode;
    return Stack(
      children: <Widget>[
        backArrow
            ? Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: isDarkMode ? Colors.white : backArrowColor,
                    ),
                    label: Text(
                      'back',
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : backArrowColor),
                    )))
            : Container(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(alignment: Alignment.center, child: Text(title)),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))),
      ],
    );
  }
}
