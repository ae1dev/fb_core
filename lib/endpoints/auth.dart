part of fb_core;

class AuthEnd extends EndpointBase {
  @override
  String get _path => '/auth';

  AuthEnd(super.api);

  /// Get auth token with email and password
  Future<fb.UserWithAuth> login({
    required String email,
    required String password,
    required String recaptchaToken,
    required String type,
  }) async {
    Response response = await dio.post(
      'https://auth.featurebase.app/api/v1/auth/login',
      data: {
        "email": email,
        "password": password,
        "recaptchaToken": recaptchaToken,
        "type": type,
      },
    );

    //Set base user
    Map<String, Object?> tempMap = response.data['user'];

    //Update access token from cookie
    if (response.headers.map['set-cookie'] != null) {
      String setCookie = response.headers.map['set-cookie']!.first;
      // Extract the token value using a regular expression
      final RegExp regExp = RegExp(r'featurebase-access=([^;]+)');
      final Match? match = regExp.firstMatch(setCookie);
      if (match != null) {
        String cookieToken = match.group(1)!;
        tempMap['accessToken'] = cookieToken;
      }
    }

    return fb.UserWithAuth.fromJson(tempMap);
  }
}
