class Roles{
  String roleName;
  Roles({this.roleName});
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["roleName"] = roleName;
    return map;
  }
  Roles.fromMap(Map<dynamic,dynamic> data){
    roleName=data['roleName'];
  }
}