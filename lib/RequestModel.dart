import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

import 'Product.dart';
import 'Utils.dart';
class RequestModel extends StatefulWidget {
  @override
  _RequestModelState createState() => _RequestModelState();
}

class _RequestModelState extends State<RequestModel> {
  Uint8List picked_image;
  File _image;
  GlobalKey<FormBuilderState> _fbkey=GlobalKey();
  StorageReference storageReference;
  TextEditingController productName,surface,thickness,size,range,material,color,technology,structure,edge,classification,suitibility;
  @override
  void initState() {
    productName=TextEditingController();
    surface=TextEditingController();
    thickness=TextEditingController();
    size=TextEditingController();
    range=TextEditingController();
    material=TextEditingController();
    color=TextEditingController();
    technology=TextEditingController();
    structure=TextEditingController();
    edge=TextEditingController();
    classification=TextEditingController();
    suitibility=TextEditingController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text("Request Model"),
          backgroundColor: Color(0xFF004c4c),
      ),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbkey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: FormBuilderTextField(
                      attribute: "Product Name",
                      controller: productName,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                        hintText: "Product Name",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: FormBuilderTextField(
                      attribute: "Surface",
                      controller: surface,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                        hintText: "Surface"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: FormBuilderTextField(
                      attribute: "Thickness",
                      controller: thickness,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                        hintText: "Thickness"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: FormBuilderTextField(
                      attribute: "Size (cm)",
                      controller: size,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                        hintText: "Size (cm)"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: FormBuilderTextField(
                      attribute: "Range",
                      controller: range,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                          hintText: "Range"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: FormBuilderTextField(
                      attribute: "Material",
                      controller: material,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                          hintText: "Material"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: FormBuilderTextField(
                      attribute: "Color",
                      controller: color,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                          hintText: "Color"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: FormBuilderTextField(
                      attribute: "Technology",
                      controller: technology,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                          hintText: "Technology"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: FormBuilderTextField(
                      attribute: "Structure",
                      controller: structure,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                          hintText: "Structure"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: FormBuilderTextField(
                      attribute: "Edge",
                      controller: edge,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                          hintText: "Edge"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: FormBuilderTextField(
                      attribute: "Classification",
                      controller: classification,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                          hintText: "Classification"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: FormBuilderTextField(
                      attribute: "Suitibility",
                      controller: suitibility,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                          hintText: "Suitibility"
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
                      padding: EdgeInsets.only(top: 16),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        child: MaterialButton(
                          onPressed: (){
                            if(_fbkey.currentState.validate()){
                              var uniqueId=Uuid().v1();

                              storageReference = FirebaseStorage.instance
                                  .ref()
                                  .child("requested_model_images").child(uniqueId);
                              ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                              pd.show();
                              StorageUploadTask uploadTask = storageReference.putFile(_image);
                              uploadTask.onComplete.then((value){
                                storageReference.getDownloadURL().then((downloadUrl){
                                  if(downloadUrl!=null){
                                    Firestore.instance.collection("model_requests").document().setData(Product(name: productName.text,surface: surface.text,thickness: thickness.text,size: size.text,range: range.text,material: material.text,colour: color.text,technology: technology.text,structure: structure.text,edge:edge.text,classification: classification.text,suitibility: suitibility.text,image:downloadUrl, ).toJson()).then((response) {
                                      pd.hide();
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text("Model Added to the System"),
                                      ));
                                    }).catchError((onError){
                                      pd.hide();
                                      print(onError);
                                    });
                                  }else{
                                    pd.hide();
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Request for Model submitted"),
                                      backgroundColor: Colors.green,
                                    ));
                                  }
                                }).catchError((onError){
                                  pd.hide();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(onError.toString()),
                                    backgroundColor: Colors.red,
                                  ));
                                });
                              });
                            }
                          },
                          color:  Color(0xFF004c4c),
                          child: Text("Submit",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    );
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
