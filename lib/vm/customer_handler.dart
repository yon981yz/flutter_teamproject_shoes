import 'dart:typed_data';

import 'package:flutter_teamproject_shoes/model/PurchaseComplete.dart';
import 'package:flutter_teamproject_shoes/model/account.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/model/shoes.dart';
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

///// 신발 이미지로 정렬 (고객 구매 페이지 디스플레이) 

Future<List<Shoes>> queryShoesHome() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes group by image');
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

// 동일 이미지별 신발 사이즈 불러오기
Future<List<int>> queryShoesSize(Uint8List image) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select size from shoes where image=?',
      [image]);
      return queryResult.map((e) => e['size'] as int).toList();
  }
// Dropdown에서 사이즈 선택된 상품으로 받아오기 
  Future<List<Shoes>> querySelectshoe(Uint8List image, int size) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select *from shoes where image=? and size=?',
      [image, size]);
      return queryResult.map((e) => Shoes.fromMap(e)).toList();  
  }

///// 신발 이미지로 정렬한상태에서 이름으로 검색 (고객 구매 페이지 디스플레이에서 검색)

Future<List<Shoes>> queryShoesHomeSearch(String name) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where name like ? group by image',
      ['%$name%']);
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }
  
///// 신발 이미지로 정렬한상태에서 이름으로 검색 (고객 구매 페이지 디스플레이에서 검색) 
//int로?
Future<List<Shoes>> queryShoesHomeSelect(int size) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where size =? group by image',
      [size]);
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

///// 브랜드이름 Nike 이름으로 정렬 (고객 구매 페이지 브랜드별 디스플레이) 

Future<List<Shoes>> queryNike() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where brand = "Nike" group by image');
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

Future<List<Shoes>> queryBrandSearch(String brand, String name) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where brand = ? and name like ? group by image',
      [brand, '%$name%']);
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

///// 브랜드이름 NewBalance 이름으로 정렬 (고객 구매 페이지 브랜드별 디스플레이) 

Future<List<Shoes>> queryNewBalance() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where brand = "NewBalance" group by image');
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

///// 브랜드이름 ProSpecs 이름으로 정렬 (고객 구매 페이지 브랜드별 디스플레이) 

Future<List<Shoes>> queryProSpecs() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where brand = "ProSpecs" group by image');
      return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

///// 브랜드이름 Nike 이름으로 정렬한table에서 이름검색 (브랜트별 페이지에서 검색) 

Future<List<Shoes>> queryNikeSearch(String name) async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('select * from shoes where brand = "Nike" and name like ? group by image',
      ['%$name%']);
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
      insert into purchase(id, account_id, shoes_id, branch_id, salesprice, purchasedate, collectiondate, collectionstatus)
      values (?,?,?,?,?,?,?,?)
      """, [
        purchase.id,
        purchase.accountid,
        purchase.shoesid,
        purchase.branchid,
        purchase.salesprice,
        purchase.purchasedate,
        purchase.collectiondate,
        purchase.collectionstatus
      ]
    );
    return result;
  }

  // 구매상품확인
  Future<List<PurchaseComplete>> queryuserpurchase() async{
    final Database db = await databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult =
      await db.rawQuery('''
        select p.id, b.name
        from branch b, purchase p 
        where b.id=p.branch_id
        ''');
        print(queryResult);
      return queryResult.map((e) => PurchaseComplete.fromMap(e)).toList();
  }


}
