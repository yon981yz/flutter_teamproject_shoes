import 'package:flutter_teamproject_shoes/model/shoes.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
import 'package:sqflite/sqflite.dart';

final DatabaseHandler databaseHandler = DatabaseHandler();

class MgtHandler{

Future<List<Shoes>> queryShoes() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes');
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

Future<List<Shoes>> query() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes');
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

  Future<int> insertShoes(Shoes shoes) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.rawInsert(
      """
      insert into shoes(name, size, color, salesprice, image, logo, brand)
      values (?,?,?,?,?,?,?)
      """, [
        shoes.name,
        shoes.size,
        shoes.color,
        shoes.salesprice,
        shoes.image,
        shoes.logo,
        shoes.brand,
      ]
    );
    return result;

  }
}