

import 'package:flutter/material.dart';
import 'package:naromusic/ui/playlist_page/favroutiteList.dart';

class playlist_screen extends StatefulWidget {
  const playlist_screen({super.key});

  @override
  State<playlist_screen> createState() => _playlist_screenState();
}

class _playlist_screenState extends State<playlist_screen> {
  
  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        title: Text("Your Library"),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.add))
        ],
      ),
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: Padding(
      //         padding: const EdgeInsets.all(5.0),
      //         child: ListView.builder(
      //           itemCount: 10,
      //           itemBuilder: (BuildContext context, int index) {
      //             return Container(
      //               margin: EdgeInsets.only(bottom: 5),
      //               color: Colors.grey.shade400,
      //               child: index==0? 
      //               ListTile(
      //                 shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(15),
      //                 ),
      //                 leading: CircleAvatar(),
      //                 title: Text("Liked Songs🖤"),
      //                 subtitle: Text("PlayList.songs $index"),
      //                 onTap: (){
      //                   Navigator.push(context, MaterialPageRoute(builder: (context) => favlistscreen(),));
      //                 },
      //               ):ListTile(
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(12),
      //                 ),
      //                 leading: CircleAvatar(),
      //                 title: Text("PlayList Name"),
      //                 subtitle: Text("PlayList.songs $index"),
      //                 trailing: Row(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [
      //                     IconButton(
      //                       onPressed: () {},
      //                       icon: Icon(
      //                         Icons.edit_outlined,
      //                       ),
      //                     ),
      //                     IconButton(onPressed: (){}, icon: Icon(
      //               Icons.delete_outlined,
      //               ),)
      //                   ],
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => favlistscreen()));
            },
            child: Container(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/category1.jpg"),
                      fit: BoxFit.cover
                      ),
                      //color: Colors.purple[600],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    margin: EdgeInsets.only(right: 10),
                    width: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         Center(child: SizedBox(
                          height: 50,
                          width: 100,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                            color: Color.fromARGB(255, 0, 0, 0),
                            child: Center(child: Text('Favorites', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255),),textAlign: TextAlign.center,)),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/category3.jpg"),
                      fit: BoxFit.cover
                      ),
                      //color: Colors.purple[600],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    margin: EdgeInsets.only(right: 10),
                    width: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         Center(child: SizedBox(
                          height: 50,
                          width: 100,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                            color: Color.fromARGB(255, 0, 0, 0),
                            child: Center(child: Text('Recently Played', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255),),textAlign: TextAlign.center,)),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/category1.jpg"),
                      fit: BoxFit.cover
                      ),
                      //color: Colors.purple[600],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    margin: EdgeInsets.only(right: 10),
                    width: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         Center(child: SizedBox(
                          height: 50,
                          width: 100,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                            color: Color.fromARGB(255, 0, 0, 0),
                            child: Center(child: Text('Most Played', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255),),textAlign: TextAlign.center,)),
                          ),
                        )),
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
      )
    );
  }
}
