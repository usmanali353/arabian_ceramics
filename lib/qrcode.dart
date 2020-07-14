import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'found_bluetooth_devices.dart';
class GenerateedQrcode extends StatefulWidget {
  var requestId;

  GenerateedQrcode(this.requestId);

  @override
  _GenerateedQR createState() => _GenerateedQR(requestId);
}

class _GenerateedQR extends State<GenerateedQrcode> {
  var requestId;
  GlobalKey globalKey = new GlobalKey();
  _GenerateedQR(this.requestId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("QR Code"),),
    body: Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         RepaintBoundary(
           key: globalKey,
           child: QrImage(
             data: requestId,
             version: QrVersions.auto,
             size: 200.0,
           ),
         ),
//         MaterialButton(
//           color: Colors.teal,
//           child: Text("Print",style: TextStyle(color: Colors.white),),
//           onPressed: ()async{
//             RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
//             var image = await boundary.toImage();
//             ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
//             Uint8List pngBytes = byteData.buffer.asUint8List();
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>foundBluetoothDevices(image)));
//           },
//
//         )
       ],

     ),
   ),
    );
  }
}
