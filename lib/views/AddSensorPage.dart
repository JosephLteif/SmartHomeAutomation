import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:smarthomeautomation/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';

import '../services/OpenHabService.dart';

class CompleteProfileWidget extends StatefulWidget {
  const CompleteProfileWidget({Key? key}) : super(key: key);

  @override
  _CompleteProfileWidgetState createState() => _CompleteProfileWidgetState();
}

class _CompleteProfileWidgetState extends State<CompleteProfileWidget>
    with TickerProviderStateMixin {
  String? radioButtonValue;
  TextEditingController? ailmentsController;
  TextEditingController? labelController;
  TextEditingController? topicController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedValue = "A";

  @override
  void initState() {
    super.initState();

    ailmentsController = TextEditingController();
    labelController = TextEditingController();
    topicController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppearanceState>(
      builder: ((context, appearanceState, child) => Scaffold(
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
              actions: [],
              centerTitle: false,
              elevation: 0,
            ),
            body: Container(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: Image.asset(
                      'assets/images/page_background.png',
                    ).image,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    /*Couldn't decide might use later
                    mainAxisAlignment: MainAxisAlignment.center,*/
                    children: [
                      Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
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
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
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
                        padding:
                            EdgeInsetsDirectional.fromSTEB(141, 20, 20, 60),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: appearanceState.isDarkMode
                                      ? Color.fromRGBO(51, 255, 236, 1)
                                      : Color.fromRGBO(118, 98, 255, 1),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (true) {
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
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
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
                    ],
                  ),
                )),
          )),
    );
  }
}
