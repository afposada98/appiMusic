import 'package:alarmfy/src/blocs/authorization_bloc.dart';
import 'package:alarmfy/src/resources/authorizationApiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alarmfy/main.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

void main() {
  test('prueba', () {
    final authorizationCodeApiProvider = AuthorizationApiProvider();
    Future<String> code = authorizationCodeApiProvider.fetchCode();
    print(code);
    expect(code, completion(equals({"error" : null})));
  });
}
