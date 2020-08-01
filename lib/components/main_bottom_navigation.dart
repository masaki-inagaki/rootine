import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/bottom_navigation_model.dart';
import 'package:ROOTINE/components/parts/appbar.dart';

class MainBottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = context.watch<BottomNavigationModel>();
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.check), title: AppBarTitle(i: 0)),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list),
          title: AppBarTitle(i: 1),
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: bottomNavigationModel.selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        bottomNavigationModel.change(index);
      },
    );
  }
}
