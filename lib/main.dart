import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/splash_page/splash_screen.dart';
void main() {
 Hive.initFlutter();
  if(!Hive.isAdapterRegistered(songsmodelAdapter().typeId)){
    Hive.registerAdapter(songsmodelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Color.fromARGB(255, 0, 0, 0),
          displayColor: Color.fromARGB(255, 0, 0, 0)
        )
      ),
      home: const splashscreen(),
    );
  }
}