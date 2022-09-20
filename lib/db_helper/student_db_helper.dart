import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_flutter_practice/models/student_model.dart';

class DbHelper {
  static Database? _db;
  static const String databaseName = 'stud.db';
  static const int version = 1;

  static Future<Database?> database() async {
    if (_db != null) {
      return _db;
    }
    return _db = await openDatabase(
        join(await getDatabasesPath(), databaseName),
        version: version,
        onCreate: _onCreate,
        onOpen: _onOpen);
  }
}

void _onCreate(Database db, int version) async {
  await db.execute(StudentModel.createTable);
}

void _onOpen(Database db) {
  print(db.isOpen.toString());
}
