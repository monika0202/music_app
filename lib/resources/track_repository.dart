import 'dart:async';

import 'package:music_app/models/tracks.dart';
import 'package:music_app/resources/tracks_provider_api.dart';

class Repository {
  final trackApiProvider = TrackApiProvider();

  Future<Result> fetchAllMusic() => trackApiProvider.fetchMusicList();
}
