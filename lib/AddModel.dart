import 'package:Arabian_Ceramics/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'Utils.dart';

class AddModel extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddModel();
  }

}
class _AddModel extends State<AddModel>{
  TextEditingController thickness, suitability;
  var pickedImage=null;
  List<String> product_name =["Alma","Apollo","Aqua","Aragon","Arcadia","Area","Artic","Atrium","Avenue","Baikal","Barsha","Bistro","Bologna","Brada","Bronze","CalaCatta","Canica","Capri","carrara","Cement","Circle","Code","Coliseo","Cotto","Cotton","Daka","Darco","Dayana","Devon","Diverse","Dogana","Duomo","Finnis","Joly","Maria","Tiera","Venecia"], surface=[], size=[], range=[], material=[], color=[], technology=[], structure=[], edge=[], classification=[];
  String selected_product_name, selected_surface, selected_size, selected_range, selected_material, selected_color, selected_technology, selected_structure, selected_edge, selected_classification;
  int product_name_id, surface_id, size_id, range_id, material_id, color_id, technology_id, structure_id, edge_id,classification_id;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  @override
  void initState() {
    thickness = TextEditingController();
    suitability = TextEditingController();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_enhance),
        onPressed: (){
          Utils.getImage().then((image){
            this.pickedImage=image.readAsBytes();
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF004c4c),
        title: Text("Create Production Request", style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Visibility(
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: FormBuilderDropdown(
                        attribute: "Product Name",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Select Product"),
                        items:product_name!=null?product_name.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_product_name=value;
                            this.product_name_id=product_name.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: Visibility(
                    // visible: flushes_loaded,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: FormBuilderDropdown(
                        attribute: "Surface",
                        validators: [FormBuilderValidators.required()],
                        hint: Text('Select Surface'),
                        items:surface!=null?surface.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_surface=value;
                            this.surface_id=surface.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: thickness,
                      attribute: "Thickness",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(hintText: "Thickness (cm)",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                  child: Visibility(
                    // visible: flushes_loaded,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FormBuilderDropdown(
                        attribute: "Size",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Size (cm)"),
                        items:size!=null?size.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_size=value;
                            this.size_id=size.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16,left: 16,right:16),
                  child: Visibility(
                    // visible: flushes_loaded,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FormBuilderDropdown(
                        attribute: "Range",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Select Range"),
                        items:range!=null?range.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_range=value;
                            this.range_id=range.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:16,left:16,right:16),
                  child: Visibility(
                    // visible: flushes_loaded,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FormBuilderDropdown(
                        attribute: "Material",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Select Material"),
                        items:material!=null?material.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_material=value;
                            this.material_id=material.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:16,left:16,right:16),
                  child: Visibility(
                    // visible: flushes_loaded,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: FormBuilderDropdown(
                        attribute: "Color",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Select Color"),
                        items:color!=null?color.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16)
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_color=value;
                            this.color_id=color.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16,left: 16,right:16),
                  child: Visibility(
                    // visible: flushes_loaded,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FormBuilderDropdown(
                        attribute: "Technology",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Select Technology"),
                        items:technology!=null?technology.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          border:InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_technology=value;
                            this.technology_id=technology.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                  child: Visibility(
                    // visible: flushes_loaded,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FormBuilderDropdown(
                        attribute: "Structure",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Select Structure"),
                        items:structure!=null?structure.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16)
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_structure=value;
                            this.structure_id=structure.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16,left: 16,right:16),
                  child: Visibility(
                    // visible: flushes_loaded,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FormBuilderDropdown(
                        attribute: "Edge",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Select Edge"),
                        items:edge!=null?edge.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_edge=value;
                            this.edge_id=edge.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16,left: 16,right:16),
                  child: Visibility(
                    // visible: flushes_loaded,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FormBuilderDropdown(
                        attribute: "Classification",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Select Classification"),
                        items:classification!=null?classification.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_classification=value;
                            this.classification_id=classification.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16,left: 16,right:16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FormBuilderTextField(
                      //keyboardType: TextInputType.number,
                      controller: suitability,
                      attribute: "Suitability",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(hintText: "Suitability",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
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

                              Firestore.instance.collection("models").document().setData(Product(name:'ARAGON CREAM',surface: 'GLOSSY',thickness:'9mm',size: '45x45 cm',range: 'DAR',material:'MARBLE',colour: 'BEIGE, BROWN',technology:'DIGITAL',edge:'natural',structure: 'PLAIN',classification:'NATURAL',suitibility: 'RESIDENTIAL AREA,LIVING ROOM,BATHROOM',image: null).toJson()).then((response) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Model Added to the System"),
                                ));
                              }).catchError((onError){
                                print(onError);
                              });
                          },
                          color:  Color(0xFF004c4c),
                          child: Text("Submit",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    );
                  },
                ),
//                Builder(
//                  builder: (BuildContext context){
//                    return Padding(
//                      padding: EdgeInsets.only(top: 16),
//                      child: MaterialButton(
////                        onPressed: (){
////                          if(_fbKey.currentState.validate()){
////                            ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
////                            pd.show();
////                            Network_Operations.CreateCustomerCase(customerId, description.text, 1, caseType, 'some customer', 0, 'caseMemo').then((response){
////                              pd.hide();
////                              if(response!=null){
////                                Scaffold.of(context).showSnackBar(SnackBar(
////                                  backgroundColor: Colors.green,
////                                  content: Text("Case Added Sucessfully"),
////                                ));
////                                Navigator.pop(context,'Refresh');
////                              }else{
////                                Scaffold.of(context).showSnackBar(SnackBar(
////                                  backgroundColor: Colors.red,
////                                  content: Text("Case not Added"),
////                                ));
////                              }
////                            });
////                          }
////                        },
//                        color:  Color(0xFF004c4c),
//                        child: Text("Submit",style: TextStyle(color: Colors.white),),
//                      ),
//                    );
//                  },
//                ),
              ],
            ),
          )

        ],
      ),
    );
  }

}