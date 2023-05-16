import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/playlistmodel.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/bottom_navbarroot/bottomNavBar.dart';
import 'package:naromusic/ui/bottom_navbarroot/drawer.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:naromusic/ui/nowPlaying/nowplayingscreen.dart';
import 'package:naromusic/widgets/allwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

class _homescreenState extends State<homescreen> {
  String? savedName;
  DateTime? savedDate;

  List categories = ["Played", "Most Played", "Recently Played", "Best Songs"];

  //shared preferences name assigning
  Future<void> username() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = sharedPrefs.getString('Save_Name');
    });
  }

  Future<void> _selectedTime() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username();
  }

  @override
  Widget build(BuildContext context) {
    //allsongsValueNOtifier
    AllsongsdatashowList();
    addplaylistdbtovaluelistenable();
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
            body: Material(
              color: Color.fromARGB(255, 255, 255, 255),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(
                            builder: (context) {
                              return IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                icon: Icon(Icons.more_vert),
                              );
                            },
                          ),
                          Text(
                            "N A R O M U S I C",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: InkWell(
                              onTap: () {},
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(12)),
                                    intensity: 1,
                                    color: Color.fromARGB(255, 217, 217, 217)),
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(Icons.search)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 290,
                        child: ProductWidgets(),
                      ),
                      SizedBox(
                          height: 65,
                          child: ValueListenableBuilder(
                            valueListenable: playlistnamenotifier,
                            builder: (BuildContext context,
                                List<playlistmodel> playlistname,
                                Widget? child) {
                              return !playlistname.isEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: playlistname.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final data = playlistname[index];
                                        return InkWell(
                                          onTap: () {},
                                          child: Neumorphic(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 25),
                                            style: NeumorphicStyle(
                                                shape: NeumorphicShape.flat,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            20)),
                                                color: Colors.white,
                                                intensity: 1),
                                            child: Center(
                                                child: Text(
                                              data.playlistname,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                          ),
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                        "No Play List",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                            },
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Y O U R S O N G S",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                      ValueListenableBuilder(
                          valueListenable: allSongListNotifier,
                          builder: (BuildContext context,
                              List<songsmodel> newlist, Widget? child) {
                            return !newlist.isEmpty
                                ? ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: newlist.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final data = newlist[index];
                                      return Container(
                                        margin: EdgeInsets.only(
                                            bottom: 5, right: 15),
                                        child: songlistbar(
                                            data: data,
                                            index: index,
                                            context: context,
                                            songslist: newlist),
                                      );
                                    })
                                : Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                        ),
                                        Text(
                                          "No songs found",
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  );
                          })
                    ],
                  ),
                ),
              ),
            ),
            drawer: drawerlist()),
      ),
    );
  }
}
