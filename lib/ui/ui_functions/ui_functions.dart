import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/db/functions/db_functions.dart';

void findsong(int id){
  for(var element in allSongListNotifier.value){
    if(element.id==id){
     addrecentlyplayed(element);
     mostPlayedSongs(element);
     break;
    }
  }
}


