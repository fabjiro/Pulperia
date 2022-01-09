import 'package:pulperia/models/ProductGenral.dart';
import 'package:pulperia/models/ProductSpecific.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseData {
  static Database? db;

  initDB() async {
    String documentDirectory = await getDatabasesPath();
    String path = join(documentDirectory, "pulperiaDB.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE "ProductGeneral" (
          "id" TEXT NOT NULL,
          "title"	TEXT NOT NULL
        );
        ''');

        await db.execute('''
          CREATE TABLE "ProductSpecific" (
            "id" TEXT NOT NULL,
            "title"	TEXT NOT NULL,
            "imagen"	TEXT NOT NULL,
            "urlimage" TEXT NOT NULL,
            "idgeneral"	TEXT NOT NULL
          );
        ''');
      },
    );
  }

  inserProduct(dynamic product) async {
    if (product is ProductSpecific) {
      await db!.insert("ProductSpecific", product.toMap());
    } else if (product is ProductGeneral) {
      await db!.insert("ProductGeneral", product.toMap());
    }
  }

  Future<List<ProductSpecific>> getSpecific(String id) async {
    final List<Map<String, Object?>> queryresult = await db!
        .query('ProductSpecific', where: "idGeneral = ?", whereArgs: [id]);
    return queryresult.map((e) => ProductSpecific.fromMap(e)).toList();
  }

  Future<List<ProductGeneral>> getAllGeneral() async {
    final List<Map<String, Object?>> queryResult =
        await db!.query('ProductGeneral');
    return queryResult.map((e) => ProductGeneral.fromMap(e)).toList();
  }

  Future<List<ProductSpecific>> getAllSpecific() async {
    final List<Map<String, Object?>> queryResult =
        await db!.query('ProductSpecific');
    return queryResult.map((e) => ProductSpecific.fromMap(e)).toList();
  }

  closeBaseData() {
    db!.close();
  }
}
