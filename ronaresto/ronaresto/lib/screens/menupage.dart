import 'package:flutter/material.dart';
import 'package:ronaresto/screens/allergypage.dart';
import 'package:ronaresto/services/database.dart';

class MenuPage extends StatelessWidget {

  final List<dynamic> dishes;
  final String restaurant_id;
  final int restaurant_tafel;
  final String user_id;

  MenuPage({Key key, @required List<dynamic> this.dishes, String this.restaurant_id, int this.restaurant_tafel, String this.user_id}) : super(key: key);

  Widget getList(){
    Widget child;
    if(dishes.length == 0){
      child = Text("Geen gerechten teruggevonden", style: TextStyle(fontSize: 30), textAlign: TextAlign.center,);
    }else{
      child = ListView.builder(
          itemCount: dishes.length,
          itemBuilder: (BuildContext context, int index){
            return Column(
                children: <Widget>[
                  Text(dishes[index][1] , style: TextStyle(fontSize: 20)),
                  ElevatedButton(
                    onPressed: () {
                      if(dishes[index][0] != null){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (contex) => AllergyPage(dish: dishes[index], restaurant_id: restaurant_id, user_id: user_id)),
                        ); // , ipv ;
                      }
                    },
                    child: Text('info'),
                  ),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Menu:'),

                Container(
                    height: 360.0,
                    child: getList()
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }
  
}
