import 'package:mysql1/mysql1.dart';
import 'package:password/password.dart';

var settings = new ConnectionSettings(
    host: 'remotemysql.com',
    port: 3306,
    user: 'ZdZsbXqf4M',
    password: 'Rf1I4vFY8P',
    db: 'ZdZsbXqf4M');

int userId;
bool isMailFound =  false;

void login(String email, String password)  async {
  var conn = await MySqlConnection.connect(settings);
  String passwordHash = Password.hash(password, PBKDF2());
  Results results =  await conn.query('SELECT * FROM User WHERE email = ? AND password = ?', [email, passwordHash]);
  if (results.length == 1) {
    for (var row in results) {
      userId = row[0];
    }
    print(userId);
  }
  conn.close();
}

void register(String name, String email, String password, String phone) async {
  String passwordHash = Password.hash(password, PBKDF2());
  var conn = await MySqlConnection.connect(settings);
  await conn.query('INSERT INTO User (email, password, telephonenumber, name) VALUES (?, ?, ?, ?)', [email, passwordHash, phone, name]);
  conn.close();
}

void findByMail(String email) async {
  var conn = await MySqlConnection.connect(settings);
  Results results =  await conn.query('SELECT COUNT(user_id) FROM User WHERE email = ?', [email]);
  conn.close();
  isMailFound = results.fields.first != 0;
}
