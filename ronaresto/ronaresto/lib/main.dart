import 'package:flutter/material.dart';
import 'screens/homepage.dart';
import 'package:ronaresto/services/database.dart';

void main() {
  connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Welcome to Rona Resto';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rona Resto',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: HomePage(),
      ),
    );
  }
}
