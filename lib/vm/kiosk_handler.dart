import 'package:flutter_teamproject_shoes/model/branch.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/model/userlist.dart';
import 'package:flutter_teamproject_shoes/view/user_purchase_list.dart';
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
// 구매 상품 확인
Future<List<Userlist>> queryuserlist(String id) async {
  final Database db = await databaseHandler.initializeDB();
  final List<Map<String, Object?>> queryResult = await db.rawQuery('''
    SELECT
      p.id as id,
      a.name as accountname,
      a.phone as accountphone,
      s.name as shoesname,
      s.size as shoessize,
      s.color as shoescolor,
      s.brand as shoesbrand,
      p.salesprice as salesprice,
      p.purchasedate as purchasedate,
      p.collectiondate as collectiondate,
      p.collectionstatus as collectionstatus,
      s.image as shoesimage,
	    b.id as branchid
    FROM purchase p, shoes s, account a , branch b
    WHERE p.account_id = a.id and
      p.shoes_id = s.id and
	    p.branch_id = b.id AND
      a.id = ?
      ''',
      [id]);
  
  return queryResult.map((e) => Userlist.fromMap(e)).toList();
}


// 구매 상품 확인
Future<List<Userlist>> querykioskList(int id) async {
  final Database db = await databaseHandler.initializeDB();
  final List<Map<String, Object?>> queryResult = await db.rawQuery('''
    SELECT
      p.id as id,
      a.name as accountname,
      a.phone as accountphone,
      s.name as shoesname,
      s.size as shoessize,
      s.color as shoescolor,
      s.brand as shoesbrand,
      p.salesprice as salesprice,
      p.purchasedate as purchasedate,
      p.collectiondate as collectiondate,
      p.collectionstatus as collectionstatus,
      s.image as shoesimage,
	    b.id as branchid
    FROM purchase p, shoes s, account a , branch b
    WHERE p.account_id = a.id and
      p.shoes_id = s.id and
	    p.branch_id = b.id AND
      p.id = ?
      ''',
      [id]);
  
  return queryResult.map((e) => Userlist.fromMap(e)).toList();
}

// 신발 수령
  Future<int> updateTransfer(Purchase purchase) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.rawUpdate(
      """
      update purchase
      set collectionstatus = ?
    
      where id = ?
      """, [
        purchase.collectionstatus, purchase.id
      ]
    );
    return result;
  }


}