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

  /// Get the location of the user
  Future<fb.FormattedLocation> getLocation(String userId) async {
    final Map<String, Object?> map = (await dio.get(
      '$_path/getUserLocation',
      queryParameters: {
        "userId": userId,
      },
    ))
        .data;
    return fb.FormattedLocation.fromJson(
        map['formattedLocation'] as Map<String, Object?>);
  }
}
