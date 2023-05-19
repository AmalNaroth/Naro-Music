import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:naromusic/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/playlistmodel.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:naromusic/ui/home_page/home_screen.dart';
import 'package:naromusic/ui/mini_player/miniPlayer.dart';
import 'package:naromusic/ui/nowPlaying/nowplayingscreen.dart';
import 'package:naromusic/ui/favourite_songs/favourite_songs_list.dart';
import 'package:naromusic/ui/most_played/mostplayed_songs_list.dart';
import 'package:naromusic/ui/playlist_page/playlist_songlisting.dart';
import 'package:naromusic/ui/recently_played/recently_played_list.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

//allsonglisting hompage songlistbar
class songlistbar extends StatefulWidget {
  songlistbar(
      {super.key,
      required this.data,
      required this.index,
      required this.context,
      required this.songslist});

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
    bool isChecking = favouritecheckings(widget.data);
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      leading: QueryArtworkWidget(
        id: widget.data.id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: CircleAvatar(
          backgroundImage: AssetImage('assets/image2/narolistlogo.png'),
        ),
      ),
      title: TextScroll(
        widget.data.songName,
      ),
      subtitle: Text(
        widget.data.artistName,
        overflow: TextOverflow.ellipsis,
      ),
      tileColor: Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                callingBottomSheet(context, widget.data);
              },
              icon: Icon(Icons.list)),
          IconButton(
              onPressed: () {
                setState(() {
                  if (isChecking == false) {
                    addtofavroutiedbfunction(widget.data, context);
                  } else {
                    favsongslistdelete(widget.data, context);
                  }
                });
              },
              icon: isChecking == true
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_outline_outlined))
        ],
      ),
      onTap: () {
        playsongs(widget.index, allSongListNotifier.value);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => nowplayingscreen(data: widget.data),
        //     ));
        MiniPlayer();
      },
    );
  }
}

//recentplay and most play listing listviewbuilder
class recentlyplayedandmostplayed extends StatelessWidget {
  recentlyplayedandmostplayed(
      {super.key,
      required this.data,
      required this.index,
      required this.newlist});
  songsmodel data;
  int index;
  List<songsmodel> newlist;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),),
      leading: QueryArtworkWidget(
        id: data.id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: CircleAvatar(
          backgroundImage: AssetImage('assets/image2/narolistlogo.png'),
          radius: 25,
        ),
      ),
      title: Text(
        data.songName,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        data.artistName,
        overflow: TextOverflow.ellipsis,
      ),
      tileColor: Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
      onTap: () {
        playsongs(index, newlist);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nowplayingscreen(
                data: data,
              ),
            ));
      },
    );
  }
}

// The home page three container Fav,Recently,Most
class ProductWidgets extends StatefulWidget {
  const ProductWidgets({super.key});

  @override
  State<ProductWidgets> createState() => _ProductWidgetsState();
}

class _ProductWidgetsState extends State<ProductWidgets> {
  List<Widget> containerNavigation = [
    favlistscreen(),
    recentlylistscreen(),
    mostplayedlistScreen()
  ];

  List<String> containername = ["Favorite", "Recently Played", "Most Played"];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: SizedBox(
            width: 250,
            child: Stack(
              children: [
                SizedBox(
                  height: 250,
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        intensity: 1,
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        containerNavigation[index],
                                  ));
                            },
                            child: Image.asset(
                              'assets/image2/image${index}.jpg',
                              height: 250,
                              width: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 184, 184, 184),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 4)
                            ]),
                        child: Text(
                          containername[index],
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

//playlist container showing
class PlayListListing extends StatelessWidget {
  PlayListListing({super.key, required this.index, required this.data});
  int index;
  playlistmodel data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayListSongListing(data: data),
            ),
          );
        },
        child: Neumorphic(
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            color: Color.fromARGB(255, 227, 225, 225),
            intensity: 1,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  "assets/image2/image2.jpg",
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.playlistname,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Songs count",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Areyou sure you want to delete")));
                        showDialog(
  context: context,
  builder: (BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.withOpacity(0.8),
            Colors.white.withOpacity(0.8),
            Colors.grey.withOpacity(0.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: AlertDialog(
      title: Text('Alert'),
      content: Text('Are you sure you want to delete'),
      actions: <Widget>[
        ElevatedButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the alert dialog
          },
        ),
        ElevatedButton(
          child: Text('OK'),
          onPressed: () {
            // Perform an action
            Navigator.of(context).pop();
            playlistdelete(data, context);
          },
        ),
      ],
    )
    );
  },
);
//
                      },
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12),
                          ),
                          intensity: 1,
                          color: Color.fromARGB(255, 217, 217, 217),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//common white shade design

class NeuBox extends StatefulWidget {
  final child;
  NeuBox({super.key, required this.child});

  @override
  State<NeuBox> createState() => _NeuBoxState();
}

class _NeuBoxState extends State<NeuBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(
        child: widget.child,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 15,
                offset: Offset(
                  5,
                  5,
                )),
            BoxShadow(
                color: Colors.white, blurRadius: 15, offset: Offset(-5, -5))
          ]),
    );
  }
}

