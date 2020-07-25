import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DetailPage.dart';
import 'Model/Product.dart';
import 'Model/Users.dart';
import 'Observations.dart';
import 'Production_Schedule/SchedulesList.dart';
import 'Users/Login.dart';
import 'Utils.dart';
import 'acmcapproval.dart';
import 'productionCompleted.dart';
import 'request_Model_form/Assumptions.dart';

class ModelRequests extends StatefulWidget {
  Users user;
  List<Product> products;
  List<String> productId;

  ModelRequests(this.user, this.products, this.productId);

  @override
  _ModelReState createState() => _ModelReState(user,products,productId);
}

class _ModelReState extends ResumableState<ModelRequests>{
  List<Product> products=[];
  List<String> productId=[],status=['All','New Request','Approved by ACMC','Rejected by ACMC','Scheduled for Samples Production','Samples Produced','Approved for Trial','Rejected for Trial','Scheduled for Trial','Approved by Customer','Rejected by Customer','Scheduled for Production'];
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey=GlobalKey();
  bool isDataEntryOperator=false;
  bool isCustomer=false;
  bool canScheduleProduction=false;
  bool canApproveAcmc=false;
  bool canApproveforTrial=false;
  var selectedPreference,selectedStatus;
  Users users;

  _ModelReState(this.users,this.products,this.productId);

