import 'package:flutter_teamproject_shoes/model/account.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/model/shoes.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
import 'package:sqflite/sqflite.dart';

final DatabaseHandler databaseHandler = DatabaseHandler();


class CustomerHandler{
///// 계정 추가

  Future<int> insertAccount(Accout account) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.rawInsert(
      """
      insert into shoes(id, name, phone, password)
      values (?,?,?,?)
      """, [
        account.id,
        account.name,
        account.phone,
        account.password,
      ]
    );
    return result;
  }

///// 내정보 검색

Future<List<Accout>> queryMyinfo() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from Accont');
      return queryResult.map((e) => Accout.fromMap(e)).toList();
  }

///// 신발 이미지로 정렬 (고객 구매 페이지 디스플레이) 

Future<List<Shoes>> queryShoesHome() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes group by image');
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

///// 신발 이미지로 정렬한상태에서 이름으로 검색 (고객 구매 페이지 디스플레이에서 검색) 

Future<List<Shoes>> queryShoesHomeSearch(String name) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes group by image where name like ?',
      ['%$name%']);
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

///// 브랜드이름 Nike 이름으로 정렬 (고객 구매 페이지 브랜드별 디스플레이) 

Future<List<Shoes>> queryNike() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where brand = "Nike"');
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }
///// 브랜드이름 Nike 이름으로 정렬한table에서 이름검색 (브랜트별 페이지에서 검색) 

Future<List<Shoes>> queryNikeSearch(String name) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where brand = "Nike" and name like ?',
      ['%$name%']);
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

///// 브랜드이름 NewBalance 이름으로 정렬 (고객 구매 페이지 브랜드별 디스플레이) 

Future<List<Shoes>> queryNewBalance() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where brand = "NewBalance"');
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

///// 브랜드이름 NewBalance 이름으로 정렬한table에서 이름검색 (브랜트별 페이지에서 검색) 

Future<List<Shoes>> queryNewBalanceSearch(String name) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where brand = "NewBalance" and name like ?',
      ['%$name%']);
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

///// 브랜드이름 ProSpecs 이름으로 정렬 (고객 구매 페이지 브랜드별 디스플레이) 

Future<List<Accout>> queryProSpecs() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where brand = "ProSpecs"');
      return queryResult.map((e) => Accout.fromMap(e)).toList();
  }

///// 브랜드이름 ProSpecs 이름으로 정렬한table에서 이름검색 (브랜트별 페이지에서 검색) 

Future<List<Shoes>> queryProSpecsSearch(String name) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where brand = "ProSpecs" and name like ?',
      ['%$name%']);
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

  
  ///// 상품 구매 
  Future<int> insertPurchase(Purchase purchase) async {
    int result = 0;
    final Database db = await databaseHandler.initializeDB();
    result = await db.rawInsert(
      """
      insert into shoes(id, salesprice, purchasedate, collectiondate, collectionstatus)
      values (?,?,?,?,?)
      """, [
        purchase.id,
        purchase.salesprice,
        purchase.purchasedate,
        purchase.collectiondate,
        purchase.collectionstatus,
      ]
    );
    return result;
  }




}