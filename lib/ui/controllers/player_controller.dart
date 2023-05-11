import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:naromusic/db/functions/db_functions.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:naromusic/ui/home_page/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

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

  List <Audio> audio=[];
  
playsongs(index,List songlist){
  audio.clear();
  for(var elements in songlist){
    audio.add(Audio.file(elements.uri,metas: Metas(id: elements.id.toString(),
    artist: elements.artistName,
    title: elements.songName
    )));
  }
  audioPlayer.open(Playlist(audios: audio,startIndex: index),autoStart: false,showNotification: true);
}