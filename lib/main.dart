import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:ROOTINE/models/bottom_navigation_model.dart';
import 'package:ROOTINE/config/const_text.dart';
import 'package:ROOTINE/components/main_bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationModel>(
          create: (context) => BottomNavigationModel(),
        ),
        //ChangeNotifierProvider(
        ChangeNotifierProvider<TaskList>(create: (context) => TaskList()),
      ],
      child: MaterialApp(
        title: ConstText.appTitle,
        //home: Rootine(),
        home: MainBottomNavigation(),
      ),
    );
  }
}
