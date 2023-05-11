import 'package:flutter/material.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:naromusic/ui/nowPlaying/nowplayingscreen.dart';
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
            child: ValueListenableBuilder(
              valueListenable:  recentlyPlayedNotifier,
              builder: (BuildContext ctx, List<songsmodel>newlist, Widget? child) {
                return ListView.builder(
               itemCount: newlist.length,
               itemBuilder: (context, index) {
                 final data=newlist[index];
                 return Container(
                  color: Color.fromARGB(255, 178, 177, 177),
                   margin: EdgeInsets.only(bottom: 5),
                   child: ListTile(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(12),
                     ),
                     leading: QueryArtworkWidget(id: data.id, type:ArtworkType.AUDIO,
                     nullArtworkWidget: Icon(Icons.music_note_rounded),
                     ),
            
                     title: Text(data.songName,overflow: TextOverflow.ellipsis,),
                     subtitle: Text(data.artistName,overflow: TextOverflow.ellipsis,),
                     tileColor: Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
                     trailing: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         IconButton(onPressed: () {
                           
                         }, icon: Icon(Icons.list)),
                        //  IconButton(
                        //      onPressed: () {
                        //        addtofavroutiedbfunction(data,context);
                        //      },
                        //      icon: Icon(Icons.favorite_outline_outlined))
                       ],
                     ),
                     onTap: () {
                       playsongs(index, newlist);
                       Navigator.push(context, MaterialPageRoute(builder: (context) => nowplayingscreen(data: data,),));
                     },
                   ),
                 );
               },
                      );
              },
            ),
        
          ),
        ),
      ),
    );
  }
}