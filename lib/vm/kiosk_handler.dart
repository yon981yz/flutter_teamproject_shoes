import 'package:flutter_teamproject_shoes/model/branch.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
import 'package:sqflite/sqflite.dart';

final DatabaseHandler databaseHandler = DatabaseHandler();

class KioskHandler{


/// 주문번호 토대로 주문상세 검색

Future<List<Purchase>> queryPurchase(int id) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from purchase where id = ?', 
      [ id ]
      );
      return queryResult.map((e) => Purchase.fromMap(e)).toList();
  }

// 지점
Future<void> insertBranches(List<Branch> name) async {
  final Database db = await databaseHandler.initializeDB();
  for (var branch in name) {
    await db.rawInsert(
      """
      insert into branch(name)
      values(?)
      """,
      [branch.name],
    );
  }
}
}