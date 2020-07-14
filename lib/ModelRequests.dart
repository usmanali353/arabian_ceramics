import 'package:Arabian_Ceramics/DetailPage.dart';
import 'package:Arabian_Ceramics/Model/Product.dart';
import 'package:Arabian_Ceramics/Model/Schedule.dart';
import 'package:Arabian_Ceramics/Model/Users.dart';
import 'package:Arabian_Ceramics/Observations.dart';
import 'package:Arabian_Ceramics/Production_Schedule/SchedulesList.dart';
import 'package:Arabian_Ceramics/Users/Login.dart';
import 'package:Arabian_Ceramics/Utils.dart';
import 'package:Arabian_Ceramics/acmcapproval.dart';
import 'package:Arabian_Ceramics/newproductsList.dart';
import 'package:Arabian_Ceramics/productionCompleted.dart';
import 'package:Arabian_Ceramics/request_Model_form/Assumptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ModelRequests extends StatefulWidget {
  Users user;

  ModelRequests(this.user);

  @override
  _ModelReState createState() => _ModelReState(user);
}

class _ModelReState extends ResumableState<ModelRequests> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey=GlobalKey();
  List<Product> products=[];
  List<String> productId=[],status=['All','New Request','Approved by ACMC','Rejected by ACMC','Scheduled','Approved by Customer','Rejected by Customer'];
  Users users;
  bool isCustomer=false;
  bool canScheduleProduction=false;
  bool canApproveAcmc=false;
  var selectedPreference,selectedStatus;
  String userId;
  _ModelReState(this.users);
@override
  void onResume() {
    if(resume.data.toString()=="Refresh"){
      WidgetsBinding.instance
          .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
    }
    super.onResume();
  }
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
                 isCustomer?Column(
                   children: <Widget>[
                     ListTile(
                       title: Text("Products for Trial"),
                       leading: FaIcon(FontAwesomeIcons.box),
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>newProductList()));
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
                 ):ListTile(
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
           )
          ],
        ),
      ),
      floatingActionButton: buildFloatingactionButtons(),
      appBar: AppBar(
          title:Text("Model Requests"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice){
              if(choice=='Sort by Status'){
                showStatusAlertDialog(context);
              }
            },
            itemBuilder: (BuildContext context){
              return ['Sort by Status'].map((String choice){
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.builder(itemCount:products!=null?products.length:0,itemBuilder: (BuildContext context,int index){
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(products[index].image),
                    subtitle: Text(products[index].status),
                    title: Text(products[index].requestDate),
                    onTap: (){
                        if(canApproveAcmc&&products[index].status=="New Request"){
                          showAlertDialog(context,products[index],productId[index]);
                        }else if(canScheduleProduction&&products[index].status=="Approved by ACMC"){
                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 60))).then((selectedDate){
                            if(selectedDate!=null){
                              Map<String,dynamic> map=Map();
                              map.putIfAbsent("status", () => "Scheduled for Production");
                              ProgressDialog pd=ProgressDialog(context);
                              pd.show();
                              Firestore.instance.collection("model_requests").document(productId[index]).updateData(map).then((value) {
                                Firestore.instance.collection("Schedules").document().setData(Schedule(
                                    scheduledById: userId,
                                    scheduledOn:DateFormat("yyyy-MM-dd").format(selectedDate),
                                    requestedDate: products[index].requestDate,
                                    scheduledByName: users.name,
                                    surface: products[index].surface,
                                    thickness: products[index].thickness,
                                    size:products[index].size,
                                    range: products[index].range,
                                    material:products[index].material,
                                    colour: products[index].colour,
                                    technology: products[index].technology,
                                    structure: products[index].structure,
                                    edge: products[index].edge,
                                    classification: products[index].classification).toJson()).then((value){
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
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 5),
                                  )..show(context);
                                });
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
                        }else if(canScheduleProduction&&products[index].status=="Scheduled for Production"){
                            showAlertChangeStatus(context, productId[index], products[index]);
                        }else if(isCustomer&&products[index].status=="Produced"){
                          showCustomerApprovalDialog(context, products[index], productId[index]);
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(products[index],productId[index])));
                        }

                    },
                  ),
                  Divider(),
                ],
              );
            }),
          ),
        ),
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
       Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(product,productId)));
      },
    );
    Widget approveRejectButton = FlatButton(
      child: Text("Set"),
      onPressed: () {
       if(selectedPreference=="Approve"){
         Navigator.pop(context);
         push(context, MaterialPageRoute(builder: (context)=>acmcApproval(selectedPreference,productId,users.name,userId)));

       }else if(selectedPreference=="Reject"){
         Navigator.pop(context);
         push(context, MaterialPageRoute(builder: (context)=>acmcApproval(selectedPreference,productId,users.name,userId)));
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
  showCustomerApprovalDialog(BuildContext context,Product product,String productId){
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(product,productId)));
      },
    );
    Widget approveRejectButton = FlatButton(
      child: Text("Set"),
      onPressed: () {
        Navigator.pop(context);
        push(context, MaterialPageRoute(builder: (context)=>Observations(selectedPreference,productId)));
      },
    );
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
  showAlertChangeStatus(BuildContext context,String productId,Product product){
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(product,productId)));
      },
    );
    Widget changeStatus = FlatButton(
      child: Text("Change Status"),
      onPressed: () {
        Navigator.pop(context);
        push(context, MaterialPageRoute(builder: (context)=>productionCompleted(productId)));
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Change Status of Request"),
      content: Text("are you sure you want to change status to request to Produced?"),
      actions: [
        cancelButton,
        detailsPage,
        changeStatus,
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
  Widget buildFloatingactionButtons(){
    if(isCustomer){
      return FloatingActionButton(
          child: Icon(Icons.add),
    onPressed: (){
    push(context, MaterialPageRoute(builder: (context)=>Assumptions()));
    },
      );
    }else if(canScheduleProduction)
      return FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: (){
          push(context, MaterialPageRoute(builder: (context)=>SchedulesList()));
        },
      );
  }
  showStatusAlertDialog(BuildContext context) {
    // set up the buttons
    Widget searchBtn = FlatButton(
      child: Text("Search"),
      onPressed:  () {
        Navigator.pop(context);
        if(selectedStatus=='All'){
          WidgetsBinding.instance
              .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
        }else{
          Firestore.instance.collection("model_requests").where("status",isEqualTo:selectedStatus).getDocuments().then((querySnapshot){
            if(querySnapshot.documents.length>0){
              setState(() {
                if(products.length>0){
                  products.clear();
                }
                if(productId.length>0){
                  productId.clear();
                }
                products.addAll(querySnapshot.documents.map((e) => Product.fromMap(e.data)).toList());
                for(int i=0;i<querySnapshot.documents.length;i++){
                  productId.add(querySnapshot.documents[i].documentID);
                }
              });
            }else{
              Flushbar(
                message: "No Request Found According to the Status",
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
              )..show(context);
            }
          });
        }

      },
    );
    Widget cancelBtn = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Filter by Status"),
      content:FormBuilder(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FormBuilderDropdown(
                attribute: "Select Status",
                hint: Text("Select Status"),
                items: status!=null?status.map((plans)=>DropdownMenuItem(
                  child: Text(plans),
                  value: plans,
                )).toList():[""].map((name) => DropdownMenuItem(
                    value: name, child: Text("$name")))
                    .toList(),
                onChanged: (value){
                  setState(() {
                    this.selectedStatus=value;
                  });
                },
                style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontSize: 11)),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                ),

              ),
            ],
          )
      ),
      actions: [
        cancelBtn,
        searchBtn,

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
