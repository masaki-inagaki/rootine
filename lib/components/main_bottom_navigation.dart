import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/bottom_navigation_model.dart';
import 'package:ROOTINE/components/parts/add_task_dialog.dart';

class MainBottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final bottomNavigationModel = Provider.of<BottomNavigationModel>(context, listen: true);
    final bottomNavigationModel = context.watch<BottomNavigationModel>();
    return Scaffold(
      body: Center(
        child: bottomNavigationModel.getSelectedScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            title: Text('Overdue Tasks'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text('All Tasks'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavigationModel.selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          bottomNavigationModel.change(index);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_box),
        label: const Text('ADD A NEW TASK'),
        onPressed: () {
          //_showNewRootineDialog(context);
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (buildContext) {
              //_showNewRootineDialog(context);
              return AddTaskDialog();
            },
          );
        },
      ),
    );
  }
}
