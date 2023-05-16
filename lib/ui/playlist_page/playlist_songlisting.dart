import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/playlistmodel.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:naromusic/ui/nowPlaying/nowplayingscreen.dart';
import 'package:naromusic/widgets/allwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';


//PLAYLIST INSIDE SONG LISTING
class PlayListSongListing extends StatefulWidget {
  PlayListSongListing({super.key, required this.data});
  playlistmodel data;

  @override
  State<PlayListSongListing> createState() => _PlayListSongListingState();
}

class _PlayListSongListingState extends State<PlayListSongListing> {
  
  @override
  Widget build(BuildContext context) {
    playlistsongnotifier.value=widget.data.playlistarray;
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
                      widget.data.playlistname,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                    InkWell(
                      onTap: () {
                        callingBottomSheetsonglisting(context,widget.data.playlistname);
                      },
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                            color: Colors.grey,
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
              // SizedBox(
              //   height: 30,
              // ),
             Padding(
          padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
          child: ValueListenableBuilder(
            valueListenable: playlistsongnotifier
          , builder: (BuildContext context, List<songsmodel> playlistarrysongs, Widget? child,){
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            itemCount: playlistarrysongs.length,
            itemBuilder: (BuildContext context, int index) {
              final data=playlistarrysongs[index];
              return !playlistarrysongs.isEmpty ? Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 171, 170, 170),
                  borderRadius: BorderRadius.circular(15)
                ),
                margin: EdgeInsets.only(bottom: 5),
                child: ListTile(
                  leading: QueryArtworkWidget(id: data.id, type:ArtworkType.AUDIO,
                   nullArtworkWidget: CircleAvatar(backgroundImage: AssetImage('assets/images/Naro logo.png'),),
                   ),
                   title: Text(data.songName,overflow: TextOverflow.ellipsis,),
                   subtitle: Text(data.artistName,overflow: TextOverflow.ellipsis,),
                   tileColor: Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
                   trailing:  IconButton(
                           onPressed: () {
                            songsdeletefromplaylist(data, widget.data.playlistname);
                           },
                           icon: Icon(Icons.delete)),
                   onTap: () {
                     playsongs(index, playlistarrysongs);
                     Navigator.push(context, MaterialPageRoute(builder: (context) => nowplayingscreen(data: data,),));
                   },
                ),
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