import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/task_screen.dart';
import 'providers/theme_provider.dart';
import 'screens/add_task_screen.dart';
import 'models/task_database.dart';
import 'main_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TaskDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskDatabase()),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider()), // Non-ChangeNotifier provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // ✅ Get instance

    return MaterialApp(
      //TODO set boolean to false once done with app
      debugShowCheckedModeBanner: true,
      home: MainHomeScreen(),
      themeMode: themeProvider.themeMode, // ✅ Use the provider
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      initialRoute: '/',
      routes: {
        '/task-screen': (_) => const TaskScreen(),
        '/add-task-screen': (_) => AddTask(),
      },
    );
  }
}
