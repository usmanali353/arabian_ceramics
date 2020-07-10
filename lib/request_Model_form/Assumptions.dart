import 'package:Arabian_Ceramics/request_Model_form/Specifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:need_resume/need_resume.dart';
class Assumptions extends StatefulWidget {
  @override
  _AssumptionsState createState() => _AssumptionsState();
}

class _AssumptionsState extends ResumableState<Assumptions> {
  TextEditingController event,client,other;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  List<String> marketList=['Local General','Local Exclusive','Export'];
  String selectedMarket;
  @override
  void onResume() {
   Navigator.pop(context,'Refresh');
    super.onResume();
  }
  @override
  void initState() {
    event=TextEditingController();
    client=TextEditingController();
    other=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assumptions"),
      ),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                //Market Dropdown
                Padding(
                  padding: const EdgeInsets.only(top: 16,left: 16,right:16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FormBuilderDropdown(
                      attribute: "Market",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Select Market"),
                      items:marketList!=null?marketList.map((horse)=>DropdownMenuItem(
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
                          this.selectedMarket=value;
                        });
                      },
                    ),
                  ),
                ),
                // Event TextBox
                Padding(
                  padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FormBuilderTextField(
                      controller: event,
                      attribute: "Event",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(hintText: "Event",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ),
                // Client TextBox
                Padding(
                  padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FormBuilderTextField(
                      controller: client,
                      attribute: "Client",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(hintText: "Client",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ),
                //Other TextBox
                Padding(
                  padding: EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FormBuilderTextField(
                      controller: other,
                      attribute: "Other",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(hintText: "Other",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: MaterialButton(
                    child: Text("Proceed",style: TextStyle(color: Colors.white),),
                    color: Color(0xFF004c4c),
                    onPressed: (){
                      if(_fbKey.currentState.validate()){
                        push(context, MaterialPageRoute(builder: (context)=>Specifications(selectedMarket,client.text,event.text,other.text)));
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
