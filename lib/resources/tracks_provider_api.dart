import 'dart:async';
import 'package:http/http.dart' show Client;

import 'dart:convert';

import 'package:music_app/models/tracks.dart';

class TrackApiProvider {
  Client client = Client();
  final _apiKey = 'your_api_key';

  Future<Result> fetchMusicList() async {
    print("entered");
    final response = await client.get(Uri.parse(
        "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7"));
    print(response.body.toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      return Result.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
