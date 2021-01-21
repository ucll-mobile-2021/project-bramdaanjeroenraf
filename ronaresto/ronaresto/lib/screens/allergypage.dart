import 'package:flutter/material.dart';
import 'package:ronaresto/screens/allergypage.dart';
import 'package:ronaresto/services/database.dart';

class AllergyPage extends StatelessWidget {

  final List<dynamic> dish;
  final String restaurant_id;
  final String user_id;

  AllergyPage({Key key, @required List<dynamic> this.dish, String this.restaurant_id, String this.user_id}) : super(key: key);

  Widget getList(){ // allergies
    Widget child;
    if(dish[4].length == 0){
      child = Text("Geen allergenen", style: TextStyle(fontSize: 16));
    }else{
      child = ListView.builder(
          itemCount: dish[4].length,
          itemBuilder: (BuildContext context, int index){
            return Column(
                children: <Widget>[
                  Text(dish[4][index][0] , style: TextStyle(fontSize: 24)),
                  Text(dish[4][index][1], style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
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
              child: Column(
                children: [
                  Text(dish[1], style: TextStyle(fontSize: 30)),
                  Text('Prijs: '+dish[2]+' euro', style: TextStyle(fontSize: 16)),
                  Text(dish[3], style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
                  Container(width: 0.0, height: 20.0),
                  Text('Allergieen:', style: TextStyle(fontSize: 16)),
                  Container(
                      height: 200,
                      child: getList()
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(width: 0.0, height: 0.0),
            ),
          ],
        ),



        ],



      ),

    ),
    );
  }
}
