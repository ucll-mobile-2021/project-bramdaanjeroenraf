import 'package:flutter/material.dart';
import 'screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Welcome tot Rona Resto';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rona Resto',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: HomePage(),
      ),
    );
  }
}