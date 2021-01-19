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
      child = Text("Geen reservaties", style: TextStyle(fontSize: 30));
    }else{
      child = ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: reservations.length,
          itemBuilder: (BuildContext context, int index){
            return Column(
                children: <Widget>[
                  Text(reservations[index][3]+" : "+reservations[index][2]+" om "+_hourValidator(reservations[index][1]) , style: TextStyle(fontSize: 20)),
                  Text("voor: "+reservations[index][0], style: TextStyle(fontSize: 14)),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Bent u zeker?"),
                            actions: <Widget> [
                              FlatButton(
                                child: Text('Ja'),
                                onPressed: (){
                                  deleteReservation(reservations[index][4]);
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
                              ),
                              FlatButton(
                                child: Text('Nee'),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Annuleren'),
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
    return WillPopScope(
        child: Scaffold(
          body : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Reservations:'),
                Container(
                    height: 400.0,
                    child: getList()
                ),
              ],
            ),
          ),
        ),
        onWillPop: (){
          return Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QrPage(user_id: user_id)),
          );
        }
    );
  }

  String _hourValidator(String value){
    String pattern = r'^[0-9]:[0-9]{2}:$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(value)) {
      return value.substring(0,4);
    }
    return value;
  }
}