

import 'package:hive_flutter/adapters.dart';
import 'package:naromusic/db/db_List/songNotifierList.dart';
import 'package:naromusic/db/models/songsmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';

void addallsongsdb(SongModel data) async {
  final allsongdatabase = await Hive.openBox<songsmodel>(boxname);

  final newnongs = songsmodel(
      songName: data.displayName,
      artistName: data.artist!,
      uri: data.uri!,
      id: data.id,
      duration: data.duration!);

  bool flag = true;

  for (var elements in allsongdatabase.values) {
    if (elements.id == newnongs.id) {
      flag = false;
    }
  }
  if (flag == true) {
    allsongdatabase.add(newnongs);
  }
}

printdata() async {
  final allsongdatabase = await Hive.openBox<songsmodel>("AllSongs");
  for (var elemetns in allsongdatabase.values) {
    print(elemetns.songName);
  }
}

AllsongsdatashowList() async {
  final allsongdatabase = await Hive.openBox<songsmodel>("AllSongs");
  allSongListNotifier.value.clear();
  allSongListNotifier.value.addAll(allsongdatabase.values);
  allSongListNotifier.notifyListeners();
}