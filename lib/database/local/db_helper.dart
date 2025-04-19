import 'package:exp/model_classes/items_list.dart';
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
}
