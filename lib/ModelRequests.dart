import 'package:Arabian_Ceramics/Product.dart';
import 'package:Arabian_Ceramics/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
class ModelRequests extends StatefulWidget {
  @override
  _ModelReState createState() => _ModelReState();
}

class _ModelReState extends State<ModelRequests> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey=GlobalKey();
  List<Product> products=[];
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Model Requests")),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((connected){
            if(connected){
              Firestore.instance.collection("model_requests").getDocuments().then((querySnapshot){
                 if(querySnapshot.documents.length>0){
                  setState(() {
                   products.addAll(querySnapshot.documents.map((e) => Product.fromMap(e.data)).toList());
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
                trailing: Image.network(products[index].image),
                title: Text(products[index].name),
                subtitle: Text(products[index].size),
              ),
              Divider(),
            ],

          );
        }),
      ),
    );
  }
}
