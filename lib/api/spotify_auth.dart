import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import '../api/utils.dart';

// Responsible for handling authorization (using OAuth2.0) using Authorization Code flow
// It is a singleton class so as manage authentication tokens and user-related data consistently across different parts of the app. It also simplifies the initialization and configuration of the service.

class SpotifyService {
  String? _accessToken;
  String? _refreshToken;
  String? _authCode;
  int _expireSeconds = 0;
  int _lastCalled = 0;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get authCode => _authCode;

  // Singleton Construction
  static final SpotifyService _instance = SpotifyService._internal();
  factory SpotifyService() {
    return _instance;
  }
  SpotifyService._internal();

  // Function responsible for granting permissions to work with Spotify account of the user, to be called once for a user
  // Sets the initial access token by exchanging the auth code with access code
  Future<void> authorize() async {
    // Redirect the user to browser for auth
    final result = await FlutterWebAuth.authenticate(
      url: AuthConstants.authUrl.toString(),
      callbackUrlScheme: AuthConfig.callbackUrlScheme,
    );

    // Extract code from resulting url
    _authCode = Uri.parse(result).queryParameters['code'];
    getAccessToken(false);
  }

  // An abstraction provided to the users to get the access tokens / refresh tokens
  Future<void> getAccessToken(bool isRefresh) async {
    final http.Response response = await _performTokenRequest(isRefresh);

    if (response.statusCode == 200) {
      // Successful
      final tokens = ExtractFromResBody.extractAuthTokens(response.body);
      if (tokens != null) {
        _updateTokens(tokens);
      } else {
        // Handle token errors
      }
    }
  }

  Future<void> checkValidAccessToken() async {
    if (accessToken == null) {
      await authorize();
    } else if (DateTime.now().second - _lastCalled >= _expireSeconds) {
      await getAccessToken(true);
    }
  }

  // A utility function to perform HTTP calls
  Future<http.Response> _performTokenRequest(bool isRefresh) async {
    final Map<String, String> headers = {
      'Authorization': 'Basic ${AuthConfig.authBase64}',
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    final Map<String, String> body = !isRefresh
        ? {
            'client_id': AuthConfig.clientId,
            'redirect_uri': '${AuthConfig.callbackUrlScheme}://',
            'grant_type': 'authorization_code',
            'code': _authCode!,
          }
        : {
            'grant_type': 'refresh_token',
            'refresh_token': _refreshToken!,
          };

    return await http.post(AuthConstants.accessUrl,
        headers: headers, body: body);
  }

  void _updateTokens(Map<String, dynamic> tokens) {
    _accessToken = tokens['access_token'];
    _refreshToken = tokens['refresh_token'];
    _lastCalled = DateTime.now().second;
    _expireSeconds = tokens['expires_in'];
  }
}
