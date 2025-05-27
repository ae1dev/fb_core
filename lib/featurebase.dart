part of fb_core;

class FeaturebaseApi extends FeaturebaseApiBase {
  FeaturebaseApi.from({
    // ignore: unused_element
    super.organizationName,
  }) : super.from();
}

abstract class FeaturebaseApiBase {
  static String _organizationName = "featurebase";
  String get organizationName => _organizationName;

  final Dio _dio = Dio(
    BaseOptions(
      receiveTimeout: const Duration(seconds: 50),
    ),
  );
  Dio get dio => _dio;

  late AuthEnd _auth;
  AuthEnd get auth => _auth;

  late HelpCenterEnd _helpCenter;
  HelpCenterEnd get helpCenter => _helpCenter;

  late ChangelogEnd _changelog;
  ChangelogEnd get changelog => _changelog;

  late OrganizationEnd _organization;
  OrganizationEnd get organization => _organization;

  late FeedbackEnd _feedback;
  FeedbackEnd get feedback => _feedback;

  late CommentEnd _comment;
  CommentEnd get comment => _comment;

  late UserEnd _user;
  UserEnd get user => _user;

  FeaturebaseApiBase.from({
    String organizationName = "featurebase",
  }) {
    _organizationName = organizationName;

    //Setup the base url
    _dio.options.baseUrl = 'https://$organizationName.featurebase.app/api/v1';

    // Add the Origin header to the request
    _dio.options.headers['Origin'] =
        'https://$organizationName.featurebase.app';

    //Setup the endpoints
    _auth = AuthEnd(this);
    _helpCenter = HelpCenterEnd(this);
    _changelog = ChangelogEnd(this);
    _organization = OrganizationEnd(this);
    _feedback = FeedbackEnd(this);
    _comment = CommentEnd(this);
    _user = UserEnd(this);

    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     // onError: (options, handler) {
    //     //   print('Request: ${options.response?.data}');
    //     //   return handler.next(options);
    //     // },
    //     onError: (options, handler) {
    //       print(
    //           'Request error: ${options.response?.realUri} ${options.response?.data}');
    //       return handler.next(options);
    //     },
    //   ),
    // );
  }

  /// Set the access token for the posts API requests
  void setAccessToken(String accessToken) {
    _dio.options.headers['x-access-token'] = accessToken;

    setTBSessionId();
  }

  /// Set the CSRF token for the posts API requests
  void setCsrfToken(String csrfToken) {
    _dio.options.headers['x-csrf-token'] = csrfToken;
  }

  /// Set the tinybird session id
  void setTBSessionId() {
    var uuid = Uuid();
    _dio.options.headers['x-tb-session-id'] = uuid.v4();
  }

  bool isTokenSet() {
    return _dio.options.headers['x-access-token'] != null;
  }
}
