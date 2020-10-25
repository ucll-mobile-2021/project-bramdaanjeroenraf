import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ronaresto/screens/homepage.dart';
import 'package:ronaresto/services/htmlloader.dart';
import 'package:barcode_scan/barcode_scan.dart';

class QrPage extends StatelessWidget {
  QrPage({Key key}) : super(key: key);

  Future _scanQr() async{
    print('scanner actief 3');
    try{
      var resultaat = await BarcodeScanner.scan();
      var res = await resultaat.rawContent;
      print('scan resultaat: $res' );
    } on PlatformException catch(ex){
      print('Oops, iets ging mis :\'(');
    } on FormatException catch(ex){
      print('je bent uit de scanner gegaan zonder te scannen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Row(
              children:<Widget>[
                Expanded(
                  flex: 2,
                  child: Container(width: 0.0, height: 0.0),
                ),
                Expanded(
                  flex: 6,
                  child:
                  Text('Resto pagina:', style: TextStyle(fontSize: 16)),
                ),
                Expanded(
                  flex: 2,
                  child: Container(width: 0.0, height: 0.0),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ButtonTheme(
              minWidth: 200.0,
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Hoofdmenu', style: TextStyle(fontSize: 20)),
              ),
            ),
            ButtonTheme(
              minWidth: 200.0,
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: _scanQr,
                child: Text('SCAN ME PLZZZ', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
