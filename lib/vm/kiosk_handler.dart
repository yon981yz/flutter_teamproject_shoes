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
Future<void> insertBranches(List<Branch> branches) async {
  final Database db = await databaseHandler.initializeDB();

  for (var branch in branches) {
    // 지점이 이미 존재하는지 확인
    final List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT * FROM branch WHERE name = ?",
      [branch.name],
    );

    // 지점 중복 방지
    if (result.isEmpty) {
      await db.rawInsert(
        """
        INSERT INTO branch(name)
        VALUES(?)
        """,
        [branch.name],
      );
      print('Inserted branch: ${branch.name}');
    }
  }
}

}