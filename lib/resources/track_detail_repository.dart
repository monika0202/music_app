import 'dart:async';

import 'package:music_app/models/track_detail.dart';
import 'package:music_app/models/tracks.dart';
import 'package:music_app/resources/track_detail_provider_api.dart';

class TrackDetailRepository {
  final trackApiProvider = TrackDetailApiProvider();

  Future<Track_Detail_Result> fetch_Track_Detail(track_id) =>
      trackApiProvider.fetchtrackdetail(track_id);
}
