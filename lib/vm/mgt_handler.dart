import 'package:flutter_teamproject_shoes/model/PurchaseSummary.dart';
import 'package:flutter_teamproject_shoes/model/Topbrand.dart';
import 'package:flutter_teamproject_shoes/model/purchaseDetail.dart';
import 'package:flutter_teamproject_shoes/model/shoes.dart';
import 'package:flutter_teamproject_shoes/model/topAccount.dart';
import 'package:flutter_teamproject_shoes/model/topfiveshoes.dart';
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
      purchase.id AS id,
      account.name AS account_name,
      account.phone AS account_phone,
      shoes.name AS shoes_name,
      shoes.size AS shoes_size,
      shoes.color AS shoes_color,
      shoes.brand AS shoes_brand,
      purchase.salesprice,
      purchase.purchasedate,
      purchase.collectiondate,
      purchase.collectionstatus
    FROM purchase
    INNER JOIN account ON purchase.account_id = account.id
    INNER JOIN shoes ON purchase.shoes_id = shoes.id
    order by purchase.purchasedate
  ''');
  
  return queryResult.map((e) => PurchaseDetail.fromMap(e)).toList();
}


// 신발추가

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



// 오늘 매출

Future<List<PurchaseSummary>> querySalesToday() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('''
      select count(id) sum(p.salesprice) 
      from purchase 
      where purchasedate = DATE('now', 'localtime')
      ''');
      return queryResult.map((e) => PurchaseSummary.fromMap(e)).toList();
  }



// 이번달 매출

Future<List<PurchaseSummary>> querySalesMonth() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('''
      select count(id) sum(salesprice) 
      from purchase 
      where strftime('%Y-%m-%d', purchasedate) = strftime('%Y-%m-%d', 'now', 'localtime')
      ''');
      return queryResult.map((e) => PurchaseSummary.fromMap(e)).toList();
  }

// 이달의 상품 탑5

Future<List<Topfiveshoes>> queryTopFiveShoes() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('''
    SELECT s.image, s.id, s.name, s.brand, COUNT(p.id), SUM(p.salesprice)
    FROM shoes s
    INNER JOIN purchase p ON s.id = p.shoes_id
    WHERE strftime('%Y-%m-%d', p.purchasedate) = strftime('%Y-%m-%d', 'now', 'localtime')
    GROUP BY s.id
    ORDER BY total_sales DESC
    LIMIT 5
      ''');
      return queryResult.map((e) => Topfiveshoes.fromMap(e)).toList();
  }


// 이번달 브랜드별 매출

Future<List<Topbrand>> querySalesBrand() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('''
      SELECT s.brand, SUM(p.salesprice) AS total_sales
      FROM shoes s
      INNER JOIN purchase p ON s.id = p.shoes_id
      WHERE strftime('%Y-%m-%d', p.purchasedate) = strftime('%Y-%m-%d', 'now', 'localtime')
      GROUP BY s.brand
      ORDER BY total_sales DESC
      ''');
      return queryResult.map((e) => Topbrand.fromMap(e)).toList();
  }
// 이번달 탑 5 사용자 매출

Future<List<Topaccount>> queryTopFiveAccount() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('''
      SELECT a.id AS account_id, a.name AS account_name, COUNT(p.id) AS purchase_count, SUM(p.salesprice) AS total_sales
      FROM account a
      INNER JOIN purchase p ON a.id = p.account_id
      WHERE strftime('%Y-%m-%d', p.purchasedate) = strftime('%Y-%m-%d', 'now', 'localtime')
      GROUP BY a.id
      ORDER BY total_sales DESC
      LIMIT 5
      ''');
      return queryResult.map((e) => Topaccount.fromMap(e)).toList();
  }


  
  }

