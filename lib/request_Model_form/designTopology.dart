import 'package:Arabian_Ceramics/request_Model_form/Suitability.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:need_resume/need_resume.dart';
class designTopology extends StatefulWidget {
  String market,client,event,other,size,surface,thickness,classification,color;

  designTopology(this.market, this.client, this.event, this.other, this.size,
      this.surface, this.thickness, this.classification, this.color);

  @override
  _designTopologyState createState() => _designTopologyState(market,client,event,other,size,surface,thickness,classification,color);
}

class _designTopologyState extends ResumableState<designTopology> {
  List _myMaterials;
  final formKey = new GlobalKey<FormState>();
 List<String> range=['Ark'], material=["Stone","Marble","Wood", "Texture","Geometrics","Cement","Rustic","Plain Color"],structure=['Plain',"Structured"], edge=['Natural'],technology=["Digital"];
 String market,client,event,other,size,surface,name,thickness,classification,color;
String selected_technology, selected_structure, selected_edge,selected_range, selected_material;
GlobalKey<FormBuilderState> fbkey=GlobalKey();
int range_id, material_id,technology_id, structure_id, edge_id;
 _designTopologyState(
      this.market,
      this.client,
      this.event,
      this.other,
      this.size,
      this.surface,
      this.thickness,
      this.classification,
      this.color);
 @override
  void onResume() {
   if(resume.data.toString()=='Close') {
     Navigator.pop(context, 'Close');
   }
    super.onResume();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More Specifications"),
      ),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: fbkey,
            child: Column(
              children: <Widget>[
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
                        hintText: "Select Design Topology",
                        titleText: 'Select Design Topology',
                        border: InputBorder.none,
                        validator: (value) {
                          return value == null || value.length == 0?'Please select one or more options':null;
                        },
                        dataSource: [
                          {
                            "display": "STONE",
                            "value": "STONE",
                          },
                          {
                            "display": "MARBLE",
                            "value": "MARBLE",
                          },
                          {
                            "display": "WOOD",
                            "value": "WOOD",
                          },
                          {
                            "display": "TEXTURE",
                            "value": "TEXTURE",
                          },
                          {
                            "display": "GEOMETRICS",
                            "value": "GEOMETRICS",
                          },
                          {
                            "display": "CEMENT",
                            "value": "CEMENT",
                          },
                          {
                            "display": "RUSTIC",
                            "value": "RUSTIC",
                          },
                          {
                            "display": "PLAIN COLOR",
                            "value": "PLAIN COLOR",
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
                            _myMaterials = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                //Product Materials

                //Product Range
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
                //Product Technology
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
                //Product Structure
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
                //Edge
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Color(0xFF004c4c),
                      child: Text("Proceed",style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        if(fbkey.currentState.validate()&&formKey.currentState.validate()){
                          formKey.currentState.save();
                          setState(() {
                            selected_material=_myMaterials.toString();
                            print(selected_material);
                          });
                          push(context, MaterialPageRoute(builder: (context)=>Suitability(
                              market,
                              client,
                              event,
                              other,
                              size,
                              surface,
                              thickness,
                              classification,
                              color,
                              selected_technology,
                              selected_structure,
                              selected_edge,
                              selected_range,
                              selected_material)));
                        }
                      },
                    ),
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
