import 'package:alarmfy/src/models/add_track_playlist.dart';

import 'package:rxdart/rxdart.dart';


class AddplaylistBloc {

  final PublishSubject _addlistTokenFetcher = PublishSubject<AuthorizationModel>();
  final PublishSubject _addlistCodeFetcher = PublishSubject<String>();

  Observable<String> get addlistCode => _addlistCodeFetcher.stream;
  Observable<AuthorizationModel> get addlistToken => _addlistTokenFetcher.stream;

  disposeCode() {
    _addlistCodeFetcher.close();
  }

  disposeToken() {
    _addlistTokenFetcher.close();
  }
}

final AddplaylistBloc addplaylistBloc = AddplaylistBloc();