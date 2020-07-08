import 'file:///C:/Users/IIB/AndroidStudioProjects/flutter_app/lib/Model/Product.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScanner extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _QRScanner_State();
  }

}

class _QRScanner_State extends State<QRScanner>{
  String barcode;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF004c4c),
        title: Text("Create Production Request", style: TextStyle(
            color: Colors.white
        ),),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            QrImage(
              data: Product(name:'ARAGON CREAM',surface: 'GLOSSY',thickness:'9mm',size: '45x45 cm',range: 'DAR',material:'MARBLE',colour: 'BEIGE, BROWN',technology:'DIGITAL',structure: 'PLAIN',classification:'NATURAL',suitibility: 'RESIDENTIAL AREA,LIVING ROOM,BATHROOM',image: null).toJson().toString(),
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        child: Icon(Icons.camera_enhance),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future scan() async {
    try {
      barcode = (await BarcodeScanner.scan()) as String;
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}