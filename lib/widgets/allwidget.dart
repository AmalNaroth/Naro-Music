import 'package:flutter/material.dart';

Widget playbox(String text,int curretidx,int value){
  return Container(
    color:curretidx==value?Colors.grey: const Color.fromARGB(255, 63, 63, 63),
    child:Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/images/category1.jpg', height:curretidx==value? 110:80,),
          Text(text,style: TextStyle(
            color: curretidx==value?Colors.amber:Colors.black,
            fontWeight: curretidx==value?FontWeight.w900:null
            ),)
        ],
      ),
    )
  );
}

Widget nowplaying(BuildContext context){
  return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bgimage2.jpg"))
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [
              Colors.white.withOpacity(0.0),
              Colors.grey.withOpacity(0.2),
            ])
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: 
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 45,horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.more_vert_rounded,color: Colors.white,),
                      )
                    ],
                  ),
                ),
                Spacer(

                ),
                Container(
                  height: MediaQuery.of(context).size.height/2.5,
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 23,horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("fjsfikfnikfn"),
                                SizedBox(height: 10,),
                                Text("fjsfikfnikfn")
                              ],
                            ),
                            Icon(Icons.favorite,color: Colors.red,size: 25,),

                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Slider(min: 0,max: 100,value: 40,onChanged: (value) {
                            
                          },
                          activeColor: Colors.white,
                          inactiveColor: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("02:10"),
                                Text("05:10"),

                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.shuffle)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_outlined)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow))
                      ],)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
}