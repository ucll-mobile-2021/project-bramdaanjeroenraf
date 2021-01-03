import 'package:flutter/material.dart';
import 'package:ronaresto/services/database.dart';
import 'package:ronaresto/screens/reviewpage.dart';
import 'package:ronaresto/screens/menupage.dart';
import 'package:ronaresto/screens/reservationplacingpage.dart';

class QrResPage extends StatelessWidget {

  final String user_id;
  final String restaurant_name;
  final int restaurant_tafel;
  final String restaurant_id;
  final String restaurant_location;

  QrResPage({Key key, @required String this.user_id,String this.restaurant_name, int this.restaurant_tafel, String this.restaurant_id, String this.restaurant_location}) : super(key: key);


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
            Text(restaurant_name, style: TextStyle(fontSize: 30)),
            Text(restaurant_location, style: TextStyle(fontSize: 12)),
            Text('ID: '+restaurant_id, style: TextStyle(fontSize: 20)),
            Text('tafel nr: '+restaurant_tafel.toString(), style: TextStyle(fontSize: 20)),

            ElevatedButton(
              onPressed: () {
                var info = reviews(restaurant_id);
                info.then((resp) {
                  // info
                  if(resp==null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReviewPage(reviews: [], restaurant_id: restaurant_id, user_id: user_id,)),
                    );
                  }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReviewPage(reviews: resp, restaurant_id: restaurant_id, user_id: user_id,)),
                    ); // , ipv ;
                  }
                });
              },
              child: Text('Beoordelingen'),
            ),
            ElevatedButton(
              onPressed: () {
                var info = dishes(restaurant_id);
                info.then((resp) {
                  // info
                  if(resp==null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuPage(dishes: [], restaurant_id: restaurant_id, restaurant_tafel: restaurant_tafel, user_id: user_id,)),
                    );
                  }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuPage(dishes: resp, restaurant_id: restaurant_id, restaurant_tafel: restaurant_tafel, user_id: user_id,)),
                    ); // , ipv ;
                  }
                });
              },
              child: Text('Menu'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (contex) => ReservationPage(restaurant_id: restaurant_id, user_id: user_id,)),
                );
              },
              child: Text('Maak een reservatie'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createAlert(int.parse(restaurant_id), restaurant_tafel);
          },
        child: Icon(Icons.hail),
      ),
    );
  }
}
