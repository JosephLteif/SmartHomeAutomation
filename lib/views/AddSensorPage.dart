import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AddSensorState.dart';
import 'package:smarthomeautomation/providers/OpenHabState.dart';

import 'package:flutter/material.dart';
import 'package:smarthomeautomation/utils/colors.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';

import '../services/OpenHabService.dart';
import '../models/addSensorModel.dart';

class CompleteProfileWidget extends StatefulWidget {
  const CompleteProfileWidget({Key? key}) : super(key: key);

  @override
  _CompleteProfileWidgetState createState() => _CompleteProfileWidgetState();
}

class _CompleteProfileWidgetState extends State<CompleteProfileWidget>
    with TickerProviderStateMixin {
  bool radioButtonValue = false;
  TextEditingController locationController = TextEditingController();

  addSensorModel sensor = addSensorModel();
  String? selectedValue;
  String? selectedRoom;

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<AddSensorState>(context, listen: false).clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppearanceState>(
      builder: ((context, appearanceState, child) => Consumer<OpenHabState>(
            builder: (context, openhabState, child) => Consumer<AddSensorState>(
              builder: (context, addSensorState, child) => Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: darkColorScaffoldTheme,
                  automaticallyImplyLeading: false,
                  leading: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.chevron_left_rounded,
                      size: 32,
                    ),
                  ),
                  title: const Text(
                    'Add Sensor',
                  ),
                  centerTitle: false,
                  elevation: 0,
                ),
                body: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                icon: const Icon(Icons.qr_code_rounded),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/qrscanner');
                                }),
                          ),
                          const Spacer(),
                          TextFormField(
                            initialValue: addSensorState.getTopic(),
                            onChanged: addSensorState.setTopic,
                            keyboardType: TextInputType.emailAddress,
                            keyboardAppearance: appearanceState.isDarkMode
                                ? Brightness.dark
                                : Brightness.light,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: const Text('Topic'),
                              hintText: 'topic/channel',
                            ),
                            validator: (topic) {
                              if (topic!.isEmpty) {
                                return null;
                              }
                              return 'Invalid Topic';
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: addSensorState.getLabel(),
                            onChanged: addSensorState.setLabel,
                            keyboardType: TextInputType.emailAddress,
                            keyboardAppearance: appearanceState.isDarkMode
                                ? Brightness.dark
                                : Brightness.light,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: const Text('Label'),
                              hintText: 'TempSensor',
                            ),
                            validator: (Label) {
                              if (Label!.isEmpty) {
                                return null;
                              }
                              return 'Invalid Label';
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text("Existing room"),
                              Radio<bool>(
                                  value: radioButtonValue,
                                  groupValue: true,
                                  onChanged: (value) {
                                    setState(() {
                                      radioButtonValue = !radioButtonValue;
                                    });
                                  }),
                              const Spacer(),
                              const Text("New room"),
                              Radio<bool>(
                                  value: !radioButtonValue,
                                  groupValue: true,
                                  onChanged: (value) {
                                    setState(() {
                                      radioButtonValue = !radioButtonValue;
                                    });
                                  }),
                            ],
                          ),
                          const SizedBox(height: 16),
                          radioButtonValue
                              ? DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: appearanceState.isDarkMode
                                              ? const Color.fromRGBO(
                                                  51, 255, 236, 1)
                                              : const Color.fromRGBO(
                                                  118, 98, 255, 1),
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) =>
                                      value == null ? "Select a Room" : null,
                                  value: selectedRoom,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedRoom = newValue!;
                                    });
                                  },
                                  items: openhabState.rooms.map((String value) {
                                    return DropdownMenuItem(
                                      value: value.toString(),
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )
                              : TextFormField(
                                  controller: locationController,
                                  keyboardType: TextInputType.emailAddress,
                                  keyboardAppearance: appearanceState.isDarkMode
                                      ? Brightness.dark
                                      : Brightness.light,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    label: const Text('Room'),
                                    hintText: 'TempSensor',
                                  ),
                                  validator: (Label) {
                                    if (Label!.isEmpty) {
                                      return null;
                                    }
                                    return 'Invalid Label';
                                  },
                                ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: appearanceState.isDarkMode
                                        ? const Color.fromRGBO(51, 255, 236, 1)
                                        : const Color.fromRGBO(118, 98, 255, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            value: selectedValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: <String>[
                              'Temperature',
                              'Water',
                              'Infrared',
                              'Sound',
                              'Light'
                            ].map((String value) {
                              return DropdownMenuItem(
                                value: value.toString(),
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    sensor.Label = addSensorState.getLabel();
                                    sensor.Topic = addSensorState.getTopic();
                                    sensor.Type = selectedValue;
                                    sensor.Location = radioButtonValue
                                        ? selectedRoom
                                        : locationController.text.toString();
                                    if (await OpenHabService()
                                        .createProcess(sensor)) {
                                      openhabState.update();
                                      //Temporary Until Services are done
                                      Fluttertoast.showToast(
                                          msg: "Connection Made",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              appearanceState.isDarkMode
                                                  ? darkColorTheme
                                                  : lightColorTheme,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Navigator.pushReplacementNamed(
                                          context, '/main');
                                    } //Always true thus grayed out
                                    else {
                                      Fluttertoast.showToast(
                                          msg: "Connection Failed",
                                          gravity: ToastGravity.BOTTOM,
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: const Text("Add Sensor"),
                                ),
                              )
                            ],
                          ),
                          const Spacer(
                            flex: 4,
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          )),
    );
  }
}
