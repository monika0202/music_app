import 'package:flutter/material.dart';
import 'package:music_app/blocs/lyrics_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../blocs/track_bloc.dart';
import '../blocs/track_detail_bloc.dart';
import '../models/lyrics_detail.dart';
import '../models/track_detail.dart';
import '../models/tracks.dart';
import 'dart:async';

class Track_Detail extends StatefulWidget {
  final int? track_id;
  const Track_Detail({Key? key, required this.track_id}) : super(key: key);

  @override
  State<Track_Detail> createState() => _Track_DetailState();
}

class _Track_DetailState extends State<Track_Detail> {
  StreamSubscription? connection;
  bool isoffline = false;

  @override
  void initState() {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    trackdetailsbloc.fetchTrackDetail(widget.track_id);
    lyricsbloc.fetchLyrics(widget.track_id);
    return Scaffold(
        appBar: AppBar(
          title: Text("Track Detials"),
        ),
        body: isoffline == true
            ? Container(
                alignment: Alignment.center,
                child: Text("No Internet Connection"),
              )
            : Container(
                padding: EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: StreamBuilder(
                            stream: trackdetailsbloc.tracksDetails,
                            builder: (context,
                                AsyncSnapshot<Track_Detail_Result> snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "${snapshot.data?.message.body.track.trackName}"),
                                      SizedBox(height: 10),
                                      Text(
                                        "Artist",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "${snapshot.data?.message.body.track.artistName}"),
                                      SizedBox(height: 10),
                                      Text(
                                        "Album Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "${snapshot.data?.message.body.track.albumName}"),
                                      SizedBox(height: 10),
                                      Text(
                                        "Explicit",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(snapshot.data?.message.body.track
                                                  .explicit ==
                                              0
                                          ? "False"
                                          : "True"),
                                      SizedBox(height: 10),
                                      Text(
                                        "Rating",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "${snapshot.data?.message.body.track.track_rating}"),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      ),
                      Container(
                        child: StreamBuilder(
                            stream: lyricsbloc.lyricsDetails,
                            builder: (context,
                                AsyncSnapshot<Lyrics_Result> snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Lyrics",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        "${snapshot.data?.message.lyrics_body.lyrics.lyrics_body}"),
                                  ],
                                ));
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      )
                    ],
                  ),
                ),
              ));
  }
}
