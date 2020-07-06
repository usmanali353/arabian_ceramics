import 'package:Arabian_Ceramics/AddModel.dart';
import 'package:Arabian_Ceramics/DetailPage.dart';
import 'package:Arabian_Ceramics/Login.dart';
import 'package:Arabian_Ceramics/ModelRequests.dart';
import 'package:Arabian_Ceramics/RequestModel.dart';
import 'package:Arabian_Ceramics/scanner.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(myApp());
}
class myApp extends StatefulWidget {

  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    //final themeNotifier = Provider.of<ThemeNotifier>(context);
    return  MaterialApp(
      title: "Arabian Ceramics",
      debugShowCheckedModeBanner: false,
      home: RequestModel(),
    );
  }
}
