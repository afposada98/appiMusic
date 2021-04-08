import 'package:alarmfy/src/blocs/playlist_bloc.dart';
import 'package:alarmfy/src/models/list_playlist_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaylistTabBar extends StatefulWidget {
  PlaylistTabBarState createState() => new PlaylistTabBarState();
}

class PlaylistTabBarState extends State<PlaylistTabBar> {
  void initState() {
    // TODO: implement initState
    super.initState();
    playlistBloc.fetchPlaylistList();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: playlistBloc.playlistList,
      builder: (context, AsyncSnapshot<ListPlaylistModel> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.total,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Image.network(
                    snapshot.data.items[index].images.length > 0
                        ? snapshot.data.items[index].images[0].url
                        : "assets/tempScreen/noImagePlaylist.png"),
                title: Text("${snapshot.data.items[index].name}"),
                subtitle: Text("de ${snapshot.data.items[index].owner.id}"),
                onTap: () {
                  Navigator.pushNamed(context, "/tracks",
                      arguments: <String, Playlist>{
                        'playlist': snapshot.data.items[index],
                      });
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        //Animación de carga, siempre y cuando el listado cubra más allá de la pantalla
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
