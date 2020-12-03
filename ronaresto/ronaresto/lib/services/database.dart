import 'package:mysql1/mysql1.dart';
import 'package:password/password.dart';

var settings = new ConnectionSettings(
    host: 'remotemysql.com',
    port: 3306,
    user: 'ZdZsbXqf4M',
    password: 'Rf1I4vFY8P',
    db: 'ZdZsbXqf4M');

int userId;
bool isMailFound = false;

Future<bool> login(String email, String password)  async {
  var conn = await MySqlConnection.connect(settings);
  String passwordHash = Password.hash(password, PBKDF2());
  Results results =  await conn.query('SELECT * FROM User WHERE email = ? AND password = ?', [email, passwordHash]);
  if (results.length == 1) {
    for (var row in results) {
      userId = row[0];
    }
    return true;
  }
  return false;
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

Future<List<dynamic>> findRestaurant(String name)  async {
  var conn = await MySqlConnection.connect(settings);
  var results =  await conn.query('SELECT `restaurant_id`, `name`, `location` FROM `Restaurant` WHERE name = ?', [name]);

  var info = new List(3);

  if (results.length > 0) {
    for (var row in results) {
      info[0] = row[0].toString();
      info[1] = row[1].toString();
      info[2] = row[2].toString();
    }
    print('resto ID'+info[0].toString());
  }
  conn.close();
  return info;
}

void placeReview(String text, int stars, String user_id, String restaurant_id) async {
  var conn = await MySqlConnection.connect(settings);
  await conn.query('INSERT INTO Review (text, stars, user_id, restaurant_id) VALUES (?, ?, ?, ?)', [text, stars, user_id, restaurant_id]);
  conn.close();
}

Future<List<dynamic>> reviews(String restaurant_id)  async {
  var conn = await MySqlConnection.connect(settings);
  var results =  await conn.query('SELECT `text`, `stars`, `user_id` FROM `Review` WHERE restaurant_id = ? ORDER BY `review_id` DESC LIMIT 3', [restaurant_id]);

  if (results.length > 0){
    var reviews = new List(results.length);
    int i = 0;

    if (results.length > 0) {
      for (var row in results) {
        reviews[i] = new List(3);
        reviews[i][0] = row[0].toString();
        reviews[i][1] = row[1].toString();
        var users =  await conn.query('SELECT `name` FROM `User` WHERE user_id = ?', [row[2].toString()]);
        if (users.length > 0) {
          for (var row in users) {
            reviews[i][2] = row[0].toString();
          }
        }else{
          reviews[i][2] = 'unavailable';
        }
        i++;
      }
    }
    conn.close();
    return reviews;
  }
  else{
    conn.close();
    return null;
  }
}
