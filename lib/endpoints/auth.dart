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
    // Create a new Dio instance for the auth domain
    final authDio = Dio(
      BaseOptions(
        baseUrl: 'https://auth.featurebase.app/api/v1',
        headers: {
          'Origin': 'https://${_api.organizationName}.featurebase.app',
        },
      ),
    );

    // Add the same interceptors as the main dio instance
    if (_api._talker != null) {
      authDio.interceptors.add(
        TalkerDioLogger(
          talker: _api._talker!,
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: false,
            printResponseHeaders: false,
            printResponseMessage: true,
            printRequestData: false,
            printResponseData: false,
          ),
        ),
      );
    }

    final Map map = (await authDio.post(
      '/auth/login',
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
