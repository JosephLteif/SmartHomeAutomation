import 'package:flutter/material.dart';

import '../services/FingerPrint.dart';


class FingerPrintPage extends StatefulWidget {
  const FingerPrintPage({Key? key}) : super(key: key);

  @override
  State<FingerPrintPage> createState() => _FingerPrintPageState();
}

class _FingerPrintPageState extends State<FingerPrintPage> {

  init() async {
    bool auth = await LocalAuthApi.authenticate();

    if(auth == true)
    {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Auth')),
    );
  }
}
