import 'package:flutter_teamproject_shoes/model/account.dart';
import 'package:flutter_teamproject_shoes/model/branch.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/model/shoes.dart';
import 'package:flutter_teamproject_shoes/model/transfer.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
final DatabaseHandler databaseHandler = DatabaseHandler();

class SHandler{

  // Insert a new pair of shoes
  Future<int> insertShoes(Shoes shoes) async {
    final db = await databaseHandler.initializeDB();
    return await db.insert('shoes', {
      'name': shoes.name,
      'size': shoes.size,
      'color': shoes.color,
      'salesprice': shoes.salesprice,
      'image': shoes.image,
      'logo': shoes.logo,
      'brand': shoes.brand,
    });
  }

  // Fetch all shoes
  Future<List<Shoes>> getShoes() async {
    final db = await databaseHandler.initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('shoes');
    return queryResult.map((e) => Shoes.fromMap(e)).toList();
  }

  // Update an existing pair of shoes
  Future<int> updateShoes(Shoes shoes) async {
    final db = await databaseHandler.initializeDB();
    return await db.update(
      'shoes',
      {
        'name': shoes.name,
        'size': shoes.size,
        'color': shoes.color,
        'salesprice': shoes.salesprice,
        'image': shoes.image,
        'logo': shoes.logo,
        'brand': shoes.brand,
      },
      where: 'id = ?',
      whereArgs: [shoes.id],
    );
  }

  // Delete a pair of shoes by its ID
  Future<void> deleteShoes(int id) async {
    final db = await databaseHandler.initializeDB();
    await db.delete(
      'shoes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CRUD Operations for Account

  // Insert a new account
  Future<int> insertAccount(Account account) async {
    final db = await databaseHandler.initializeDB();
    return await db.insert('account', {
      'name': account.name,
      'phone': account.phone,
      'password': account.password,
    });
  }

  // Fetch all accounts
  Future<List<Account>> getAccounts() async {
    final db = await databaseHandler.initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('account');
    return queryResult.map((e) => Account.fromMap(e)).toList();
  }

  // Update an existing account
  Future<int> updateAccount(Account account) async {
    final db = await databaseHandler.initializeDB();
    return await db.update(
      'account',
      {
        'name': account.name,
        'phone': account.phone,
        'password': account.password,
      },
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }

  // Delete an account by its ID
  Future<void> deleteAccount(int id) async {
    final db = await databaseHandler.initializeDB();
    await db.delete(
      'account',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CRUD Operations for Branch

  // Insert a new branch
  Future<int> insertBranch(Branch branch) async {
    final db = await databaseHandler.initializeDB();
    return await db.insert('branch', {
      'address': branch.address,
    });
  }

  // Fetch all branches
  Future<List<Branch>> getBranches() async {
    final db = await databaseHandler.initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('branch');
    return queryResult.map((e) => Branch.fromMap(e)).toList();
  }

  // Update an existing branch
  Future<int> updateBranch(Branch branch) async {
    final db = await databaseHandler.initializeDB();
    return await db.update(
      'branch',
      {
        'address': branch.address,
      },
      where: 'id = ?',
      whereArgs: [branch.id],
    );
  }

  // Delete a branch by its ID
  Future<void> deleteBranch(int id) async {
    final db = await databaseHandler.initializeDB();
    await db.delete(
      'branch',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CRUD Operations for Purchase

  // Insert a new purchase
  Future<int> insertPurchase(Purchase purchase) async {
    final db = await databaseHandler.initializeDB();
    return await db.insert('purchase', {
      'salesprice': purchase.salesprice,
      'purchasedate': purchase.purchasedate,
      'collectiondate': purchase.collectiondate,
      'collectionstatus': purchase.collectionstatus,
    });
  }

  // Fetch all purchases
  Future<List<Purchase>> getPurchases() async {
    final db = await databaseHandler.initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('purchase');
    return queryResult.map((e) => Purchase.fromMap(e)).toList();
  }

  // Update an existing purchase
  Future<int> updatePurchase(Purchase purchase) async {
    final db = await databaseHandler.initializeDB();
    return await db.update(
      'purchase',
      {
        'salesprice': purchase.salesprice,
        'purchasedate': purchase.purchasedate,
        'collectiondate': purchase.collectiondate,
        'collectionstatus': purchase.collectionstatus,
      },
      where: 'id = ?',
      whereArgs: [purchase.id],
    );
  }

  // Delete a purchase by its ID
  Future<void> deletePurchase(int id) async {
    final db = await databaseHandler.initializeDB();
    await db.delete(
      'purchase',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CRUD Operations for Transfer

  // Insert a new transfer
  Future<int> insertTransfer(Transfer transfer) async {
    final db = await databaseHandler.initializeDB();
    return await db.insert('transfer', {
      'date': transfer.date,
      'collection': transfer.collection,
    });
  }

  // Fetch all transfers
  Future<List<Transfer>> getTransfers() async {
    final db = await databaseHandler.initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('transfer');
    return queryResult.map((e) => Transfer.fromMap(e)).toList();
  }

  // Update an existing transfer
  Future<int> updateTransfer(Transfer transfer) async {
    final db = await databaseHandler.initializeDB();
    return await db.update(
      'transfer',
      {
        'date': transfer.date,
        'collection': transfer.collection,
      },
      where: 'id = ?',
      whereArgs: [transfer.id],
    );
  }

  // Delete a transfer by its ID
  Future<void> deleteTransfer(int id) async {
    final db = await databaseHandler.initializeDB();
    await db.delete(
      'transfer',
      where: 'id = ?',
      whereArgs: [id],
    );
  } 
} 

