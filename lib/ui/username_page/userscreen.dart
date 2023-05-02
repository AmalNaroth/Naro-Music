import 'package:flutter/material.dart';
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

  

  @override
  Widget build(BuildContext context) {
    final splashobj=splashscreen();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Naro Music"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          // Text("ADD YOUR PHOTO"),
          // CircleAvatar(
          //   backgroundColor: Colors.black,
          //   radius: 50,
          //   child: CircleAvatar(
          //     radius: 47,
          //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
          //  backgroundImage: AssetImage('assets/images/user_icon.png'),
          //   ),
          // ),
          SizedBox(height: 120,),
          Text("ENTER YOUR NAME",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _usernamecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
                labelText: "User name"
              ),
            ),
          ),
          SizedBox(height: 10,),
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
          TextButton(onPressed: (){
            skipchacker();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => mainscreen(),));
          }, child: Text("Skip"))
        ],
      ),
    );
  }
 
}