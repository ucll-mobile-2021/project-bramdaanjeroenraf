import 'package:flutter/material.dart';
import 'package:ronaresto/services/htmlloader.dart';

class MaatregelenPage extends StatelessWidget {
  MaatregelenPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Maatreggelen')),
      body : Center(
        child:
        SingleChildScrollView(
          child:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //SingleChildScrollView(),
              const SizedBox(height: 30),
              Row(
                children:<Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(width: 0.0, height: 0.0),
                  ),
                  Expanded(
                    flex: 6,
                    child:
                    Text(getMeasures(), style: TextStyle(fontSize: 16)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(width: 0.0, height: 0.0),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ButtonTheme(
                minWidth: 200.0,
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Hoofdmenu', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
