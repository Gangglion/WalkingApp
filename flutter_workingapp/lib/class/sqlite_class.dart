// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class Sqlite {
//   Future _openDb() async {
//     final databasePath = await getDatabasesPath();
//     String path = join(databasePath, 'walkApp.db');

//     final db = await openDatabase(
//       path,
//       version: 1,
//       onConfigure: (Database db) => {},
//       onCreate: _onCreate,
//       onUpgrade: (Database db, oldVersion, newVersion) => {},
//     );
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute(
//         '''
//       CREATE TABLE IF NOT EXISTS WALKTABLE(
//         DATE TEXT PRIMARY KEY,
//         STEPVALUE INTEGER NOT NULL
//       )
//     ''');
//   }

//   Future add(item) async {
//     final db = await _openDb();
//     item.date = await db.insert(
//       'WALKTABLE',
//       {
//         'DATE': 'now time',
//         'STEPVALUE': 5,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future update(item) async {
//     final db = await _openDb();
//     await db.update(
//       'WALKTABLE',
//       {
//         'STEPVALUE': 'changed stepValue',
//       },
//       where: 'DATE = ?',
//       whereArgs: [item.date],
//     );
//     return item;
//   }
// }
