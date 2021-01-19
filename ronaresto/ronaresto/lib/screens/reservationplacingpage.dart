import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:ronaresto/models/reservation.dart';
import 'package:ronaresto/services/database.dart';
import 'package:ronaresto/screens/qrrespage.dart';
import 'package:intl/intl.dart';

class ReservationPlacingPage extends StatefulWidget {

  final String restaurant_id;
  final String user_id;

  final String restaurant_name;
  final int restaurant_tafel;
  final String restaurant_location;
  final int restaurant_capacity;

  ReservationPlacingPage({Key key, @required String this.restaurant_id, String this.user_id, int this.restaurant_tafel, String this.restaurant_location, String this.restaurant_name, int this.restaurant_capacity}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState(restaurant_id, user_id, restaurant_name, restaurant_tafel, restaurant_location, restaurant_capacity);
}

class _ReservationPageState extends State {

  String restaurant_id;
  String user_id;

  String restaurant_name;
  int restaurant_tafel;
  String restaurant_location;
  int restaurant_capacity;

  DateTime selectedDate;

  Widget timeslots = Text("loading...");

  final _reservation = Reservation();
  final _formKey = GlobalKey<FormState>();

  _ReservationPageState(String restaurant_id, String user_id, String restaurant_name, int restaurant_tafel, String restaurant_location, int restaurant_capacity){
    this.restaurant_id = restaurant_id;
    this.user_id = user_id;

    this.restaurant_name = restaurant_name;
    this.restaurant_tafel = restaurant_tafel;
    this.restaurant_location = restaurant_location;
    this.restaurant_capacity = restaurant_capacity;
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
                          const SizedBox(height: 30),
                          if(selectedDate != null)
                            Text("Gekozen datum: " + _reservation.date),
                          if(selectedDate != null)
                            ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  selectedDate = null;
                                  _reservation.date = null;
                                  _reservation.number = null;
                                  _reservation.timeslot = null;
                                });
                              },
                              child: Text("Wijzig de datum"),
                            ),
                          if(selectedDate == null)
                            ElevatedButton(
                              onPressed: () => _selectDate(context),
                              child: Text("Kies een datum"),
                            ),

                          if(_reservation.number != null)
                            Text("Gekozen aantal: " + _reservation.number.toString()),
                          if(_reservation.number != null)
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _reservation.number = null;
                                  _reservation.timeslot = null;
                                });
                              },
                              child: Text("Wijzig het aantal personen"),
                            ),
                          if(selectedDate != null && _reservation.number == null)
                            TextFormField(
                              decoration:
                              InputDecoration(labelText: 'aantal personen'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Geef alstublieft een aantal personen in.';
                                }
                                if (int.tryParse(value) > restaurant_capacity || int.tryParse(value) < 1 ){
                                  return 'Geef alstublieft een nummer tussen 1 en '+restaurant_capacity.toString();
                                }
                                else return null;
                              },
                              onSaved: (val) =>
                                  setState(() => _reservation.number= int.tryParse(val)),
                            ),
                          if(selectedDate != null && _reservation.number ==null)
                            ElevatedButton(
                              onPressed: () async {
                                final form = _formKey.currentState;
                                if(form.validate()){
                                  form.save();
                                  _getAvailableHours();
                                }
                              },
                              child: Text("bevestig het aantal"),
                            ),

                          if(_reservation.number != null)
                            Container(
                              height: 50.0,
                              child: timeslots,
                            ),
                          if(_reservation.timeslot != null)
                            Text("gekozen tijdstip: " + _reservation.timeslot),
                          if(_reservation.timeslot != null)
                            ElevatedButton(
                              onPressed: () {

                                var currentReservations = checkReservations(user_id, restaurant_id, _reservation.date);
                                currentReservations.then((resp){
                                  if(resp[0] == null){
                                    createReservation(_reservation.number, _reservation.timeslot+":00", _reservation.date, user_id, restaurant_id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (contex) => QrResPage(user_id: user_id, restaurant_name: restaurant_name, restaurant_tafel: restaurant_tafel, restaurant_id: restaurant_id, restaurant_location: restaurant_location, restaurant_capacity: restaurant_capacity,)),
                                    );
                                  }
                                  else{
                                    print(resp);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("U hebt die dag reeds een reservatie, wilt u deze nieuwe toch toevoegen?"),
                                          content: ListView.builder(
                                            itemCount: resp.length,
                                              itemBuilder: (BuildContext context, int index){
                                                return Text('Om ' + _hourValidator(resp[index][1]) + ' met ' + resp[index][0]);
                                              }
                                          ),
                                          actions: <Widget> [
                                            FlatButton(
                                              child: Text('Ja'),
                                              onPressed: (){
                                                createReservation(_reservation.number, _reservation.timeslot+":00", _reservation.date, user_id, restaurant_id);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (contex) => QrResPage(user_id: user_id, restaurant_name: restaurant_name, restaurant_tafel: restaurant_tafel, restaurant_id: restaurant_id, restaurant_location: restaurant_location, restaurant_capacity: restaurant_capacity,)),
                                                ); // , ipv ;
                                              },
                                            ),
                                            FlatButton(
                                              child: Text('Nee'),
                                              onPressed: (){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (contex) => QrResPage(user_id: user_id, restaurant_name: restaurant_name, restaurant_tafel: restaurant_tafel, restaurant_id: restaurant_id, restaurant_location: restaurant_location, restaurant_capacity: restaurant_capacity,)),
                                                ); // , ipv ;
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                });
                              },
                              child: Text('Plaats reservatie'),
                            ),
                        ]
                    )
                )
            )
        )
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)), // Refer step 1
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime(DateTime.now().year+5),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _reservation.date = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  Future<Widget> _getAvailableHours() async {
    List<bool> hours = new List(48);
    for(int i=0;i<48;i++){
      hours[i] = true;
    }

    var info = reservationTimeslots(restaurant_id, DateFormat('yyyy-MM-dd').format(selectedDate));
    await info.then((resp){
        for(int i =0;i<48;i++){
          if(resp[i]<_reservation.number) hours[i] = false;
        }
    });

    List<String> times = new List();

    for(int i=0;i<48;i++){
      String string;
      if(i/2 < 10) string = "0"+(i~/2).toString();
      else string = (i~/2).toString();
      if(i%2 == 1) string += ":30";
      else string += ":00";
      if(hours[i]) times.add(string);
    }

    setState(() {
      timeslots = ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: times.length,
          itemBuilder: (BuildContext context, int index){
            return Column(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child:
                    RichText(
                      text: new TextSpan(
                        text: times[index],
                        style: new TextStyle(color: Colors.blue, fontSize: 30),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () async {
                            setState(() {
                              _reservation.timeslot = times[index];
                            });
                          },
                      ),
                    ),
                  )
                ]
            );
          }
      );
    });
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




