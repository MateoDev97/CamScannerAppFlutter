import 'package:flutter/material.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:qr_reader_app/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String typeSelected = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScanModel = ScanModel(value: value);

    await DataBaseProvider.db.newScan(newScanModel);

    loadScansByType(typeSelected);

    return newScanModel;
  }

  loadScansByType(String type) async {
    scans = await DataBaseProvider.db.getScansByType(type);
    typeSelected = type;
    notifyListeners();
  }

  deleteAllScans() async {
    await DataBaseProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteById(int id) async {
    await DataBaseProvider.db.deleteScan(id);
  }
}
