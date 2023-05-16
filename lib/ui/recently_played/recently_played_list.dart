import 'package:flutter/material.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:naromusic/ui/nowPlaying/nowplayingscreen.dart';
import 'package:naromusic/widgets/allwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class recentlylistscreen extends StatefulWidget {
  const recentlylistscreen({super.key});

  @override
  State<recentlylistscreen> createState() => _recentlylistscreenState();
}

class _recentlylistscreenState extends State<recentlylistscreen> {
  @override
  Widget build(BuildContext context) {
    allrecentlyplaylistshow();
    return Container(
       decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey, Colors.black]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text("Recently Plyed songs"),
        backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
          child: ValueListenableBuilder(
            valueListenable:  recentlyPlayedNotifier,
            builder: (BuildContext ctx, List<songsmodel>newlist, Widget? child) {
              return !newlist.isEmpty ? ListView.builder(
             itemCount: newlist.length,
             itemBuilder: (context, index) {
               final data=newlist[index];
               return Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 178, 177, 177),
                  borderRadius: BorderRadius.circular(15)
                ),
                 margin: EdgeInsets.only(bottom: 5),
                 child:recentlyplayedandmostplayed(data: data, index: index, newlist: newlist) );
            },):Center(child: Text("No recently songs",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),);
            }
          )
        ),
      ),
    );
  }
}