part of fb_core;

class UserEnd extends EndpointBase {
  @override
  String get _path => '/user';

  UserEnd(super.api);

  /// Get the user details
  Future<fb.User> get() async {
    final Map<String, Object?> map = (await dio.get(_path)).data;
    return fb.User.fromJson(map);
  }
}
