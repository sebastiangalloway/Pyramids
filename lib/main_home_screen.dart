import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/task_screen.dart';
import 'screens/mindfulness_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/battlefield_screen.dart';
import 'screens/settings_screen.dart';

//TODO change naming to navigation bar to make function clearer
class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> widgetOptions =  [
    HomeScreen(),
    TaskScreen(),
    BattlefieldScreen(),
    MindfulnessScreen(),
    ProgressScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Pyramids', style: TextStyle(fontSize: 24)),
      ),
      drawer: Drawer(
        child: SettingsScreen(),
        width: MediaQuery.of(context).size.width,   // Gives the width,
      ),
      /*
      //TODO replace with something useful like energy, level, or goal of the day banner
      appBar: AppBar(
        title: const Text('Pyramids'),
      ),
      */
      //backgroundColor: SettingsScreen().colorSetting,
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_off),
            label: 'Battlefield',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Presence',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Progress',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
