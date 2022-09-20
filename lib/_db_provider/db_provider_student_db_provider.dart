import 'package:sqflite/sqflite.dart';
import 'package:sqflite_flutter_practice/db_helper/student_db_helper.dart';
import 'package:sqflite_flutter_practice/models/student_model.dart';

class StudentDbProvider {
  Future<bool> insertStudent(StudentModel model) async {
    Database? database = await DbHelper.database();
    int rows = await database!.insert(StudentModel.tableName, model.toMap());
    if (rows < 0) {
      return false;
    }
    return true;
  }

  Future<bool> updateStudent(StudentModel model) async {
    Database? database = await DbHelper.database();
    int rows = await database!.update(StudentModel.tableName, model.toMap(),
        where: '${StudentModel.columnId}= ?', whereArgs: [model.id]);
    if (rows < 0) {
      return false;
    }
    return true;
  }

  Future<bool> deleteStudent(StudentModel model) async {
    Database? database = await DbHelper.database();
    int rows = await database!.delete(StudentModel.tableName,
        where: '${StudentModel.columnId}= ?', whereArgs: [model.id]);
    if (rows < 0) {
      return false;
    }
    return true;
  }

  Future<List<StudentModel>> fetchStudentsFromDb() async {
    Database? database = await DbHelper.database();
    List list = await database!.query(StudentModel.tableName);
    return list.map((e) => StudentModel.fromMap(e)).toList();
  }
}
