class StudentModel {
  final int? id;
  final String? rollNo;
  final String? name;
  final String? email;
  final String? fee;
  final String? password;

  StudentModel(
      {this.id,
      required this.rollNo,
      required this.name,
      required this.email,
      required this.fee,
      required this.password});

  StudentModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        rollNo = map['rollNo'],
        name = map['name'],
        email = map['email'],
        fee = map['fee'],
        password = map['password'];

  Map<String, dynamic> toMap() {
    return {
      'roll_no': rollNo,
      'name': name,
      'email': email,
      'fee': fee,
      'password': password
    };
  }

  static const String tableName = 'student';
  static const String columnId = 'id';
  static const String columnRollNo = 'roll_no';
  static const String columnName = 'name';
  static const String columnEmail = 'email';
  static const String columnFee = 'fee';
  static const String columnPassword = 'password';
  static const String createTable =
      'CREATE TABLE IF NOT EXISTS $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT , $columnRollNo TEXT, $columnName TEXT, $columnEmail TEXT, $columnFee TEXT, $columnPassword TEXT)';
  static const String dropTable = 'DROP TABLE IF EXISTS $tableName';
}
