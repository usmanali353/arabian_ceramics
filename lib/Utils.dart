import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

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
    return FirebaseAuth.instance.currentUser()!=null;
  }
}