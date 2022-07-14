import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:music_app/blocs/track_detail_bloc.dart';
import 'package:music_app/models/tracks.dart';
import 'package:music_app/screens/track_detail.dart';
import 'dart:async';
import '../blocs/track_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    trackbloc.fetchAllTracks();
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
      ),
      body: isoffline == false
          ? Container(
              child: StreamBuilder(
                stream: trackbloc.allTracks,
                builder: (context, AsyncSnapshot<Result> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount:
                            snapshot.data?.message.body.track_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              int? track_id = snapshot.data?.message.body
                                  .track_list[index].trackDetails.trackId;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Track_Detail(
                                          track_id: track_id,
                                        )),
                              );
                            },
                            child: Card(
                              shadowColor: Colors.grey[500],
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.music_note_rounded),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 230,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${snapshot.data?.message.body.track_list[index].trackDetails.trackName}",
                                                maxLines: 2,
                                              ),
                                              Text(
                                                "${snapshot.data?.message.body.track_list[index].trackDetails.albumName}",
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: Colors.grey[500]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 60,
                                      child: Text(
                                        "${snapshot.data?.message.body.track_list[index].trackDetails.artistName}",
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            )
          // whenOnline: () {
          //   trackbloc.fetchAllTracks();
          // },
          : Container(
              alignment: Alignment.center,
              child: Text("No Internet Connection"),
            ),
    );
  }
}
