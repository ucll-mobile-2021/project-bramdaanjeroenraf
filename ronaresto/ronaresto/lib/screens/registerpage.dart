import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget{
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
                labelText: 'E-mail adres',
              ),
              focusNode: fn,
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
                labelText: 'Wachtwoord bevestigen',
              ),
              obscureText: true,
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
                labelText: 'Tel.',
              ),
              obscureText: true,
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
                if (_fk.currentState.validate()) {
                  Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
                else {
                  fn.requestFocus();
                }
              },
              child: Text('Registreren'),
            ),
          ]
      ),
    );
  }
}
