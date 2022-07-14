import 'package:music_app/models/tracks.dart';

class Track_Detail_Result {
  late Track_Detail_Message message;

  Track_Detail_Result.fromJson(Map<String, dynamic> parsedJson) {
    message = Track_Detail_Message.fromJson(parsedJson["message"]);
  }
}

class Track_Detail_Message {
  late Header header;
  late Track_Detail_Body body;
  Track_Detail_Message.fromJson(Map<String, dynamic> parsedJson) {
    header = Header.fromJson(parsedJson["header"]);
    body = Track_Detail_Body.fromJson(parsedJson["body"]);
  }
}

class Track_Detail_Body {
  late TracksDetails track;
  Track_Detail_Body.fromJson(Map<String, dynamic> parsedJson) {
    track = TracksDetails.fromJson(parsedJson["track"]);
  }
}
