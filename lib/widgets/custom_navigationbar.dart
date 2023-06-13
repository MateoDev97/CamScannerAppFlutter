import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userInterfaceProvider = Provider.of<UserInterfaceProvider>(context);

    return BottomNavigationBar(
      onTap: (index) => userInterfaceProvider.selectedPage = index,
      currentIndex: userInterfaceProvider.selectedPage,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pin_drop),
          label: 'Sites',
        )
      ],
    );
  }
}
