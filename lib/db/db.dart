import 'dart:io';
import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


const tableUser = "UserTable";
const tableBarang = "BarangTable";
const tableFoto = "FotoTable";
const tableLogin = "Logintable";
const tableBarangNew = "BarangTableNew";
const tableUserNew = "UserNewTable";

class DBHelper {
  static const columnUserName = "userName";
  static const columnNoident = "userIdent";
  static const columnPass = "userPass";

  static const columnUserFot = "userFoto";

  static const columnNamaBarang = "barangName";
  static const columnFotoBarang = "barangFoto";
  static const columnLokasiA = "barangLokA";
  static const columnLokasiB = "barangLokB";
  static const columnTanggal = "barangTanggal";

  static const columnUserLogin = "usLogin";

  static const columnLongA = "barangLongA";
  static const columnLatA = "barangLatA";
  static const columLongB = "barangLongB";
  static const columnLatB = "barangLatB";
  static const columnJarak = "barangJarak";

  static final DBHelper dbHelper = DBHelper();
  
  Database? db;

  Future<Database?> get database async{
    if (db != null) return db;

    db = await createDatabase();
    return db;
  }

  createDatabase() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();

    String path = join(docDirectory.path, "dbfile.db");
    var database = await openDatabase(path,
    version: 4,
    onCreate: initDB,
    onUpgrade: onUpgrade);
    
    return database;
  }

  Future<void> initDB(Database db, int version) async {
    await db.execute("CREATE table $tableUser ("
      "id INTEGER PRIMARY KEY, "
      "$columnUserName TEXT, "
      "$columnNoident TEXT, "
      "$columnPass TEXT"
    ")");

    await db.execute("CREATE table $tableFoto ("
      "id INTEGER PRIMARY KEY, "
      "$columnUserFot"
    ")");

    await db.execute("CREATE table $tableBarang ("
      "id INTEGER PRIMARY KEY ,"
      "$columnNamaBarang TEXT, "
      "$columnLokasiA TEXT, "
      "$columnLokasiB TEXT, "
      "$columnFotoBarang TEXT, "
      "$columnTanggal TEXT"
    ")"); 

    await db.execute("CREATE table $tableLogin ("
    "id INTEGER PRIMARY KEY, "
    "$columnUserLogin TEXT"
    ")");

    await db.execute("CREATE table $tableBarangNew ("
      "id INTEGER PRIMARY KEY, "
      "$columnNamaBarang TEXT, "
      "$columnLatA TEXT, "
      "$columnLongA TEXT, "
      "$columnLatB TEXT, "
      "$columLongB TEXT, "
      "$columnJarak TEXT, "
      "$columnFotoBarang TEXT, "
      "$columnTanggal TEXT"
    ")");
  
   await db.execute("CREATE table $tableUserNew ("
      "id INTEGER PRIMARY KEY, "
      "$columnUserName TEXT, "
      "$columnNoident TEXT, "
      "$columnPass TEXT, "
      "$columnUserFot TEXT"
    ")");
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {}
  }

}
