import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/utils/colors.dart';

import '../providers/AddSensorState.dart';
import 'AddSensorPage.dart';

class QRScannerPage extends StatefulWidget {
  QRScannerPage({Key? key}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  Barcode? result;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      dynamic data = jsonDecode(result!.code.toString());
      Provider.of<AddSensorState>(context, listen: false).FillFromQRCode(data);
      controller.dispose();
      Fluttertoast.showToast(
          msg: "Qr Scanned",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor:
              Provider.of<AppearanceState>(context, listen: false).isDarkMode
                  ? darkColorTheme
                  : lightColorTheme,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.popUntil(context, ModalRoute.withName('/main'));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CompleteProfileWidget()),
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        overlay: QrScannerOverlayShape(borderColor: Colors.red),
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}
