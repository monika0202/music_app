import 'package:music_app/models/tracks.dart';

import 'package:rxdart/rxdart.dart';

import '../resources/track_repository.dart';

class TracksBloc {
  final _repository = Repository();
  final _tracksFetcher = PublishSubject<Result>();

  Stream<Result> get allTracks => _tracksFetcher.stream;

  fetchAllTracks() async {
    Result track = await _repository.fetchAllMusic();
    _tracksFetcher.sink.add(track);
  }

  dispose() {
    _tracksFetcher.close();
  }
}

final trackbloc = TracksBloc();
