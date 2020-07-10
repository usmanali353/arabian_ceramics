import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class GenerateedQrcode extends StatefulWidget {
  var requestId;

  GenerateedQrcode(this.requestId);

  @override
  _GenerateedQR createState() => _GenerateedQR(requestId);
}

class _GenerateedQR extends State<GenerateedQrcode> {
  var requestId;

  _GenerateedQR(this.requestId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("QR Code"),),
    body: Center(
     child: QrImage(
        data: requestId,
       version: QrVersions.auto,
       size: 200.0,
     ),
   ),
    );
  }
}
