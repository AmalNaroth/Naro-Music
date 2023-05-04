import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naromusic/ui/main_page/main_screen.dart';
import 'package:naromusic/ui/splash_page/splash_screen.dart';
import 'package:slide_to_act/slide_to_act.dart';

class userscreen extends StatefulWidget {
  userscreen({super.key});

  @override
  State<userscreen> createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  final _usernamecontroller=TextEditingController();
  String? imagepath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey,
            Colors.black
          ]
        ),
        
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Naro Music"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            SizedBox(height: 120,),
            Text("ENTER YOUR NAME",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _usernamecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  labelText: "User name",
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
              child: SlideAction(
                outerColor: Colors.black,
                onSubmit: () {
                  namechecker(_usernamecontroller.text);
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => mainscreen(),), (route) => false);
                },
                text: "Start",
              ),
            ),
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => mainscreen(),));
            }, child: Text("Skip",style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),))
          ],
        ),
      ),
    )
    );
  }
}