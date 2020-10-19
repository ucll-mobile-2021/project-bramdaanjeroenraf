import 'package:flutter/material.dart';
import 'package:ronaresto/services/database.dart';

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
  FocusNode fn;

  @override
  void initState() {
    super. initState();

    fn = FocusNode();
  }

  @override
  void dispose() {
    fn.dispose();

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
              labelText: 'Enter your email adress',
            ),
            focusNode: fn,
            validator: (value){
              if (value.isEmpty) {
                return "Please enter your email adress";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter your password',
            ),
            obscureText: true,
            validator: (value){
              if (value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          const SizedBox(height: 60),
          ElevatedButton(
              onPressed: () {
                  if (_fk.currentState.validate()) {
                    Scaffold
                        .of(context)
                        .showSnackBar(SnackBar(content: Text('Processing Data')));
                  }
                  else {
                    fn.requestFocus();
                  }
              },
              child: Text('Inloggen'),
          ),
        ]
      ),
    );
  }

}
