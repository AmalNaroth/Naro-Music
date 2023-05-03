import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:naromusic/widgets/allwidget.dart';

class nowplayingscreen extends StatefulWidget {
  const nowplayingscreen({super.key});

  @override
  State<nowplayingscreen> createState() => _nowplayingscreenState();
}

class _nowplayingscreenState extends State<nowplayingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: nowplaying(context)
    );
  }
}