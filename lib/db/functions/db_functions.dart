import 'package:flutter/material.dart';
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
  final allsongdatabase = await Hive.openBox<songsmodel>(boxname);
  for (var elemetns in allsongdatabase.values) {
    print(elemetns.songName);
  }
}

AllsongsdatashowList() async {
  final allsongdatabase = await Hive.openBox<songsmodel>(boxname);
  allSongListNotifier.value.clear();
  allSongListNotifier.value.addAll(allsongdatabase.values);
  allSongListNotifier.notifyListeners();
}

addtofavroutiedbfunction(songsmodel data, BuildContext context) async {
  final favrioutedatabase = await Hive.openBox<songsmodel>("favlistDB");
  bool check = false;
  for (var elements in favrioutedatabase.values) {
    if (data.id == elements.id) {
      check = true;
    }
  }
  if (check == false) {
    favrioutedatabase.add(data);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Added to fav list"),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 1),
    ));
  }
  allsongsfavlistshow();
}

allsongsfavlistshow() async {
  final favrioutedatabase = await Hive.openBox<songsmodel>("favlistDB");
  favsongListNotifier.value.clear();
  favsongListNotifier.value.addAll(favrioutedatabase.values);
  favsongListNotifier.notifyListeners();
}

favsongslistdelete(songsmodel data, BuildContext context) async {
  final favrioutedatabase = await Hive.openBox<songsmodel>("favlistDB");
  int count = 0;
  for (var elements in favrioutedatabase.values) {
    if (data.id == elements.id) {
      favrioutedatabase.deleteAt(count);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Removed song"),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ));
    }
    count++;
  }
  allsongsfavlistshow();
}

Future<void> addrecentlyplayed(songsmodel data) async {
  final recentlyplayeddatabae =
      await Hive.openBox<songsmodel>("recentlyplayeddb");
  int count = 0;
  for (var elements in recentlyplayeddatabae.values) {
    count++;
  }
  if (count > 4) {
    recentlyplayeddatabae.deleteAt(0);
  }
  int index = 0;
  for (var element in recentlyplayeddatabae.values) {
    if (element.id == data.id) {
      recentlyplayeddatabae.deleteAt(index);
    }
    index++;
  }
  recentlyplayeddatabae.add(data);
  allrecentlyplaylistshow();
}

allrecentlyplaylistshow() async {
  final recentlyplayeddatabae =
      await Hive.openBox<songsmodel>("recentlyplayeddb");
  recentlyPlayedNotifier.value.clear();
  recentlyPlayedNotifier.value.addAll(recentlyplayeddatabae.values);
  recentlyPlayedNotifier.value =
      List<songsmodel>.from(recentlyPlayedNotifier.value.reversed);
  recentlyPlayedNotifier.notifyListeners();
}

void mostPlayedSongs(songsmodel data) async {
  final mostplayedDB = await Hive.openBox<songsmodel>('mostplayedDB');
  //data.count = data.count + 1;
  int mostplayedcount=0;
  int count = 0;
  for (var element in mostplayedDB.values) {
    count++;
  }
  if (count > 4) {
    mostplayedDB.deleteAt(0);
  }
  int index = 0;
  for (var element in mostplayedDB.values) {
    if (data.id == element.id) {
      mostplayedcount=element.count+1;
      mostplayedDB.deleteAt(index);
    }
    index++;
  }
  final newsong = songsmodel(
      songName: data.songName,
      artistName: data.songName,
      uri: data.uri,
      id: data.id,
      duration: data.duration,
      count: mostplayedcount);
  mostplayedDB.add(newsong);
  
  allMostPlayedListShow();
}

void allMostPlayedListShow() async {
  final mostplayedDB = await Hive.openBox<songsmodel>('mostplayedDB');
  mostplayedsongNotifier.value.clear();
  for (var element in mostplayedDB.values) {
    if (element.count > 10) {
      mostplayedsongNotifier.value.add(element);
    }
  }
  for (int i = 0; i < mostplayedsongNotifier.value.length; i++) {
    for (int j = i + 1; j < mostplayedsongNotifier.value.length; j++) {
      if (mostplayedsongNotifier.value[i].count <
          mostplayedsongNotifier.value[j].count) {
        songsmodel temp = mostplayedsongNotifier.value[i];
        mostplayedsongNotifier.value[i] = mostplayedsongNotifier.value[j];
        mostplayedsongNotifier.value[j] = temp;
      }
    }
  }
  mostplayedsongNotifier.notifyListeners();
}

bool favouritecheckings(songsmodel data) {
  for (var elements in favsongListNotifier.value) {
    if (data.id == elements.id) {
      return true;
    }
  }
  return false;
}
