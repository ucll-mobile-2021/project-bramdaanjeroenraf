import 'package:flutter/material.dart';
import 'package:ronaresto/screens/reviewplacingpage.dart';
import 'package:ronaresto/services/database.dart';

class ReviewPage extends StatelessWidget {

  final String text;
  final String stars;
  final String user;
  final String restaurant_id;

  ReviewPage({Key key, @required String this.text, String this.stars, String this.user, String this.restaurant_id}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(text, style: TextStyle(fontSize: 20)),
            Text(stars, style: TextStyle(fontSize: 20)),
            Text(user, style: TextStyle(fontSize: 20)),

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
