import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class privacydialoge extends StatelessWidget {
   privacydialoge({super.key,this.radius=8,required this.mdFileName1}):assert(mdFileName1.contains('.md'));
  final double radius;
  final String mdFileName1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(children: [
        Expanded(child: 
        FutureBuilder(
          future: Future.delayed(Duration(milliseconds: 150)).then((value) {
            return rootBundle.loadString("assets/privacypolicy/$mdFileName1");
          }),
          builder: (context, snapshot) {
         if(snapshot.hasData){
           return Markdown(
            data: snapshot.data!,
           );
         }
         return CircularProgressIndicator();
        },)),
        ElevatedButton(onPressed: () => Navigator.of(context).pop(),child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius)
            )
          ),
          alignment: Alignment.center,
          height: 50,
          width: double.infinity,
          child: Text("Close"),
        ),)
      ],),
    );
  }
}