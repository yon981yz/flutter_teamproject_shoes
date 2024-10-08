import 'package:flutter_teamproject_shoes/model/PurchaseSummary.dart';
import 'package:flutter_teamproject_shoes/model/Topbrand.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/model/purchaseDetail.dart';
import 'package:flutter_teamproject_shoes/model/shoes.dart';
import 'package:flutter_teamproject_shoes/model/topAccount.dart';
import 'package:flutter_teamproject_shoes/model/topfiveshoes.dart';
import 'package:flutter_teamproject_shoes/model/transfer.dart';
import 'package:flutter_teamproject_shoes/model/transferSummary.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
import 'package:sqflite/sqflite.dart';

final DatabaseHandler databaseHandler = DatabaseHandler();

class MgtHandler{

    ///// 신발 전체 검색

Future<List<Shoes>> queryShoes() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes');
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

  ///// 신발 재품명 검색 (검색창)

Future<List<Shoes>> queryShoesSearch(String name) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where name like ?',
      ['%$name%']);
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

  ////구매 내역 확인

Future<List<PurchaseDetail>> queryPurchaseDetails() async {
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
      p.collectionstatus as collectionstatus
    FROM purchase p, shoes s, account a 
    WHERE p.account_id = a.id and
      p.shoes_id = s.id and
      order by p.purchasedate
  ''');
  
  return queryResult.map((e) => PurchaseDetail.fromMap(e)).toList();
}
  ////구매 내역 확인

Future<List<PurchaseDetail>> queryPurchaseDetailsSearch(String name) async {
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
      p.collectionstatus as collectionstatus
    FROM purchase p, shoes s, account a 
    WHERE p.account_id = a.id and
      p.shoes_id = s.id and
      a.name like ?
      order by p.purchasedate
      ''',
      ['%$name%']);
  
  return queryResult.map((e) => PurchaseDetail.fromMap(e)).toList();
}

  ////구매 내역 확인

Future<List<PurchaseDetail>> queryPurchaseDetails2Limit() async {
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
      p.collectionstatus as collectionstatus
    FROM purchase p, shoes s, account a 
    WHERE p.account_id = a.id and
      p.shoes_id = s.id
      order by p.purchasedate
      LIMIT 2
  ''');
  
  return queryResult.map((e) => PurchaseDetail.fromMap(e)).toList();
}


// 신발추가

  Future<int> insertShoes(Shoes shoes) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.rawInsert(
      """
      INSERT into shoes(name, size, color, salesprice, image, logo, brand)
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



// 오늘 매출

Future<List<PurchaseSummary>> querySalesToday() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('''
      SELECT count(id) as count , sum(salesprice) as total
      FROM purchase
      WHERE purchasedate = DATE('now', 'localtime')
      ''');
      print(queryResult);
      return queryResult.map((e) => PurchaseSummary.fromMap(e)).toList();
  }



// 이번달 매출

Future<List<PurchaseSummary>> querySalesMonth() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('''
      SELECT count(id) as count , sum(salesprice) as total
      FROM purchase 
      WHERE strftime('%Y-%m', purchasedate) = strftime('%Y-%m', 'now', 'localtime')
      ''');
      return queryResult.map((e) => PurchaseSummary.fromMap(e)).toList();
  }

// 이달의 상품 탑5

Future<List<Topfiveshoes>> queryTopFiveShoes() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('''
    SELECT 
      s.image as image, 
      s.id as shoesid,
      s.name as shoesname,
      s.brand as shoesbrand,
      COUNT(p.id) as totalorder, 
      SUM(p.salesprice) as totalsales
    FROM shoes s, purchase p
    WHERE s.id = p.shoes_id and
      strftime('%Y-%m', purchasedate) = strftime('%Y-%m', 'now', 'localtime')
    GROUP BY s.id
    ORDER BY totalsales DESC
    LIMIT 5
      ''');
      return queryResult.map((e) => Topfiveshoes.fromMap(e)).toList();
  }


// 이번달 브랜드별 매출

Future<List<Topbrand>> querySalesBrand() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('''
    SELECT s.brand, SUM(p.salesprice) AS totalsales
    FROM shoes s, purchase p
    WHERE s.id = p.shoes_id and
      strftime('%Y-%m', purchasedate) = strftime('%Y-%m', 'now', 'localtime')
    GROUP BY s.brand
    ORDER BY totalsales DESC
    LIMIT 3
      ''');
      return queryResult.map((e) => Topbrand.fromMap(e)).toList();
  }
// 이번달 탑 5 사용자 매출

Future<List<Topaccount>> queryTopFiveAccount() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('''
      SELECT a.id AS accountid, a.name AS accountname, COUNT(p.id) AS purchasecount, SUM(p.salesprice) AS totalsales
      FROM account a, purchase p
      WHERE a.id = p.account_id and
        strftime('%Y-%m', purchasedate) = strftime('%Y-%m', 'now', 'localtime')
      GROUP BY a.id
      ORDER BY totalsales DESC
      LIMIT 5
      ''');
      return queryResult.map((e) => Topaccount.fromMap(e)).toList();
  }

// 배송추가

Future<int> insertTransfer(Transfer transfer) async {
  final Database db = await databaseHandler.initializeDB();
    int result = await db.rawInsert(
      """
      INSERT INTO transfer (shoes_id, branch_id, date, collectionstatus)
      VALUES (?, ?, ?, ?)
      """, [
      transfer.shoesid,
      transfer.branchid,
      transfer.date,
      transfer.collectionstatus
      ]
    );
    return result;
  }

// 배송확인
Future<List<Transfersummary>> queryTransfer() async {
  final Database db = await databaseHandler.initializeDB();
  final List<Map<String, Object?>> queryResult =
    await db.rawQuery('''
    SELECT t.id, b.name as branchname, s.id as shoesid, s.name as shoesname, t.date, t.collectionstatus, b.id as branchid
    FROM transfer t, shoes s, branch b
    WHERE b.id = t.branch_id and s.id = t.shoes_id
    ''');
  return queryResult.map((e) => Transfersummary.fromMap(e)).toList();
}

// 구매

  Future<int> purchaseShoes(Purchase purchase) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.rawInsert(
      """
      INSERT into purchase(id, salesprice, purchasedate, collectiondate, collectionstatus, branch_id, account_id, shoes_id )
      values (?,?,?,?,?,?,?,?)
      """, [
        purchase.id,
        purchase.salesprice,
        purchase.purchasedate,
        purchase.collectiondate,
        purchase.collectionstatus,
        purchase.branchid,
        purchase.accountid,
        purchase.shoesid,
      ]
    );
    return result;

  }

// 배송 수령
  Future<int> updateTransfer(Transfer transfer) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.rawUpdate(
      """
      update transfer
      set collectionstatus = ?


      where id = ?
      """, [
        transfer.collectionstatus, transfer.id
      ]
    );
    return result;
  }

}

