import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
class Observations extends StatefulWidget {
  String status,productId;
  Observations(this.status,this.productId);
  @override
  _ObservationsState createState() => _ObservationsState(status,productId);
}

class _ObservationsState extends State<Observations> {
  String status,productId;
  TextEditingController observation;
  GlobalKey<FormBuilderState> fbKey=GlobalKey();
  _ObservationsState(this.status,this.productId);
 @override
  void initState() {
    observation=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Observations"),),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FormBuilderTextField(
                      attribute: "Commercial Observation",
                      controller: observation,
                      validators: [FormBuilderValidators.required()],
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: "Commercial Observation",
                        contentPadding: EdgeInsets.all(16),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                Center(
                  child: MaterialButton(
                    child: Text("Change Status",style: TextStyle(color: Colors.white),),
                    color: Color(0xFF004c4c),
                    onPressed: (){
                      if(fbKey.currentState.validate()){
                        ProgressDialog pd=ProgressDialog(context);
                        pd.show();
                        Map<String,dynamic> map=Map();
                        if(status=='Approve'){
                          map.putIfAbsent("status", () => 'Approved by Customer');
                          map.putIfAbsent("customerApprovalDate", () => DateFormat("yyyy-MM-dd").format(DateTime.now()));
                        }else{
                          map.putIfAbsent("status", () => 'Rejected by Customer');
                          map.putIfAbsent("customerRejectionDate", () => DateFormat("yyyy-MM-dd").format(DateTime.now()));
                        }
                        map.putIfAbsent("customer_observation", () => observation.text);

                        Firestore.instance.collection("model_requests").document(productId).updateData(map).then((updated){
                           pd.hide();
                           Navigator.pop(context,"Refresh");
                           Flushbar(
                             message: 'Status of Request Changed',
                             duration: Duration(seconds: 5),
                             backgroundColor: Colors.green,
                           )..show(context);
                        }).catchError((onError){
                          pd.hide();
                          Flushbar(
                            message: onError.toString(),
                            duration: Duration(seconds: 5),
                            backgroundColor: Colors.red,
                          )..show(context);
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
