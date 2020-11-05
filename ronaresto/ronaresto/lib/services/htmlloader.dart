import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

String _measures = '';

void loadMeasures() async {
  var url = 'https://www.info-coronavirus.be/nl/faq/#id_3';

  final response = await http.Client().get(Uri.parse(url));

  if (response.statusCode == 200) {
    var document = parse(response.body);
    var ul = document.getElementById('id_3').children[1].children;
    for (int i = 0 ; i < ul.length ; i++) {
      String parsed = ul[i].text.replaceAll('â', "\'");
      parsed = parsed.replaceAll('â', "\'");
      parsed = parsed.replaceAll('Ã©', r'é');
      if(!parsed.contains('Lees hier')) _measures += parsed + '\n\n';
    }
  }
}

String getMeasures() {
  loadMeasures();
  return _measures;
}
