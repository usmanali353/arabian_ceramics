import 'package:Arabian_Ceramics/Model/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Utils.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Product> products=[];
  List<String> productId=[];
  List<Product> newRequests=[],acmcApproved=[],sampleProductionScheduled=[],sampleProduced=[],approvedForTrial=[];
 // status=['All','New Request','Approved by ACMC','Rejected by ACMC','Scheduled for Samples Production','Samples Produced','Approved for Trial','Rejected for Trial','Scheduled for Trial','Approved by Customer','Rejected by Customer','Scheduled for Production']
  @override
  void initState() {
    Utils.check_connectivity().then((connected){
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
                if(products.length>0&&products[i].status=='New Request'){
                  newRequests.add(products[i]);
                }
              }
              for(int i=0;i<querySnapshot.documents.length;i++){
                if(products.length>0&&products[i].status=='Approved by ACMC'){
                  acmcApproved.add(products[i]);
                }
              }
              for(int i=0;i<querySnapshot.documents.length;i++){
                if(products.length>0&&products[i].status=='Scheduled for Samples Production'){
                  sampleProductionScheduled.add(products[i]);
                }
              }
              for(int i=0;i<querySnapshot.documents.length;i++){
                if(products.length>0&&products[i].status=='Samples Produced'){
                  sampleProduced.add(products[i]);
                }
              }
              for(int i=0;i<querySnapshot.documents.length;i++){
                if(products.length>0&&products[i].status=='Approved for Trial'){
                  approvedForTrial.add(products[i]);
                }
              }
//              for(int i=0;i<querySnapshot.documents.length;i++){
//                productId.add(querySnapshot.documents[i].documentID);
//              }
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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard"),),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(left: 17),
                    child: Text("Model Requests", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),)
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          //Delivery Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //Today Deliveries
              InkWell(
                onTap:(){
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryList((DateFormat("yyyy-MM-dd").format(DateTime.now())),customerId)));
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    height: 130,
                    //width: 185,
                    width: MediaQuery.of(context).size.width * 0.45 ,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFF004c4c),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          //margin: EdgeInsets.only(left: 12),
                          child: Text("Requested",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          height: 30,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade100,
                          ),
                          child: Center(
                            child: Container(
                              //margin: EdgeInsets.only(left: 10,top: 5),
                              child: Text(newRequests!=null?newRequests.length.toString():'', style: TextStyle(color:Color(0xFF004c4c),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Weekly Deliveries
              InkWell(
                onTap: (){
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesOrdersList(DateFormat("yyyy-MM-dd").format(DateTime.now()),DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 30))),customerId,DateFormat.MMMM().format(DateTime.now()).toString()+' Deliveries')));
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width * 0.45 ,
                    //width: MediaQuery.of(context).size.width /2.2 ,
                    //width: 185,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF004c4c),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          //margin: EdgeInsets.only(left: 12),
                          child: Text('ACMC Approved',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          //padding: EdgeInsets.all(3),
                          margin: EdgeInsets.only(left: 5, right: 5),

                          height: 30,
                          width: 145,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade100,
                          ),
                          child: Center(
                            child: Container(
                              //margin: EdgeInsets.only(left: 10,top: 5),
                              child: Text(acmcApproved!=null?acmcApproved.length.toString():'',
                                style: TextStyle(
                                    color:Colors.teal.shade800,
                                    //Color(0xFF004c4c),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),

                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                  ),
                ),
              ),

            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          InkWell(
            onTap: (){
             // Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList(null,null,customerId)));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0,right:8.0),
              child: Card(
                elevation: 10,
                child: Container(
                  // margin: EdgeInsets.only(left: 12.5,right: 12.5),
                  height: 130,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 12),
                        child: Text("Scheduled Sample Production",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),
                        height: 30,
                        width: MediaQuery.of(context).size.width *0.35,
                        //width: 145,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15)
                          ),
                          color: Color(0xFF004c4c),
                        ),
                        child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                          child: Text(sampleProductionScheduled!=null?sampleProductionScheduled.length.toString():'',
                            style: TextStyle(
                                color:Colors.white,
                                //Color(0xFF004c4c),
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                        ),
                      ),
                    ],
                  ),

                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //Today Deliveries
              InkWell(
                onTap:(){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryList((DateFormat("yyyy-MM-dd").format(DateTime.now())),customerId)));
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    height: 130,
                    //width: 185,
                    width: MediaQuery.of(context).size.width * 0.45 ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF004c4c),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          //margin: EdgeInsets.only(left: 12),
                          child: Text("Sample Produced",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          height: 30,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade100,
                          ),
                          child: Center(
                            child: Container(
                              //margin: EdgeInsets.only(left: 10,top: 5),
                              child: Text(sampleProduced!=null?sampleProduced.length.toString():'', style: TextStyle(color:Color(0xFF004c4c),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Weekly Deliveries
              InkWell(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesOrdersList(DateFormat("yyyy-MM-dd").format(DateTime.now()),DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 30))),customerId,DateFormat.MMMM().format(DateTime.now()).toString()+' Deliveries')));
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width * 0.45 ,
                    //width: MediaQuery.of(context).size.width /2.2 ,
                    //width: 185,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF004c4c),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          //margin: EdgeInsets.only(left: 12),
                          child: Text('Approved for Trial',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          //padding: EdgeInsets.all(3),
                          margin: EdgeInsets.only(left: 5, right: 5),
                          height: 30,
                          width: 145,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade100,
                          ),
                          child: Center(
                            child: Container(
                              //margin: EdgeInsets.only(left: 10,top: 5),
                              child: Text(approvedForTrial!=null?approvedForTrial.length.toString():'',
                                style: TextStyle(
                                    color:Colors.teal.shade800,
                                    //Color(0xFF004c4c),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),

                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
