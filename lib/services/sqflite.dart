import 'package:food_ordering_app/models/submitted_food.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {

  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'food.db'),
      version: 3,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE food(id INTEGER PRIMARY KEY ,image TEXT NOT NULL,name TEXT NOT NULL,cuisine TEXT NOT NULL,rating TEXT NOT NULL)",
        );
      },
    );
  }


  // insert data
  Future<int> insert(List<SubmittedFood> planets) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var planet in planets) {
      result = await db.insert('food', planet.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }

  // retrieve data
  Future<List<SubmittedFood>> retrieve() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('food');
    return queryResult.map((e) => SubmittedFood.fromMap(e)).toList();
  }


}
