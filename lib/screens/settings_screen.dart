import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  //final colorSetting = Colors.white;
  //final themeSetting = brightness.dark,
  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
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
    final Uri url = Uri.parse(
        'https://github.com/sebastiangalloway/Pyramids'); // Replace with your actual link
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> _launchURL2() async {
    final Uri url = Uri.parse(
        'https://sgalloway.net'); // Replace with your actual link
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // ✅ Get instance
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Screen', style: TextStyle(fontSize: 24)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          )
        )
      ),

      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text("Account",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ],
              ),
              Divider(height: 20, thickness: 1),
              SizedBox(height: 10),
              buildAccountOption(context, "Face ID"),
              buildAccountOption(context, "Preferences"),
              buildAccountOption(context, "Language"),
              buildAccountOption(context, "Privacy and Security"),
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(Icons.palette, color: Colors.blue),
                  SizedBox(width: 10),
                  Text("Appearance",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ],
              ),
              Divider(height: 20, thickness: 1),
              SizedBox(height: 10),
              buildToggleOption("Theme Toggle", isDarkMode, (value) {
                setState(() {
                  themeProvider.toggleTheme(value);
                });
              }),
              buildAccountOption(context, "Font Size"),
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(Icons.volume_up_outlined, color: Colors.blue),
                  SizedBox(width: 10),
                  Text("Notifications",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ],
              ),
              Divider(height: 20, thickness: 1),
              SizedBox(height: 10),
              buildToggleOption(
                "All On / Off", notification_2, onChangeFunction2),
              buildToggleOption(
                "Task Reminder Notifications", notification_3, onChangeFunction3),
              buildToggleOption(
                "Mindfulness Notifications", notification_4, onChangeFunction4),
              buildToggleOption(
                "Encouragement Notifications", notification_5, onChangeFunction5),
              SizedBox(height: 30),
                            Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text("Extras",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ],
              ),
              Divider(height: 20, thickness: 1),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.public),
                title: Text('About',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600])),

                onTap: _launchURL1, // Call the function when tapped
              ),
              ListTile(
                leading: Icon(Icons.public),
                title: Text('Meet the Developer',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600])),

                onTap: _launchURL2, // Call the function when tapped
              ),
              SizedBox(height: 30),
              Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                  onPressed: () {},
                  child: Text("SIGN IN/OUT", style: TextStyle(
                    fontSize: 10, 
                    letterSpacing: 2.2, 
                  ),),
                ),
              ),
            ],
          )
          //child: Text('Settings Screen', style: TextStyle(fontSize: 24)),
          ),
    );
  }

Widget buildToggleOption(String title, bool value, void Function(bool) onChangeMethod) {
  return ListTile(
    title: Text(title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      )
    ),
    trailing: Switch(
      value: value,
      activeColor: Colors.blue,
      onChanged: (bool newValue) {
        onChangeMethod(newValue); // ✅ Calls the provided function
      },
    ),
  );
}

  GestureDetector buildAccountOption(BuildContext context, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text(title),
                  content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Text("Option 1"), Text("Option 2")]),
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
                    color: Colors.grey[600])
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey)
            ],
          )),
    );
  }
}
