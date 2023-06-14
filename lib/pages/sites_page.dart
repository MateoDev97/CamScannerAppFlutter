import 'package:flutter/material.dart';
import 'package:qr_reader_app/widgets/widgets.dart';

class SitesPage extends StatelessWidget {
  const SitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanTileWidget(type: 'http');
  }
}
