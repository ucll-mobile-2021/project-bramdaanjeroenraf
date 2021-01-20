import 'package:flutter/material.dart';
import 'package:ronaresto/screens/reviewplacingpage.dart';
import 'package:ronaresto/services/database.dart';
import 'package:ronaresto/screens/qrrespage.dart';

class ReviewPage extends StatelessWidget {

  final List<dynamic> reviews;
  final String restaurant_id;
  final String user_id;

  final String restaurant_name;
  final int restaurant_tafel;
  final String restaurant_location;
  final int restaurant_capacity;

  ReviewPage({Key key, @required List<dynamic> this.reviews, String this.restaurant_id, String this.user_id, int this.restaurant_tafel, String this.restaurant_location, String this.restaurant_name, int this.restaurant_capacity}) : super(key: key);

  Widget getList(){
    Widget child;
    if(reviews.length == 0){
      child = Text("Geen beoordelingen", style: TextStyle(fontSize: 30));
    }else{
      child = ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (BuildContext context, int index){
            return Column(
                children: <Widget>[
                  Text(reviews[index][2]+" : "+reviews[index][1]+" sterren" , style: TextStyle(fontSize: 20)),
                  Text(reviews[index][0], style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 10),
                ]
            );
          }
      );
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Beoordelingen:'),
                Container(
                    height: 400.0,
                    child: getList()
                ),

                if(user_id!=null)
                  ElevatedButton(
                    onPressed: () {
                      if(user_id!=null){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (contex) => ReviewPlacingPage(restaurant_id: restaurant_id, user_id: user_id, restaurant_tafel: restaurant_tafel, restaurant_location: restaurant_location, restaurant_name: restaurant_name,restaurant_capacity: restaurant_capacity,)),
                        ); // , ipv ;
                      }
                    },
                    child: Text('Voeg beoordeling toe'),
                  ),

              ],
            ),
          ),
        ),
        onWillPop: (){
          return Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QrResPage(user_id: user_id, restaurant_name: restaurant_name, restaurant_tafel: restaurant_tafel, restaurant_id: restaurant_id, restaurant_location: restaurant_location, restaurant_capacity: restaurant_capacity,)),
          );

        },
      );
    }
}
