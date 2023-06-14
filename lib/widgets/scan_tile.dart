import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/utils/utils.dart';

class ScanTileWidget extends StatelessWidget {
  const ScanTileWidget({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final scansProvider = Provider.of<ScanListProvider>(context);
    scansProvider.typeSelected = type;

    if (scansProvider.scans.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              (type == 'http')
                  ? Icons.link_off_sharp
                  : Icons.location_off_rounded,
              size: 70,
              color: Colors.grey,
            ),
            const Text('No Records'),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: scansProvider.scans.length,
      itemBuilder: (context, index) => Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .deleteById(scansProvider.scans[index].id ?? 0);
        },
        child: ListTile(
          leading: Icon(
            (type == 'http') ? Icons.link_outlined : Icons.map_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scansProvider.scans[index].value),
          subtitle: Text(scansProvider.scans[index].id.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () async {
            launchUrlAction(context, scansProvider.scans[index]);
          },
        ),
      ),
    );
  }
}
