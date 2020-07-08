import 'package:Arabian_Ceramics/DetailPage.dart';
import 'package:Arabian_Ceramics/Model/Product.dart';
import 'package:Arabian_Ceramics/Model/Users.dart';
import 'package:Arabian_Ceramics/Users/Login.dart';
import 'package:Arabian_Ceramics/Utils.dart';
import 'package:Arabian_Ceramics/request_Model_form/Assumptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ModelRequests extends StatefulWidget {
  Users user;

  ModelRequests(this.user);

  @override
  _ModelReState createState() => _ModelReState(user);
}

class _ModelReState extends State<ModelRequests> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey=GlobalKey();
  List<Product> products=[];
  List<String> productId=[];
  Users users;
  bool isCustomer=false;
  bool canScheduleProduction=false;
  bool canApproveAcmc=false;
  var selectedPreference;
  String userId;
  _ModelReState(this.users);

  @override
  void initState() {
    print(users.name);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
    if(users.roles[0]['roleName'] =='Make Model Requests'){
     setState(() {
       isCustomer=true;
     });
    }else if(users.roles[0]['roleName'] =='Approve Requests'){
      setState(() {
        canApproveAcmc=true;
      });
    }else if(users.roles[0]['roleName'] =='Schedule Model Requests'){
      setState(() {
        canScheduleProduction=true;
      });
    }
    FirebaseAuth.instance.currentUser().then((val){
      if(val!=null){
        setState(() {
          userId=val.uid;
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isCustomer?FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Assumptions()));
        },
      ):Container(),
      appBar: AppBar(
          title:Text("Model Requests"),
        backgroundColor: Color(0xFF004c4c),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice){
              if(choice=='Sign Out'){
                FirebaseAuth.instance.signOut();
                SharedPreferences.getInstance().then((prefs){
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
                trailing: Text(products[index].requestDate),
                onTap: (){
                    if(canApproveAcmc&&products[index].status=="New Request"){
                      showAlertDialog(context,products[index],productId[index]);
                    }else if(canScheduleProduction&&products[index].status=="Approved by ACMC"){
                      showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 60))).then((selectedDate){
                        if(selectedDate!=null){
                          Map<String,dynamic> map=Map();
                          map.putIfAbsent("scheduledOn", () => DateFormat("yyyy-MM-dd").format(selectedDate));
                          map.putIfAbsent("scheduledById", () => userId);
                          map.putIfAbsent("scheduledByName", () => users.name);
                          map.putIfAbsent("status", () => "Scheduled for Production");
                          ProgressDialog pd=ProgressDialog(context);
                          pd.show();
                          Firestore.instance.collection("model_requests").document(productId[index]).updateData(map).then((value) {
                            pd.hide();
                            Flushbar(
                              message: "request Scheduled",
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 5),
                            )..show(context);
                            WidgetsBinding.instance
                                .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
                          }).catchError((onError){
                            pd.hide();
                            Flushbar(
                              message: onError.toString(),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 5),
                            )..show(context);
                          });
                        }
                      });
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(products[index])));
                    }

                },
              ),
              Divider(),
            ],

          );
        }),
      ),
    );
  }
  showAlertDialog(BuildContext context,Product product,String productId) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget detailsPage = FlatButton(
      child: Text("Go to Details"),
      onPressed: () {
        Navigator.pop(context);
       Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(product)));
      },
    );
    Widget approveRejectButton = FlatButton(
      child: Text("Set"),
      onPressed: () {
       if(selectedPreference=="Approve"){
         Navigator.pop(context);
         ProgressDialog pd=ProgressDialog(context);
         pd.show();
         Map<String,dynamic> map=Map();
         map.putIfAbsent("status", () => "Approved by ACMC");
         map.putIfAbsent("acmcapprovalbywhomId", () => userId);
         map.putIfAbsent("acmcapprovalbywhomName", () => users.name);
         map.putIfAbsent("acmcapprovaldate", () => DateFormat("yyyy-MM-dd").format(DateTime.now()));
         Firestore.instance.collection("model_requests").document(productId).updateData(map).then((value){

           Flushbar(
             message: "Request Approved",
             backgroundColor: Colors.green,
             duration: Duration(seconds: 5),
           )..show(context);
           WidgetsBinding.instance
               .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
         }).catchError((onError){
           pd.hide();
           Flushbar(
             message: onError.toString(),
             backgroundColor: Colors.red,
             duration: Duration(seconds: 5),
           )..show(context);
         });
       }else if(selectedPreference=="Reject"){
         Navigator.pop(context);
         ProgressDialog pd=ProgressDialog(context);
         pd.show();
         Map<String,dynamic> map=Map();
         map.putIfAbsent("status", () => "Rejected by ACMC");
         map.putIfAbsent("acmcrejectedbywhomId", () => userId);
         map.putIfAbsent("acmcrejectedbywhomName", () => users.name);
         map.putIfAbsent("acmcrejectiondate", () => DateFormat("yyyy-MM-dd").format(DateTime.now()));
         Firestore.instance.collection("model_requests").document(productId).updateData(map).then((value){
           pd.hide();
           Flushbar(
             message: "Request Rejected",
             backgroundColor: Colors.green,
             duration: Duration(seconds: 5),
           )..show(context);
           WidgetsBinding.instance
               .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
         }).catchError((onError){
           pd.hide();
           Flushbar(
             message: onError.toString(),
             backgroundColor: Colors.red,
             duration: Duration(seconds: 5),
           )..show(context);
         });
       }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Approve/Reject Model Request"),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile(
                title: Text("Approve"),
                value: 'Approve',
                groupValue: selectedPreference,
                onChanged: (choice) {
                  setState(() {
                    this.selectedPreference = choice;
                  });
                },
              ),
              RadioListTile(
                title: Text("Reject"),
                value: 'Reject',
                groupValue: selectedPreference,
                onChanged: (choice) {
                  setState(() {
                    this.selectedPreference = choice;
                  });
                },
              ),
            ],
          );
        },
      ),
      actions: [
        cancelButton,
        detailsPage,
        approveRejectButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