  String userId;
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
    if(users.roles[0]['roleName'] =='Make Model Requests'){
      setState(() {
        isDataEntryOperator=true;
      });
    }else if(users.roles[0]['roleName'] =='Approve Requests'){
      setState(() {
        canApproveAcmc=true;
      });
    }else if(users.roles[0]['roleName'] =='Schedule Model Requests'){
      setState(() {
        canScheduleProduction=true;
      });
    }else if(users.roles[0]['roleName'] =='Approve for trials'){
      setState(() {
        canApproveforTrial=true;
      });
    }else if(users.roles[0]['roleName'] =='Approve on behalf of Customer'){
      setState(() {
        isCustomer=true;
      });
    }
    print(users.roles[0]['roleName']);
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
    // TODO: implement build
    return Scaffold(
      floatingActionButton: buildFloatingactionButtons(),
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
        appBar: AppBar(
          title: Text("Model Requests", style: TextStyle(
              color: Colors.white
          ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showStatusAlertDialog(context);
              },
            )
          ],
        ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Color(0xFF004c4c),
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount:products.length, itemBuilder: (context,int index)
              {
                return InkWell(
                  onTap: (){
                    if(canApproveAcmc&&products[index].status=="New Request"){
                      showAlertDialog(context,products[index],productId[index]);
                    }else if(canScheduleProduction&&products[index].status=="Approved by ACMC"){
                      showDatePicker(helpText:"Select Date for Sample Production",context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 60))).then((selectedDate){
                        if(selectedDate!=null){
                          Map<String,dynamic> map=Map();
                          map.putIfAbsent("status", () => "Scheduled for Samples Production");
                          map.putIfAbsent("closeing_date", () => DateFormat("yyyy-MM-dd").format(selectedDate));
                          ProgressDialog pd=ProgressDialog(context);
                          pd.show();
                          Firestore.instance.collection("model_requests").document(productId[index]).updateData(map).then((value) {
                            pd.hide();
                            WidgetsBinding.instance
                                .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
                            Flushbar(
                              message: "Request Scheduled",
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 5),
                            )..show(context);
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
                    }else if(canScheduleProduction&&products[index].status=="Scheduled for Samples Production"){
                      showAlertChangeStatus(context, productId[index], products[index]);
                    }else if(canApproveforTrial&&products[index].status=="Samples Produced"){
                      // showCustomerApprovalDialog(context, products[index], productId[index]);
                      showTrialApprovalDialog(context,products[index],productId[index]);
                    }else if(canApproveforTrial&&(products[index].status=="Approved for Trial")){
                      showDatePicker(helpText:"Select Date for Produced Sample Trial",context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 60))).then((selectedDate){
                        if(selectedDate!=null){
                          Map<String,dynamic> map=Map();
                          map.putIfAbsent("trial_date", () => DateFormat("yyyy-MM-dd").format(selectedDate));
                          map.putIfAbsent("status", () =>"Scheduled for Trial");
                          ProgressDialog pd=ProgressDialog(context);
                          pd.show();
                          Firestore.instance.collection("model_requests").document(productId[index]).updateData(map).then((updatedTrialDate){
                            pd.hide();
                            Navigator.pop(context,'Refresh');
                            Flushbar(
                              message: "Trial Scheduled",
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 5),
                            )..show(context);
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
                    }else if(isCustomer&&products[index].status=='Scheduled for Trial'){
                      showCustomerApprovalDialog(context, products[index], productId[index]);
                    }else if(canScheduleProduction&&products[index].status=='Approved by Customer'){
                      showDatePicker(helpText:"Select Date for Production for Customer",context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 120))).then((selectedDate){
                        if(selectedDate!=null){
                          Map<String,dynamic> map=Map();
                          map.putIfAbsent("production_date", () => DateFormat("yyyy-MM-dd").format(selectedDate));
                          map.putIfAbsent("status", () =>"Scheduled for Production");
                          ProgressDialog pd=ProgressDialog(context);
                          pd.show();
                          Firestore.instance.collection("model_requests").document(productId[index]).updateData(map).then((updatedTrialDate){
                            pd.hide();
                            Navigator.pop(context,'Refresh');
                            Flushbar(
                              message: "Production for Customer Scheduled",
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 5),
                            )..show(context);
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
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(products[index],productId[index])));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Card(
                      color: Colors.white,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              //color: Color(0xFF004c4c),
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(products[index].image),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 150),
                              child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  //width: ,
                                  child: Card(
                                    color: Colors.white,
                                    //margin: EdgeInsets.only(right: 15.0, left: 15.0),
                                    child: Scrollbar(
                                      child: ListView(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 4, bottom: 4),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 4, bottom: 4),
                                          ),
                                          ListTile(
                                            title: Text("Model Name", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),),
                                            trailing: Text(products[index].modelName!=null?products[index].modelName:'---'),
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text("Model Code", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),),
                                            trailing: Text(products[index].modelCode!=null?products[index].modelCode:'---'),
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text("Date", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),),
                                            trailing: Text(products[index].requestDate),
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text("Surface", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),),
                                            trailing: Text(products[index].surface),
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text("Size", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),),
                                            trailing: Text(products[index].size),
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text("Status", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),),
                                            trailing: Text(products[index].status),
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text("Commercial Decision", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),),
                                            subtitle: Text(products[index].customerObservtion!=null?products[index].customerObservtion:'---', ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )


                    ),
                  ),
                );
              }),
            )

        ],
      ),

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
  showTrialApprovalDialog(BuildContext context,Product product,String productId){
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
        ProgressDialog pd=ProgressDialog(context);
        pd.show();
        if(selectedPreference=="Approve"){
          Map<String,dynamic> map=Map();
          map.putIfAbsent("status", () => "Approved for Trial");
          Firestore.instance.collection("model_requests").document(productId).updateData(map).then((value){
            pd.hide();
            WidgetsBinding.instance
                .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
            Flushbar(
              message: "Request Approved for Trial",
              backgroundColor: Colors.green,
              duration: Duration(seconds: 5),
            )..show(context);
          }).catchError((onError){
            pd.hide();
            Flushbar(
              message: onError.toString(),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            )..show(context);
          });
        }else if(selectedPreference=="Reject"){
          Map<String,dynamic> map=Map();
          map.putIfAbsent("status", () => "Rejected for Trial");
          Firestore.instance.collection("model_requests").document(productId).updateData(map).then((value){
            pd.hide();
            WidgetsBinding.instance
                .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
            Flushbar(
              message: "Status of Request Changed",
              backgroundColor: Colors.green,
              duration: Duration(seconds: 5),
            )..show(context);
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
    AlertDialog alert = AlertDialog(
      title: Text("Approve/Reject Model for Trials"),
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
  Widget buildFloatingactionButtons(){
    if(isDataEntryOperator){
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
  @override
  void dispose() {
    FirebaseAuth.instance.signOut();
    SharedPreferences.getInstance().then((prefs){
      prefs.remove("user_id");
    });
    super.dispose();
  }

}

