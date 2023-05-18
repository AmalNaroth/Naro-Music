import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

 lyricsBottom(context, titlename, artistname) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        backgroundColor: Colors.black.withOpacity(.7),
        contentTextStyle: const TextStyle(color: Colors.white),
        content: FutureBuilder(
          future: getLyrics(titlename, artistname),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(snapshot.data!),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
                child: const Center(
                  child: Text(
                    'Failed to load lyrics',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              );
            }
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ]),
  );
}

Future getLyrics(String songName, String artistName) async {
  const apiKey = '605a5382d4c7031ed33ffed6ab6cf941';
  final response = await http.get(Uri.parse(
      'https://api.musixmatch.com/ws/1.1/matcher.lyrics.get?apikey=$apiKey&q_track=$songName&q_artist=$artistName'));
  if (response.statusCode == 200) {
    final lyricsResponse = jsonDecode(response.body);
    final lyrics = lyricsResponse['message']['body']['lyrics']['lyrics_body'];
    return lyrics;
  } else {
    const text = Text('Failed to fetch lyrics');
    return text;
 }
}
