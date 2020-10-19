import 'package:mysql1/mysql1.dart';

var settings = new ConnectionSettings(
    host: 'remotemysql.com',
    port: 3306,
    user: 'ZdZsbXqf4M',
    password: 'Rf1I4vFY8P',
    db: 'ZdZsbXqf4M');

dynamic connect() async {
  var conn = await MySqlConnection.connect(settings);
  var results =  await conn.query('SELECT * FROM users');
  for (var row in results) {
    print('Name: ${row[0]}, email: ${row[1]}');
  }
  conn.close();
}
