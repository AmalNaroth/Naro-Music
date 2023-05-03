

import 'package:flutter/material.dart';

class settings_screen extends StatefulWidget {
  const settings_screen({super.key});

  @override
  State<settings_screen> createState() => _settings_screenState();
}

List<String> SettingsName = [
  "About",
  "Share",
  "Notification",
  "Terms And Conditions",
  "Privacy & Policy"
];
List<IconData> SettingsIcon = [
  Icons.person_outline_outlined,
  Icons.share_outlined,
  Icons.notifications_outlined,
  Icons.article_outlined,
  Icons.privacy_tip_outlined,
];

List<String> SettingsText=[
  '''Naro Music is an offline music player
  app which allows use to hear music from their local storage
  and also do functions like add to favorites, create playlists,
  recently played, mostly played
  etc.
  
  App developed by Amal N''',
  
];

class _settings_screenState extends State<settings_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.black,
        actions: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/images/dq.jpg"),
              ),
              SizedBox(
                width: 10,
              ),
              Text("Amal Naroth")
            ],
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(SettingsIcon[index]),
              backgroundColor: Colors.black,
            ),
            title: Text(SettingsName[index]),
            trailing: index == 2
                ? IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_forward_rounded))
                : Text(""),
            onTap: () {
              showDialog(
                context: context,
                builder: (context1) {
                  return AlertDialog(
                    title: Text("About"),
                    content: Text("Do you want to"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context1).pop();
                          }, child: Text("Close"))
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
