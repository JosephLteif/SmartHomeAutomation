import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:collection/collection.dart';

import 'HomePage.dart';
import 'MainPage.dart';

class IntroPage extends StatelessWidget {
  List<Slide> slides = [];

  IntroPage({Key? key}) : super(key: key) {
    slides.add(
      Slide(
        title: "ERASER",
        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        pathImage: "images/photo_eraser.png",
        backgroundColor: const Color(0xfff5a623),
      ),
    );
    slides.add(
      Slide(
        title: "PENCIL",
        description:
            "Ye indulgence unreserved connection alteration appearance",
        pathImage: "images/photo_pencil.png",
        backgroundColor: const Color(0xff203152),
      ),
    );
    slides.add(
      Slide(
        title: "RULER",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "images/photo_ruler.png",
        backgroundColor: const Color(0xff9932CC),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      isScrollable: true,
      slides: slides,
      onDonePress: () => Navigator.pushReplacementNamed(context, '/main'),
      );
  }
}
