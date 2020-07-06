import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//        appBar: AppBar(
//          leading:  IconButton(
//            icon: Icon(Icons.menu, color: Colors.white,size:32),
////                            onPressed: (){
////                              Navigator.pop(context);
////                            },
//          ),
//          backgroundColor:  Color(0xFF004c4c),
//          titleSpacing: 90,
//          title: Text("Delivery Details", style: TextStyle(
//              color: Colors.white
//          ),
//          ),
//
//        ),
//        appBar: AppBar(
//         toolbarOpacity: 1,
//          leading:  IconButton(
//            icon: Icon(Icons.menu, color: Colors.white,size:32),
////                            onPressed: (){
////                              Navigator.pop(context);
////                            },
//          ),
//          backgroundColor:  Color(0xFF004c4c),
//          titleSpacing: 90,
//          title: Text("Product Details", style: TextStyle(
//              color: Colors.white
//          ),
//          ),
//
//        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF004c4c),
          title: Text("Product Details"),
          actions: <Widget>[
            //Center(child: Text("Add New",textScaleFactor: 1.3,)),
            IconButton(

              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => add_breeding_control(token)),);
              },
            )
//          IconButton(
//            icon: Icon(Icons.picture_as_pdf),
//           // onPressed: () => _generatePdfAndView(context),
//          ),
          ],
        ),
        body: Stack(
          children: <Widget>[

            Container(
              //color: Color(0xFF004c4c),
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/img/background.png'),
                  fit: BoxFit.cover,
//                  Image.asset(
//                    'assets/marble.jpg',
//                    fit: BoxFit.cover,
//                  ),
                )
              ),
              //child: Text("Hello", style: TextStyle(color: Colors.amber, fontSize: 30),),
            ),
