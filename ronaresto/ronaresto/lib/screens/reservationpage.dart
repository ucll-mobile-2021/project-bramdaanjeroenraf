import 'package:flutter/material.dart';
import 'package:ronaresto/services/database.dart';
import 'package:ronaresto/screens/qrpage.dart';

class ReservationPage extends StatelessWidget {

  final List<dynamic> reservations;
  final String user_id;

  ReservationPage({Key key, @required List<dynamic> this.reservations, String this.user_id}) : super(key: key);

  Widget getList(){
    Widget child;
    if(reservations.length == 0){
      child = Text("no reservations", style: TextStyle(fontSize: 30));
    }else{
      child = ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: reservations.length,
          itemBuilder: (BuildContext context, int index){
            return Column(
                children: <Widget>[
                  Text(reservations[index][3]+" : "+reservations[index][2]+" on "+reservations[index][1] , style: TextStyle(fontSize: 20)),
                  Text("for: "+reservations[index][0], style: TextStyle(fontSize: 14)),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Are you sure?"),
                            actions: <Widget> [
                              FlatButton(
                                child: Text('yes'),
                                onPressed: (){
                                  deleteReservation(reservations[index][4]);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => QrPage(user_id: user_id)),
                                  ); // , ipv ;
                                },
                              ),
                              FlatButton(
                                child: Text('no'),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Cancel'),
                  ),
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
                height: 400.0,
                child: getList()
            ),
          ],
        ),
      ),
    );
  }


}