import 'package:flutter/material.dart';
import 'maatregelenpage.dart';
import 'loginpage.dart';
import 'registerpage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

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
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => MaatregelenPage()));
              },
              child: Text('Maatregelen', style: TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(height: 30),
          ButtonTheme(
            minWidth: 200.0,
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => LoginPage()));
              },
              child: Text('Inloggen', style: TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(height: 30),
          ButtonTheme(
            minWidth: 200.0,
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => RegisterPage()));
              },
              child: const Text('Registreren', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}