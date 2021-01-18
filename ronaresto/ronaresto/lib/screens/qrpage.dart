import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:ronaresto/screens/qrrespage.dart';
import 'package:ronaresto/screens/searchrestaurantpage.dart';
import 'package:ronaresto/screens/reservationpage.dart';
import 'package:ronaresto/services/database.dart';
import 'package:ronaresto/screens/homepage.dart';

class QrPage extends StatelessWidget {
  final String user_id;

  QrPage({Key key, @required String this.user_id}) : super(key: key);

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
                  final scanResult = _scanQr();
                  scanResult.then((resp) {
                    String name = resp.split(";").first;
                    int tafel = 0;
                    if( resp.split(";").length == 2){
                      tafel = int.parse( resp.split(";").last );
                    }
                    var info = findRestaurant(name);
                    info.then((resp2) {
                    // info
                      createVisit(int.parse(resp2[0]));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QrResPage(user_id: user_id, restaurant_name: name, restaurant_tafel: tafel, restaurant_id: resp2[0], restaurant_location: resp2[2])),
                      ); // , ipv ;

                    });
                  });
                },

                child: Text('Scan QR code', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 30),
            ButtonTheme(
              minWidth: 200.0,
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchRestaurantPage(user_id: user_id)),
                  ); // , ipv ;
                },
                child: Text('Zoek restaurant', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 30),
            ButtonTheme(
              minWidth: 200.0,
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {
                  var info = getReservations(user_id);
                  info.then((resp){
                    if(resp==null){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReservationPage(reservations: [],user_id: user_id)),
                      );
                    }
                    else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReservationPage(reservations: resp,user_id: user_id)),
                      );
                    }
                  });// , ipv ;
                },
                child: Text('Bekijk reservaties', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 30),
            ButtonTheme(
              minWidth: 200.0,
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text('Hoofdmenu', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
