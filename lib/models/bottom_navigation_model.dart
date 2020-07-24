import 'package:flutter/material.dart';
import 'package:ROOTINE/components/overdue.dart';
import 'package:ROOTINE/components/show_list.dart';

class BottomNavigationModel with ChangeNotifier {
  final List<Widget> options = [
    // Rootine(),
    OverDue(),
    ShowTodoList(),
  ];

  final List<String> appBarTitle = [
    "Todo: Now",
    "All Tasks",
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

  String getAppBarTitle() {
    return appBarTitle[selectedIndex];
  }
}
