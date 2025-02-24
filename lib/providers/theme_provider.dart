import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  Color _accentColor = Colors.blue; // Default accent color

  bool get isDarkMode => _isDarkMode;
  Color get accentColor => _accentColor;

  ThemeProvider() {
    Future.microtask(() => _loadSettings());
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    int? colorValue = prefs.getInt('accentColor');
    if (colorValue != null) {
      _accentColor = Color(colorValue);
    }
    notifyListeners(); // Notify UI when values are loaded
  }

  // Toggle Dark Mode
  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners(); // Ensure UI updates
  }

  // Change Accent Color
  Future<void> setAccentColor(Color color) async {
    _accentColor = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accentColor', color.value);
    notifyListeners(); // Notify UI of changes
  }
}
