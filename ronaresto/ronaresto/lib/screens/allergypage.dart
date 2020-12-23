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
      child = Text("no allergy", style: TextStyle(fontSize: 16));
    }else{
      child = ListView.builder(
          itemCount: dish[4].length,
          itemBuilder: (BuildContext context, int index){
            return Column(
                children: <Widget>[
                  Text(dish[4][index][0] , style: TextStyle(fontSize: 16)),
                  Text(dish[4][index][1], style: TextStyle(fontSize: 12)),
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

            Text(dish[1], style: TextStyle(fontSize: 24)),
            Text('prijs: '+dish[2]+'euro', style: TextStyle(fontSize: 20)),
            Text('beschrijving:', style: TextStyle(fontSize: 20)),
            Text(dish[3], style: TextStyle(fontSize: 16)),
            Text('allergieën:', style: TextStyle(fontSize: 20)),
            Container(
                height: 200.0,
                child: getList()
            ),


          ],
        ),

      ),
    );
  }
}
