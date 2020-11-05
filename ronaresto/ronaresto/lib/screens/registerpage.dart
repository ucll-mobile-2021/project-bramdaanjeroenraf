import 'package:flutter/material.dart';
import 'package:ronaresto/services/database.dart';

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
  final tecName = TextEditingController();
  final tecEmail = TextEditingController();
  final tecPass = TextEditingController();
  final tecConPass = TextEditingController();
  final tecPhone = TextEditingController();

  @override
  void initState() {
    super. initState();
  }

  @override
  void dispose() {
    tecName.dispose();
    tecEmail.dispose();
    tecPass.dispose();
    tecConPass.dispose();
    tecPhone.dispose();

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
                labelText: 'Volledige naam',
              ),
              controller: tecName,
              validator: (value){
                if (value.isEmpty) {
                  return "Fout";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'E-mail adres',
              ),
              controller: tecEmail,
              validator: (value){
                if (value.isEmpty) {
                  return "Fout";
                }
                else if (findByMail(tecEmail.text) != null){
                  return "Email is reed geregistreerd";
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
              controller: tecPass,
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
              controller: tecConPass,
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
              controller: tecPhone,
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
                if (_fk.currentState.validate() && tecPass.text == tecConPass.text) {
                  register(tecName.text, tecEmail.text, tecPass.text, tecPhone.text);
                  Navigator.pop(context);
                }
                else {
                }
              },
              child: Text('Registreren'),
            ),
          ]
      ),
    );
  }
}
