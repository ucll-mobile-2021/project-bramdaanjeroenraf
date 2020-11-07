import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:ronaresto/screens/qrrespage.dart';

class QrPage extends StatelessWidget {
  QrPage({Key key}) : super(key: key);

  Future<String> _scanQr() async{
    print('scanner actief 3');
    try{
      var resultaat = await BarcodeScanner.scan();
      return resultaat.rawContent;
    } on PlatformException catch(ex){
      print('Oops, iets ging mis :\'(');
    } on FormatException catch(ex){
      print('Je bent uit de scanner gegaan zonder te scannen.');
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
                onPressed: () {
                  final scanResult = _scanQr();
                  scanResult.then((resp) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (contex) => QrResPage(result: resp)),
                    );
                  });
                },

                child: Text('Scan QR code', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
