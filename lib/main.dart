import 'package:ROOTINE/components/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ROOTINE/models/task_list.dart';
import 'package:ROOTINE/models/bottom_navigation_model.dart';
import 'package:ROOTINE/models/scoped_variable.dart';
import 'package:ROOTINE/models/settings_list.dart';
import 'package:ROOTINE/components/main_bottom_navigation.dart';
import 'package:ROOTINE/components/parts/add_new_task_button.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ROOTINE/language/app_localizations_delegate.dart';
import 'package:ROOTINE/components/parts/appbar.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(RootineProvider());

class RootineProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<BottomNavigationModel>(
        create: (context) => BottomNavigationModel(),
      ),
      ChangeNotifierProvider<TaskList>(create: (context) => TaskList()),
      ChangeNotifierProvider<SettingsList>(create: (context) => SettingsList()),
    ], child: RootineScopedModel());
  }
}

class RootineScopedModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScopedVariableModel _model = ScopedVariableModel();
    return ScopedModel<ScopedVariableModel>(
      model: _model,
      child: RootineScreen(),
    );
  }
}

class RootineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = context.watch<BottomNavigationModel>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        const AppLocalDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ja', ''),
      ],
      home: Scaffold(
          appBar: AppBar(
            title: AppBarTitle(i: bottomNavigationModel.getSelectedIndex()),
          ),
          body: Center(
            child: bottomNavigationModel.getSelectedScreen(),
          ),
          bottomNavigationBar: MainBottomNavigation(),
          drawer: SizedBox(width: 220, child: SettingsScreen()),
          floatingActionButton: AddNewTaskButton()),
    );
  }
}
