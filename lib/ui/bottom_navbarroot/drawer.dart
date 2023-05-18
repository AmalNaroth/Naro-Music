// only drawer
import 'package:flutter/material.dart';
import 'package:naromusic/ui/showdialogs/privacy_dialoge.dart';
import 'package:shared_preferences/shared_preferences.dart';

class drawerlist extends StatefulWidget {
  drawerlist({super.key});

  @override
  State<drawerlist> createState() => _drawerlistState();
}

class _drawerlistState extends State<drawerlist> {
  String? savedName;
  //sharedpreference
  Future<void> username() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = sharedPrefs.getString('Save_Name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(accountName: Text((savedName==null)?savedName.toString():"UserName"), accountEmail: Text("Amalzenox@129"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage("assets/images/dq.jpg"),
          ),
          decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(image: AssetImage("assets/images/bgimage2.jpg",),fit: BoxFit.cover)
          ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("About"),
            onTap: (){
                showAboutDialog(
                    context: context,
                    applicationName: "NARO MUSIC",
                    applicationIcon: Image.asset(
                      "assets/images/Naro logo.png",
                      height: 32,
                      width: 32,
                    ),
                    applicationVersion: "1.0.1",
                    children: [
                      const Text(
                          "NARO MUSIC is an offline music player app which allows use to hear music from their local storage and also do functions like add to favorites , create playlists , recently played , mostly played etc."),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("App developed by Amal N.")
                    ]);
              leading: const Icon(
                Icons.person,
                size: 35,
                color: Colors.white,
              );
              title: const Text(
                "About",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                    fontSize: 18),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notificaton"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.rule),
            title: Text("Terms and Conditions"),
            onTap: (){
               showDialog(context: context, builder: (context) {
                return privacydialoge(mdFileName:"terms_and_conditions.md");
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text("Privacy and Policy"),
            onTap: (){
              showDialog(context: context, builder: (context) {
                return privacydialoge(mdFileName:"privacy_policy.md");
              },
              );
            },
          )
        ],
      ),
      
    );
  }
} //**drwer */