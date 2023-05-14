import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:naromusic/ui/nowPlaying/nowplayingscreen.dart';
import 'package:naromusic/ui/playlist_page/favroutiteList.dart';
import 'package:naromusic/ui/playlist_page/mostplayedlist.dart';
import 'package:naromusic/ui/playlist_page/recentlyList.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

// Widget playbox(String text, int curretidx, int value) {
//   return Container(
//       color: curretidx == value
//           ? Colors.grey
//           : const Color.fromARGB(255, 63, 63, 63),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Image.asset(
//               'assets/images/category1.jpg',
//               height: curretidx == value ? 110 : 80,
//             ),
//             Text(
//               text,
//               style: TextStyle(
//                   color: curretidx == value ? Colors.amber : Colors.black,
//                   fontWeight: curretidx == value ? FontWeight.w900 : null),
//             )
//           ],
//         ),
//       ));
// }

//allsonglisting mainpage
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
          backgroundImage: AssetImage('assets/images/Naro logo.png'),
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
          IconButton(onPressed: () {}, icon: Icon(Icons.list)),
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
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nowplayingscreen(data: widget.data),
            ));
      },
    );
  }
}

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
      leading: QueryArtworkWidget(
        id: data.id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: CircleAvatar(
          backgroundImage: AssetImage('assets/images/Naro logo.png'),
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                //adding to playlist
              },
              icon: Icon(Icons.list)),
        ],
      ),
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


// this is home page container show
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

//playlist listing

class PlayListListing extends StatelessWidget {
  PlayListListing({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            color: Color.fromARGB(255, 227, 225, 225),
            intensity: 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/image2/image2.jpg",
                  height: 150,
                  width: double.infinity,
                ),
              ),
              Text(
                "PlayList Name",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black45),
              ),
              Text("Songs count",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
