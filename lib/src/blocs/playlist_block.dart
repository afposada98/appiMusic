import 'package:alarmfy/src/models/list_playlist_model.dart';
import 'package:alarmfy/src/models/tracks_playlist_model.dart';

import 'package:rxdart/rxdart.dart';

class PlaylistBloc {
  final PublishSubject _playlist_list_Fetcher =
      PublishSubject<ListPlaylistModel>();
  final PublishSubject _tracks_list_Fetcher =
      PublishSubject<TracksPlaylistModel>();

  Observable<ListPlaylistModel> get playlistList =>
      _playlist_list_Fetcher.stream;
  Observable<TracksPlaylistModel> get tracksList => _tracks_list_Fetcher.stream;

  disposePlaylist() {
    _playlist_list_Fetcher.close();
  }

  disposeTracks() {
    _tracks_list_Fetcher.close();
  }
}

final PlaylistBloc playlistBloc = PlaylistBloc();
