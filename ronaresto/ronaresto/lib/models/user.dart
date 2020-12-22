class User {
  int _userId;
  String _email;
  String _name;
  String _telephone;
  String _type;

  User(int userId, String email, String telephone, String name) {
    this._userId = userId;
    this._email = email;
    this._telephone = telephone;
    this._name = name;
  }

  String get type => _type;

  String get telephone => _telephone;

  String get name => _name;

  String get email => _email;

  int get userId => _userId;

  set type(String value) {
    _type = value;
  }
}
