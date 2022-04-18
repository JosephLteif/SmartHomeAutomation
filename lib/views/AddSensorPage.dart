import 'package:provider/provider.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:smarthomeautomation/utils/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';

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
  // final animationsMap = {
  //   'circleImageOnPageLoadAnimation': AnimationInfo(
  //     curve: Curves.bounceOut,
  //     trigger: AnimationTrigger.onPageLoad,
  //     duration: 600,
  //     fadeIn: true,
  //     initialState: AnimationState(
  //       offset: Offset(0, 19),
  //       opacity: 0,
  //     ),
  //     finalState: AnimationState(
  //       offset: Offset(0, 0),
  //       opacity: 1,
  //     ),
  //   ),
  //   'textOnPageLoadAnimation1': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     duration: 600,
  //     delay: 50,
  //     fadeIn: true,
  //     initialState: AnimationState(
  //       offset: Offset(0, 20),
  //       opacity: 0,
  //     ),
  //     finalState: AnimationState(
  //       offset: Offset(0, 0),
  //       opacity: 1,
  //     ),
  //   ),
  //   'textFieldOnPageLoadAnimation1': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     duration: 600,
  //     delay: 100,
  //     fadeIn: true,
  //     initialState: AnimationState(
  //       offset: Offset(0, 20),
  //       opacity: 0,
  //     ),
  //     finalState: AnimationState(
  //       offset: Offset(0, 0),
  //       opacity: 1,
  //     ),
  //   ),
  //   'textFieldOnPageLoadAnimation2': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     duration: 600,
  //     delay: 200,
  //     fadeIn: true,
  //     initialState: AnimationState(
  //       offset: Offset(0, 40),
  //       opacity: 0,
  //     ),
  //     finalState: AnimationState(
  //       offset: Offset(0, 0),
  //       opacity: 1,
  //     ),
  //   ),
  //   'textFieldOnPageLoadAnimation3': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     duration: 600,
  //     delay: 200,
  //     fadeIn: true,
  //     initialState: AnimationState(
  //       offset: Offset(0, 60),
  //       opacity: 0,
  //     ),
  //     finalState: AnimationState(
  //       offset: Offset(0, 0),
  //       opacity: 1,
  //     ),
  //   ),
  //   'textOnPageLoadAnimation2': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     duration: 600,
  //     delay: 250,
  //     fadeIn: true,
  //     initialState: AnimationState(
  //       offset: Offset(0, 50),
  //       opacity: 0,
  //     ),
  //     finalState: AnimationState(
  //       offset: Offset(0, 0),
  //       opacity: 1,
  //     ),
  //   ),
  //   'radioButtonOnPageLoadAnimation': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     duration: 600,
  //     delay: 300,
  //     fadeIn: true,
  //     initialState: AnimationState(
  //       offset: Offset(0, 50),
  //       opacity: 0,
  //     ),
  //     finalState: AnimationState(
  //       offset: Offset(0, 0),
  //       opacity: 1,
  //     ),
  //   ),
  //   'buttonOnPageLoadAnimation1': AnimationInfo(
  //     curve: Curves.bounceOut,
  //     trigger: AnimationTrigger.onPageLoad,
  //     duration: 600,
  //     delay: 350,
  //     fadeIn: true,
  //     initialState: AnimationState(
  //       offset: Offset(0, 40),
  //       opacity: 0,
  //     ),
  //     finalState: AnimationState(
  //       offset: Offset(0, 0),
  //       opacity: 1,
  //     ),
  //   ),
  //   'buttonOnPageLoadAnimation2': AnimationInfo(
  //     curve: Curves.bounceOut,
  //     trigger: AnimationTrigger.onPageLoad,
  //     duration: 600,
  //     delay: 400,
  //     fadeIn: true,
  //     initialState: AnimationState(
  //       offset: Offset(0, 40),
  //       opacity: 0,
  //     ),
  //     finalState: AnimationState(
  //       offset: Offset(0, 0),
  //       opacity: 1,
  //     ),
  //   ),
  // };

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
              backgroundColor: Color(0xFF1A1F24),
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: Color(0xFF1A1F24),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: Image.asset(
                    'assets/images/page_background.png',
                  ).image,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/uiAvatar@2x.png',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: topicController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Topic',
                          labelStyle: const TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color.fromARGB(133, 255, 255, 255)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'arduino1/Temp',
                          hintStyle: const TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0x98FFFFFF),
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(17, 20, 23, 100),
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                        ),
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: appearanceState.isDarkMode
                              ? darkColorTheme
                              : lightColorTheme,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: labelController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Label',
                          labelStyle: const TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color.fromARGB(133, 255, 255, 255),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(17, 20, 23, 100),
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                        ),
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: appearanceState.isDarkMode
                              ? darkColorTheme
                              : lightColorTheme,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: ailmentsController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Ailments',
                          labelStyle: const TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color.fromARGB(211, 211, 211, 211),
                          ),
                          hintText: 'What types of allergies do you have..',
                          hintStyle: const TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0x98FFFFFF),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(17, 20, 23, 100),
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0x00000000),
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    //   child: StreamBuilder<UsersRecord>(
                    //     stream: UsersRecord.getDocument(currentUserReference),
                    //     builder: (context, snapshot) {

                    //       final buttonLoginUsersRecord = snapshot.data;
                    //       return FFButtonWidget(
                    //         onPressed: () async {
                    //           final usersUpdateData = createUsersRecordData(
                    //             displayName: yourNameController.text,
                    //             age: int.parse(yourAgeController.text),
                    //             ailments: ailmentsController.text,
                    //             userSex: radioButtonValue,
                    //           );
                    //           await buttonLoginUsersRecord.reference
                    //               .update(usersUpdateData);
                    //           await Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) =>

                    //             ),
                    //           );
                    //         },
                    //         text: 'Complete Profile',
                    //         options: FFButtonOptions(
                    //           width: 230,
                    //           height: 56,
                    //           color: appearanceState.isDarkMode
                    //                   ? darkColorTheme
                    //                   : lightColorTheme,
                    //           textStyle:
                    //               TextStyle(
                    //                     fontFamily: 'Lexend Deca',
                    //                     color: Color(0x00000000),
                    //                   ),
                    //           elevation: 3,
                    //           borderSide: BorderSide(
                    //             color: Colors.transparent,
                    //             width: 1,
                    //           ),
                    //           borderRadius: 8,
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
