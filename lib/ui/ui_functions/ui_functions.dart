import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/db/notifierlist/songNotifierList.dart';
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


songsmodel findsongwithid(int songid){
  late songsmodel data;
  for(var element in allSongListNotifier.value){
    
    if(songid == element.id){
     
    data =  element;
    }
  }

  return data;
  
}