import 'package:flutter/material.dart';
import 'package:ronaresto/screens/reviewplacingpage.dart';
import 'package:ronaresto/services/database.dart';

class ReviewPage extends StatelessWidget {

  final List<dynamic> reviews;
  final String restaurant_id;

  ReviewPage({Key key, @required List<dynamic> this.reviews, String this.restaurant_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(reviews[0][2]+" : "+reviews[0][1]+" stars" , style: TextStyle(fontSize: 20)),
            Text(reviews[0][0], style: TextStyle(fontSize: 14)),
            const SizedBox(height: 30),
            Text(reviews[1][2]+" : "+reviews[1][1]+" stars" , style: TextStyle(fontSize: 20)),
            Text(reviews[1][0], style: TextStyle(fontSize: 14)),
            const SizedBox(height: 30),
            Text(reviews[2][2]+" : "+reviews[2][1]+" stars" , style: TextStyle(fontSize: 20)),
            Text(reviews[2][0], style: TextStyle(fontSize: 14)),
            const SizedBox(height: 30),

            /*ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  children: <Widget>[
                    Text(reviews[index][2]+" : "+reviews[index][1]+" stars" , style: TextStyle(fontSize: 20)),
                    Text(reviews[index][0], style: TextStyle(fontSize: 12)),
                  ]
                );
              }
            ),*/

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (contex) => ReviewPlacingPage(restaurant_id: restaurant_id)),
                ); // , ipv ;
              },
              child: Text('Reviews'),
            ),

          ],
        ),
      ),
    );
  }
}
