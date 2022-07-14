import 'package:music_app/resources/lyrics_provider_api.dart';

import '../models/lyrics_detail.dart';

class Lyrics_Repository {
  final lyricsApiProvider = LyricsApiProvider();

  Future<Lyrics_Result> fetchlyrics(track_id) =>
      lyricsApiProvider.fetchlyrics(track_id);
}
