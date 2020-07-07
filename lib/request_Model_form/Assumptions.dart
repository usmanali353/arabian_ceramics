import 'package:Arabian_Ceramics/request_Model_form/Specifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
class Assumptions extends StatefulWidget {
  @override
  _AssumptionsState createState() => _AssumptionsState();
}

class _AssumptionsState extends State<Assumptions> {
  TextEditingController market,event,client,other;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    market = TextEditingController();
    event=TextEditingController();
    client=TextEditingController();
    other=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF004c4c),
        title: Text("Assumptions"),
      ),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                //Market TextBox
                Padding(
                  padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: market,
                      attribute: "Market",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(hintText: "Market",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
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
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Specifications(market.text,client.text,event.text,other.text)));
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
