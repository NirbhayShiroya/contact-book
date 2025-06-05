import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? database;

  Future<bool> initDatacall() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
print("======$path");
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'create table contactinfo (id integer primary key autoincrement,fname text,mname text,lname text,email text,phonecode text,mno text,address text,city text,gender text,hobby text)');
    });
    return true;
  }
}
