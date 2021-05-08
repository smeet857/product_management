import 'package:path/path.dart';
import 'package:product_management/model/product_model.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseService {
  static Database db;
  static String _tableName = 'products';

  static Future<void> openDb() async {
    var _path = join(await getDatabasesPath(), 'products.db');
    db = await openDatabase(
        _path,
      onCreate: (_db, version) {
        // Run the CREATE TABLE statement on the database.
        return _db.execute(
          "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, name TEXT, description TEXT, price TEXT, quantity TEXT, image TEXT)",
        );
      },
      version: 1
    );
  }

  static Future<void> insertProduct(ProductModel productModel) async {
    await db.insert(
      _tableName,
      productModel.toMap(),
    );
  }

  static Future<List<ProductModel>> getProducts() async {

    try{
      var maps = await db.query(_tableName);
      print('map: ${maps.toString()}');
      List<ProductModel> _list = [];
      if(maps.length > 0) {
        await Future.forEach(maps, (element) {
          print("have");
          _list.add(ProductModel(
            id: element['id'],
            name: element['name'],
            description: element['description'],
            price: element['price'],
            quantity: element['quantity'],
            imgPath: element['image'],
          ));
        });
      }
      return _list;
    }catch(error){
      print('Error : $error');
      return null;
    }
  }

  static Future<void> updateProducts(ProductModel productModel) async {
    print('id : ${productModel.id}');
    try{
      var _result = await db.update(
        _tableName,
        productModel.toMap(),
        where: "id = ?",
        whereArgs: [productModel.id],
      );
      print('result == $_result');
    }catch(error){
      print('error on updating : $error');
    }
  }

  static Future<void> deleteProducts(int id) async {
    await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> dispose ()async{
    await db.close();
  }
}
