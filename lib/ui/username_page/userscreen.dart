
import 'package:flutter/material.dart';
import 'package:naromusic/ui/bottom_navbarroot/bottomNavBar.dart';
import 'package:naromusic/widgets/allwidget.dart';
import 'package:slide_to_act/slide_to_act.dart';

class userscreen extends StatefulWidget {
  userscreen({super.key, required this.onAddUserName});
    final void Function(String username) onAddUserName;

  @override
  State<userscreen> createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  final _usernamecontroller=TextEditingController();
  String? imagepath;
  final _formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255)
          ]
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false, 
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        title: Text("N A R O M U S I C"),
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
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _usernamecontroller,
                  decoration: InputDecoration(
                    focusColor: Colors.grey,
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    labelText: "User name",
                  ),
                  validator: (value) {
                    if(value==null||value.isEmpty){
                      return "Enter your name";
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
              child: SlideAction(
                outerColor: Color.fromARGB(255, 227, 227, 227),
                onSubmit: () {
                  if(_formkey.currentState!.validate()){
                     widget.onAddUserName(_usernamecontroller.text);
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => mainscreen(),), (route) => false);
                  }
                },
                text: "Start",
              )
            ),
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => mainscreen(),));
            }, child: Text("Skip",style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 18
            ),))
          ],
        ),
      ),
    )
    );
  }
}