import 'package:Arabian_Ceramics/Model/Product.dart';
import 'package:Arabian_Ceramics/Model/Users.dart';
import 'package:Arabian_Ceramics/ModelRequests.dart';
import 'package:Arabian_Ceramics/Users/Login.dart';
import 'package:Arabian_Ceramics/request_Model_form/Assumptions.dart';
import 'package:Arabian_Ceramics/scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:need_resume/need_resume.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils.dart';
class Dashboard extends StatefulWidget {
  Users user;

  Dashboard(this.user);

  @override
  _DashboardState createState() => _DashboardState(user);
}

class _DashboardState extends ResumableState<Dashboard> {
  List<Product> products=[],scheduledTrial=[];
  List<String> productId=[],newRequestId=[],acmcApprovedId=[],sampleProductionScheduledId=[],sampleProducedId=[],approvedForTrialID=[],customerApprovedId=[],scheduledProductionId=[],scheduledTrialId=[];
  Users user;
  bool isCustomer=false;
  _DashboardState(this.user);

  List<Product> newRequests=[],acmcApproved=[],sampleProductionScheduled=[],sampleProduced=[],approvedForTrial=[],customerApproved=[],scheduledProduction=[];
 // status=['All','New Request','Approved by ACMC','Rejected by ACMC','Scheduled for Samples Production','Samples Produced','Approved for Trial','Rejected for Trial','Scheduled for Trial','Approved by Customer','Rejected by Customer','Scheduled for Production']
 @override
  void onResume() {
    if(resume.data.toString()=="Refresh"){
      Firestore.instance.collection("model_requests").getDocuments().then((querySnapshot){
        if(querySnapshot.documents.length>0){
          if(products.length>0){
            products.clear();
          }
          if(productId.length>0){
            productId.clear();
          }
          if(newRequests.length>0){
            newRequests.clear();
          }
          if(newRequestId.length>0){
            newRequestId.clear();
          }
          if(acmcApproved.length>0){
            acmcApproved.clear();
          }
          if(acmcApprovedId.length>0){
            acmcApprovedId.clear();
          }
          if(sampleProductionScheduled.length>0){
            sampleProductionScheduled.clear();
          }
          if(sampleProductionScheduledId.length>0){
            sampleProductionScheduledId.clear();
          }
          if(sampleProduced.length>0){
            sampleProduced.clear();
          }
          if(sampleProducedId.length>0){
            sampleProducedId.clear();
          }
          if(approvedForTrial.length>0){
            approvedForTrial.clear();
          }
          if(approvedForTrialID.length>0){
            approvedForTrialID.clear();
          }
          if(customerApproved.length>0){
            customerApproved.clear();
          }
          if(customerApprovedId.length>0){
            customerApprovedId.clear();
          }
          if(scheduledProduction.length>0){
            scheduledProduction.clear();
          }
          if(scheduledProductionId.length>0){
            scheduledProductionId.clear();
          }
          if(scheduledTrial.length>0){
            scheduledTrial.clear();
          }
          if(scheduledTrialId.length>0){
            scheduledTrialId.clear();
          }
          setState(() {
            products.addAll(querySnapshot.documents.map((e) => Product.fromMap(e.data)).toList());
            for(int i=0;i<querySnapshot.documents.length;i++){
              if(products.length>0&&products[i].status=='New Request'){
                newRequests.add(products[i]);
                newRequestId.add(querySnapshot.documents[i].documentID);
              }
            }
            for(int i=0;i<querySnapshot.documents.length;i++){
              if(products.length>0&&products[i].status=='Approved by ACMC'){
                acmcApproved.add(products[i]);
                acmcApprovedId.add(querySnapshot.documents[i].documentID);
              }
            }
            for(int i=0;i<querySnapshot.documents.length;i++){
              if(products.length>0&&products[i].status=='Scheduled for Samples Production'){
                sampleProductionScheduled.add(products[i]);
                sampleProductionScheduledId.add(querySnapshot.documents[i].documentID);
              }
            }
            for(int i=0;i<querySnapshot.documents.length;i++){
              if(products.length>0&&products[i].status=='Samples Produced'){
                sampleProduced.add(products[i]);
                sampleProducedId.add(querySnapshot.documents[i].documentID);
              }
            }
            for(int i=0;i<querySnapshot.documents.length;i++){
              if(products.length>0&&products[i].status=='Approved for Trial'){
                approvedForTrial.add(products[i]);
                approvedForTrialID.add(querySnapshot.documents[i].documentID);
              }
            }
            for(int i=0;i<querySnapshot.documents.length;i++){
              if(products.length>0&&products[i].status=='Approved by Customer'){
                customerApproved.add(products[i]);
                customerApprovedId.add(querySnapshot.documents[i].documentID);
              }
            }
            for(int i=0;i<querySnapshot.documents.length;i++){
              if(products.length>0&&products[i].status=='Scheduled for Production'){
                scheduledProduction.add(products[i]);
                scheduledProductionId.add(querySnapshot.documents[i].documentID);
              }
            }
            for(int i=0;i<querySnapshot.documents.length;i++){
              if(products.length>0&&products[i].status=='Scheduled for Trial'){
                scheduledTrial.add(products[i]);
                scheduledTrialId.add(querySnapshot.documents[i].documentID);
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
    super.onResume();
  }
  @override
  void initState() {
    Utils.check_connectivity().then((connected){
      if(connected){
        if(user.roles[0]['roleName'] =='Make Model Requests'){
          setState(() {
            isCustomer=true;
          });
        }
        Firestore.instance.collection("model_requests").getDocuments().then((querySnapshot){
          if(querySnapshot.documents.length>0){
            if(products.length>0){
              products.clear();
            }
            if(productId.length>0){
              productId.clear();
            }
            if(newRequests.length>0){
              newRequests.clear();
            }
            if(newRequestId.length>0){
              newRequestId.clear();
            }
            if(acmcApproved.length>0){
              acmcApproved.clear();
            }
            if(acmcApprovedId.length>0){
              acmcApprovedId.clear();
            }
            if(sampleProductionScheduled.length>0){
              sampleProductionScheduled.clear();
            }
            if(sampleProductionScheduledId.length>0){
              sampleProductionScheduledId.clear();
            }
            if(sampleProduced.length>0){
              sampleProduced.clear();
            }
            if(sampleProducedId.length>0){
              sampleProducedId.clear();
            }
            if(approvedForTrial.length>0){
              approvedForTrial.clear();
            }
            if(approvedForTrialID.length>0){
              approvedForTrialID.clear();
            }
            if(customerApproved.length>0){
              customerApproved.clear();
            }
            if(customerApprovedId.length>0){
              customerApprovedId.clear();
            }
            if(scheduledProduction.length>0){
              scheduledProduction.clear();
            }
            if(scheduledProductionId.length>0){
              scheduledProductionId.clear();
            }
            if(scheduledTrial.length>0){
              scheduledTrial.clear();
            }
            if(scheduledTrialId.length>0){
              scheduledTrialId.clear();
            }
            setState(() {

              products.addAll(querySnapshot.documents.map((e) => Product.fromMap(e.data)).toList());
              for(int i=0;i<querySnapshot.documents.length;i++){
                if(products.length>0&&products[i].status=='New Request'){
                  newRequests.add(products[i]);
                  newRequestId.add(querySnapshot.documents[i].documentID);
                }
              }
              for(int i=0;i<querySnapshot.documents.length;i++){
                if(products.length>0&&products[i].status=='Approved by ACMC'){
                  acmcApproved.add(products[i]);
                  acmcApprovedId.add(querySnapshot.documents[i].documentID);
                }
              }
              for(int i=0;i<querySnapshot.documents.length;i++){
                if(products.length>0&&products[i].status=='Scheduled for Samples Production'){
                  sampleProductionScheduled.add(products[i]);
                  sampleProductionScheduledId.add(querySnapshot.documents[i].documentID);
                }
              }
              for(int i=0;i<querySnapshot.documents.length;i++){
                if(products.length>0&&products[i].status=='Samples Produced'){
                  sampleProduced.add(products[i]);
                  sampleProducedId.add(querySnapshot.documents[i].documentID);
                }
              }
              for(int i=0;i<querySnapshot.documents.length;i++){
                if(products.length>0&&products[i].status=='Approved for Trial'){
                  approvedForTrial.add(products[i]);
                  approvedForTrialID.add(querySnapshot.documents[i].documentID);
                }
              }
              for(int i=0;i<querySnapshot.documents.length;i++){
                if(products.length>0&&products[i].status=='Approved by Customer'){
                  customerApproved.add(products[i]);
                  customerApprovedId.add(querySnapshot.documents[i].documentID);
                }
              }
              for(int i=0;i<querySnapshot.documents.length;i++){
                if(products.length>0&&products[i].status=='Scheduled for Production'){
                  scheduledProduction.add(products[i]);
                  scheduledProductionId.add(querySnapshot.documents[i].documentID);
                }
              }
              for(int i=0;i<querySnapshot.documents.length;i++){
                if(products.length>0&&products[i].status=='Scheduled for Trial'){
                  scheduledTrial.add(products[i]);
                  scheduledTrialId.add(querySnapshot.documents[i].documentID);
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
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xEBECF0),
              alignment: Alignment.topCenter,
              child: DrawerHeader(
                child:  Image.asset("Assets/img/AC.png",width: 200,height: 200,),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      isCustomer?ListTile(
                        title: Text("Add Model Request"),
                        leading: FaIcon(FontAwesomeIcons.projectDiagram),
                        onTap: (){
                          push(context, MaterialPageRoute(builder: (context)=>Assumptions()));
                        },
                      ):Container(),
                       Divider(),
                      ListTile(
                        title: Text("Scan Barcode"),
                        leading: FaIcon(FontAwesomeIcons.barcode),
                        onTap: (){
                         push(context, MaterialPageRoute(builder: (context)=>QRScanner()));
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Sign Out"),
                        leading: FaIcon(FontAwesomeIcons.signOutAlt),
                        onTap: (){
                          FirebaseAuth.instance.signOut();
                          SharedPreferences.getInstance().then((prefs){
                            prefs.remove("user_id");
                          });
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                        },
                      ),
                      Divider(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
              InkWell(
                onTap:(){
                  push(context, MaterialPageRoute(builder: (context)=>ModelRequests(user,newRequests,newRequestId)));
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
                  push(context, MaterialPageRoute(builder: (context)=>ModelRequests(user,acmcApproved,acmcApprovedId)));
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
              push(context, MaterialPageRoute(builder: (context)=>ModelRequests(user,sampleProductionScheduled,sampleProductionScheduledId)));
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
                  push(context, MaterialPageRoute(builder: (context)=>ModelRequests(user,sampleProduced,sampleProducedId)));
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
                  push(context, MaterialPageRoute(builder: (context)=>ModelRequests(user,approvedForTrial,approvedForTrialID)));
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
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          InkWell(
            onTap: (){
              push(context, MaterialPageRoute(builder: (context)=>ModelRequests(user,scheduledTrial,scheduledTrialId)));
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
                        child: Text("Scheduled for Trial",
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
                          child: Text(scheduledTrial!=null?scheduledTrial.length.toString():'',
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
                  push(context, MaterialPageRoute(builder: (context)=>ModelRequests(user,customerApproved,customerApprovedId)));
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
                          child: Text("Customer Approved",
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
                  push(context, MaterialPageRoute(builder: (context)=>ModelRequests(user,scheduledProduction,scheduledProductionId)));
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
                          child: Text('Scheduled for Production',
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
  @override
  void dispose() {
    FirebaseAuth.instance.signOut();
    SharedPreferences.getInstance().then((prefs){
      prefs.remove("user_id");
    });
    super.dispose();
  }
}
