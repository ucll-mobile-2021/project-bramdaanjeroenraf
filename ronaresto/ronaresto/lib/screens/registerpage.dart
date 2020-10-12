import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonTheme(
            minWidth: 200.0,
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back Register', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}