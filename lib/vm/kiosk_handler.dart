import 'package:flutter_teamproject_shoes/model/shoes.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
import 'package:sqflite/sqflite.dart';

final DatabaseHandler databaseHandler = DatabaseHandler();

Future<List<Shoes>> queryshoes() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes');
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }