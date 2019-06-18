import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:s9_qrscannerapp/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  initDB() async {
//path donde se encuentra la misma
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

//se une la ruta y el nombre  que va a tener la db
    final path = join(documentsDirectory.path, "ScansDB.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      //aqui ya esta lista y creada mi bd
      await db.execute('CREATE TABLE Scans('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')');
    });
  }

  //CREAR REGISTROS DB

  //METODO TRADICIONAL

  nuevoScanRaw(ScanModel scanModel) async {
    final db = await database;

    final res = await db.rawInsert("INSERT Into Scans(id,tipo,valor)"
        "VALUES(${scanModel.id}) '${scanModel.tipo}' ${scanModel.valor} ");

    return res;
  }

  //metodo recortado de inserción.
  nuevoScan(ScanModel scanModel) async {
    final db = await database;

    final res = await db.insert("Scans", scanModel.toJson());

    return res;
  }

  //REGRESAR DATA (SELECT)
//regresa la data por id
  Future<ScanModel> getScanId(int id) async {
    final db = await database;
    final res = await db.query("Scans", where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

//regresa todos los scans
  Future<List<ScanModel>> getTodosScans() async {
    final db = await database;
    final scans = await db.query("Scans");

    List<ScanModel> scansresp = scans.isNotEmpty
        ? scans.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];

    return scansresp;
  }

//regresa la lista de los que son por mapa y los que son urls
  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    final scans = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo'");

    List<ScanModel> scansresp = scans.isNotEmpty
        ? scans.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];

    return scansresp;
  }

//Actualizar registros

  Future<int> updateScan(ScanModel scanModel) async {
    final db = await database;

    final res = await db.update("Scans", scanModel.toJson(),
        where: "id = ?", whereArgs: [scanModel.id]);

    return res;
  }

//Eliminar registro por id
  Future<int> deleteScan(int id) async {
    final db = await database;

    final res = await db.delete("Scans", where: "id=?", whereArgs: [id]);

    return res;
  }

//Eliminar todos los registros
  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete("DELETE FROM Scans");
    return res;
  }
}
