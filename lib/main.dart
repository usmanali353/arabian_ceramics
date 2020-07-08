import 'package:Arabian_Ceramics/AddModel.dart';
import 'package:Arabian_Ceramics/DetailPage.dart';
import 'package:Arabian_Ceramics/ModelRequests.dart';
import 'package:Arabian_Ceramics/RequestModel.dart';
import 'package:Arabian_Ceramics/Users/Login.dart';
import 'package:Arabian_Ceramics/Utils.dart';
import 'package:Arabian_Ceramics/request_Model_form/Assumptions.dart';
import 'package:Arabian_Ceramics/scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main(){
  runApp(myApp());
}
class myApp extends StatefulWidget {

  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  void initState() {
    Utils.isLogin().then((authenticated){
      if(authenticated){
        setState(() {
          loggedIn=true;
        });
      }else{
        setState(() {
          loggedIn=false;
        });
      }
    });
    super.initState();
  }
  bool loggedIn=false;
  @override
  Widget build(BuildContext context) {
    //final themeNotifier = Provider.of<ThemeNotifier>(context);
    return  MaterialApp(
      title: "Arabian Ceramics",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),//loggedIn?ModelRequests():LoginScreen(),
    );
  }
}
