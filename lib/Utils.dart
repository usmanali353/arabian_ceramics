import 'dart:io';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils{
  static Future<PickedFile> getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    return image;
  }
  static Future<bool> check_connectivity () async{
    bool result = await DataConnectionChecker().hasConnection;
    return result;
  }
  static bool validateStructure(String value){
    RegExp regExp = new RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{6,}$');
    return regExp.hasMatch(value);
  }
  static bool validateEmail(String value){
    RegExp regExp=  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp.hasMatch(value);
  }
  static Future<bool> isLogin()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString("user_info")!=null&&prefs.getString("user_id")!=null;
  }
}