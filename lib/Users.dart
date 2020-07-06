import 'Roles.dart';

class Users{
  String name;
  List<Map> roles;

  Users({this.name, this.roles});

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["roles"] = roles;
    return map;
  }
  Users.fromMap(Map<dynamic,dynamic> data){
    name=data['name'];
    roles=data["roles"];
  }
}