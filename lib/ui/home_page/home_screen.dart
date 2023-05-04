import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:naromusic/ui/nowPlaying/nowplayingscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
    
class _homescreenState extends State<homescreen> {

  String? savedName; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username();
  }

  @override
  Widget build(BuildContext context) {

    AllsongsdatashowList();
    DateTime now = DateTime.now();
    dynamic currenttime = DateFormat('kk').format(now);
    var time = int.parse(currenttime);
    String timename;
    if (00 >= time && 11 < time) {
      timename = "Good Morning";
    } else if (12 >= time && 23 < time) {
      timename = "Good Afternoon";
    } else {
      timename = "Good Evening";
    }

    //controller
   // var controller = Get.put(Playercontroller());

    var currentindex=0;
    List<String> playcard=[
      "Favourites",
      "Recently Played",
      "Most Played",
    ];
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey,
            Colors.black
          ]
        ),
        
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: 
        Padding(
          padding: const EdgeInsets.only(top: 20,left: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.sort_rounded)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),


                child:savedName==null ? Text('Hello Sir',
                style: TextStyle(fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1
                ),
                ) :Text((savedName!),


                style: TextStyle(fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text("What do yo want to here sir?",
                style: TextStyle(fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white
                ),
                ),
              ),
              Expanded(
                 child: Padding(
                   padding: const EdgeInsets.only(right: 15),
                   child: ValueListenableBuilder(
                     valueListenable:  allSongListNotifier,
                     builder: (BuildContext ctx, List<songsmodel>newlist, Widget? child) {
                       return ListView.builder(
                      itemCount: newlist.length,
                      itemBuilder: (context, index) {
                        final data=newlist[index];
                        return Container(
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
                                IconButton(
                                    onPressed: () {
                                      addtofavroutiedbfunction(data);
                                    },
                                    icon: Icon(Icons.favorite_outline_outlined))
                              ],
                            ),
                            onTap: () {
                              playsongs(index, allSongListNotifier.value);
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
            ],
          ),
        )
        ),
      ),
    );
  }
  Future<void> username()async{
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      savedName=sharedPrefs.getString('Save_Name');
    });
}
}
