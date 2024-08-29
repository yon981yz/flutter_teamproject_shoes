import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler{
  
    Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "kiosk.db"),
      onCreate: (db, version) async{
        await db.execute(
          """
          create table address
          (
          id integer primary key autoincrement,
          name text,
          size int,
          color text,
          salseprice int,
          receiptdate date
          )
          """
        );
        await db.execute("""
          CREATE TABLE account (
            id text PRIMARY KEY,
            name TEXT,
            phone TEXT,
            password TEXT
          )
        """);
        await db.execute("""
          CREATE TABLE branch (
            id integer primary key autoincrement,
            name TEXT
          )
        """);
        await db.execute("""
          CREATE TABLE purchase (
            id text PRIMARY KEY,
            account_id text PRIMARY KEY,
            shoes_id integer PRIMARY KEY,
            branch_id integer PRIMARY KEY,
            salesprice text,
            purchasedate Date,
            collectiondate Date,
            collectionstatus text
          )
        """);
        await db.execute("""
          CREATE TABLE transfer (
            id integer primary key autoincrement,
            shoes_id text PRIMARY KEY,
            branch_id TEXT PRIMARY KEY,
            date Date
            collectionstatus text
          )
        """);
      },
      version: 1
    );
  }

}