import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../data/task_database.dart';  // Import your TaskDatabase

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.grey
  ];
  bool notification_1 = false;
  bool notification_2 = false;
  bool notification_3 = false;
  bool notification_4 = false;
  bool notification_5 = false;

  onChangeFunction1(bool newValue1) {
    setState(() {
      notification_1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      notification_2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      notification_3 = newValue3;
    });
  }

  onChangeFunction4(bool newValue4) {
    setState(() {
      notification_4 = newValue4;
    });
  }

  onChangeFunction5(bool newValue5) {
    setState(() {
      notification_5 = newValue5;
    });
  }

  Future<void> _launchURL1() async {
    final Uri url = Uri.parse('https://github.com/sebastiangalloway/Pyramids');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
  
  Future<void> _launchURL2() async {
    final Uri url = Uri.parse('https://sgalloway.net');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Color borderColor = themeProvider.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Screen', style: TextStyle(fontSize: 24)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.person, color: themeProvider.accentColor),
                SizedBox(width: 10),
                Text("Account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            buildToggleOption("Face ID", notification_1, onChangeFunction1),
            buildAccountOption(context, "Preferences"),
            buildAccountOption(context, "Language"),
            buildAccountOption(context, "Privacy and Security"),
            SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.palette, color: themeProvider.accentColor),
                SizedBox(width: 10),
                Text("Appearance",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            buildToggleOption("Theme Toggle", themeProvider.isDarkMode, (value) {
              themeProvider.toggleDarkMode();
            }),
            buildAccountOption(context, "Font Size"),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Select Accent Color:", style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8,
                children: colors.map((color) {
                  return GestureDetector(
                    onTap: () {
                      themeProvider.setAccentColor(color);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: themeProvider.accentColor == color
                              ? borderColor
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.volume_up_outlined, color: themeProvider.accentColor),
                SizedBox(width: 10),
                Text("Notifications",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            buildToggleOption("All On / Off", notification_2, onChangeFunction2),
            buildToggleOption("Task Reminders", notification_3, onChangeFunction3),
            buildToggleOption("Mindfulness Reminders", notification_4, onChangeFunction4),
            buildToggleOption("Encouragements", notification_5, onChangeFunction5),
            SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.person, color: themeProvider.accentColor),
                SizedBox(width: 10),
                Text("Extras",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.public),
              title: Text('About',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              onTap: _launchURL1,
            ),
            ListTile(
              leading: Icon(Icons.public),
              title: Text('Meet the Developer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              onTap: _launchURL2,
            ),
            SizedBox(height: 30),
            // Button to reset the pyramid bricks list

            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  Provider.of<TaskDatabase>(context, listen: false).resetBricks();
                },
                child: Text(
                  "RESET PYRAMID BRICKS",
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2.2,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {},
                child: Text(
                  "SIGN IN/OUT",
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2.2,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildToggleOption(
      String title, bool value, void Function(bool) onChangeMethod) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          )),
      trailing: Switch(
        value: value,
        onChanged: (bool newValue) {
          onChangeMethod(newValue);
        },
      ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text(title),
                  content:
                      Column(mainAxisSize: MainAxisSize.min, children: [Text("Option 1"), Text("Option 2")]),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Close"))
                  ]);
            });
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )),
              Icon(Icons.arrow_forward_ios, color: Colors.grey)
            ],
          )),
    );
  }
}