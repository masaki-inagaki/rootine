import 'package:ROOTINE/components/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:ROOTINE/models/bottom_navigation_model.dart';
import 'package:ROOTINE/components/main_bottom_navigation.dart';
import 'package:ROOTINE/components/parts/add_new_task_button.dart';

void main() => runApp(Rootine());

class Rootine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<BottomNavigationModel>(
        create: (context) => BottomNavigationModel(),
      ),
      ChangeNotifierProvider<TaskList>(create: (context) => TaskList()),
    ], child: RootineScreen());
  }
}

class RootineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = context.watch<BottomNavigationModel>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text(bottomNavigationModel.getAppBarTitle()),
          ),
          body: Center(
            child: bottomNavigationModel.getSelectedScreen(),
          ),
          bottomNavigationBar: MainBottomNavigation(),
          drawer: Settings(),
          floatingActionButton: AddNewTaskButton()),
    );
  }
}