// playlistcreationbootmsheet home page
void callingBottomSheet(BuildContext context, songsmodel songdata) {
  addplaylistdbtovaluelistenable();
  final obj=createnewplaylist(context);
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    context: context,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 230, 230, 230),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      height: 400,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'P L A Y L I S T',
            style: TextStyle(
                fontSize: 23,
                color: Colors.black45,
                fontWeight: FontWeight.w500),
          ),
          IconButton(
              onPressed: () {
                obj.createnewolayList(context);
              },
              icon: Icon(
                Icons.add_circle,
                size: 40,
              )),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: playlistnamenotifier,
                builder: (BuildContext context,
                    List<playlistmodel> playlistname, Widget? child) {
                  return !playlistname.isEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: playlistname.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = playlistname[index];
                            return Container(
                                height: 65,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(12)),
                                margin: EdgeInsets.only(
                                    bottom: 5, right: 15, left: 15),
                                child: Center(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/image2/narolistlogo.png'),
                                    ),
                                    title: TextScroll(
                                      data.playlistname,
                                      style: TextStyle(
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    tileColor: Color.fromARGB(0, 136, 136, 136)
                                        .withOpacity(0.3),
                                    onTap: () {
                                      songaddtoplaylistdatabase(
                                          data.playlistname, songdata, context);
                                    },
                                  ),
                                ));
                          },
                        )
                      : Center(
                          child: Text("No Play List Add"),
                        );
                }),
          ),
        ],
      ),
    ),
  );
}

//songslisting adding time listing in bottommodel plus

void callingBottomSheetsonglisting(BuildContext context, String listname) {
  addplaylistdbtovaluelistenable();
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    context: context,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 230, 230, 230),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      height: 400,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'A L L S O N G L I S T',
              style: TextStyle(fontSize: 25, color: Colors.black45),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: allSongListNotifier.value.length,
              itemBuilder: (BuildContext context, int index) {
                final data = allSongListNotifier.value[index];
                return Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(12)),
                    margin: EdgeInsets.only(bottom: 5, right: 15, left: 15),
                    child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: QueryArtworkWidget(
                          id: data.id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/image2/narolistlogo.png'),
                          ),
                        ),
                        title: TextScroll(
                          data.songName,
                        ),
                        subtitle: Text(
                          data.artistName,
                          overflow: TextOverflow.ellipsis,
                        ),
                        tileColor:
                            Color.fromARGB(0, 136, 136, 136).withOpacity(0.3),
                        trailing: IconButton(
                            onPressed: () {
                              songaddtoplaylistdatabase(
                                  listname, data, context);
                            },
                            icon: Icon(Icons.add))));
              },
            ),
          ),
        ],
      ),
    ),
  );
}


 class createnewplaylist{
  createnewplaylist(this.context);
  BuildContext context;
  final _formkey=GlobalKey<FormState>();
    final _playlisttexcontroller = TextEditingController();
   void createnewolayList(BuildContext context,){

    showDialog(
  context: context,
  builder: (BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.withOpacity(0.8),
            Colors.white.withOpacity(0.8),
            Colors.grey.withOpacity(0.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: AlertDialog(
        title:Padding(
  padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
            key: _formkey,
            child: Container(
              width: 100,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter playlist name',
                    labelStyle: TextStyle(color: Colors.black26),
                    border: InputBorder.none,
                  ),
                  controller: _playlisttexcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the playlist name';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          Icon(
            Icons.add,
            color: Colors.black26,
          ),
        ],
      ),
    ),
  ),
),

        actions: [
          InkWell(
              onTap:() {
                 if(_formkey.currentState!.validate()){
                  _submitForm();
                 }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(20),
                      ),
                      color: Colors.white,
                      intensity: 1,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      child: Row(
                        children: [
                          Text(
                            "Create",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  },
);
  }
  void _submitForm() {
    final textValue = _playlisttexcontroller.text;
    print('textcontroller = ${textValue}');
    List<songsmodel> listarray = [];
    addplaylisttodatabase(textValue, listarray, context);
    Navigator.pop(context);
  }
 }



// music slider in nowplaying screen
 class musicsliders extends StatefulWidget {
   musicsliders({super.key});

  @override
  State<musicsliders> createState() => _musicslidersState();
}

class _musicslidersState extends State<musicsliders> {
  double slidervalue =0;

  double duration =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     audioPlayer.current.listen((event) {
      final totalduration = event!.audio.duration;
      duration = event.audio.duration.inSeconds.toDouble();

    });
  }

  @override
  Widget build(BuildContext context) {
    
    return PlayerBuilder.currentPosition(player: audioPlayer, builder: (context, position) {

    slidervalue = position.inSeconds.toDouble();

    return Column(
      children: [
        Slider(value: slidervalue, min: 0.0,max: duration, onChanged: (value) {
          
            slidervalue = value;
            audioPlayer.seek(Duration(seconds: slidervalue.toInt()));
         
        },),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal:20.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [

        //       PlayerBuilder.currentPosition(player: audioPlayer, builder: (context, position) {
        //       final mm = (position.inMinutes %60).toString().padLeft(2,'0');
        //       final ss = (position.inSeconds %60).toString().padLeft(2,'0');
        //       return Text('${mm}:${ss}');
        //     },),
        //     PlayerBuilder.current(player: audioPlayer, builder: (context, playing) {
        //       final totalduration = playing.audio.duration;
        //       final mm = (totalduration.inMinutes %60).toString().padLeft(2,'0');
        //       final ss = (totalduration.inSeconds %60).toString().padLeft(2,'0');
        //       return Text('${mm}:${ss}');
        //     },)
              

           
        //   ],),
        // )
      ],
    );
  },);
  }
}