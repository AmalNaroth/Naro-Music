import 'dart:async';
import 'package:flutter/material.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/ui/main_page/main_screen.dart';
import 'package:naromusic/ui/username_page/userscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState(){
    Timer(Duration(seconds: 3), () {
      checkpermission();
      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => userscreen(),), (route) => false);
      skipname();
      addname();
    // AllsongsdatashowList();
    });
    
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(child:
    Center(child: Image.asset('assets/images/Naro logo.png',height: 200,))
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

   Future<void>skipname()async{
    final SharedPreferences check=await SharedPreferences.getInstance();
    final checkvalue=check.getBool("Save_value");
    if(checkvalue==true){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => mainscreen(),));
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => userscreen()));
    }
  }
  Future<void>addname()async{
    final SharedPreferences add=await SharedPreferences.getInstance();
    final addvalue=add.getString("Save_Name");
    if(addvalue!=null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => mainscreen(),));
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => userscreen()));
    }
  }
}
Future<void>skipchacker()async{
    final Sharedpref= await SharedPreferences.getInstance();
    Sharedpref.setBool("Save_value", true);
  }

  Future<void>namechecker(String username)async{
    final Sharedprefs= await SharedPreferences.getInstance();
    Sharedprefs.setString("Save_Name", username);
  }