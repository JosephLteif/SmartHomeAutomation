import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/models/ChartDataModel.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/providers/OpenHabState.dart';

class CardElement extends StatefulWidget {
  String title, unit, value, device;
  IconData icon;
  Color color;
  bool isRoom;

  CardElement(
      {Key? key,
      required this.color,
      required this.icon,
      required this.title,
      required this.unit,
      required this.value,
      required this.device,
      this.isRoom = false})
      : super(key: key);

  @override
  State<CardElement> createState() => _CardElementState();
}

class _CardElementState extends State<CardElement> {
  List<ChartDataModel> dataItems = [];
  late Timer timer;
  bool isFirstTime = true;
  bool isDarkMode = false;

  init() async {
    dataItems = await Provider.of<OpenHabState>(context, listen: false)
        .getPersistenceByName(widget.title);
    dataItems = dataItems.isEmpty
        ? List.generate(60, (index) => ChartDataModel(x: '0', y: 0.0))
        : dataItems.sublist(dataItems.length - 60);
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    if (!widget.isRoom) {
      init();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      if (!widget.isRoom) {
        timer = Timer.periodic(const Duration(seconds: 5), (timer) {
          init();
        });
      }
      isFirstTime = false;
      isDarkMode =
          Provider.of<AppearanceState>(context, listen: false).isDarkMode;
    }

    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => TestCategoryPage(title: widget.title)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: 150,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: !isDarkMode
              ? LinearGradient(
                  colors: [
                    widget.color,
                    const Color.fromARGB(255, 242, 242, 243),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 2.5),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp)
              : LinearGradient(
                  colors: [const Color.fromARGB(255, 26, 26, 26), widget.color],
                  begin: const FractionalOffset(0.0, -.5),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(isDarkMode ? 0.6 : 0.0),
              offset: const Offset(1, 3),
              blurRadius: 1,
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
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white),
                ),
                Icon(widget.icon, color: Colors.white)
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            if (widget.isRoom)
              if (widget.title == 'Temperature' ||
                  widget.device == 'Temperature')
                Expanded(
                    child: Center(
                        child: double.parse(widget.value) > 30
                            ? const Icon(
                                Icons.sunny,
                                size: 50,
                                color: Colors.white,
                              )
                            : double.parse(widget.value) < 23
                                ? const Icon(
                                    Icons.cloudy_snowing,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.cloud,
                                    size: 50,
                                    color: Colors.white,
                                  )))
              else if (widget.title == 'Light' || widget.device == 'Light')
                GridView.builder(
                    shrinkWrap: true,
                    itemCount: int.parse(widget.value),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                    itemBuilder: (context, index) => const Icon(
                          Icons.light,
                          color: Colors.white,
                        ))
              else if (widget.title == 'Security' ||
                  widget.device == 'Security')
                GridView.builder(
                    shrinkWrap: true,
                    itemCount: int.parse(widget.value),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                    itemBuilder: (context, index) => const Icon(
                          Icons.camera,
                          color: Colors.white,
                        )),
            const Spacer(
              flex: 2,
            ),
            Text("${widget.value} ${widget.unit}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
            const Spacer(
              flex: 1,
            ),
            Text(widget.device, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
