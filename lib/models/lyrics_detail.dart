import 'package:music_app/models/tracks.dart';

class Lyrics_Result {
  late Lyrics_Message message;

  Lyrics_Result.fromJson(Map<String, dynamic> parsedJson) {
    message = Lyrics_Message.fromJson(parsedJson["message"]);
  }
}

class Lyrics_Message {
  late Header header;
  late Lyrics_Body lyrics_body;
  Lyrics_Message.fromJson(Map<String, dynamic> parsedJson) {
    header = Header.fromJson(parsedJson["header"]);
    lyrics_body = Lyrics_Body.fromJson(parsedJson["body"]);
  }
}

class Lyrics_Body {
  late Lyrics lyrics;
  Lyrics_Body.fromJson(Map<String, dynamic> parsedJson) {
    lyrics = Lyrics.fromJson(parsedJson["lyrics"]);
  }
}

class Lyrics {
  final int lyrics_id;
  final int explicit;
  final lyrics_body;

  Lyrics(
      {required this.lyrics_id,
      required this.explicit,
      required this.lyrics_body});

  Lyrics.fromJson(Map<String, dynamic> json)
      : lyrics_id = json['lyrics_id'],
        explicit = json['explicit'],
        lyrics_body = json['lyrics_body'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lyrics_id'] = lyrics_id;
    data['explicit'] = explicit;
    data['lyrics_body'] = lyrics_body;

    return data;
  }
}
