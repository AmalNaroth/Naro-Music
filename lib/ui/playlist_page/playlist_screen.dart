import 'package:flutter/material.dart';
import 'package:naromusic/widgets/widget.dart';

class playlist_screen extends StatefulWidget {
  const playlist_screen({super.key});

  @override
  State<playlist_screen> createState() => _playlist_screenState();
}

class _playlist_screenState extends State<playlist_screen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: CircleAvatar(radius: 5, backgroundColor: Colors.white),
        title: Text("Your Library"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
         
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 5),
                    color: Colors.grey.shade400,
                    child: index==0? 
                    ListTile(
                      shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
                      ),
                      leading: CircleAvatar(),
                      title: Text("Liked Songs🖤"),
                      subtitle: Text("PlayList.songs $index"),
                    ):ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: CircleAvatar(),
                      title: Text("PlayList Name"),
                      subtitle: Text("PlayList.songs $index"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit_outlined,
                            ),
                          ),
                          IconButton(onPressed: (){}, icon: Icon(
                    Icons.delete_outlined,
                    ),)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
