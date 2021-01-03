import 'package:flutter/material.dart';
import 'package:ronaresto/models/review.dart';
import 'package:ronaresto/screens/reviewpage.dart';
import 'package:ronaresto/services/database.dart';

class ReviewPlacingPage extends StatefulWidget {

  final String restaurant_id;
  final String user_id;

  ReviewPlacingPage({Key key, @required String this.restaurant_id, String this.user_id}) : super(key: key);

  @override
  _ReviewPlacingPageState createState() => _ReviewPlacingPageState(restaurant_id, user_id);
}

class _ReviewPlacingPageState extends State {

  String restaurant_id;
  String user_id;

  final _review = Review();
  final _formKey = GlobalKey<FormState>();

  _ReviewPlacingPageState(String restaurant_id, String user_id){
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
                          TextFormField(
                            decoration:
                            InputDecoration(labelText: 'Commentaar'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Voeg alstublieft commentaar toe';
                              }
                              else return null;
                            },
                            onSaved: (val) =>
                                setState(() => _review.text = val),
                          ),
                          TextFormField(
                              decoration:
                              InputDecoration(labelText: 'sterren'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Voeg alstublieft het aantal sterren toe';
                                }
                                if (int.tryParse(value) > 5 || int.tryParse(value) < 0 ){
                                  return 'Geef alstublieft een nummer tussen 0 en 5';
                                }
                                else return null;
                              },
                              onSaved: (val) =>
                                  setState(() => _review.stars = int.tryParse(val)),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if(form.validate()){
                                form.save();
                                var info = placeReview(_review.text, _review.stars, user_id, restaurant_id);
                                info.then((resp) {
                                  // info
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (contex) => ReviewPage(reviews: resp, restaurant_id: restaurant_id, user_id: user_id)),
                                    ); // , ipv ;
                                });
                              }
                            },
                            child: Text('Plaats beoordeling'),
                          ),
                        ]
                    )
                )
            )
        )
    );
  }
}