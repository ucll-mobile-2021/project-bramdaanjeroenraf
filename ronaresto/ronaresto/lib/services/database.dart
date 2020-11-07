import 'package:mysql1/mysql1.dart';
import 'package:password/password.dart';

var settings = new ConnectionSettings(
    host: 'remotemysql.com',
    port: 3306,
    user: 'ZdZsbXqf4M',
    password: 'Rf1I4vFY8P',
    db: 'ZdZsbXqf4M');

int user_id;

Future<bool> login(String email, String password)  async {
  var conn = await MySqlConnection.connect(settings);
  String passwordHash = Password.hash(password, PBKDF2());
  var results =  await conn.query('SELECT * FROM User WHERE email = ? AND password = ?', [email, passwordHash]);
  if (results.length == 1) {
    for (var row in results) {
      user_id = row[0];
    }
    print(user_id);
    conn.close();
    return true;
  }else{
    conn.close();
    return false;
  }
}

void register(String name, String email, String password, String phone) async {
  String passwordHash = Password.hash(password, PBKDF2());
  var conn = await MySqlConnection.connect(settings);
  var results =  await conn.query('INSERT INTO User (email, password, telephonenumber, name) VALUES (?, ?, ?, ?)', [email, passwordHash, phone, name]);
  conn.close();
}

Future<Results> findByMail(String email) async {
  var conn = await MySqlConnection.connect(settings);
  var results =  await conn.query('SELECT * FROM User WHERE email = ?', [email]);
  conn.close();
  if(results.length > 0) {
    return results;
  }
  return null;
}
