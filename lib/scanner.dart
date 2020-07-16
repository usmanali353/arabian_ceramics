import 'package:Arabian_Ceramics/DetailPage.dart';
import 'package:Arabian_Ceramics/Model/Product.dart';
import 'package:barcode_scan/model/model.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';

class QRScanner extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _QRScanner_State();
  }

}

class _QRScanner_State extends State<QRScanner>{
  ScanResult barcode;
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
             Text(barcode!=null?barcode.rawContent:'No Barcode Found')
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
    ProgressDialog pd=ProgressDialog(context);

    try {
      barcode = (await BarcodeScanner.scan());
      print('Barcode '+barcode.rawContent);
      setState(() {
        this.barcode = barcode;
        pd.show();
        Firestore.instance.collection("model_requests").document(barcode.rawContent).get().then((documentSnapshot){
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
      pd.hide();
      if (e.code == BarcodeScanner.cameraAccessDenied) {

       Flushbar(
         message: "Camera Access not Granted",
         backgroundColor: Colors.red,
         duration: Duration(seconds: 5),
       ).show(context);
      } else {
        Flushbar(
          message: e.toString(),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ).show(context);
       // setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      pd.hide();
      Flushbar(
        message: "User returned using the back-button before scanning anything",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ).show(context);
      //setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      pd.hide();
      Flushbar(
        message: e,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ).show(context);
     // setState(() => this.barcode = 'Unknown error: $e');
    }
    return barcode;
  }
}