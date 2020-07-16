import 'package:Arabian_Ceramics/Model/Product.dart';
import 'package:Arabian_Ceramics/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class newProductList extends StatefulWidget {
  @override
  _newProductListState createState() => _newProductListState();
}

class _newProductListState extends State<newProductList> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey=GlobalKey();
  List<Product> newProducts=[];
  List<String> newProductId=[];
  bool newProductListVisible=false;
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products for Trial"),),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((connected){
            if(connected){
              Firestore.instance.collection("model_requests").where("status",isEqualTo: "Approved for Trials").getDocuments().then((querySnapshot){
                if(querySnapshot.documents.length>0){
                  setState(() {
                    if(newProducts.length>0){
                      newProducts.clear();
                    }
                    if(newProductId.length>0){
                      newProductId.clear();
                    }
                    newProductListVisible=true;
                    newProducts.addAll(querySnapshot.documents.map((e) => Product.fromMap(e.data)).toList());
                    for(int i=0;i<querySnapshot.documents.length;i++){
                      newProductId.add(querySnapshot.documents[i].documentID);
                    }
                  });
                }else{
                  Flushbar(
                    message: "No new Products found",
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 5),
                  )..show(context);
                }
              });
            }else{
              Flushbar(
                message: "Network Not Available",
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
              )..show(context);
            }
          });
        },
        child: Visibility(
          visible: newProductListVisible,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(itemCount: newProducts.length,itemBuilder: (context,index){
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(newProducts[index].modelName),
                      subtitle: Text(newProducts[index].modelCode),
                      leading:  Material(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.teal.shade100,
                        child: Padding(
                          padding: const EdgeInsets.only(top:10,bottom: 15,right: 10,left: 10),
                          child: Icon(FontAwesomeIcons.box,size: 30,color: Color(0xFF004c4c),),
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
