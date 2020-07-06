import 'dart:io';
import 'package:data_connection_checker/data_connection_checker.dart';
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
}