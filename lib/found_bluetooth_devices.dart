import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:flutter/material.dart';
class foundBluetoothDevices extends StatefulWidget {
  var image;

  foundBluetoothDevices(this.image);

  @override
  _foundBluetoothDevicesState createState() => _foundBluetoothDevicesState(image);
}

class _foundBluetoothDevicesState extends State<foundBluetoothDevices> {
  PrinterBluetoothManager printerManager;
  List<PrinterBluetooth> _devices = [];
  bool isVisible=false;
  var image;
  _foundBluetoothDevicesState(this.image);

  @override
  void initState() {
    printerManager = PrinterBluetoothManager();
    printerManager.startScan(Duration(seconds: 4));
    printerManager.scanResults.listen((scannedDevices) {
      setState(() {
          _devices = scannedDevices;
          print("scaned Devices "+scannedDevices.toString());
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Found Bluetooth Devices"),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListView.builder(itemCount:_devices.length,itemBuilder: (context,index){
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(_devices[index].name),
                  subtitle: Text(_devices[index].address),
                  onTap: (){
                    printerManager.selectPrinter(_devices[index]);
                    Ticket ticket=Ticket(PaperSize.mm58);
                    ticket.image(image);
                    ticket.feed(1);
                    ticket.cut();
                  },
                ),
                Divider(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
