// only drawer
import 'package:flutter/material.dart';
import 'package:naromusic/ui/showdialogs/privacy_dialoge.dart';

class drawerlist extends StatefulWidget {
  const drawerlist({super.key});

  @override
  State<drawerlist> createState() => _drawerlistState();
}

class _drawerlistState extends State<drawerlist> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(accountName: Text("Amal"), accountEmail: Text("Amalzenox@129"),
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
              // showDialog(context: context, builder: (context) {
              //   return privacydialoge(mdFileName:"privacy_policy.md");
              // },
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text("Privacy and Policy"),
            onTap: (){},
          )
        ],
      ),
      
    );
  }
} //**drwer */