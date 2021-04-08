import 'dart:async';
import 'package:alarmfy/src/models/authorization_model.dart';
import 'package:alarmfy/src/models/list_playlist_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PlaylistListApiProvider {
  Client client = Client();
  var urlToPlaylist = 'https://api.spotify.com/v1/me/playlists';

  Future<ListPlaylistModel> fetchPlaylistList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
    String tokenType = prefs.getString('token_type');

    String authorizationWithToken = '$tokenType $accessToken';

    //Envía una solicitud HTTP GET con los encabezados dados a la URL indicada
    var response = await client
        .get(urlToPlaylist, headers: {'Authorization': authorizationWithToken});

    //SI SE NECESITA NUEVO TOKEN
    //En caso de rechazo en la autenticación
    if (response.statusCode == 401) {
      String refreshToken = prefs.getString('refresh_token');
      String clientId = "c84a6e893ab6446a9b155d9f0c04f12c";
      String clientSecret = "15ff9e02ab7645d1a600857d1af6f72b";
      String authorizationStr = "$clientId:$clientSecret";

      //Defino la cadena de autorización bajo el estándar de caracteres
      var bytes = utf8.encode(authorizationStr);
      var base64Str = base64.encode(bytes);
      String authorization = 'Basic ' + base64Str;

      var responseNewToken =
          await client.post("https://accounts.spotify.com/api/token", body: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
        'redirect_uri': 'alarmfy:/'
      }, headers: {
        'Authorization': authorization
      });

      // En caso de éxito, parseo a Json
      if (responseNewToken.statusCode == 200) {
        AuthorizationModel aM =
            AuthorizationModel.fromJson(json.decode(responseNewToken.body));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', aM.accessToken);
        prefs.setString('token_type', aM.tokenType);
        prefs.setBool('logged', true);

        accessToken = prefs.getString('access_token');
        tokenType = prefs.getString('token_type');
        String authorizationWithToken = '$tokenType $accessToken';
        response = await client.get(urlToPlaylist,
            headers: {'Authorization': authorizationWithToken});
        print("Se dio un nuevo token!");
      } else {
        throw Exception(
            'Error al solicitar un nuevo token, autenticación rechazada');
      }
    }

    if (response.statusCode == 200) {
      // Llamado con éxito, parseo a JSON
      return ListPlaylistModel.fromJson(json.decode(response.body));
    } else {
      print("EstatusCode: ${response.statusCode}");
      print("BODY: ${response.body}");
      throw Exception('Error al obtener la Playlist');
    }
  }
}
