import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/home_page/home_screen.dart';
import 'package:naromusic/ui/ui_functions/ui_functions.dart';
import 'package:on_audio_query/on_audio_query.dart';

class nowplayingscreen extends StatefulWidget {
  nowplayingscreen({super.key, required this.data});

  songsmodel data;

  @override
  State<nowplayingscreen> createState() => _nowplayingscreenState();
}

class _nowplayingscreenState extends State<nowplayingscreen> {
  bool playstate = false;
  @override
  Widget build(BuildContext context) {
    bool ischeck= favouritecheckings(widget.data);
    return Scaffold(body: audioPlayer.builderCurrent(
      builder: (context, playing) {
        int songid = int.parse(playing.audio.audio.metas.id!);
        findsong(songid);
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bgimage2.jpg"))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromARGB(255, 255, 255, 255).withOpacity(0.0),
                    Color.fromARGB(255, 86, 85, 85).withOpacity(0.2),
                    Color.fromARGB(255, 74, 74, 74).withOpacity(0.7),
                    Color.fromARGB(255, 0, 0, 0).withOpacity(1.0)
                  ])),
              child: Container(
                // color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 45, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.more_vert_rounded,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 90,),
                    Container(
                        color: Colors.transparent,
                        child: Container(
                          height: 200,
                          width: 200,
                          child: QueryArtworkWidget(
                            id: int.parse(playing.audio.audio.metas.id!),
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: CircleAvatar(backgroundImage: AssetImage('assets/images/Naro logo.png',),
                           radius: 100,
                            ),
                          ),
                        )),
                    Spacer(),
                    Container(
                      //color: Colors.red,
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: Column(
                        children: [
                          //SizedBox(height: 40,),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 23, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        playing.audio.audio.metas.title!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 23,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        playing.audio.audio.metas.artist!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 19,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      //addtofavroutiedbfunction(widget.data);
                                      setState(() {
                                        if(ischeck==false){
                                           addtofavroutiedbfunction(widget.data,context);
                                        }else{
                                          favsongslistdelete(widget.data,context);
                                        }
                                        
                                      });
                                    },
                                    icon:ischeck==true?
                                     Icon(Icons.favorite): Icon(Icons.favorite_outline_outlined)
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Slider(
                                min: 0,
                                max: 100,
                                value: 40,
                                onChanged: (value) {},
                                activeColor: Colors.white,
                                inactiveColor: Colors.grey,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("02:10"),
                                    Text("05:10"),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon:
                                      Icon(Icons.shuffle, color: Colors.white)),
                              IconButton(
                                  onPressed: () {
                                    audioPlayer.previous();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (playstate == false) {
                                        playstate = true;
                                      } else {
                                        playstate = false;
                                      }
                                    });
                                    audioPlayer.playOrPause();
                                  },
                                  icon: playstate == false
                                      ? Icon(Icons.play_arrow,
                                          color: Colors.white)
                                      : Icon(Icons.pause, color: Colors.white)),
                              IconButton(
                                  onPressed: () {
                                    audioPlayer.next();
                                  },
                                  icon: Icon(Icons.arrow_forward_ios_outlined,
                                      color: Colors.white)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.play_arrow,
                                      color: Colors.white))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
