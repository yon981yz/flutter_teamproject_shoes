  import 'package:flutter_teamproject_shoes/model/dev_kiosk.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<List<DevKiosk>> queryDevkiosk() async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from address');
      return queryResult.map((e) => DevKiosk.fromMap(e)).toList();
  }