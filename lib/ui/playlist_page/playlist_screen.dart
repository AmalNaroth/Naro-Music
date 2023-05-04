import 'package:flutter/material.dart';
import 'package:naromusic/ui/playlist_page/recentlyList.dart';

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
      
      body: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                InkWell(
                  onTap: () {
                  },
                  child: Container(
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
                ),
                InkWell(
                  onTap: () {
                    
                  },
                  child: Container(
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
                          child: InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => recentlylistscreen(),)),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                              ),
                              color: Color.fromARGB(255, 0, 0, 0),
                              child: Center(child: Text('Recently Played', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255),),textAlign: TextAlign.center,)),
                            ),
                          ),
                        )),
                      ],
                    ),
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
      )
    );
  }
}
