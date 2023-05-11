import 'package:flutter/material.dart';
import 'package:naromusic/db/models/playlistmodel.dart';
import 'package:naromusic/db/models/songsmodel.dart';

ValueNotifier<List<songsmodel>>allSongListNotifier= ValueNotifier([]);

ValueNotifier<List<songsmodel>>favsongListNotifier= ValueNotifier([]);

ValueNotifier<List<songsmodel>>recentlyPlayedNotifier= ValueNotifier([]);

ValueNotifier<List<songsmodel>>mostplayedsongNotifier=ValueNotifier([]);

ValueNotifier<List<songsmodel>>newplaylistnotifier=ValueNotifier([]);

ValueNotifier<List<playlistmodel>>playlistnotifier=ValueNotifier([]);
