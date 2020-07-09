import 'package:Arabian_Ceramics/Model/Schedule.dart';
import 'package:Arabian_Ceramics/Production_Schedule/scheduleDetails.dart';
import 'package:Arabian_Ceramics/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class SchedulesList extends StatefulWidget {
  @override
  _SchedulesListState createState() => _SchedulesListState();
}

class _SchedulesListState extends State<SchedulesList> {
  bool scheduleListVisible=false;
  List<Schedule> schedules=[];
  List<String> schedulesId=[];
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey=GlobalKey();
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Schedules")),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((connected){
            if(connected){
              Firestore.instance.collection("Schedules").getDocuments().then((querySnapshot){
                if(querySnapshot.documents.length>0){
                  if(schedules!=null&&schedules.length>0){
                    schedules.clear();
                  }
                  if(schedulesId!=null&&schedulesId.length>0){
                    schedules.clear();
                  }
                  setState(() {
                    this.scheduleListVisible=true;
                    schedules.addAll(querySnapshot.documents.map((e) => Schedule.fromMap(e.data)).toList());
                    for(int i=0;i<querySnapshot.documents.length;i++){
                      schedulesId.add(querySnapshot.documents[i].documentID);
                    }
                  });

                }
              }).catchError((onError){
                Flushbar(
                  message: onError.toString(),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                )..show(context);
              });
            }else{
              Flushbar(
                message: "Network not Available",
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
              )..show(context);
            }
          });
        },
        child: Visibility(
          visible: scheduleListVisible,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 10,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(itemCount:schedules!=null?schedules.length:0,itemBuilder: (context,index){
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(schedules[index].name),
                      subtitle: Text('Planned Production Date: '+schedules[index].scheduledOn),
                      leading:  Material(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.teal.shade100,
                          child: Padding(
                            padding: const EdgeInsets.only(top:10,bottom: 15,right: 10,left: 10),
                            child: Icon(FontAwesomeIcons.calendar,size: 30,color: Color(0xFF004c4c),),
                          ),
                      ),
                      onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ScheduleDetails(schedules[index])));
                      },
                    ),
                    Divider(),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
