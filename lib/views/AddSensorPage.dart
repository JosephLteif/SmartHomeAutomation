import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/OpenHabState.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:smarthomeautomation/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String? radioButtonValue;
  TextEditingController locationController = TextEditingController();
  TextEditingController labelController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  addSensorModel sensor = addSensorModel();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedValue = "A";
  String? selectedRoom;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppearanceState>(
      builder: ((context, appearanceState, child) => Consumer<OpenHabState>(
        builder: (context, openhabState, child) => Scaffold(
              resizeToAvoidBottomInset: false,
              key: scaffoldKey,
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Spacer(),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                            child: TextFormField(
                              controller: topicController,
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
                            )),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: TextFormField(
                            controller: labelController,
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
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: DropdownButtonFormField(
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
                            validator: (value) =>
                                value == null ? "Select a Room" : null,
                            value: selectedRoom,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedRoom = newValue!;
                              });
                            },
                            items:
                                openhabState.rooms.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(141, 20, 20, 60),
                          child: DropdownButtonFormField(
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
                            validator: (value) =>
                                value == null ? "Select a country" : null,
                            value: selectedValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items:
                                <String>['A', 'B', 'C', 'D'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
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
                                  sensor.Label = labelController.text.toString();
                                  sensor.Topic = topicController.text.toString();
                                  sensor.Type = selectedValue;
                                  sensor.Location = selectedRoom;
                                  if (await OpenHabService().createProcess(sensor)) {
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
                        const Spacer(flex: 4,),
                      ],
                    ),
                  )),
            ),
      )),
    );
  }
}
