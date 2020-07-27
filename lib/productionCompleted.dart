import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
class productionCompleted extends StatefulWidget {
  String productId;

  productionCompleted(this.productId);

  @override
  _productionCompletedState createState() => _productionCompletedState(productId);
}

class _productionCompletedState extends State<productionCompleted> {
  String productId;
  TextEditingController modelName,modelCode;
  GlobalKey<FormBuilderState> fbKey=GlobalKey();
//  map.putIfAbsent("modelName", () => modelName.text);
//  map.putIfAbsent("modelCode", () => modelCode.text);
  _productionCompletedState(this.productId);

  @override
  void initState() {
    modelName=TextEditingController();
    modelCode=TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Model Name/Code"),),
    body: ListView(
      children: <Widget>[
        FormBuilder(
          key: fbKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FormBuilderTextField(
                    attribute: "Model Name",
                    controller: modelName,
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        border: InputBorder.none,
                        hintText: "Model Name"
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FormBuilderTextField(
                    attribute: "Model Code",
                    controller: modelCode,
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        border: InputBorder.none,
                        hintText: "Model Code"
                    ),
                  ),
                ),
              ),
              Center(
                child: MaterialButton(
                  color: Color(0xFF004c4c),
                  child: Text("Proceed",style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    if(fbKey.currentState.validate()){
                      Map<String,dynamic> map=Map();
                      map.putIfAbsent("modelName", () => modelName.text);
                      map.putIfAbsent("modelCode", () => modelCode.text);
                      map.putIfAbsent("status", () => "Samples Produced");
                      map.putIfAbsent("sample_production_date", () => DateFormat("yyyy-MM-dd").format(DateTime.now()));
                      ProgressDialog pd=ProgressDialog(context);
                      pd.show();
                      Firestore.instance.collection("model_requests").document(productId).updateData(map).then((updateStatus){
                        pd.hide();
                        Navigator.pop(context,"Close");
                        Flushbar(
                          message: "Status for Request changed to Produced",
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
        )

      ],
    ),
    );
  }
}
