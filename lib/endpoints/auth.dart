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
    final Map map = (await dio.post(
      'https://auth.featurebase.app/api/v1/auth/login',
      data: {
        "email": email,
        "password": password,
        "recaptchaToken": recaptchaToken,
        "type": type,
      },
    ))
        .data;
    return fb.UserWithAuth.fromJson(map['user']);
  }
}
