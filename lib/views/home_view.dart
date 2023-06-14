import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/pages/pages.dart';
import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/providers/ui_provider.dart';
import 'package:qr_reader_app/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
                  .deleteAllScans();
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _HomeBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userInterfaceProvider = Provider.of<UserInterfaceProvider>(context);
    final scansProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch (userInterfaceProvider.selectedPage) {
      case 0:
        scansProvider.loadScansByType('geo');
        return const MapsPage();
      case 1:
        scansProvider.loadScansByType('http');
        return const SitesPage();
      default:
        scansProvider.loadScansByType('geo');
        return const MapsPage();
    }
  }
}
