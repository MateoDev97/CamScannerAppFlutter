import 'package:flutter/material.dart';

class UserInterfaceProvider extends ChangeNotifier {
  int _selectedPage = 0;

  int get selectedPage {
    return _selectedPage;
  }

  set selectedPage(int index) {
    _selectedPage = index;
    notifyListeners();
  }
}
