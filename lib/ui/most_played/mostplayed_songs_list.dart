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

class mostplayedlistScreen extends StatefulWidget {
  const mostplayedlistScreen({super.key});

  @override
  State<mostplayedlistScreen> createState() => _mostplayedlistScreenState();
}

class _mostplayedlistScreenState extends State<mostplayedlistScreen> {
  @override
  Widget build(BuildContext context) {
    allMostPlayedListShow();
    // return Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //         colors: [Colors.grey, Colors.black]),
    //   ),
    //   child: Scaffold(
    //     backgroundColor: Colors.transparent,
    //     appBar: AppBar(
    //     title: Text("Most Played Songs"),
    //     backgroundColor: Colors.black,
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
    //     child: ValueListenableBuilder(
    //       valueListenable: mostplayedsongNotifier,
    //       builder: (BuildContext ctx, List<songsmodel>mostlist, Widget? child) {
    //         return !mostlist.isEmpty ? ListView.builder(
    //        itemCount: mostlist.length,
    //        itemBuilder: (context, index) {
    //          final data=mostlist[index];
    //          return Container(
    //           decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(15),
    //             color: Colors.grey,
    //           ),
    //            margin: EdgeInsets.only(bottom: 5),
    //            child:recentlyplayedandmostplayed(data: data, index: index, newlist: mostlist),
    //           //  child: ListTile(
    //           //    leading: QueryArtworkWidget(id: data.id, type:ArtworkType.AUDIO,
    //           //    nullArtworkWidget: Icon(Icons.music_note_rounded),
    //           //    ),
        
    //           //    title: Text(data.songName,overflow: TextOverflow.ellipsis,),
    //           //    subtitle: Text(data.artistName,overflow: TextOverflow.ellipsis,),
    //           //    tileColor: Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
    //           //    trailing: Row(
    //           //      mainAxisSize: MainAxisSize.min,
    //           //      children: [
    //           //        IconButton(onPressed: () {
                       
    //           //        }, icon: Icon(Icons.list)),
    //           //      ],
    //           //    ),
    //           //    onTap: () {
    //           //      playsongs(index, mostlist);
    //           //      Navigator.push(context, MaterialPageRoute(builder: (context) => nowplayingscreen(data: data,),));
    //           //    },
    //           //  ),
    //          );
    //        },
    //               ):Center(child: 
    //               Text("No songs found"),);
    //       },
    //     ),

    //   )
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
                      "Most played",
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
            valueListenable: mostplayedsongNotifier,
           builder: (BuildContext context, List<songsmodel> mostplayed, Widget? child,){
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            itemCount: mostplayed.length,
            itemBuilder: (BuildContext context, int index) {
              final data=mostplayed[index];
              return !mostplayed.isEmpty ? Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 214, 214, 214),
                  borderRadius: BorderRadius.circular(15)
                ),
                margin: EdgeInsets.only(bottom: 5),
                child: recentlyplayedandmostplayed(data: data, index: index, newlist: mostplayed)
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