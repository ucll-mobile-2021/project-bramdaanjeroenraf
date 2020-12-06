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
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            controller: tecEmail,
            validator: (value){
              if (value.isEmpty) {
                return "Fout";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Wachtwoord',
            ),
            obscureText: true,
            controller: tecPassword,
            validator: (value){
              if (value.isEmpty) {
                return "Fout";
              }
              return null;
            },
          ),
          const SizedBox(height: 60),
          ElevatedButton(
              onPressed: () {
                var info = login(tecEmail.text, tecPassword.text);
                info.then((resp) {
                  // info
                  if(resp==null){
                    print('FOUTE LOGIN');
                  }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (contex) => QrPage(user_id: resp)),
                    ); // , ipv ;
                  }
                });
              },
              child: Text('Inloggen'),
          ),
        ]
      ),
    );
  }

  /*void swapPage(bool found) {
    if (found) {
      Navigator.push(context,
        MaterialPageRoute(builder: (contex) => QrPage()),
      );
    }
    else {
      print('FOUTE LOGIN');
    }
  }*/
}


