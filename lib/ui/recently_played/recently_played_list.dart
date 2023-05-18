import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:naromusic/db/notifierlist/songNotifierList.dart';
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
    // return Container(
    //    decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //         colors: [Colors.grey, Colors.black]),
    //   ),
    //   child: Scaffold(
    //     backgroundColor: Colors.transparent,
    //     appBar: AppBar(title: Text("Recently Plyed songs"),
    //     backgroundColor: Colors.black,
    //     ),
    //     body: Padding(
    //       padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
    //       child: ValueListenableBuilder(
    //         valueListenable:  recentlyPlayedNotifier,
    //         builder: (BuildContext ctx, List<songsmodel>newlist, Widget? child) {
    //           return !newlist.isEmpty ? ListView.builder(
    //          itemCount: newlist.length,
    //          itemBuilder: (context, index) {
    //            final data=newlist[index];
    //            return Container(
    //             decoration: BoxDecoration(
    //               color: Color.fromARGB(255, 178, 177, 177),
    //               borderRadius: BorderRadius.circular(15)
    //             ),
    //              margin: EdgeInsets.only(bottom: 5),
    //              child:recentlyplayedandmostplayed(data: data, index: index, newlist: newlist) );
    //         },):Center(child: Text("No recently songs",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),);
    //         }
    //       )
    //     ),
    //   ),
    // );
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.dark_mode,
                      color: Colors.white,
                    ),
                    Text(
                      "Recently played",
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    InkWell(
                      onTap: () {
                      },
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                            color: Color.fromARGB(255, 240, 239, 239),
                            intensity: 1),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(CupertinoIcons.music_albums),
                        ),
                      ),
                    )
                  ],
                ),
              ),
             Padding(
          padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
          child: ValueListenableBuilder(
            valueListenable: recentlyPlayedNotifier,
           builder: (BuildContext context, List<songsmodel> recentlist, Widget? child,){
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            itemCount: recentlist.length,
            itemBuilder: (BuildContext context, int index) {
              final data=recentlist[index];
              return !recentlist.isEmpty ? Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 214, 214, 214),
                  borderRadius: BorderRadius.circular(15)
                ),
                margin: EdgeInsets.only(bottom: 5),
                child: recentlyplayedandmostplayed(data: data, index: index, newlist: recentlist)
              ):Text("No songs");
            },
          );
          }
          )
        )
            ],
          ),
        )));
  }
}