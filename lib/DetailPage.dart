import 'package:Arabian_Ceramics/Model/Product.dart';
import 'package:Arabian_Ceramics/qrcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DetailPage extends StatefulWidget {
 Product product;
 String productId;
 DetailPage(this.product,this.productId);

  @override
  _DetailPageState createState() => _DetailPageState(product,productId);
}

class _DetailPageState extends State<DetailPage>{
   Product product;
   String productId;
  _DetailPageState(this.product,this.productId);
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Request Details"),
          actions: <Widget>[
            product.status=='Produced'||product.status=='Approved by Customer'||product.status=='Approved for Trials'||product.status=='Scheduled for Production'?InkWell(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Center(child: Text("Generate QR Code")),
               ),
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>GenerateedQrcode(productId)));
              },
            ):Container(),
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
                  //height: MediaQuery.of(context).size.height * 0.65,
                  //width: ,
                  child: new Card(
                    elevation: 6.0,
                    margin: EdgeInsets.only(right: 15.0, left: 15.0),
                      child: Scrollbar(
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top:4,bottom: 4),
                              child: Center(
                                child: Text("Request Details", style:
                                TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                              ),

                            ),
                            ListTile(
                              title: Text("Request Date",style: TextStyle(fontWeight: FontWeight.bold),),
                              trailing: Text(product.requestDate),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Technical Considerations",style: TextStyle(fontWeight: FontWeight.bold),),
                              subtitle: Text(product.technical_consideration),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Request Status",style: TextStyle(fontWeight: FontWeight.bold),),
                              trailing: Text(product.status),
                            ),
                            Divider(),
                            product.customerObservtion!=null?Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text("Customer Observation",style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text(product.customerObservtion),
                                ),
                                Divider(),
                              ],
                            ):Container(),
                            product.designers!=null&&product.designersObservations!=null?Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text("Designers",style: TextStyle(fontWeight: FontWeight.bold),),
                                  trailing: Text(product.designers.replaceAll("[", '').replaceAll("]", '')),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text("Designers Observations",style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text(product.designersObservations),
                                ),
                                Divider(),
                              ],
                            ):Container(),
                            product.closeing_date!=null?Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text("Closing Date",style: TextStyle(fontWeight: FontWeight.bold),),
                                  trailing: Text(product.closeing_date!=null?product.closeing_date:''),
                                ),
                                Divider(),
                              ],
                            ):Container(),
                            product.trialDate!=null?Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text("Trial Date",style: TextStyle(fontWeight: FontWeight.bold),),
                                  trailing: Text(product.trialDate!=null?product.trialDate:''),
                                ),
                                Divider(),
                              ],
                            ):Container(),
                            Padding(
                              padding: EdgeInsets.only(top: 4, bottom: 4),
                            ),
                            Center(child: Text("Item Specifications",
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
                           Padding(
                             padding: EdgeInsets.only(top: 4, bottom: 4),
                           ),
                           product.modelName!=null?Column(
                             children: <Widget>[
                               ListTile(
                                 title: Text("Model Name",style: TextStyle(fontWeight: FontWeight.bold),),
                                 trailing: Text(product.modelName),
                               ),
                               Divider(),
                             ],
                           ):Container(),
                            product.modelCode!=null?Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text("Model Code",style: TextStyle(fontWeight: FontWeight.bold),),
                                  trailing: Text(product.modelCode),
                                ),
                                Divider(),
                              ],
                            ):Container(),
                           ListTile(
                              title: Text("Surface", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                              ),),
                              trailing: Text(product.surface),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Thickness", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                              ),),
                              trailing: Text(product.thickness),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Size", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                              ),),
                              trailing: Text(product.size),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Range", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                              ),),
                              trailing: Text(product.range),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Material", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                              ),),
                              trailing: Text(product.material),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Color", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                              ),),
                              trailing: Text(product.colour),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Technology", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                              ),),
                              trailing: Text(product.technology),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Structure", style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),
                              trailing: Text(product.structure),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Edge", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                              ),),
                              trailing: Text(product.edge),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Classification", style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                              trailing: Text(product.classification),
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Suitability", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                              ),),
                              subtitle: Text(product.suitibility.replaceAll("[", '').replaceAll("]", '')),
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

