import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Album.dart';

class SpotifyAPI {
  //Initialise necessary variables from Spotify API
  // var API_Token = '<Token>'
  // use api token in API function
  Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  // Get List of music from playlist
  void getMusic(String playlistURL) {}

  // Filter music according to genres
  void filterMusic(String genre) {}
}
