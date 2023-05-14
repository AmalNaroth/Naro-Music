import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/ui/ui_functions/ui_functions.dart';
import 'package:naromusic/widgets/allwidget.dart';

class playlist_screen extends StatefulWidget {
  const playlist_screen({super.key});

  @override
  State<playlist_screen> createState() => _playlist_screenState();
}

class _playlist_screenState extends State<playlist_screen> {
  final NewPlayListName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey, Colors.black]),
        ),
        child: Material(
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
                        Icon(Icons.dark_mode),
                        Text(
                          "P L A Y L I S T",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        Neumorphic(
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      callingBottomSheet(context);
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
                            color: Color.fromARGB(255, 255, 255, 255),
                            intensity: 1,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 30),
                            child: Row(
                              children: [
                                Icon(Icons.playlist_add, color: Colors.black45),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "PLAY LIST",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        Neumorphic(
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20),
                            ),
                            color: Color.fromARGB(255, 255, 255, 255),
                            intensity: 1,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 30),
                            child: Row(
                              children: [
                                Icon(Icons.music_note, color: Colors.black45),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "MUSIC",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 20,right: 5,left: 5,bottom: 50),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (MediaQuery.of(context).size.width-15-10)/(2*250),
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 5
                          ),
                          itemCount: 4,
                      itemBuilder: (context, index) {
                        if(index%2==0){
                          return PlayListListing(index: index,);
                        }
                        return OverflowBox(
                          maxHeight: 250+70,
                          child: Container(
                            margin: EdgeInsets.only(top: 70),
                            child: PlayListListing(index: index,),
                          ),
                        );
                      },)
                ],
              ),
            ),
          ),
        ));
  }

  //playlistcreationbootmsheet
  void callingBottomSheet(BuildContext context) {
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
        child: Center(
            child: Column(
          children: [
            Padding(
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
                              spreadRadius: 2)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 200,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Enter the playlist name",
                                  labelStyle: TextStyle(color: Colors.black26),
                                  border: InputBorder.none),
                              controller: NewPlayListName,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.black26,
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                addplayListToDB(NewPlayListName.text, context);
                Navigator.pop(context);
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
        )),
      ),
    );
  }
}
