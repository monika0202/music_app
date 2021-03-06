import 'dart:async';
import 'package:http/http.dart' show Client;

import 'dart:convert';

import 'package:music_app/models/lyrics_detail.dart';

class LyricsApiProvider {
  Client client = Client();
  final _apiKey = '';

  Future<Lyrics_Result> fetchlyrics(track_id) async {
    print("entered");
    final response = await client.get(Uri.parse(
        "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${track_id}&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7"));
    print(response.body.toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      return Lyrics_Result.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
