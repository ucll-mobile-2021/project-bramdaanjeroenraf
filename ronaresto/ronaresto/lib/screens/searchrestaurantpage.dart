import 'package:flutter/material.dart';
import 'package:ronaresto/models/search.dart';
import 'package:ronaresto/screens/qrrespage.dart';
import 'package:ronaresto/services/database.dart';

class SearchRestaurantPage extends StatefulWidget {

  final String user_id;

  SearchRestaurantPage({Key key, String this.user_id}) : super(key: key);

  @override
  _SearchRestaurantPageState createState() => _SearchRestaurantPageState(user_id);
}

class _SearchRestaurantPageState extends State {

  String user_id;

  final _search = Search();
  final _formKey = GlobalKey<FormState>();

  _SearchRestaurantPageState(String user_id){
    this.user_id = user_id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration:
                            InputDecoration(labelText: 'Naam'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Geef alstublieft een naam in';
                              }
                              else return null;
                            },
                            onSaved: (val) =>
                                setState(() => _search.name = val),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if(form.validate()){
                                form.save();
                                var info = findRestaurant(_search.name);
                                info.then((resp) {
                                  // info
                                  if(resp[0] == null){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Restaurant niet teruggevonden"),
                                          actions: <Widget> [
                                            FlatButton(
                                              child: Text('Ok'),
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  else{
                                    //createVisit(int.parse(resp[0]));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (contex) => QrResPage(user_id: user_id, restaurant_name: resp[1], restaurant_tafel: 0, restaurant_id: resp[0], restaurant_location: resp[2], restaurant_capacity: int.tryParse(resp[3]),)),
                                    ); // , ipv ;
                                  }
                                });
                              }
                            },
                            child: Text('Zoek'),
                          ),
                        ]
                    )
                )
            )
        )
    );
  }
}