import 'package:flutter/material.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey, Colors.black]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
        title: Text("Most Played Songs"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
        child: ValueListenableBuilder(
          valueListenable: mostplayedsongNotifier,
          builder: (BuildContext ctx, List<songsmodel>mostlist, Widget? child) {
            return !mostlist.isEmpty ? ListView.builder(
           itemCount: mostlist.length,
           itemBuilder: (context, index) {
             final data=mostlist[index];
             return Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
               margin: EdgeInsets.only(bottom: 5),
               child:recentlyplayedandmostplayed(data: data, index: index, newlist: mostlist),
              //  child: ListTile(
              //    leading: QueryArtworkWidget(id: data.id, type:ArtworkType.AUDIO,
              //    nullArtworkWidget: Icon(Icons.music_note_rounded),
              //    ),
        
              //    title: Text(data.songName,overflow: TextOverflow.ellipsis,),
              //    subtitle: Text(data.artistName,overflow: TextOverflow.ellipsis,),
              //    tileColor: Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
              //    trailing: Row(
              //      mainAxisSize: MainAxisSize.min,
              //      children: [
              //        IconButton(onPressed: () {
                       
              //        }, icon: Icon(Icons.list)),
              //      ],
              //    ),
              //    onTap: () {
              //      playsongs(index, mostlist);
              //      Navigator.push(context, MaterialPageRoute(builder: (context) => nowplayingscreen(data: data,),));
              //    },
              //  ),
             );
           },
                  ):Center(child: 
                  Text("No songs found"),);
          },
        ),

      )
      ),
    );
  }
}