import 'package:flutter_teamproject_shoes/model/account.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
import 'package:sqflite/sqflite.dart';

final DatabaseHandler databaseHandler = DatabaseHandler();


class CustomerHandler{
///// 계정 추가
Future<int> insertAccount(Account account) async {
  int result = 0;
  final Database db = await databaseHandler.initializeDB();
  // 아이디 중복 체크
  final List<Map<String, dynamic>> checknewID = await db.rawQuery(
    "SELECT COUNT(*) as count FROM account WHERE id = ?",
    [account.id]
  );
  
  int count = checknewID.first['count'] as int;

  if (count > 0) {
    return -1; 
  }

  // 아이디가 존재하지 않을 경우, 새로운 계정 삽입
  result = await db.rawInsert(
    """
    INSERT INTO account(id, name, phone, password)
    VALUES (?,?,?,?)
    """, [
      account.id,
      account.name,
      account.phone,
      account.password,
    ]
  );
  return result;
}


///// 로그인 검색
Future<int> queryLoginCheck(String id, String password) async {
  int result = 0;
  final Database db = await databaseHandler.initializeDB();
  final List<Map<String, Object?>> queryResult = await db.rawQuery(
    'select count(*) from account where id = ? and password = ?',
    [id, password],
  );

    result = queryResult[0]['count(*)'] as int;
    // print(result);
    return result;
}

// ID중복 검색

Future<int> serchID(String id) async{
  int result = 0;
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select count(*) from account where id = ?',
      [id]);
      // print(result);
      result = queryResult[0]['count(*)'] as int;
      return result;
  }


///// 내정보 검색

Future<List<Account>> queryMyinfo(String id) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from account where id = ?',
      [id]);
      return queryResult.map((e) => Account.fromMap(e)).toList();
  }

  // 구매 리스트
  Future<List<Purchase>> purchaseList(String id) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = 
    await db.rawQuery(
      """
      select * from purchase where id =?
      """,
      [id]
    );
    return queryResult.map((e) => Purchase.fromMap(e)).toList();
  }

  // 키오스크에서 주문번호 검색
Future<int> queryPurchaseNumber(String id) async {
  final Database db = await databaseHandler.initializeDB();
  List<Map<String, dynamic>> queryResult = await db.rawQuery(
    """
    select count(*) as count from purchase where id = ?
    """, [id]
  );
    return queryResult.isNotEmpty ? 1 : 0;
  }

}