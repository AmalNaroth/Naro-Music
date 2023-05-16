import 'package:flutter/material.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:naromusic/ui/nowPlaying/nowplayingscreen.dart';
import 'package:naromusic/widgets/allwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("S E A R C H",style: TextStyle(
              fontSize: 25,
              //fontWeight: FontWeight.w500,
              color: Colors.black54
            ),),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: NeuBox(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Container(
                    width: 300,
                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      labelText: "What do you want to listen to ?",
                      border: InputBorder.none,
                      filled: true,
                    ),
                    controller: _searchController,
              cursorColor: Colors.grey,
              onChanged:(value) {
                songsearch(value);
              },
                    ),
                    ),
                  ),
                  Icon(Icons.search,color: Colors.black26,)
                ],),
            ),
          ),
          //SizedBox(height: 20,),
          songsdisplaylist.isNotEmpty
                    ? ListView.builder(
            itemCount: songsdisplaylist.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final data=songsdisplaylist[index];
               bool isChecking = favouritecheckings(data);
              return Container(
                       margin: EdgeInsets.only(left: 15,bottom: 5,right: 15),
                        child: ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      leading: QueryArtworkWidget(
        id:data.id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: CircleAvatar(
          backgroundImage: AssetImage('assets/images/Naro logo.png'),
        ),
      ),
      title: TextScroll(
        data.songName,
      ),
      subtitle: Text(
        data.artistName,
        overflow: TextOverflow.ellipsis,
      ),
      tileColor: Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.list)),
          IconButton(
              onPressed: () {
                setState(() {
                  if (isChecking == false) {
                    addtofavroutiedbfunction(data, context);
                  } else {
                    favsongslistdelete(data, context);
                  }
                });
              },
              icon: isChecking == true
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_outline_outlined))
        ],
      ),
      onTap: () {
        playsongs(index, songsdisplaylist);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nowplayingscreen(data:data),
            ));
      },
    )
                      );
            },
          ):Column(
            children: [
              SizedBox(height: 30,),
              Center(
                child: Text(
                  'No match found',
                  style: TextStyle(fontSize: 20,
                  color: Colors.black54
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  void songsearch(String value){
    songsdisplaylist.clear;
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