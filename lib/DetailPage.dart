import 'package:Arabian_Ceramics/Model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DetailPage extends StatefulWidget {
 Product product;

 DetailPage(this.product);

  @override
  _DetailPageState createState() => _DetailPageState(product);
}

class _DetailPageState extends State<DetailPage>{
   Product product;
  _DetailPageState(this.product);
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF004c4c),
          title: Text("Product Details"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => add_breeding_control(token)),);
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              //color: Color(0xFF004c4c),
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.image),
                  fit: BoxFit.cover,
                )
              ),
            ),
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
                            Center(child: Text(product.name,
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
                              trailing: Text(product.surface, style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Thickness", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text(product.thickness, style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Size", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text(product.size, style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Range", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text(product.range, style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Material", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text(product.material, style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Color", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text(product.colour, style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Technology", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text(product.technology, style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Structure", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text(product.structure, style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Edge", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text(product.edge, style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Classification", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text(product.classification, style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Suitability", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                              trailing: Text(product.suitibility, style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 18
                              ),),
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
        ));

  }

}

