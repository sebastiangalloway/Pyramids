import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Scaffold(
      appBar: AppBar(
          title: Text('Settings Screen', style: TextStyle(fontSize: 24)),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ))),
      //backgroundColor: colorSetting,
      //brightness: themeSetting,

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
                  Icon(Icons.volume_up_outlined, color: Colors.blue),
                  SizedBox(width: 10),
                  Text("Appearance",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ],
              ),
              Divider(height: 20, thickness: 1),
              SizedBox(height: 10),
              buildNotificationOptions(
                  "Theme Toggle", notification_1, onChangeFunction1),
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
              buildNotificationOptions(
                "On / Off", notification_2, onChangeFunction2),
              buildNotificationOptions(
                "Task Notifications", notification_3, onChangeFunction3),
              buildNotificationOptions(
                "Mindfulness Notifications", notification_4, onChangeFunction4),
              buildNotificationOptions(
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
                leading: Icon(Icons.info),
                title: Text('About',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600])),

                onTap: _launchURL1, // Call the function when tapped
              ),
              ListTile(
                leading: Icon(Icons.info),
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
                  child: Text("SIGN OUT", style: TextStyle(
                    fontSize: 10, 
                    letterSpacing: 2.2, 
                    color: Colors.black
                  ),),
                ),
              ),
            ],
          )
          //child: Text('Settings Screen', style: TextStyle(fontSize: 24)),
          ),
    );
  }

  Padding buildNotificationOptions(
      String title, bool value, Function onChangeMedthod) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600])),
            Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                    activeTrackColor: Colors.blue,
                    inactiveThumbColor: Colors.grey,
                    value: value,
                    onChanged: (bool newValue) {
                      onChangeMedthod(newValue);
                    }))
          ],
        ));
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
