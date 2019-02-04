import 'dart:async';
import 'dart:io';

import 'package:notodo/model/nodo_item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class databaseHelper {
  databaseHelper.internal(); // constructor
  //create final instance
  static final databaseHelper _instance = databaseHelper.internal();
  // return final instance using factory constructor
  factory databaseHelper() => _instance;
  // DB instance
  static Database _db;
  //columns names to be used in create table string
  static String tableName = "NoTodos";
  static String id = "id";
  static String column1 = "itemName";
  static String column2 = "dateCreated";
  // create table string to be used in onCreate
  static String _createTable =
      "CREATE TABLE $tableName ( $id INTEGER PRIMARYKEY , $column1 TEXT NOT NULL, $column2 Text NOT NULL)";
  static String _recordCount = "Select count(1) from $tableName";
  static String _getAllRecords = "SELECT * FROM $tableName ORDER BY $id";
  static String _getRecord = "SELECT * FROM $tableName where $id = ";
  // DB name to be used in initDB()
  String dbName = "notodo";
  void _onCreate(Database _db, int newVersion) async {
    await _db.execute(_createTable);
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDB();
      return _db;
    } else
      return _db;
  }

  Future close() async {
    // always close DB after use
    var dbClient = await db;
    return dbClient.close();
  }

  Future<int> saveRecord(NoDoItem record) async {
    var dbClient = await db;
    int result = await dbClient.insert(tableName, record.toMap());
    return result;
  }

  Future<int> getRecordCount() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(_recordCount);
    int count = Sqflite.firstIntValue(result);
    return count;
  }

  Future<List> getAllRecords() async {
    // user must check if no records found
    var dbClient = await db;
    var records = await dbClient.rawQuery(_getAllRecords);
    return records;
  }

  Future<NoDoItem> findRecord(int recordId) async {
    var dbClient = await db;
    String query = _getRecord + recordId.toString();
    print(query);
    var result = await dbClient.rawQuery(query);
    if (result.length != 0) return NoDoItem.fromMap(result.first);
    else {
      result = await dbClient.rawQuery("SELECT * FROM $tableName");
      return NoDoItem.fromMap(result.last);
    }
  }

  Future<int> deleteRecord(int del_id) async {
    var dbClient = await db;
    var result =
        await dbClient.delete(tableName, where: 'id = ?', whereArgs: [del_id]);
    return result;
  }

  Future<int> updateRecord(NoDoItem updItem) async {
    var dbClient = await db;
    var result = await dbClient.update(tableName, updItem.toMap(),
        where: 'id = ?', whereArgs: [updItem.id]);
    return result;
  }
}
