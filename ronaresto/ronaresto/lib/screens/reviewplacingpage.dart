import 'package:flutter/material.dart';
import 'package:ronaresto/models/review.dart';
import 'package:ronaresto/services/database.dart';

class ReviewPlacingPage extends StatefulWidget {

  String restaurant_id;

  ReviewPlacingPage({Key key, @required String this.restaurant_id}) : super(key: key);

  @override
  _ReviewPlacingPageState createState() => _ReviewPlacingPageState(restaurant_id);
}

class _ReviewPlacingPageState extends State {

  String restaurant_id;

  final _review = Review();
  final _formKey = GlobalKey<FormState>();

  _ReviewPlacingPageState(String restaurant_id){
    this.restaurant_id = restaurant_id;
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
                            InputDecoration(labelText: 'comment'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a comment';
                              }
                            },
                            onSaved: (val) =>
                                setState(() => _review.text = val),
                          ),
                          TextFormField(
                              decoration:
                              InputDecoration(labelText: 'stars'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter the number of stars.';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _review.stars = int.tryParse(val)),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if(form.validate()){
                                form.save();
                                placeReview(_review.text, _review.stars, '2', restaurant_id);
                              }
                            },
                            child: Text('Place review'),
                          ),
                        ]
                    )
                )
            )
        )
    );
  }
}