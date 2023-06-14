import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/utils/utils.dart';

class ScanFloatingButton extends StatelessWidget {
  const ScanFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scansProvider = Provider.of<ScanListProvider>(context, listen: false);

    launchCustomUrl(ScanModel newScan) {
      launchUrlAction(context, newScan);
    }

    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancel', false, ScanMode.QR);

        if (barcodeScanRes == "-1") {
          return;
        }

        final newScan = await scansProvider.newScan(barcodeScanRes);
        launchCustomUrl(newScan);
      },
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
