import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playtify/api/spotify_auth.dart';
import 'package:playtify/api/utils.dart';

import '../album.dart';

class SpotifyAPI {
  final SpotifyService
      spotifyService; // Dependency Injection of SpotifyService class

  SpotifyAPI({required this.spotifyService});

  // Function responsible for fetching all the categories used to tag music albums in spotify
  // Returns the id, name and href of the categories
  Future<List<Map<String, dynamic>>?> fetchCategories() async {
    // Check if the access code is valid or not
    await spotifyService.checkValidAccessToken();

    final response = await http.get(AuthConstants.categoryUrl, headers: {
      'Authorization': 'Bearer ${spotifyService.accessToken}',
      'limit': '30', // Change the limit to adjust pagination
    });

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> categories =
          ExtractFromResBody.extractCategoriesFromRes(response.body);

      print(categories);
      return categories;
    }

    // Handle the errors here
    print('Error occured: ${response.body}');
    return null;
  }

  // Provided a Category ID, fetch the playlists within that category
  Future<String?> getCategoryPlaylist(String categoryId) async {
    await spotifyService.checkValidAccessToken();

    final Uri playlistUrl = Uri.https(
        'api.spotify.com', '/v1/browse/categories/$categoryId/playlists');

    final result = await http.get(playlistUrl, headers: {
      'Authorization': 'Bearer ${spotifyService.accessToken}',
      'limit': '30', // Change the limit to adjust pagination
    });

    if (result.statusCode == 200) {
      print(result.body);
      return result.body;
    }
    // Handle various errors - refer to Spotify WebAPI docs for statusCodes
    return null;
  }

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
