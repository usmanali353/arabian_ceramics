
import 'dart:io';
import 'dart:typed_data';

import 'package:Arabian_Ceramics/Model/Product.dart';
import 'package:Arabian_Ceramics/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';


class Suitability extends StatefulWidget{
  String market,client,event,other,size,surface,name,thickness,classification,color,technology, structure, edge,range,material;

  Suitability(
    this.market,
    this.client,
    this.event,
    this.other,
    this.size,
    this.surface,
    this.name,
    this.thickness,
    this.classification,
    this.color,
    this.technology,
    this.structure,
    this.edge,
    this.range,
    this.material);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Suitability_State(market,client,event,other,size,surface,name,thickness,classification,color,technology, structure, edge,range,material);
  }
}

class _Suitability_State extends ResumableState<Suitability> {
  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();
  final fbKey = new GlobalKey<FormBuilderState>();
  FirebaseUser user;
  String market,client,event,other,size,surface,name,thickness,classification,color,technology, structure, edge,range,material;
 @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user){
    this.user=user;
  });
    super.initState();
  }

  _Suitability_State(
      this.market,
      this.client,
      this.event,
      this.other,
      this.size,
      this.surface,
      this.name,
      this.thickness,
      this.classification,
      this.color,
      this.technology,
      this.structure,
      this.edge,
      this.range,
      this.material);

  Uint8List picked_image;
  File _image;
  StorageReference storageReference;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Suitability"),
        ),
        body:ListView(
          children: <Widget>[
            FormBuilder(
              key: fbKey,
              child: Column(
                children: <Widget>[
                  //ProductName Dropdown
                  //Product Color multiSelect FormField
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.only(top:16,left:16,right:16),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: MultiSelectFormField(
                          hintText: "Suitable for",
                          titleText: 'Select Suitability',
                          border: InputBorder.none,
                          validator: (value) {
                            return value == null || value.length == 0?'Please select one or more options':null;
                          },
                          dataSource: [
                            {
                              "display": "BATHROOMS",
                              "value": "BATHROOMS",
                            },
                            {
                              "display": "KITCHEN",
                              "value": "KITCHEN",
                            },
                            {
                              "display": "SALONS/HALLS",
                              "value": "SALONS/HALLS",
                            },
                            {
                              "display": "PUBLIC PLACES",
                              "value": "PUBLIC PLACES",
                            },
                            {
                              "display": "OTHERS",
                              "value": "OTHERS",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCEL',
                          //value: _myActivities,
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              _myActivities = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(16),
                          height: 100,
                          width: 80,
                          child: _image == null ? Text('No image selected.') : Image.file(_image),
                        ),
                        MaterialButton(
                          color: Colors.teal,
                          onPressed: (){
                            Utils.getImage().then((image_file){
                              if(image_file!=null){
                                image_file.readAsBytes().then((image){
                                  if(image!=null){
                                    setState(() {
                                      this.picked_image=image;
                                      _image = File(image_file.path);
                                    });
                                  }
                                });
                              }else{

                              }
                            });
                          },
                          child: Text("Select Image",style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (BuildContext context){
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: MaterialButton(
                            color: Color(0xFF004c4c),
                            child: Text("Proceed",style: TextStyle(color: Colors.white),),
                            onPressed: (){
                              if(fbKey.currentState.validate()&&formKey.currentState.validate()){
                                formKey.currentState.save();
                                setState(() {
                                  _myActivitiesResult = _myActivities.toString();
                                });
                                var uniqueId=Uuid().v1();
                                storageReference = FirebaseStorage.instance
                                    .ref()
                                    .child("requested_model_images").child(uniqueId);
                                Utils.check_connectivity().then((connected){
                                  if(connected){
                                    ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                    pd.show();
                                    StorageUploadTask uploadTask = storageReference.putFile(_image);
                                    uploadTask.onComplete.then((value){
                                      storageReference.getDownloadURL().then((downloadUrl){
                                        if(downloadUrl!=null){
                                          Firestore.instance.collection("model_requests").document().setData(Product(name: name,surface: surface,edge: edge,classification: classification,structure: structure,market: market,client: client,event: event,technology: technology,other: other,suitibility:  _myActivitiesResult,material: material,image: downloadUrl,colour: color,range: range,requestedBy: user.uid,size: size,thickness: thickness,status:"New Request",requestDate:DateFormat("yyyy-MM-dd").format(DateTime.now())).toJson()).then((response){
                                            pd.hide();
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text("Request for Model Added"),
                                              backgroundColor: Colors.green,
                                            ));
                                            Navigator.pop(context,'Close');
                                          }).catchError((onError){
                                            pd.hide();
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text(onError.toString()),
                                              backgroundColor: Colors.red,
                                            ));
                                          });
                                        }
                                      }).catchError((onError){
                                        pd.hide();
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(onError.toString()),
                                          backgroundColor: Colors.red,
                                        ));
                                      });
                                    }).catchError((onError){
                                      pd.hide();
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(onError.toString()),
                                        backgroundColor: Colors.red,
                                      ));
                                    });
                                  }else{
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Network not Available"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                });


                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>designTopology(market,client,event,other,selected_size,selected_surface,selected_product_name,thickness.text,selected_classification,_myActivitiesResult)));
                              }
                            },
                          ),
                        ),
                      );
                    },

                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}