import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

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
              child: Text('Back Login', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}