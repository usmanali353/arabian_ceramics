import 'dart:convert';

import 'package:Arabian_Ceramics/DetailPage.dart';
import 'package:Arabian_Ceramics/Login.dart';
import 'package:Arabian_Ceramics/Product.dart';
import 'package:Arabian_Ceramics/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ModelRequests extends StatefulWidget {
  @override
  _ModelReState createState() => _ModelReState();
}

class _ModelReState extends State<ModelRequests> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey=GlobalKey();
  List<Product> products=[];
  List<String> productId=[];
  var users;
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
    SharedPreferences.getInstance().then((prefs){
      users=jsonDecode(prefs.getString("user_info"));
      print(users['name']);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text("Model Requests"),
        backgroundColor: Color(0xFF004c4c),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice){
              if(choice=='Sign Out'){
                FirebaseAuth.instance.signOut();
                SharedPreferences.getInstance().then((prefs){
                   prefs.remove("user_info");
                   prefs.remove("user_id");
                });
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
              }
            },
            itemBuilder: (BuildContext context){
              return ['Sign Out'].map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((connected){
            if(connected){
              Firestore.instance.collection("model_requests").getDocuments().then((querySnapshot){
                 if(querySnapshot.documents.length>0){
                   if(products.length>0){
                     products.clear();
                   }
                   if(productId.length>0){
                     productId.clear();
                   }
                  setState(() {
                   products.addAll(querySnapshot.documents.map((e) => Product.fromMap(e.data)).toList());
                   for(int i=0;i<querySnapshot.documents.length;i++){
                     productId.add(querySnapshot.documents[i].documentID);
                   }
                  });
                 }
              }).catchError((onError){
               Flushbar(
                 message: onError.toString(),
                 backgroundColor: Colors.red,
                 duration: Duration(seconds: 5),
               )..show(context);
              });
            }
          });
        },
        child: ListView.builder(itemCount:products!=null?products.length:0,itemBuilder: (BuildContext context,int index){
          return Column(
            children: <Widget>[
              ListTile(
                leading: Image.network(products[index].image),
                title: Text(products[index].name),
                subtitle: Text(products[index].size),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(products[index])));
                },
              ),
              Divider(),
            ],

          );
        }),
      ),
    );
  }
}
