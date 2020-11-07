import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QrResPage extends StatelessWidget {
  final String result;
  QrResPage({Key key, @required String this.result}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                  Text('Resto pagina:', style: TextStyle(fontSize: 16)),
                ),
                Expanded(
                  flex: 2,
                  child: Container(width: 0.0, height: 0.0),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(result.split(";").first, style: TextStyle(fontSize: 30)),
            Text('tafel: '+result.split(";").last, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
