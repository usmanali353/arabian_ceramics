import 'package:Arabian_Ceramics/DetailPage.dart';
import 'package:Arabian_Ceramics/Model/Product.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
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

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          scan();
//          BarcodeScanner.scan().then((barcodeData){
//            ProgressDialog pd=ProgressDialog(context);
//            pd.show();
//            print('scan results'+barcodeData.toString());
//            Firestore.instance.collection("model_requests").document(barcodeData.toString()).get().then((documentSnapshot){
//              pd.hide();
//              if(documentSnapshot.exists){
//                Product p=Product.fromMap(documentSnapshot.data);
//                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(p,documentSnapshot.documentID)));
//              }
//            }).catchError((onError){
//              pd.hide();
//              Flushbar(
//                message: "No Product Info Found",
//                backgroundColor: Colors.red,
//                duration: Duration(seconds: 5),
//              )..show(context);
//            });
//          }).catchError((onError){
//            Flushbar(
//              message: onError.toString(),
//              backgroundColor: Colors.red,
//              duration: Duration(seconds: 5),
//            )..show(context);
//          });
        },
        child: Icon(Icons.camera_enhance),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future scan() async {
    try {
      barcode = (await BarcodeScanner.scan()) as String;
      print(barcode);
      setState(() {
        this.barcode = barcode;

        ProgressDialog pd=ProgressDialog(context);
        pd.show();
        Firestore.instance.collection("model_requests").document(barcode).get().then((documentSnapshot){
          if(documentSnapshot.exists){
            pd.hide();
            Product p=Product.fromMap(documentSnapshot.data);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(p,documentSnapshot.documentID)));
          }
        }).catchError((onError){
          pd.hide();
          Flushbar(
            message: "No Product Info Found",
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          )..show(context);
        });
      });
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