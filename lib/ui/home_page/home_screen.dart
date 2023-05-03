import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/ui/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
    
class _homescreenState extends State<homescreen> {
  

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
    

    return Scaffold(
        //backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(timename),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      printdata();
                    }, icon: Icon(Icons.notification_add)),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/dq.jpg"),
                ),
              ],
            )
          ],
        ),
        body:
           Column(
             children: [
               Container(
                color: Colors.white,
                 child: SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Row(
                       children: <Widget>[
                         Card(
                           child: Stack(
                             children: [
                  Container(
                  margin: EdgeInsets.only(top: 30,left: 20),
                      height: 230,
                      width: 230,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/category1.jpg")),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)
                      ),
                             ),
                             Container(
                  margin: EdgeInsets.only(top:230,left: 65),
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text("Favourites"),
                      Text("0 Songs")
                      ],
                     ),
                     SizedBox(width: 10,),
                     CircleAvatar()
                    ],
                  )
                             )
                             ],
                           ),
                         ),
                         Card(
                           child: Stack(
                             children: [
                  Container(
                  margin: EdgeInsets.only(top: 30,left: 20),
                      height: 230,
                      width: 230,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/category3.jpg")),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)
                      ),
                             ),
                             Container(
                  margin: EdgeInsets.only(top:230,left: 50),
                  height: 50,
                  width: 170,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(55)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text("Recently Played",),
                      Text("0 Songs")
                      ],
                     ),
                     SizedBox(width: 10,),
                     CircleAvatar()
                    ],
                  )
                             )
                             ],
                           ),
                         ),
               
                         Card(
                           child: Stack(
                             children: [
                  Container(
                  margin: EdgeInsets.only(top: 30,left: 20,right: 10),
                      height: 230,
                      width: 230,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/category1.jpg")),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)
                      ),
                             ),
                             Container(
                  margin: EdgeInsets.only(top:230,left: 65),
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text( "Most Played"),
                      Text("0 Songs")
                      ],
                     ),
                     SizedBox(width: 10,),
                     CircleAvatar()
                    ],
                  )
                             )
                             ],
                           ),
                         ),
                       ],
                     ),
                         ),
               ),
               SizedBox(
                          height: 5,
                         ),

               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            tileColor: Colors.grey.shade300,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(onPressed: () {
                                  
                                }, icon: Icon(Icons.list)),
                                IconButton(
                                    onPressed: () {
                                    },
                                    icon: Icon(Icons.favorite_outline_outlined))
                              ],
                            ),
                            onTap: () {
                              playsongs(data.uri);
                            },
                          ),
                        );
                      },
                             );
                     },
                   ),
                   
                   
                   
                   
                   
                   
                   
                 ),
               ),
              

              //  Expanded(
              //    child: FutureBuilder<List<SongModel>>(
              //            future: controller.audioquery.querySongs(
              //     ignoreCase: true,
              //     orderType: OrderType.ASC_OR_SMALLER,
              //     sortType: null,
              //     uriType: UriType.EXTERNAL
              //            ),
              //            builder: (BuildContext context, snapshot) {
              //     if(snapshot.data==null){
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }else if(snapshot.data!.isEmpty){
              //       return Center(
              //         child: Text("No song found"),
              //       );
              //     }else{
              //       print(snapshot.data);
              //       return Padding(
              //            padding: const EdgeInsets.all(8.0),
              //            child: ListView.builder(
              //     physics: BouncingScrollPhysics(),
              //     itemCount: snapshot.data!.length,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         margin: EdgeInsets.only(bottom: 5),
              //         child: ListTile(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(12),
              //           ),
              //           leading: QueryArtworkWidget(id: snapshot.data![index].id, type:ArtworkType.AUDIO,
              //           nullArtworkWidget: Icon(Icons.music_note_rounded),
              //           ),
               
              //           title: Text(snapshot.data![index].displayNameWOExt,overflow: TextOverflow.ellipsis,),
              //           subtitle: Text("${snapshot.data![index].artist}",overflow: TextOverflow.ellipsis,),
              //           tileColor: Colors.grey.shade300,
              //           trailing: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               IconButton(onPressed: () {
                              
              //               }, icon: Icon(Icons.list)),
              //               IconButton(
              //                   onPressed: () {
              //                   },
              //                   icon: Icon(Icons.favorite_outline_outlined))
              //             ],
              //           ),
              //           onTap: () {
              //             controller.playsong(snapshot.data![index].uri.toString());
              //           },
              //         ),
              //       );
              //     },
              //            ),
              //          );
              //     }
              //          },),
              //  ),
             ],
           )
        
        );
  }
}
