import 'package:flutter/material.dart';


class search_screen extends StatefulWidget {
  const search_screen({super.key});

  @override
  State<search_screen> createState() => _search_screenState();
}

class _search_screenState extends State<search_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Colors.black,
      ),
     body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              hintText:"What do you want to listen to ?"
            ),
          ),
        )
      ],
     ),
    );
  }
}