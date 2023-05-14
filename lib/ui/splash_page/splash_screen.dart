import 'dart:async';
import 'package:flutter/material.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:naromusic/ui/bottom_navbarroot/bottomNavBar.dart';
import 'package:naromusic/ui/username_page/userscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  //value getting to sharedPreferences
  Future<void>addname()async{
    final SharedPreferences add=await SharedPreferences.getInstance();
    final addvalue=add.getString("Save_Name");
    if(addvalue!=null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => mainscreen(),));
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => userscreen(onAddUserName: namechecker,)));
    }
  }

  //value adding to share preference
  Future<void>namechecker(String username)async{
    final Sharedprefs= await SharedPreferences.getInstance();
    Sharedprefs.setString("Save_Name", username);
  }

  @override
  void initState(){
    Timer(Duration(seconds: 3), () {
      checkpermission();
      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => userscreen(),), (route) => false);
      addname();
    // AllsongsdatashowList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Center(child: Image.asset('assets/images/Naro logo.png',height: 200,))
    );
  }

  
}

  