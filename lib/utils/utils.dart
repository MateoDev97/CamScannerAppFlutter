import 'package:flutter/material.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

launchUrlAction(BuildContext context, ScanModel scan) async {
  if (scan.type == 'http') {
    launchUrlString(scan.value);
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
