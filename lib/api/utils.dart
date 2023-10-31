import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthConfig {
  static final String clientId = dotenv.env['CLIENT_ID']!;
  static final String clientSecret = dotenv.env['CLIENT_SECRET']!;
  static const String callbackUrlScheme = 'com.example.playtify';
  static const String scope =
      'user-read-email user-library-read user-library-modify user-read-recently-played playlist-read-private playlist-modify-private playlist-modify-public';

  static final authBase64 = base64
      .encode('${AuthConfig.clientId}:${AuthConfig.clientSecret}'.codeUnits);
}

class AuthConstants {
  // URL for Spotify authorization
  static final Uri authUrl = Uri.https('accounts.spotify.com', '/authorize', {
    'response_type': 'code',
    'client_id': AuthConfig.clientId,
    'redirect_uri': '${AuthConfig.callbackUrlScheme}://',
    'scope': AuthConfig.scope,
  });

  // URL for Token Exchange
  static final Uri accessUrl = Uri.https('accounts.spotify.com', '/api/token');

  // URL for Fetching Categories
  static final Uri categoryUrl =
      Uri.https('api.spotify.com', '/v1/browse/categories');
}

class ExtractFromResBody {
  static List<Map<String, dynamic>> extractCategoriesFromRes(String resBody) {
    final resJson = jsonDecode(resBody);
    final List<Map<String, dynamic>> categories = [];

    resJson['categories']['items'].forEach(
      (category) => {
        categories.add({
          'id': category['id'],
          'name': category['name'],
          'href': category['href'],
        }),
      },
    );

    print(categories);
    return categories;
  }

  // A utility function to extract the access, refresh tokens from the JSON response of HTTP calls
  static Map<String, dynamic>? extractAuthTokens(String responseBody) {
    try {
      final parsedJsonBody = jsonDecode(responseBody);
      return {
        'access_token': parsedJsonBody['access_token'] as String,
        'refresh_token': parsedJsonBody['refresh_token'] as String,
        'expires_in': parsedJsonBody['expires_in'] as int,
      };
    } catch (e) {
      // Handle JSON parsing error here
      return null;
    }
  }
}
