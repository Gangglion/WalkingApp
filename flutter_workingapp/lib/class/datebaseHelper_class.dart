import 'dart:io';

import 'package:flutter_workingapp/class/StepValue_class.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'walkvalue.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _oncreate,
    );
  }

  Future _oncreate(Database db, int version) async {
    await db.execute('CREATE TABLE Walk(dates TEXT PRIMARY KEY, step INTEGER)');
  }

  Future<List<StepValue>> getStepValue() async {
    Database db = await instance.database;
    var stepValue = await db.query('Walk', orderBy: 'dates');
    List<StepValue> stepValueList = stepValue.isNotEmpty
        ? stepValue.map((c) => StepValue.fromMap(c)).toList()
        : [];
    return stepValueList;
  }

  Future<int> add(StepValue stepValue) async {
    Database db = await instance.database;
    return await db.insert('Walk', stepValue.toMap());
  }
}
