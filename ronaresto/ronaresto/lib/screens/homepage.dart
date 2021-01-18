import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ronaresto/services/htmlloader.dart';
import 'maatregelenpage.dart';
import 'loginpage.dart';
import 'registerpage.dart';
import 'visitformpage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Bent u zeker dat u de applicatie wilt verlaten?"),
                actions: <Widget> [
                  FlatButton(
                    child: Text('Ja'),
                    onPressed: (){
                      Navigator.pop(context,true); // , ipv ;
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
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 200.0,
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (contex) => MaatregelenPage()),
                      );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (contex) => LoginPage()),
                      );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (contex) => RegisterPage()),
                      );
                    },
                    child: const Text('Registreren', style: TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(height: 30),
                RichText(
                  text: new TextSpan(
                    text: 'Inloggen als gast',
                    style: new TextStyle(color: Colors.blue),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VisitFormPage()),
                        );
                      },
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

}
