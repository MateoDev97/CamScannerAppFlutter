import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider {
  static Database? _database;

  static final db = DataBaseProvider._();

  DataBaseProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDataBase();

    return _database;
  }

  Future<Database> initDataBase() async {
    //Database path
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'scansDataBase.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
      ''');
    });
  }

  Future<int> newScan(ScanModel model) async {
    final db = await database;

    final res = await db!.insert('Scans', model.toJson());

    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isEmpty ? null : ScanModel.fromJson(res.first);
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db!.query('Scans');

    return res.isEmpty
        ? []
        : res.map((s) => ScanModel.fromJson(s)).toList();
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final res = await db!.query('Scans', where: 'type = ?', whereArgs: [type]);
  
    return res.isEmpty
        ? []
        : res.map((s) => ScanModel.fromJson(s)).toList();
  }

  Future<int> updateScan(ScanModel model) async {
    final db = await database;

    final res = await db!.update('Scans', model.toJson(),
        where: 'id = ?', whereArgs: [model.id]);

    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;

    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;

    final res = await db!.delete('Scans');

    return res;
  }
}
