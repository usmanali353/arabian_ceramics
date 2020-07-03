import 'package:Arabian_Ceramics/AddModel.dart';
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
      title: "Sales Management",
      debugShowCheckedModeBanner: false,
      //theme: themeNotifier.getTheme(),
      home: AddModel(),
    );
  }
}
