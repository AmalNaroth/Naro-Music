import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

// class Playercontroller extends GetxController{
//   final audioquery = OnAudioQuery();
//   final audioplyer = AudioPlayer();

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     checkpermission();
//   }

//   checkpermission()async{
//     final permission = await Permission.storage.request();
//     if(permission.isGranted){
     
      
//       return OnAudioQuery().querySongs(
//         ignoreCase: true,
//           orderType: OrderType.ASC_OR_SMALLER,
//           sortType: null,
//           uriType: UriType.EXTERNAL,
//       );
//     }else{
//       checkpermission();

//     }
//   }


//   playsong(String uri){
//     try {
//       audioplyer.setAudioSource(
//         AudioSource.uri(Uri.parse(uri))
//       );
//       audioplyer.play();
//     } on Exception catch (e) {
      
//     }

//   }
// }

final audioquery = OnAudioQuery();
final audioplyer= AssetsAudioPlayer();

List<SongModel> allsongsList=[];
List<SongModel> Mp3songsList=[];
List<songsmodel> allsongs=[];

checkpermission() async{
  final permission = await Permission.storage.request();
  if(permission.isGranted){
    allsongsList=await audioquery.querySongs();

    for(var elements in allsongsList){
      if(elements.fileExtension=="mp3"){
        Mp3songsList.add(elements);
      }
    }

    for(var elements in Mp3songsList){
      addallsongsdb(elements);
    }
  }else{
    checkpermission();
  }
}

playsongs(Uri){
  audioplyer.open(Audio.file(Uri));
  audioplyer.play();
}