import 'package:flutter/material.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:naromusic/ui/nowPlaying/nowplayingscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class favlistscreen extends StatefulWidget {
  const favlistscreen({super.key});

  @override
  State<favlistscreen> createState() => _favlistscreenState();
}

class _favlistscreenState extends State<favlistscreen> {
  @override
  Widget build(BuildContext context) {
    allsongsfavlistshow();
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
          backgroundColor: Colors.black,
          title: Text("Favorites"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
          child: ValueListenableBuilder(
            valueListenable: favsongListNotifier,
            builder: (BuildContext ctx, List<songsmodel>favlist, Widget? child) {
              return favlist.isNotEmpty ? ListView.builder(
             itemCount: favlist.length,
             itemBuilder: (context, index) {
               final data=favlist[index];
               return Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 171, 170, 170),
                  borderRadius: BorderRadius.circular(15)
                ),
                 margin: EdgeInsets.only(bottom: 5),
                 child:
                 ListTile(
                   leading: QueryArtworkWidget(id: data.id, type:ArtworkType.AUDIO,
                   nullArtworkWidget: CircleAvatar(backgroundImage: AssetImage('assets/images/Naro logo.png'),),
                   ),
                   title: Text(data.songName,overflow: TextOverflow.ellipsis,),
                   subtitle: Text(data.artistName,overflow: TextOverflow.ellipsis,),
                   tileColor: Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
                   trailing: Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       IconButton(onPressed: () {
                         
                       }, icon: Icon(Icons.list)),
                       IconButton(
                           onPressed: () {
                            favsongslistdelete(data,context);
                           },
                           icon: Icon(Icons.delete))
                     ],
                   ),
                   onTap: () {
                     playsongs(index, favlist);
                     Navigator.push(context, MaterialPageRoute(builder: (context) => nowplayingscreen(data: data,),));
                   },
                 ),
               );
             },
              ):Center(child: Text('No Favorite Songs',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),));
            },
          ),
    
        )
      ),
    );
  }
}