import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanFloatingButton extends StatelessWidget {
  const ScanFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancel', false, ScanMode.QR);
        print(barcodeScanRes);
      },
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
