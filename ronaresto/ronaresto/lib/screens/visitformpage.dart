import 'package:flutter/material.dart';
import 'package:ronaresto/screens/qrpage.dart';
import 'package:ronaresto/services/database.dart' as db;

class VisitFormPage extends StatelessWidget {

  VisitFormPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: VisitForm(),
        ),
      ),
    );
  }
}

class VisitForm extends StatefulWidget{
  
  @override
  _VisitFormState createState() => _VisitFormState();
}

class _VisitFormState extends State<VisitForm> {
  final _fk = GlobalKey<FormState>();
  final tecName = TextEditingController();
  final tecEmail = TextEditingController();
  final tecPhone = TextEditingController();

  @override
  void initState() {
    super. initState();
  }

  @override
  void dispose() {
    tecName.dispose();
    tecEmail.dispose();
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
                  return "Geef alstublieft een naam in";
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
                  return "Geef alstublieft een emailadres in";
                }
                else return _emailValidator(value);
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
                  return "Geef alstublieft een telefoonnummer in";
                }
                return _phoneValidator(value);
              },
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                final form = _fk.currentState;
                if(form.validate()) {
                  db.loginGuest(tecEmail.text, tecPhone.text, tecName.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QrPage())
                  );
                }
              },
              child: Text('Doorgaan'),
            ),
          ]
      ),
    );
  }

  String _emailValidator(String value){
    String pattern = r'^[a-zA-Z0-9.-]+@[a-zA-Z]+\.[a-zA-Z]+$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Geen geldige mail';
    }
    return null;
  }

  String _phoneValidator(String value){
    String pattern = r'^[0-9]{10}$';
    RegExp regExp = new RegExp(pattern);
    if(!regExp.hasMatch(value)){
      return 'Een telefoonnummer is een reeks van 10 cijfers';
    }
    return null;
  }
}