//            new Image.asset(
//              'assets/marble.jpg',
//              fit: BoxFit.cover,
//         ),

            Padding(
              padding: const EdgeInsets.only(top: 150, bottom: 10),
              child: Center(
                child: new Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  //width: ,
                  child: new Card(
                    color: Colors.white,
                    elevation: 6.0,
                    margin: EdgeInsets.only(right: 15.0, left: 15.0),
                      child: Scrollbar(
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 4, bottom: 4),
                            ),
                            Center(child: Text("ARAGON ROJO",
                              style:
//                              GoogleFonts.courgette(
//                              textStyle: TextStyle(color: Colors.black, fontSize: 25),
//                            ),
                            TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            ),
                            ),
                            ),
                           Padding(
                             padding: EdgeInsets.only(top: 4, bottom: 4),
                           ),
                           ListTile(
                              title: Text("Surface", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text("Glossy", style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            ListTile(
                              title: Text("Thickness", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text("9 cm", style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            ListTile(
                              title: Text("Size", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text("45 x 45 cm", style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            ListTile(
                              title: Text("Range", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text("DAR", style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            ListTile(
                              title: Text("Material", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text("Marble", style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            ListTile(
                              title: Text("Color", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text("Coffee Brown", style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            ListTile(
                              title: Text("Technology", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text("Digital", style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            ListTile(
                              title: Text("Structure", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text("Plain", style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            ListTile(
                              title: Text("Edge", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text("Natural", style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            ListTile(
                              title: Text("Classification", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text("Floor Tiles", style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            ListTile(
                              title: Text("Suitability", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text("Residential Area", style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),

//                  child: new Wrap(
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.only(left: 12, top: 25),
//                        width: MediaQuery.of(context).size.width,
//                        height: 70,
//                        color: Colors.white,
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text("Order ID",
//                              style: TextStyle(
//                                  color: Colors.grey.shade600,
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 17
//                              ),
//                            ),
//                            Padding(
//                              padding: EdgeInsets.only(top: 2),
//                            ),
//                            Text("19S0-03",
//                              style: TextStyle(
//                                  color: Colors.black,
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 17
//                              ),
//                            )
//                          ],
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(top: 5, bottom: 5),
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          Container(
//                            margin: EdgeInsets.only(left: 2, right: 2 ),
//                            width: 110,
//                            height: 70,
//                            color: Colors.white,
//                            child: Column(
//                              children: <Widget>[
//                                Text("Packing Slip#",
//                                  style: TextStyle(
//                                      color: Colors.grey.shade600,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 17
//                                  ),
//                                ),
//                                Padding(
//                                  padding: EdgeInsets.only(top: 2),
//                                ),
//                                Text("19-DN05344",
//                                  style: TextStyle(
//                                      color: Colors.black,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 17
//                                  ),
//                                )
//                              ],
//                            ),
//                          ),
//                          Container(
//                            width: 110,
//                            height: 70,
//                            color: Colors.white,
//                            child: Column(
//                              children: <Widget>[
//                                Text("Plate Quantity",
//                                  style: TextStyle(
//                                      color: Colors.grey.shade600,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 17
//                                  ),
//                                ),
//                                Padding(
//                                  padding: EdgeInsets.only(top: 2),
//                                ),
//                                Text("44",
//                                  style: TextStyle(
//                                      color: Colors.black,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 17
//                                  ),
//                                )
//                              ],
//                            ),
//                          ),
//                          Container(
//                            width: 130,
//                            height: 70,
//                            color: Colors.white,
//                            child: Column(
//                              children: <Widget>[
//                                Text("Quantity In SQM",
//                                  style: TextStyle(
//                                      color: Colors.grey.shade600,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 17
//                                  ),
//                                ),
//                                Padding(
//                                  padding: EdgeInsets.only(top: 2),
//                                ),
//                                Text("1520.640",
//                                  style: TextStyle(
//                                      color: Colors.black,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 17
//                                  ),
//                                )
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(top: 6, bottom: 6),
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          Container(
//                            margin: EdgeInsets.only(left: 2, right: 2 ),
//                            width: 110,
//                            height: 70,
//                            color: Colors.white,
//                            child: Column(
//                              children: <Widget>[
//                                Text("Truck Driver",
//                                  style: TextStyle(
//                                      color: Colors.grey.shade600,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 17
//                                  ),
//                                ),
//                                Padding(
//                                  padding: EdgeInsets.only(top: 2),
//                                ),
//                                Text("Usman",
//                                  style: TextStyle(
//                                      color: Colors.black,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 17
//                                  ),
//                                )
//                              ],
//                            ),
//                          ),
//                          Container(
//                            width: 110,
//                            height: 70,
//                            color: Colors.white,
//                            child: Column(
//                              children: <Widget>[
//                                Text("Truck Number",
//                                  style: TextStyle(
//                                      color: Colors.grey.shade600,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 17
//                                  ),
//                                ),
//                                Padding(
//                                  padding: EdgeInsets.only(top: 2),
//                                ),
//                                Text("3289",
//                                  style: TextStyle(
//                                      color: Colors.black,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 17
//                                  ),
//                                )
//                              ],
//                            ),
//                          ),
//                          Container(
//                            width: 110,
//                            height: 70,
//                            color: Colors.white,
//                            child: Column(
//                              children: <Widget>[
//                                Text("Line No.",
//                                  style: TextStyle(
//                                      color: Colors.grey.shade600,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 17
//                                  ),
//                                ),
//                                Padding(
//                                  padding: EdgeInsets.only(top: 2),
//                                ),
//                                Text("0",
//                                  style: TextStyle(
//                                      color: Colors.black,
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 17
//                                  ),
//                                )
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(top: 5, bottom: 5),
//                      ),
//                      Container(
//                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
//                        width: 350,
//                        height: 85,
//                        decoration: BoxDecoration(
//                          color: Color(0xFF004c4c),
//                          borderRadius: BorderRadius.circular(8),
//                        ),
//                        child: ListTile(
//                          leading: Icon(Icons.date_range, color: Colors.white,size:45),
//                          title: Text("Delivery Date", style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold
//
//                          ),
//                          ) ,
//                          subtitle:Text("15 April 2020", style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold
//                          ),
//                          ) ,
//                        ),
//
//                      )
//                    ],
//                  ),
                  ),
                ),
              ),
            ),
//            new RaisedButton(
//              onPressed: () {
//                print('Login Pressed');
//              },
//              color: Colors.redAccent,
//              shape: new RoundedRectangleBorder(
//                  borderRadius: new BorderRadius.circular(30.0)),
//              child: new Text('Login',
//                  style: new TextStyle(
//                      color: Colors.white,
//                      fontSize: 16.0,
//                      fontWeight: FontWeight.bold)),
//            ),
          ],
        ));

  }

}

