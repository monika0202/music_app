import 'dart:convert';

import 'package:flutter/rendering.dart';

class Result {
  late Message message;

  Result.fromJson(Map<String, dynamic> parsedJson) {
    message = Message.fromJson(parsedJson["message"]);
  }
}

class Message {
  late Header header;
  late Body body;
  Message.fromJson(Map<String, dynamic> parsedJson) {
    header = Header.fromJson(parsedJson["header"]);
    body = Body.fromJson(parsedJson["body"]);
  }
}

class Header {
  late int status_code;
  late double execute_time;
  Header.fromJson(Map<String, dynamic> parsedJson) {
    status_code = parsedJson['status_code'];
    execute_time = parsedJson['execute_time'];
  }
}

class Body {
  List<Track> track_list = [];
  Body.fromJson(Map<String, dynamic> parsedJson) {
    List<Track> trackslist = [];
    for (int i = 0; i < parsedJson['track_list'].length; i++) {
      Track t = Track.fromJson(parsedJson["track_list"][i]);
      trackslist.add(t);
    }
    track_list = trackslist;
  }
}

class Track {
  late TracksDetails trackDetails;

  Track.fromJson(Map<String, dynamic> parsedJson) {
    trackDetails = TracksDetails.fromJson(parsedJson["track"]);
  }
}

class TracksDetails {
  final int trackId;
  final String trackName;
  final String albumName;
  final String artistName;
  final int explicit;
  final int track_rating;

  TracksDetails(
      {required this.trackId,
      required this.trackName,
      required this.albumName,
      required this.artistName,
      required this.explicit,
      required this.track_rating});

  TracksDetails.fromJson(Map<String, dynamic> json)
      : trackId = json['track_id'],
        trackName = json['track_name'],
        albumName = json['album_name'],
        artistName = json['artist_name'],
        explicit = json['explicit'],
        track_rating = json['explicit'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['track_id'] = trackId;
    data['track_name'] = trackName;
    data['album_name'] = albumName;
    data['artist_name'] = artistName;
    data['exppicit'] = explicit;
    data['track_rating'] = track_rating;

    return data;
  }
}

List<TracksDetails> trackFromJson(String str) => List<TracksDetails>.from(
    json.decode(str).map((x) => TracksDetails.fromJson(x)));
String trackToJson(List<TracksDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
