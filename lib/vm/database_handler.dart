import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler{
  
    Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "shoes_store.db"),
      onCreate: (db, version) async{
        
        // shoes

        await db.execute(
          """
          create table shoes
          (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            size INTEGER,
            color TEXT,
            salesprice INTEGER,
            image BLOB,
            logo BLOB,
            brand TEXT
          )
          """
        );

        // Account

        await db.execute("""
          CREATE TABLE account (
            id text PRIMARY KEY,
            name TEXT,
            phone TEXT,
            password TEXT
          )
        """);

        // branch

        await db.execute("""
          CREATE TABLE branch (
            id integer primary key autoincrement,
            name TEXT
          )
        """);

        // purchase

        await db.execute("""
          CREATE TABLE purchase (
            id TEXT PRIMARY KEY,
            account_id TEXT,
            shoes_id INTEGER,
            branch_id INTEGER,
            salesprice TEXT,
            purchasedate DATE,
            collectiondate DATE,
            collectionstatus TEXT,
            FOREIGN KEY(account_id) REFERENCES user_account(id),
            FOREIGN KEY(shoes_id) REFERENCES account(id),
            FOREIGN KEY(branch_id) REFERENCES branch(id)
          )
        """);

        // Account

        await db.execute("""
          CREATE TABLE transfer (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            shoes_id INTEGER,
            branch_id TEXT,
            date DATE,
            collectionstatus TEXT,
            FOREIGN KEY(shoes_id) REFERENCES account(id),
            FOREIGN KEY(branch_id) REFERENCES branch(id)
          )
        """);
      },
      version: 1
    );
  }

}