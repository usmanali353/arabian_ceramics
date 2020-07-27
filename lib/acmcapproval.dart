import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:progress_dialog/progress_dialog.dart';
class acmcApproval extends StatefulWidget {
 String status,productId,approvedBy,approveById;

 acmcApproval(this.status, this.productId,this.approvedBy,this.approveById);

 @override
  _acmcApprovalState createState() => _acmcApprovalState(status,productId,approvedBy,approveById);
}

class _acmcApprovalState extends State<acmcApproval> {
  GlobalKey<FormBuilderState> fbKey=GlobalKey();
  GlobalKey<FormState> formState=GlobalKey();
  List myDesigners;
  TextEditingController designerObservations,modelName,modelCode;
  String status,productId,approvedBy,approveById;
  _acmcApprovalState(this.status, this.productId,this.approvedBy,this.approveById);

  @override
  void initState() {
    designerObservations=TextEditingController();
    modelName=TextEditingController();
    modelCode=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Designers Involved"),
      ),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: fbKey,
            child: Column(
              children: <Widget>[
                Form(
                  key: formState,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: MultiSelectFormField(
                        autovalidate: false,
                        hintText: "Select Designers",
                        titleText: 'Select Designers',
                        textField: 'display',
                        valueField: 'value',
                        okButtonLabel: 'OK',
                        cancelButtonLabel: 'CANCEL',
                        dataSource: [
                          {"display":"Designer 1","value":"Designer 1"},
                          {"display":"Designer 2","value":"Designer 2"},
                          {"display":"Designer 3","value":"Designer 3"},
                          {"display":"Designer 4","value":"Designer 4"},
                        ],
                        border: InputBorder.none,
                        validator: (value) {
                          return value == null || value.length == 0?'Please select one or more Designer':null;
                        },
                        onSaved: (value){
                          if (value == null) return;
                          setState(() {
                            myDesigners = value;
                          });
                        },

                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FormBuilderTextField(
                      attribute: "Designer Observations",
                      maxLines: 8,
                      controller: designerObservations,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        border: InputBorder.none,
                        hintText: "Designer Observations"
                      ),

                    ),
                  ),
                ),
                MaterialButton(
                  color: Color(0xFF004c4c),
                  child: Text("Proceed",style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    if(fbKey.currentState.validate()&&formState.currentState.validate()){
                      formState.currentState.save();
                      if(status=='Reject'){
                        ProgressDialog pd=ProgressDialog(context);
                        pd.show();
                        Map<String,dynamic> map=Map();
                        map.putIfAbsent("status", () => "Rejected by ACMC");
                        map.putIfAbsent("acmcrejectedbywhomId", () => approveById);
                        map.putIfAbsent("acmcrejectedbywhomName", () => approvedBy);
                        map.putIfAbsent("acmcrejectiondate", () => DateFormat("yyyy-MM-dd").format(DateTime.now()));
                        map.putIfAbsent("designers", () => myDesigners.toString().replaceAll("[]]",''));
                        map.putIfAbsent("designers_observations", () => designerObservations.text);
                        Firestore.instance.collection("model_requests").document(productId).updateData(map).then((value){
                          pd.hide();
                          Navigator.pop(context,'Close');
                          Flushbar(
                            message: "Request Rejected",
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
                      }else{
                        ProgressDialog pd=ProgressDialog(context);
                        pd.show();
                        Map<String,dynamic> map=Map();
                        map.putIfAbsent("status", () => "Approved by ACMC");
                        map.putIfAbsent("acmcapprovalbywhomId", () => approveById);
                        map.putIfAbsent("acmcapprovalbywhomName", () => approvedBy);
                        map.putIfAbsent("acmcapprovaldate", () => DateFormat("yyyy-MM-dd").format(DateTime.now()));
                        map.putIfAbsent("designers", () => myDesigners.toString().replaceAll("[]]",''));
                        map.putIfAbsent("designer_observations", () => designerObservations.text);

                        Firestore.instance.collection("model_requests").document(productId).updateData(map).then((value){
                          pd.hide();
                          Navigator.pop(context,'Close');
                          Flushbar(
                            message: "Request Approved",
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
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
