import 'package:mysql1/mysql1.dart';
import 'package:password/password.dart';
import 'package:intl/intl.dart';
import 'package:ronaresto/models/user.dart';

var settings = new ConnectionSettings(
    host: '193.191.177.194', // raf-zegers.sb.uclllabs.be
    port: 4001,
    user: 'ZdZsbXqf4M',
    password: 'Rf1I4vFY8P',
    db: 'ZdZsbXqf4M');

User user;

Future<String> login(String email, String password)  async {
  var conn = await MySqlConnection.connect(settings);
  String passwordHash = Password.hash(password, PBKDF2());
  Results results =  await conn.query('SELECT user_id, email, telephonenumber, name FROM User WHERE email = ? AND password = ?', [email, passwordHash]);
  conn.close();
  String idReturn;

  if (results.length > 0) {
    for (var row in results) {
      int id = row[0];
      String email = row[1].toString();
      String telephone = row[2].toString();
      String name = row[3].toString();
      user = new User(id, email, telephone, name);
      user.type = "User";
      idReturn = row[0].toString();
    }
  }
  conn.close();
  return idReturn;
}

void loginGuest(String email, String telephone, String name){
  int id = 0;
  user = new User(id, email, telephone, name);
  user.type = "Guest";
}

void register(String name, String email, String password, String phone) async {
  String passwordHash = Password.hash(password, PBKDF2());
  var conn = await MySqlConnection.connect(settings);
  await conn.query('INSERT INTO User (email, password, telephonenumber, name) VALUES (?, ?, ?, ?)', [email, passwordHash, phone, name]);
  conn.close();
}

Future<bool> findByMail(String email) async {
  var conn = await MySqlConnection.connect(settings);
  Results results =  await conn.query('SELECT user_id FROM User WHERE email = ?', [email]);
  conn.close();
  return results.length != 0;
}

Future<List<dynamic>> findRestaurant(String name)  async {
  var conn = await MySqlConnection.connect(settings);
  var results =  await conn.query('SELECT `restaurant_id`, `name`, `location`,`capacity` FROM `Restaurant` WHERE name = ?', [name]);

  var info = new List(4);

  if (results.length > 0) {
    for (var row in results) {
      info[0] = row[0].toString();
      info[1] = row[1].toString();
      info[2] = row[2].toString();
      info[3] = row[3].toString();
    }
  }
  conn.close();
  return info;
}

/*Future<List<dynamic>> findRestaurantByID(String id)  async {
  var conn = await MySqlConnection.connect(settings);
  var results =  await conn.query('SELECT `restaurant_id`, `name`, `location`,`capacity` FROM `Restaurant` WHERE restaurant_id = ?', [id]);

  var info = new List(4);

  if (results.length > 0) {
    for (var row in results) {
      info[0] = row[0].toString();
      info[1] = row[1].toString();
      info[2] = row[2].toString();
      info[3] = row[3].toString();
    }
  }
  conn.close();
  return info;
}*/

Future<List<dynamic>> placeReview(String text, int stars, String user_id, String restaurant_id) async {
  var conn = await MySqlConnection.connect(settings);
  await conn.query('INSERT INTO Review (text, stars, user_id, restaurant_id) VALUES (?, ?, ?, ?)', [text, stars, user_id, restaurant_id]);
  conn.close();

  return reviews(restaurant_id);
}

