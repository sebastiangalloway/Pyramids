import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/saved_task.dart';
import 'screens/task_screen.dart';
import 'screens/add_task_screen.dart';
import 'models/task_database.dart';
import 'main_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TaskDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SaveTask()),
        Provider(create: (context) => TaskDatabase()), // Non-ChangeNotifier provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //TODO set boolean to false once done with app
      debugShowCheckedModeBanner: true,
      home: MainHomeScreen(),
      theme: ThemeData(
        //TODO add dark/light mode toggle to settings
        brightness: Brightness.light,
        //brightness: SettingsScreen().themeSetting,
      ),

      initialRoute: '/',
      routes: {
        '/task-screen': (_) => const TaskScreen(),
        '/add-task-screen': (_) => AddTask(),
      },
    );
  }
}
