
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

import 'dart:io' as io;

import '../models/cart_model.dart';

 class SqliteDBHelper{

   static sql.Database? _db;

   Future<sql.Database?> get db async{
     if(_db != null){
       // await _db!.delete('cart');
       return _db!;
     }
     _db = await initDatabase();
     return null;
   }

   initDatabase() async{
     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
     String path = join(documentDirectory.path,'cart.db');
     var db = await sql.openDatabase(path, version: 1, onCreate: _onCreate);
     return db;
   }

   _onCreate(sql.Database db, int version) async{
     await db.execute(
       "CREATE TABLE IF NOT EXISTS cart (id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE, productName TEXT, initialPrice INTEGER, productPrice INTEGER, quantity INTEGER, image TEXT)"
     );
   }

   Future<dynamic> insert(Cart cart)async{
     var dbClient = await db;
     await dbClient?.insert('cart', cart.toMap(), conflictAlgorithm: sql.ConflictAlgorithm.replace); // Explanation Needed whereas I used primary key!!
      Get.snackbar("Product added to the cart", "");
     return cart;
     }

     Future<List<Cart>> getCartList() async{
       var dbClient = await db;
       final List<Map<String, Object?>> queryResult = await dbClient!.query('cart');
       return queryResult.map((e) => Cart.fromMap(e)).toList();
     }
 }