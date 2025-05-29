part of fb_core;

class FeaturebaseApi extends FeaturebaseApiBase {
  FeaturebaseApi.from({
    // ignore: unused_element
    super.organizationName,
    super.talker,
  }) : super.from();
}

abstract class FeaturebaseApiBase {
  static String _organizationName = "feedback";
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

  late MessengerEnd _messenger;
  MessengerEnd get messeger => _messenger;

  late UserEnd _user;
  UserEnd get user => _user;

  Talker? _talker;

  FeaturebaseApiBase.from({
    String organizationName = "feedback",
    Talker? talker,
  }) {
    _organizationName = organizationName;

    _setOrganizationBasedInfo(organizationName);
    _dio.options.headers['accept'] = 'application/json';

    //Setup the endpoints
    _auth = AuthEnd(this);
    _helpCenter = HelpCenterEnd(this);
    _changelog = ChangelogEnd(this);
    _organization = OrganizationEnd(this);
    _feedback = FeedbackEnd(this);
    _comment = CommentEnd(this);
    _messenger = MessengerEnd(this);
    _user = UserEnd(this);

    _talker = talker;

    dio.interceptors.addAll([
      //Setup talker
      if (_talker != null)
        TalkerDioLogger(
          talker: _talker,
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true, //TODO: Disable later
            printResponseHeaders: true,
            printResponseMessage: true,
            printRequestData: false,
            printResponseData: false,
          ),
        ),
    ]);
  }

  /// Set the access token for the posts API requests
  void setAccessToken(
    String accessToken, {
    bool cookieToken = false,
    String? orgId,
  }) {
    if (cookieToken) {
      //Set cookie token
      if (orgId != null) {
        _dio.options.headers['Cookie'] =
            accessToken.replaceAll('-5febde12dc56d60012d47db6', '-$orgId');
      } else {
        _dio.options.headers['Cookie'] = accessToken;
      }
    } else {
      //Set SSO token
      _dio.options.headers['x-access-token'] = accessToken;
    }
    _printInfo('Core: Set access token');

    setTBSessionId();
  }

  /// Set the CSRF token for the posts API requests
  void setCsrfToken(String csrfToken) {
    _dio.options.headers['x-csrf-token'] = csrfToken;
    _printInfo('Core: Set CSRF token');
  }

  /// Set the tinybird session id
  void setTBSessionId() {
    var uuid = Uuid();
    _dio.options.headers['x-tb-session-id'] = uuid.v4();
    _printInfo('Core: Set session id');
  }

  /// Set the users organization id
  void setOrgId(String id) {
    _setOrganizationBasedInfo(id);
  }

  void _setOrganizationBasedInfo(String orgName) {
    //Setup the base url
    _dio.options.baseUrl = 'https://$orgName.featurebase.app/api/v1';

    // Add the Origin header to the request
    _dio.options.headers['Origin'] = 'https://$orgName.featurebase.app';
    _dio.options.headers['referer'] = 'https://$orgName.featurebase.app';

    _printInfo('Core: Setup $orgName');
  }

  bool isTokenSet() {
    return _dio.options.headers['x-access-token'] != null;
  }

  void _printInfo(String msg) {
    if (_talker != null) {
      _talker!.info(msg);
    }
  }
}
