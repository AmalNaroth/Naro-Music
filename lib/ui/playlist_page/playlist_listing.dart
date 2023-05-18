import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:naromusic/db/notifierlist/songNotifierList.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/playlistmodel.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/widgets/allwidget.dart';

class playlist_screen extends StatefulWidget {
  const playlist_screen({super.key});

  @override
  State<playlist_screen> createState() => _playlist_screenState();
}

class _playlist_screenState extends State<playlist_screen> {
  @override
  Widget build(BuildContext context) {
    addplaylistdbtovaluelistenable();
    final obj=createnewplaylist(context);
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
                      "P L A Y L I S T",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                    InkWell(
                      onTap: () {
                        obj.createnewolayList(context);
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
                          child: Icon(CupertinoIcons.add),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: playlistnamenotifier,
                builder: (BuildContext context,
                    List<playlistmodel> playlistname, Widget? child) {
                  return !playlistname.isEmpty ? GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.only(top: 20, right: 5, left: 5, bottom: 50),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            (MediaQuery.of(context).size.width - 15 - 10) /
                                (2 * 250),
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 5),
                    itemCount: playlistname.length,
                    itemBuilder: (context, index) {
                      final data = playlistname[index];
                      if (index % 2 == 0) {
                        return PlayListListing(
                          index: index,
                          data: data,
                        );
                      }
                      return OverflowBox(
                        maxHeight: 250 + 70,
                        child: Container(
                          margin: EdgeInsets.only(top: 70),
                          child: PlayListListing(
                            index: index,
                            data: data,
                          ),
                        ),
                      );
                    },
                  ):Column(
                    children: [
                      SizedBox(height: 300,),
                      Center(child: Text("NO PLAY LIST",style: TextStyle(color: Colors.black54,fontSize: 20),),),
                    ],
                  );
                },
              )
            ],
          ),
        )));
  }
}
