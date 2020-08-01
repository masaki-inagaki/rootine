import 'package:flutter/material.dart';
import 'package:ROOTINE/components/overdue.dart';
import 'package:ROOTINE/components/show_list.dart';
//import 'package:ROOTINE/language/app_localizations.dart';

class BottomNavigationModel with ChangeNotifier {
  final List<Widget> options = [
    // Rootine(),
    OverDue(),
    ShowTodoList(),
  ];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void change(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget getSelectedScreen() {
    return options[selectedIndex];
  }

  int getSelectedIndex() {
    return selectedIndex;
  }
}
