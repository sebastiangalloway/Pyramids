import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/save_task_model.dart';
import 'screens/task_screen.dart';
import 'screens/add_task_screen.dart';


import 'main_home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SaveTask(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainHomeScreen(),
      theme: ThemeData(
        //TODO add dark/light mode toggle to settings
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        '/task-screen': (_) => const TaskScreen(),
        '/add-task-screen': (_) => AddTask(),
      },
    );
  }
}
