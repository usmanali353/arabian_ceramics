import 'package:Arabian_Ceramics/request_Model_form/designTopology.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:need_resume/need_resume.dart';
class Specifications extends StatefulWidget {
  String market,client,event,other;

  Specifications(this.market, this.client, this.event, this.other);

  @override
  _SpecificationsState createState() => _SpecificationsState(market,client,event,other);
}

class _SpecificationsState extends ResumableState<Specifications> {
  String market,client,event,other;
  TextEditingController thickness;
  bool sizeVisible=false,surfaceVisible=false,thicknessVisible=false;
  List<String> surface=[], product_name =["Alma","Apollo","Aqua","Aragon","Arcadia","Area","Artic","Atrium","Avenue","Baikal","Barsha","Bistro","Bologna","Brada","Bronze","CalaCatta","Canica","Capri","carrara","Cement","Circle","Code","Coliseo","Cotto","Cotton","Daka","Darco","Dayana","Devon","Diverse","Dogana","Duomo","Finnis","Joly","Maria","Tiera","Venecia"],classification=["Floor Tiles","Floor Decor","Wall Tiles","Wall Decor"];
  List<dynamic> size=[];
  String selected_product_name, selected_surface, selected_size,selected_classification;
  int product_name_id, surface_id, size_id,classification_id;
  _SpecificationsState(this.market, this.client, this.event, this.other);
  List _myActivities,sizes;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final fbKey = new GlobalKey<FormBuilderState>();
  @override
  void onResume() {
    if(resume.data.toString()=='Close') {
      Navigator.pop(context, 'Close');
    }
    super.onResume();
  }
@override
  void initState() {
   thickness=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Specifications"),
      ),
      body:ListView(
        children: <Widget>[
          FormBuilder(
            key: fbKey,
            child: Column(
              children: <Widget>[
                //ProductName Dropdown
                //Product Classification Dropdown
                Padding(
                  padding: const EdgeInsets.only(top:16,left: 16,right:16,bottom: 16),
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
                          surfaceVisible=true;
                          this.selected_classification=value;
                          this.classification_id=classification.indexOf(value);
                          if(selected_classification=="Floor Tiles"||selected_classification=="Wall Tiles"){
                            if(surface.length>0){
                              surface.clear();
                            }
                            surface.add("Glossy");
                            surface.add("Mate");
                            surface.add("Outdoor");
                            surface.add("Plain");
                            surface.add("Structured");
                          }else if(selected_classification=='Floor Decor'||selected_classification=="Wall Decor"){
                            if(surface.length>0){
                              surface.clear();
                            }
                            surface.add("Mate");
                            surface.add("Glossy");
                          }
                        });
                      },
                    ),
                  ),
                ),
                //Product Surface Dropdown
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: Visibility(
                    visible: surfaceVisible,
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
                            sizeVisible=true;
                            this.selected_surface=value;
                            this.surface_id=surface.indexOf(value);
                            if(selected_surface=="Mate"&&selected_classification=='Floor Tiles'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              }
                              size.add(
                                {"display":"32 x 32","value":"32 x 32"}
                              );
                            }else if(selected_surface=="Mate"&&selected_classification=='Floor Decor'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              }
                              size.add(
                                  {"display":"32 x 32","value":"32 x 32"}
                              );
                            }else if(selected_surface=="Mate"&&selected_classification=='Wall Tiles'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              } size.add(
                                  {"display":"25 x 40","value":"25 x 40"}
                              );
                            }else if(selected_surface=="Mate"&&selected_classification=='Wall Decor'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              }
                              size.add(
                                  {"display":"25 x 40","value":"25 x 40"}
                              );
                            }else if(selected_surface=="Glossy"&&selected_classification=='Floor Tiles'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              }
                              size.add(
                                  {"display":"45 x 45","value":"45 x 45"},
                              );
                              size.add(
                                  {"display":"60 x 60","value":"60 x 60"}
                              );

                            }else if(selected_surface=="Glossy"&&selected_classification=='Floor Decor'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              }
                              size.add(
                                  {"display":"45 x 45","value":"45 x 45"},
                              );
                            }else if(selected_surface=="Glossy"&&selected_classification=='Wall Tiles'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              }
                              size.add(
                                  {"display":"25 x 50","value":"25 x 50"},
                              );
                            }else if(selected_surface=="Glossy"&&selected_classification=='Wall Decor'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              }
                              size.add('25 x 50');
                            }else if(selected_surface=="Plain"&&selected_classification=='Floor Tiles'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              }
                              size.add(
                                  {"display":"32 x 32","value":"32 x 32"},
                              );
                            }else if(selected_surface=="Plain"&&selected_classification=='Wall Tiles'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              }
                              size.add(
                                  {"display":"25 x 40","value":"25 x 40"},
                              );
                            }else if(selected_surface=="Structured"&&selected_classification=='Floor Tiles'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              }
                              size.add(
                                  {"display":"45 x 45","value":"45 x 45"},
                              );
                              size.add(
                                  {"display":"60 x 60","value":"60 x 60"},
                              );
                            }else  if(selected_surface=="Structured"&&selected_classification=='Wall Tiles'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              }
                              size.add(
                                  {"display":"25 x 50","value":"25 x 50"},
                              );
                            }else  if(selected_surface=="Outdoor"&&selected_classification=='Floor Tiles'){
                              if(size.length>0){
                                selected_size=null;
                                size.clear();
                              }
                              size.add(
                                  {"display":"60 x 60","value":"60 x 60"}
                              );
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                //Product Size Dropdown
                Padding(
                  padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                  child: Visibility(
                    visible: sizeVisible,
                    child: Form(
                      key: formKey2,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: MultiSelectFormField(
                          hintText: "Select Sizes for the Product",
                          titleText: 'Select Sizes',
                          border: InputBorder.none,
                          validator: (value) {
                            return value == null || value.length == 0?'Please select one or more options':null;
                          },
                          dataSource: size,
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCEL',
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              sizes = value;
                            });
                          },

                        ),
                      ),
                    ),
                  ),
                ),
                //Product Thickness TextBox
                Padding(
                  padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FormBuilderTextField(
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
                //Product Color multiSelect FormField
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.only(top:16,left:16,right:16),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: MultiSelectFormField(
                        hintText: "Select Color for the Product",
                        titleText: 'Select Colors',
                        border: InputBorder.none,
                        validator: (value) {
                          return value == null || value.length == 0?'Please select one or more options':null;
                        },
                        dataSource: [
                          {
                            "display": "BEIGE",
                            "value": "BEIGE",
                          },
                          {
                            "display": "BROWN",
                            "value": "BROWN",
                          },
                          {
                            "display": "CREAM",
                            "value": "CREAM",
                          },
                          {
                            "display": "GRAY",
                            "value": "GRAY",
                          },
                          {
                            "display": "LIGHT GRAY",
                            "value": "LIGHT GRAY",
                          },
                          {
                            "display": "WHITE",
                            "value": "WHITE",
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
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: MaterialButton(
                      color: Color(0xFF004c4c),
                      child: Text("Proceed",style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        if(fbKey.currentState.validate()&&formKey.currentState.validate()&&formKey2.currentState.validate()){
                          formKey.currentState.save();
                          formKey2.currentState.save();
                          setState(() {
                            _myActivitiesResult = _myActivities.toString();
                          });
                          push(context, MaterialPageRoute(builder: (context)=>designTopology(market,client,event,other,sizes.toString().replaceAll("[]", ''),selected_surface,thickness.text,selected_classification,_myActivitiesResult)));
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }
}
