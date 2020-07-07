import 'dart:convert';

import 'package:Arabian_Ceramics/ModelRequests.dart';
import 'package:Arabian_Ceramics/Users.dart';
import 'package:Arabian_Ceramics/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Roles.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username,password;
  @override
  void initState() {
   username=TextEditingController();
   password=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        padding: EdgeInsets.only(top: 55, bottom: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/img/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset('Assets/img/login.png',width: 230,height: 230,),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: username,
                      style: TextStyle(color: Colors.white),
                    decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.person,color: Colors.white,),
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                      focusedBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      disabledBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                      ),
                      errorBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      focusedErrorBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                        filled: false,
                        hintStyle: new TextStyle(color: Colors.white70),
                        hintText: "Username",
                  )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    controller: password,
                    style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: new InputDecoration(
                        labelStyle: TextStyle(color:Colors.white),
                        prefixIcon: Icon(Icons.lock,color: Colors.white,),
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white, width: 10),
                        ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white, width: 2),
                          ),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white, width: 2),
                          ),
                          disabledBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                          ),
                          errorBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                        filled: false,
                        hintStyle: new TextStyle(color: Colors.white70),
                        hintText: "Password",
                          fillColor: Colors.white70
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Builder(
                    builder: (BuildContext context){
                      return MaterialButton(
                        padding: EdgeInsets.all(16),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: ()async{
                          SharedPreferences prefs=await SharedPreferences.getInstance();
                          ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);

                          if(username.text!=null&&password.text!=null&&Utils.validateEmail(username.text)){
                            pd.show();
                            FirebaseAuth.instance.signInWithEmailAndPassword(email: username.text, password: password.text).then((authResult){
                              FirebaseUser user=authResult.user;
                             Firestore.instance.collection("Users").document(user.uid).get().then((documentSnapshot){
                               pd.hide();
                               if(documentSnapshot.exists){
                                 prefs.setString("user_info", jsonEncode(Users.fromMap(documentSnapshot.data)));
                                 prefs.setString("user_id",documentSnapshot.documentID);
                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ModelRequests()));
                               }
                             });
                            }).catchError((onError){
                              pd.hide();
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(onError.toString()),
                                backgroundColor: Colors.red,
                              ));
                            });
                          }

//                          FirebaseAuth.instance.createUserWithEmailAndPassword(email:'customer@acmc.com', password: 'acmcCustomer1').then((authresult){
//                            FirebaseUser user= authresult.user;
//                            if(user!=null){
//                               List<Map> r=[];
//                               r.add(Roles(roleName: 'Approve Requests').toJson());
//                                Firestore.instance.collection("Users").document(user.uid).setData(Users(name: 'Customer 1',roles: r).toJson()).then((value){
//                                  Scaffold.of(context).showSnackBar(SnackBar(
//                                    content: Text("Customer Registered"),
//                                    backgroundColor: Colors.green,
//                                  ));
//                                }).catchError((onError){
//                                  print(onError);
//                                });
//                            }else{
//                               Scaffold.of(context).showSnackBar(SnackBar(
//                                 content: Text("Registration Failed"),
//                                 backgroundColor: Colors.red,
//                               ));
//                            }
//                          }).catchError((onError){
//                            Scaffold.of(context).showSnackBar(SnackBar(
//                              backgroundColor: Colors.red,
//                              content: Text(onError.toString()),
//                            ));
//                          });
                        },
                        color: Colors.white,
                        child: Text("SIGN IN",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.teal
                        ),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      );
                    },
                     
                  ),
                )
              ],
            )
          ],
        ) /* add child content here */,
      ),
    );
  }
}
