import 'package:music_app/models/tracks.dart';

import 'package:rxdart/rxdart.dart';

import '../models/track_detail.dart';
import '../resources/track_detail_repository.dart';

class TracksDetailsBloc {
  final _repository = TrackDetailRepository();
  final _tracksFetcher = PublishSubject<Track_Detail_Result>();

  Stream<Track_Detail_Result> get tracksDetails => _tracksFetcher.stream;

  fetchTrackDetail(int? track_id) async {
    Track_Detail_Result track = await _repository.fetch_Track_Detail(track_id);
    _tracksFetcher.sink.add(track);
  }

  dispose() {
    _tracksFetcher.close();
  }
}

final trackdetailsbloc = TracksDetailsBloc();
