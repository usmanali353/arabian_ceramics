import 'package:Arabian_Ceramics/Model/Schedule.dart';
import 'package:flutter/material.dart';
class ScheduleDetails extends StatefulWidget {
  Schedule scheduleData;

  ScheduleDetails(this.scheduleData);

  @override
  _ScheduleDetailsState createState() => _ScheduleDetailsState(scheduleData);
}

class _ScheduleDetailsState extends State<ScheduleDetails> {
  Schedule scheduleData;

  _ScheduleDetailsState(this.scheduleData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Schedule Details"),),
        body: Stack(
          children: <Widget>[
            Container(
              //color: Color(0xFF004c4c),
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Assets/img/background.png"),
                    fit: BoxFit.cover,
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150, bottom: 10),
              child: Center(
                child: new Container(
                  //height: MediaQuery.of(context).size.height * 0.65,
                  //width: ,
                  child: new Card(
                    elevation: 6.0,
                    margin: EdgeInsets.only(right: 15.0, left: 15.0),
                    child: Scrollbar(
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top:16,bottom: 16),
                            child: Center(
                              child: Text("Schedule Info", style:
                              TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),),
                            ),

                          ),
                          ListTile(
                            title: Text("Scheduled Production",style: TextStyle(fontWeight: FontWeight.bold),),
                            trailing: Text(scheduleData.scheduledOn),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Scheduled By",style: TextStyle(fontWeight: FontWeight.bold),),
                            trailing: Text(scheduleData.scheduledByName),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(top: 16,bottom: 16),
                            child: Center(child: Text("Scheduled Item Info",
                              style:
//                              GoogleFonts.courgette(
//                              textStyle: TextStyle(color: Colors.black, fontSize: 25),
//                            ),
                              TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            ),
                          ),
                          ListTile(
                            title: Text("Surface", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                            trailing: Text(scheduleData.surface),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Thickness", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                            trailing: Text(scheduleData.thickness),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Size", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                            trailing: Text(scheduleData.size),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Range", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                            trailing: Text(scheduleData.range),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Material", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                            trailing: Text(scheduleData.material),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Color", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                            trailing: Text(scheduleData.colour),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Technology", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                            trailing: Text(scheduleData.technology),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Structure", style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                            trailing: Text(scheduleData.structure),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Edge", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                            trailing: Text(scheduleData.edge),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Classification", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                            trailing: Text(scheduleData.classification),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
