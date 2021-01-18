import 'package:flutter/material.dart';
import 'package:ronaresto/services/database.dart';
import 'package:ronaresto/screens/homepage.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: RegisterForm(),
        )
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
              validator: (value) {
                if (value.isEmpty) return "Geef alstublieft een e-mail in";
                if(_emailValidator(value)) return "geen geldige mail";
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
                  return "Geef alstublieft een wachtwoord in";
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
                  return "Bevestig alstublieft uw wachtwoord";
                }
                if(tecPass.text != value) return "De wachtwoorden moeten hetzelfde zijn";
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
                  return "Geef alstublieft een telefoonnummer in";
                }
                if(_phoneValidator(value)) return "Een telefoonnummer is een reeks van 10 cijfers";
                return null;
              },
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                if (_fk.currentState.validate() && tecPass.text == tecConPass.text) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("We verwerken uw gegevens, even geduld alstublieft"),
                      );
                    },
                  );// , ipv ;
                  var bool = findByMail(tecEmail.text);
                  bool.then((value) {
                    if(value == false){
                      register(tecName.text, tecEmail.text, tecPass.text, tecPhone.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                    else{
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Er bestaat al een account met deze mail"),
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
                  });
                }
              },
              child: Text('Registreren'),
            ),
          ]
      ),
    );
  }

  bool _emailValidator(String value){
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z]+\.[a-zA-Z]+$';
    RegExp regExp = new RegExp(pattern);
    return !regExp.hasMatch(value);
  }

  bool _phoneValidator(String value){
    String pattern = r'^[0-9]{10}$';
    RegExp regExp = new RegExp(pattern);
    return !regExp.hasMatch(value);
  }

}
