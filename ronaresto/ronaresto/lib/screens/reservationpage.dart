import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ronaresto/models/reservation.dart';
import 'package:ronaresto/services/database.dart';
import 'package:intl/intl.dart';

class ReservationPage extends StatefulWidget {

  final String restaurant_id;
  final String user_id;

  ReservationPage({Key key, @required String this.restaurant_id, String this.user_id}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState(restaurant_id, user_id);
}

class _ReservationPageState extends State {

  String restaurant_id;
  String user_id;

  DateTime selectedDate;

  Widget timeslots = Text("no hours");

  final _reservation = Reservation();
  final _formKey = GlobalKey<FormState>();

  _ReservationPageState(String restaurant_id, String user_id){
    this.restaurant_id = restaurant_id;
    this.user_id = user_id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if(selectedDate != null)
                          Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
                          ElevatedButton(
                            onPressed: () => _selectDate(context),
                            child: Text("choose date"),
                          ),
                          TextFormField(
                            decoration:
                            InputDecoration(labelText: 'number of people'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the number of people.';
                              }
                              if (int.tryParse(value) > 10 || int.tryParse(value) < 0 ){
                                return 'Please enter a number between 0 and 10.';
                              }
                              else return null;
                            },
                            onSaved: (val) =>
                                setState(() => _reservation.number= int.tryParse(val)),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final form = _formKey.currentState;
                              if(form.validate()){
                                form.save();
                                timeslots = await _getAvailableHours();
                              }
                            },
                            child: Text("test"),
                          ),
                          /*ElevatedButton(
                            onPressed: (){
                              print(hours);
                              timeslots = _getTimeslots();
                            },
                            child: Text("choose a time")
                          ),*/
                          Container(
                              height: 200.0,
                              child: timeslots,
                          ),
                          /*ElevatedButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if(form.validate()){
                                form.save();
                                var info = placeReservation(_review.text, _review.stars, user_id, restaurant_id);
                                info.then((resp) {
                                  // info
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (contex) => ReviewPage(reviews: resp, restaurant_id: restaurant_id, user_id: user_id)),
                                  ); // , ipv ;
                                });
                              }
                            },
                            child: Text('Place review'),
                          ),*/
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

    Widget child = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: times.length,
        itemBuilder: (BuildContext context, int index){
          return Column(
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Text(times[index] , style: TextStyle(fontSize: 20)),
                )
              ]
          );
        }
    );
    return child;
  }
}




