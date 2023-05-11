import 'package:flutter/material.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:naromusic/ui/nowPlaying/nowplayingscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

Widget playbox(String text,int curretidx,int value){
  return Container(
    color:curretidx==value?Colors.grey: const Color.fromARGB(255, 63, 63, 63),
    child:Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/images/category1.jpg', height:curretidx==value? 110:80,),
          Text(text,style: TextStyle(
            color: curretidx==value?Colors.amber:Colors.black,
            fontWeight: curretidx==value?FontWeight.w900:null
            ),)
        ],
      ),
    )
  );
}




  class songlistbar extends StatefulWidget {
   songlistbar({super.key, required this.data,required this.index,required this.context,required this.songslist});

  songsmodel data;
  int index;
  BuildContext context;
  List<songsmodel> songslist;

  @override
  State<songlistbar> createState() => _songlistbarState();
}

class _songlistbarState extends State<songlistbar> {
  @override
  Widget build(BuildContext context) {
    bool isChecking=favouritecheckings(widget.data);
    return ListTile(
      shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            leading: QueryArtworkWidget(id: widget.data.id, type:ArtworkType.AUDIO,
                            nullArtworkWidget: Icon(Icons.music_note_rounded),
                            ),
                   
                            title: Text(widget.data.songName,overflow: TextOverflow.ellipsis,),
                            subtitle: Text(widget.data.artistName,overflow: TextOverflow.ellipsis,),
                            tileColor: Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(onPressed: () {
                                  
                                }, icon: Icon(Icons.list)),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if(isChecking==false){
                                           addtofavroutiedbfunction(widget.data,context);
                                        }else{
                                          favsongslistdelete(widget.data,context);
                                        }
                                        
                                      });
                                    },
                                    icon:isChecking==true?
                                     Icon(Icons.favorite): Icon(Icons.favorite_outline_outlined))
                              ],
                            ),
                            onTap: () {
                              playsongs(widget.index, allSongListNotifier.value);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => nowplayingscreen(data: widget.data),));
                            },
                          );
  }
}