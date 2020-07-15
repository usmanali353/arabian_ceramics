import 'package:Arabian_Ceramics/Users/Login.dart';
import 'package:Arabian_Ceramics/Utils.dart';
import 'package:Arabian_Ceramics/acmcapproval.dart';
import 'package:Arabian_Ceramics/newproductsList.dart';
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
  Map<int, Color> color =
  {
    50:Color.fromRGBO(0,96,94,  .1),
    100:Color.fromRGBO(0,96,94, .2),
    200:Color.fromRGBO(0,96,94, .3),
    300:Color.fromRGBO(0,96,94, .4),
    400:Color.fromRGBO(0,96,94, .5),
    500:Color.fromRGBO(0,96,94, .6),
    600:Color.fromRGBO(0,96,94, .7),
    700:Color.fromRGBO(0,96,94, .8),
    800:Color.fromRGBO(0,96,94, .9),
    900:Color.fromRGBO(0,96,94,  1),
  };
  MaterialColor myColor;
  @override
  void initState() {
     myColor = MaterialColor(0xFF004c4c, color);
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
      theme: ThemeData(
        primarySwatch: myColor,
        brightness: Brightness.light,
      ),
      home: LoginScreen(),//loggedIn?ModelRequests():LoginScreen(),
    );
  }
}
