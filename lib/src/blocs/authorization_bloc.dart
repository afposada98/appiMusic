import 'package:alarmfy/src/models/authorization_model.dart';

import 'package:rxdart/rxdart.dart';

class AuthorizationBloc {
  final PublishSubject _authorizationTokenFetcher =
      PublishSubject<AuthorizationModel>();
  final PublishSubject _authorizationCodeFetcher = PublishSubject<String>();

  Observable<String> get authorizationCode => _authorizationCodeFetcher.stream;
  Observable<AuthorizationModel> get authorizationToken =>
      _authorizationTokenFetcher.stream;

  disposeCode() {
    _authorizationCodeFetcher.close();
  }

  disposeToken() {
    _authorizationTokenFetcher.close();
  }
}

final AuthorizationBloc authorizationBloc = AuthorizationBloc();
