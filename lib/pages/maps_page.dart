import 'package:flutter/material.dart';
import 'package:qr_reader_app/widgets/widgets.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanTileWidget(type: 'geo');
  }
}
