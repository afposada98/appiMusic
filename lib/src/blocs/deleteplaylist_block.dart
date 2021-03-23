import 'package:alarmfy/src/models/delete_track_playlist.dart';

import 'package:rxdart/rxdart.dart';


class DeleteplaylistBloc {

  final PublishSubject _deletelistTokenFetcher = PublishSubject<AuthorizationModel>();
  final PublishSubject _deletelistCodeFetcher = PublishSubject<String>();

  Observable<String> get deletelistCode => _deletelistCodeFetcher.stream;
  Observable<AuthorizationModel> get deletelistToken => _deletelistTokenFetcher.stream;

  disposeCode() {
    _deletelistCodeFetcher.close();
  }

  disposeToken() {
    _deletelistTokenFetcher.close();
  }
}

final DeleteplaylistBloc deleteplaylistBloc = DeleteplaylistBloc();