import 'package:flutter/material.dart';
import 'package:ronaresto/screens/reviewplacingpage.dart';
import 'package:ronaresto/services/database.dart';

class ReviewPage extends StatelessWidget {

  final List<dynamic> reviews;
  final String restaurant_id;
  final String user_id;

  ReviewPage({Key key, @required List<dynamic> this.reviews, String this.restaurant_id, String this.user_id}) : super(key: key);

  Widget getList(){
    Widget child;
    if(reviews.length == 0){
      child = Text("no reviews", style: TextStyle(fontSize: 30));
    }else{
      child = ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (BuildContext context, int index){
            return Column(
                children: <Widget>[
                  Text(reviews[index][2]+" : "+reviews[index][1]+" stars" , style: TextStyle(fontSize: 20)),
                  Text(reviews[index][0], style: TextStyle(fontSize: 12)),
                ]
            );
          }
      );
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 200.0,
              child: getList()
            ),

            if(user_id!=null)
            ElevatedButton(
              onPressed: () {
                if(user_id!=null){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (contex) => ReviewPlacingPage(restaurant_id: restaurant_id, user_id: user_id)),
                  ); // , ipv ;
                }
              },
              child: Text('add review'),
            ),

          ],
        ),
      ),
    );
  }
}
