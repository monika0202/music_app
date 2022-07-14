import 'package:music_app/models/lyrics_detail.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/lyrics_repository.dart';

class LyricsBloc {
  final _repository = Lyrics_Repository();
  final _lyricsFetcher = PublishSubject<Lyrics_Result>();

  Stream<Lyrics_Result> get lyricsDetails => _lyricsFetcher.stream;

  fetchLyrics(int? track_id) async {
    Lyrics_Result lyrics = await _repository.fetchlyrics(track_id);
    _lyricsFetcher.sink.add(lyrics);
  }

  dispose() {
    _lyricsFetcher.close();
  }
}

final lyricsbloc = LyricsBloc();
