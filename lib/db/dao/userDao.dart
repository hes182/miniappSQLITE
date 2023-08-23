import 'package:minigojec/db/db.dart';
import 'package:minigojec/model/dao/userlogin.dart';
import '../../model/dao/mdl_sendbarang.dart';
import '../../model/dao/user.dart';

class UserDao {
  final dbHelper = DBHelper.dbHelper;

  Future<dynamic> insertUser(User user) async {
    final db = await dbHelper.database;
    await db!.delete(tableUser);
    return await db.insert(tableUserNew, user.toJson());
  }

  Future<dynamic> deleteUser() async {
    final db = await dbHelper.database;
    return await db!.delete(tableUserNew);
  }

  Future<bool> checkUser() async {
    try {
      final db = await dbHelper.database;
      List<Map> user = await db!.query(tableUserNew, limit: 1);
      
      return user.isEmpty ? false : true;
    } catch (e) {
      return false;
    }
  }

  Future getUser() async {
    final db = await dbHelper.database;
    final List<Map> user = await db!.query(tableUserNew);

      if (user.length > 0 || user.isNotEmpty){
        return User(
          id: user[0]['id'],
          userName: user[0]['userName'],
          userIdent: user[0]['userIdent'],
          userPass: user[0]['userPass'],
          pathFile: user[0]['userFoto'],
        );
      }
      return null;
  }

   Future<dynamic> insertUserLogin(UserLogin user) async {
    final db = await dbHelper.database;
    await db!.delete(tableLogin);
    return await db.insert(tableLogin, user.toJson());
  }

Future<dynamic> deleteUserLog() async {
    final db = await dbHelper.database;
    return await db!.delete(tableLogin);
  }

  Future<bool> checkUserLog() async {
    try {
      final db = await dbHelper.database;
      List<Map> user = await db!.query(tableLogin, limit: 1);

      return !user.isEmpty || user.length > 0 ? true : false;
    } catch (e) {
      return false;
    }
  }

Future<dynamic> insertDataBarang(MdlSendBarang barang) async {
    final db = await dbHelper.database;
    await db!.delete(tableBarangNew);
    return await db.insert(tableBarangNew, barang.toJson());
  }

  Future<dynamic> deleteDataBarang() async {
    final db = await dbHelper.database;
    return await db!.delete(tableBarangNew);
  }

  Future<bool> checkDataBarang() async {
    try {
      final db = await dbHelper.database;
      List<Map> barang = await db!.query(tableBarangNew, limit: 1);
      
      return barang.isEmpty ? false : true;
    } catch (e) {
      return false;
    }
  }

  Future getDataBarang() async {
    final db = await dbHelper.database;
    final List<Map> barang = await db!.query(tableBarangNew);

      if (barang.length > 0 || barang.isNotEmpty){
        
        return MdlSendBarang(
          barangName: barang[0]['barangName'],
          longA: barang[0]['barangLongA'],
          longB: barang[0]['barangLongB'],
          latA: barang[0]['barangLatA'],
          latB: barang[0]['barangLatB'],
          jarak: barang[0]['barangJarak'],
          barangFoto: barang[0]['barangFoto'],
          tanggal: barang[0]["barangTanggal"],
        );
      }
      return null;
  }
  

}