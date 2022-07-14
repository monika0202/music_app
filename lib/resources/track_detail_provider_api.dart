import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:music_app/models/track_detail.dart';

import 'dart:convert';

import 'package:music_app/models/tracks.dart';

class TrackDetailApiProvider {
  Client client = Client();
  final _apiKey = '';

  Future<Track_Detail_Result> fetchtrackdetail(int track_id) async {
    print("entered");
    final response = await client.get(Uri.parse(
        "https://api.musixmatch.com/ws/1.1/track.get?track_id=${track_id}&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7"));
    print(response.body.toString());

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      return Track_Detail_Result.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
