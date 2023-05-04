import 'package:flutter/material.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:naromusic/ui/nowPlaying/nowplayingscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class search_screen extends StatefulWidget {
  const search_screen({super.key});

  @override
  State<search_screen> createState() => _search_screenState();
}

class _search_screenState extends State<search_screen> {


  // List<songsmodel>songssearchlist=Hive.box<songsmodel>(boxname).values.toList();
   late List<songsmodel>songsdisplaylist=List<songsmodel>.from(allSongListNotifier.value);
  final _searchController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Colors.black,
      ),
     body:Container(
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
      child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search,color: Colors.black,),
              hintText:"What do you want to listen to ?",
              suffixIcon: IconButton(onPressed: (){
                cleartext();
              }, icon: Icon(Icons.clear,color: Colors.black),
              ),
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(50),

              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
               ),
            ),
            autofocus: true,
            controller: _searchController,
            cursorColor: Colors.black,
            onChanged:(value) {
              songsearch(value);
            },
          ),
        ),
        Expanded(
                child: songsdisplaylist.isNotEmpty
                    ?  Padding(
                   padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
                   child: ListView.builder(
                      itemCount: songsdisplaylist.length,
                      itemBuilder: (context, index) {
                        final data=songsdisplaylist[index];
                        return Container(
                          color: Color.fromARGB(255, 98, 97, 97),
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
                              playsongs(index, songsdisplaylist);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => nowplayingscreen(data: data,),));
                            },
                          ),
                        );
                      },
                             )
                 ):const Center(
                        child: Text(
                          'No match found',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
               ),
            ],
          ),
        )
              );
  }
  void songsearch(String value){
    setState(() {
    songsdisplaylist =allSongListNotifier.value
          .where((element) =>
              element.songName.toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    }
    );
  }
  void cleartext(){
      setState(() {
        _searchController.clear();
      });
  }
}