import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'components/AppStateNotifier.dart';
import 'screens/TasksListScreen.dart';
import 'theme.dart';

void main() {
  //await GetStorage.init();
  runApp(ChangeNotifierProvider<AppStateNotifier>(
    create: (context) => AppStateNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Consumer<AppStateNotifier>(
      builder: (context, appState, child) {
        return MaterialApp(
          theme: ThemeColors.lightTheme,
          darkTheme: ThemeColors.darkTheme,
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: TasksListScreen(),
        );
      },
    );
  }
}
