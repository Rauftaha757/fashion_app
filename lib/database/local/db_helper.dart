import 'dart:ui';

import 'package:exp/model_classes/items_list.dart';
import 'package:exp/model_classes/oder_model_class.dart';
import 'package:exp/model_classes/user_modelclass.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  DbHelper._privateConstructor();
  static final DbHelper _instance = DbHelper._privateConstructor();
  static DbHelper getinstance() => _instance;

  Database? _mydb;

  Future<Database> getdb() async {
    if (_mydb != null) return _mydb!;

    _mydb = await opendb();
    return _mydb!;
  }

  Future<Database> opendb() async {
    final path = join(await getDatabasesPath(), "stock.db");
    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE stock (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price REAL,
            image TEXT,
            category TEXT
          )
        ''');
        await db.execute('''
  CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT,
    password TEXT
  )
''');

        await db.execute('''
         CREATE TABLE myoder (
  oderid INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  price real,
  count INTEGER,
  userId INTEGER,
  FOREIGN KEY (userId) REFERENCES user(id)
)

        ''');
      },
    );
  }

  Future<void> insertdata(item_model_class item) async {
    final db = await getdb();
    await db.insert("stock", item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<item_model_class>> getdata() async {
    final db = await getdb();
    final List<Map<String, dynamic>> maps = await db.query("stock");
    return maps.map((map) => item_model_class.fromMap(map)).toList();
  }
  Future<void> updateItem(item_model_class item) async {
    final db = await getdb();
    await db.update(
      "stock",
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await getdb();
    await db.delete(
      "stock",
      where: "id = ?",
      whereArgs: [id],
    );
  }
  Future<void> insertuser(usermodel user) async {
    final db = await getdb();
    await db.insert("user", user.tomap(), conflictAlgorithm: ConflictAlgorithm.ignore);

    // DEBUG: How many users exist?
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM user'));
    print("Total users in database after inserting: $count");
  }


  Future<List<usermodel>> getallUsers() async {
    final db = await getdb();
    final maps = await db.query("user");
    // into list
    return List.generate(maps.length, (i){
      return usermodel.fromMap(maps[i]);
    }
    );

  }
  Future<void> insertoder(OderModel oder) async {
    final db = await getdb();
    if (oder.userId == null || oder.userId == 0) {
      print('Invalid userId');
      return;
    }
    await db.insert("myoder", oder.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM myoder'));
    print("Total orders in database after inserting: $count");
  }

  Future<List<OderModel>> gettalloder()async{
    final db= await getdb();
    final maps=await db.query("myoder");
    return List.generate(maps.length, (i){
      return OderModel.fromMap(maps[i]);
    });
  }
  Future<List<OderModel>> getOrdersByUserId(int userId) async {
    final db = await getdb();
    final List<Map<String, dynamic>> maps = await db.query(
      "myoder",
      where: "userId = ?",
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return OderModel.fromMap(maps[i]);
    });
  }

}



