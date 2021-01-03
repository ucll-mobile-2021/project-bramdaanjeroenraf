import 'package:flutter/material.dart';
import 'package:ronaresto/services/database.dart';
import 'package:ronaresto/screens/qrpage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _fk = GlobalKey<FormState>();
  final tecEmail = TextEditingController();
  final tecPassword = TextEditingController();

  @override
  void initState() {
    super. initState();
  }

  @override
  void dispose() {
    tecEmail.dispose();
    tecPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fk,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration:
            InputDecoration(labelText: 'Email'),
            validator: (value){
              if (value.isEmpty) {
                return "mag niet leeg zijn";
              }
              else return _emailValidator(value);
            },
            onSaved: (val) =>
                setState(() => tecEmail.text = val)
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration:
            InputDecoration(labelText: 'Wachtwoord'),
            obscureText: true,
            validator: (value){
              if (value.isEmpty) {
                return "mag niet leeg zijn";
              }else return null;
            },
            onSaved: (val) =>
                setState(() => tecPassword.text = val)
          ),
          const SizedBox(height: 60),
          ElevatedButton(
              onPressed: () {
                final form = _fk.currentState;
                if(form.validate()) {
                  form.save();
                  var info = login(tecEmail.text, tecPassword.text);
                  info.then((resp) {
                    // info
                    if(resp==null){
                      print('FOUTE LOGIN');
                      /*final error = SnackBar(
                        content: Text('incorrect '),
                      );
                      Scaffold.of(context).showSnackBar(error);*/
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Incorrect login"),
                            actions: <Widget> [
                              FlatButton(
                                child: Text('ok'),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QrPage(user_id: resp)),
                      ); // , ipv ;
                    }
                  });
                }
              },
              child: Text('Inloggen'),
          ),
        ]
      ),
    );
  }

  String _emailValidator(String value){
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z]+\.[a-zA-Z]+$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'geen geldige mail';
    }
    return null;
  }
}


