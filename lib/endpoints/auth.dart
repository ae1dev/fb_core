part of fb_core;

class AuthEnd extends EndpointBase {
  @override
  String get _path => '/auth';

  AuthEnd(super.api);

  /// Get featurebase-access cookie with email and password
  Future<List<String>> login({
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
        followRedirects: false,
        validateStatus: (status) => status != null && status < 400,
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

    //Send Post
    String? authFeaturebaseCookie;
    final Response loginResponse = await authDio.post(
      '/auth/login',
      data: {
        "email": email,
        "password": password,
        "recaptchaToken": recaptchaToken,
        "type": type,
      },
    );

    //Get the cookie
    final List<String>? cookies = loginResponse.headers['set-cookie'];
    if (cookies == null || cookies.isEmpty) {
      throw Exception('The "set-cookie" header was not found in the response.');
    }
    // Find the cookie named 'featurebase-access='
    for (final String cookie in cookies) {
      if (cookie.startsWith('featurebase-access=')) {
        authFeaturebaseCookie = cookie;
        authDio.options.headers['Cookie'] = cookie;
      }
    }
    //No token found
    if (authFeaturebaseCookie == null) {
      throw Exception('No auth.featurebase token found');
    }

    //Get org
    final Response orgResponse = await authDio.get(
      '/organization/admin/orgs',
    );
    final List<dynamic>? orgs = orgResponse.data['results'];
    if (orgs == null || orgs.isEmpty) {
      throw Exception('No organizations found in the response.');
    }
    final String orgId = orgs.first['id'];
    final String orgName = orgs.first['name'];

    //Get callback
    final Response getCallback = await authDio.get(
      '/auth/admin-redirect?organizationId=$orgId',
    );

    final String? location = getCallback.headers.value('location');

    if (location == null) {
      throw Exception('Location header not found in redirect response.');
    }

    // The location is a full URL, which will set the final cookie
    final Response finalResponse = await authDio.get(location);
    final List<String>? finalCookies = finalResponse.headers['set-cookie'];

    if (finalCookies == null || finalCookies.isEmpty) {
      throw Exception(
          'The "set-cookie" header was not found in the final response.');
    }
    for (final String cookie in finalCookies) {
      if (cookie.startsWith('featurebase-access-$orgId=')) {
        return [cookie, orgName];
      }
    }
    throw Exception(
        'The "featurebase-access" cookie was not found in the final response.');
  }
}
