import 'package:mysql1/mysql1.dart';
import 'package:password/password.dart';

var settings = new ConnectionSettings(
    host: 'remotemysql.com',
    port: 3306,
    user: 'ZdZsbXqf4M',
    password: 'Rf1I4vFY8P',
    db: 'ZdZsbXqf4M');

int user_id;

dynamic connect() async {
  var conn = await MySqlConnection.connect(settings);
  var results =  await conn.query('SELECT * FROM users');
  for (var row in results) {
    print('Name: ${row[0]}, email: ${row[1]}');
  }
  conn.close();
}

dynamic login(String email, String password)  async {
  var conn = await MySqlConnection.connect(settings);
  String passwordHash = Password.hash(password, PBKDF2());
  var results =  await conn.query('SELECT * FROM users WHERE email = ? AND wachtwoord = ?', [email, passwordHash]);
  if (results.length == 1) {
    for (var row in results) {
      user_id = row[0];
    }
    print(user_id);
  }
  conn.close();
}

dynamic register(String email, String password, String phone) async {
  String passwordHash = Password.hash(password, PBKDF2());
  var conn = await MySqlConnection.connect(settings);
  var results =  await conn.query('INSERT INTO users (email, wachtwoord, telefoonnummer) VALUES (?, ?, ?)', [email, passwordHash, phone]);
  conn.close();
}