Future<List<dynamic>> reviews(String restaurant_id)  async {
  var conn = await MySqlConnection.connect(settings);
  var results =  await conn.query('SELECT `text`, `stars`, `user_id` FROM `Review` WHERE restaurant_id = ? ORDER BY `review_id` DESC LIMIT 7', [restaurant_id]);

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

void createVisit(int restaurantId) async{
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime time = DateTime.now();
  if (time.minute >= 30) {
    time = time.subtract(Duration(minutes: (time.minute - 30), seconds: time.second));
  }
  else {
    time = time.subtract(Duration(minutes: time.minute, seconds: time.second));
  }
  String timeslot = DateFormat('HH:mm:ss').format(time);
  var conn = await MySqlConnection.connect(settings);
  await conn.query('INSERT INTO Visit (date, timeslot, name, telephone, email, restaurant_id) VALUES (?, ?, ?, ?, ?, ?)', [date, timeslot, user.name, user.telephone, user.email, restaurantId]);
  conn.close();
}

void createAlert(int restaurantId, int tafelnummer) async{
  DateTime time = DateTime.now();
  String timeFormatted = DateFormat('HH:mm:ss').format(time);
  var conn = await MySqlConnection.connect(settings);
  await conn.query('INSERT INTO Alert (restaurant_id, table_number, time_created) VALUES (?, ?, ?)', [restaurantId, tafelnummer, timeFormatted]);
  conn.close();
}

Future<List<dynamic>> dishes(String restaurant_id)  async {
  var conn = await MySqlConnection.connect(settings);
  var results =  await conn.query('SELECT `dish_id`,`name`, `price`, `description` FROM `Dish` WHERE restaurant_id = ? ORDER BY 1 ASC', [restaurant_id]);

  if (results.length > 0){
    var dishes = new List(results.length);
    int i = 0;

    for (var row in results) {
      dishes[i] = new List(5);
      dishes[i][0] = row[0].toString();
      dishes[i][1] = row[1].toString();
      dishes[i][2] = row[2].toString();
      dishes[i][3] = row[3].toString();
      var allergylist =  await conn.query('SELECT a.name, a.description FROM `Allergylist` as l inner join `Allergy` as a using(allergy_id) WHERE dish_id = ?', [row[0].toString()]);
      if (allergylist.length > 0) {
        dishes[i][4] = new List(allergylist.length);
        int j = 0;
        for (var alg in allergylist) {
          dishes[i][4][j] = [ alg[0].toString(), alg[1].toString() ];
          j++;
        }
      }else{
        dishes[i][4] = [];
      }
      i++;
    }
    conn.close();
    return dishes;
  }
  else{
    conn.close();
    return null;
  }
}

Future<List<dynamic>> reservationTimeslots(String restaurant_id, String date)  async {
  var conn = await MySqlConnection.connect(settings);
  var capacityresult =  await conn.query('SELECT `capacity` FROM `Restaurant` WHERE restaurant_id = ?', [restaurant_id]);
  var results = await conn.query('SELECT timeslot, number FROM Reservation WHERE date=?',[date]);
  conn.close();

  int capacity = 0;
  if (capacityresult.length > 0) {
    for (var row in capacityresult) {
      capacity = int.tryParse(row[0].toString());
    }
  }

  List<int> list = new List(48);
  for(int i=0; i<48;i++){
    //reservation must be between 8:00 and 22:00
    if(i<16 || i>44) list[i] = 0;
    else list[i] = capacity;
  }

  if(results.length > 0){
    for(var row in results){
      DateTime time = DateFormat("hh:mm:ss").parse(row[0].toString());
      int index = time.hour*2;
      if(time.minute==30) index++;
      //expect a staying time of 2 hours, subtract number of people 2 hours before (new reservation will also stay 2 hours) and after there reservation
      for(int i=-3; i<4; i++){
        if(index + i >= 0 && index + i < list.length) list[index+i] -= int.tryParse(row[1].toString());
      }
    }
  }
  return list;
}

void createReservation(int number, String timeslot, String date, String user_id, String restaurant_id) async{
  var conn = await MySqlConnection.connect(settings);
  await conn.query('INSERT INTO Reservation (number, timeslot, date, user_id, restaurant_id) VALUES (?, ?, ?, ?, ?)', [number, timeslot, date, user_id, restaurant_id]);
  conn.close();
}

Future<List<dynamic>> getReservations(String user_id)  async {
  var conn = await MySqlConnection.connect(settings);
  var results =  await conn.query('SELECT `number`, `timeslot`, `date`, `restaurant_id`, `reservation_id` FROM `Reservation` WHERE user_id = ?', [user_id]);

  if (results.length > 0){
    var reservations = new List(results.length);
    int i = 0;

    if (results.length > 0) {
      for (var row in results) {
        reservations[i] = new List(5);
        reservations[i][0] = row[0].toString();
        reservations[i][1] = row[1].toString().substring(0,5);
        reservations[i][2] = row[2].toString().substring(0,10);
        reservations[i][4] = row[4].toString();
        var restaurants =  await conn.query('SELECT `name` FROM `Restaurant` WHERE restaurant_id = ?', [row[3].toString()]);
        if (restaurants.length > 0) {
          for (var row in restaurants) {
            reservations[i][3] = row[0].toString();
          }
        }else{
          reservations[i][3] = 'unavailable';
        }
        i++;
      }
    }
    conn.close();
    return reservations;
  }
  else{
    conn.close();
    return null;
  }
}

void deleteReservation(String reservation_id) async{
  var conn = await MySqlConnection.connect(settings);
  await conn.query('DELETE FROM Reservation WHERE reservation_id = ?', [reservation_id]);
  conn.close();
}



