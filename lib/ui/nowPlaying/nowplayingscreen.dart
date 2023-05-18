import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/home_page/home_screen.dart';
import 'package:naromusic/ui/ui_functions/ui_functions.dart';
import 'package:naromusic/widgets/allwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:text_scroll/text_scroll.dart';

import '../music_lyrics/musicLyrics.dart';

class nowplayingscreen extends StatefulWidget {
  nowplayingscreen({super.key, required this.data});

  final songsmodel data;

  @override
  State<nowplayingscreen> createState() => _nowplayingscreenState();
}

class _nowplayingscreenState extends State<nowplayingscreen> {
  bool playstate = false;
  @override
  Widget build(BuildContext context) {
    bool ischeck= favouritecheckings(widget.data);
    return Scaffold(
      body: audioPlayer.builderCurrent(
      builder: (context, playing) {
        int songid = int.parse(playing.audio.audio.metas.id!);
        findsong(songid);
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 25, left: 25, top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: NeuBox(child: IconButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, icon: Icon(Icons.arrow_drop_down)),),
                      ),
                      Text("N A R O M U S I C"),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: NeuBox(child:
                          IconButton(onPressed: () {
            lyricsBottom(context,audioPlayer.getCurrentAudioTitle,audioPlayer.getCurrentAudioArtist);
          }, icon: Icon(Icons.lyrics_outlined))
                          // PopupMenuButton(
                          //             color: Colors.white,
                          //             itemBuilder: (context) => [
                          //                   PopupMenuItem(
                          //                       child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     children: [
                          //                       Text('Delete Playlist'),
                          //                       IconButton(
                          //                           onPressed: () {
                          //                             // deletePlaylist(indx,
                          //                             //     playlistList[indx]);
                          //                             // Navigator.pop(context);
                          //                           },
                          //                           icon: Icon(Icons.delete)),
                          //                     ],
                          //                   )),
                          //                   PopupMenuItem(
                          //                       child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     children: [
                          //                       Text('Change name'),
                          //                       IconButton(
                          //                           onPressed: () {
                          //                             // Navigator.push(context,
                          //                             //     MaterialPageRoute(
                          //                             //         builder: (cntx) {
                          //                             //   return PlaylistRename(
                          //                             //     index: indx,
                          //                             //     playlistItem:
                          //                             //         playlistList[
                          //                             //             indx],
                          //                             //   );
                          //                             // }));
                          //                           },
                          //                           icon: Icon(Icons.edit))
                          //                     ],
                          //                   ))
                          //                 ])
                                          ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  //cover art,song name artist name
                  NeuBox(
                      child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 280,
                            width: 280,
                            child: QueryArtworkWidget(id: int.parse(playing.audio.audio.metas.id!),
                             type: ArtworkType.AUDIO,
                             nullArtworkWidget: ClipRect(child: Image.asset('assets/images/Naro logo.png')
                             ,)),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextScroll(playing.audio.audio.metas.title!,
                                  style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.grey.shade700)
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  TextScroll(
                                    playing.audio.audio.metas.artist!,
                                    style: TextStyle(
                                       overflow: TextOverflow.ellipsis,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if(ischeck==false){
                                      addtofavroutiedbfunction(widget.data,context);
                                    }else{
                                      favsongslistdelete(widget.data,context);
                                    }
                                  });
                                },
                                  icon:ischeck==true?
                                     Icon(Icons.favorite,size: 32,): Icon(Icons.favorite_outline_outlined,size: 32,)
                                )
                          ],
                        ),
                      )
                    ],
                  )),
                  SizedBox(
                    height: 30,
                  ),

                  //start time shuffle end time repeact icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("0:00"),
                      Icon(Icons.shuffle),
                      Icon(Icons.repeat),
                      Text("4:55")
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  //linear bar,

                  NeuBox(
                    child: LinearPercentIndicator(
                      lineHeight: 10,
                      percent: 0.5,
                      progressColor: Colors.blue.shade400,
                      backgroundColor: Colors.transparent,
                    ),
                  ),

                  SizedBox(
                    height: 35,
                  ),
                  //previous next skip
                  
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                            child: NeuBox(
                                child: IconButton(
                                    onPressed: () {
                                      audioPlayer.previous();
                                    },
                                    icon: Icon(
                                      Icons.skip_previous,
                                      size: 32,
                                    )))),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: NeuBox(
                                  child: PlayerBuilder.isPlaying(player: audioPlayer
                                  , builder: (context, isPlaying) {
                                    return IconButton(
                                      onPressed: () {
                                       
                                      if (isPlaying == false) {
                                        audioPlayer.play();
                                      } else {
                                        audioPlayer.pause();
                                      }
                                     
                                      
                                      },
                                        icon: isPlaying == false
                                      ? Icon(Icons.play_arrow,size: 32,)
                                      : Icon(Icons.pause, size: 32,));
                                  },)
                                      ))
                                      ),
                        Expanded(
                            child: NeuBox(
                                child: IconButton(
                                    onPressed: () {
                                      audioPlayer.next();
                                    },
                                    icon: Icon(
                                      Icons.skip_next,
                                      size: 32,
                                    ))))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("L Y R I C S"),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child:
                        NeuBox(
                          child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          //child:
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
