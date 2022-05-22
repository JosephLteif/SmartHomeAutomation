import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/FingerPrint.dart';


class FingerPrintPage extends StatefulWidget {
  const FingerPrintPage({Key? key}) : super(key: key);

  @override
  State<FingerPrintPage> createState() => _FingerPrintPageState();
}

class _FingerPrintPageState extends State<FingerPrintPage> {
  Color Iconcolor = Colors.white;

  init() async {
    bool auth = await LocalAuthApi.authenticate();

    if(auth == true)
    {
      Iconcolor = Colors.green;
      Fluttertoast.showToast(msg: 'Authenticated');
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/main');
      });
    } else {
      Fluttertoast.showToast(msg: 'Unauthenticated');
      Iconcolor = Colors.red;
      Future.delayed(const Duration(seconds: 1), () {
        exit(0);
      });
    }
    setState(() {
      
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Icon(Icons.fingerprint, size: 128, color: Iconcolor,),),
    );
  }
}
