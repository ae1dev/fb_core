part of fb_core;

class MessengerEnd extends EndpointBase {
  @override
  String get _path => '/messenger';

  MessengerEnd(super.api);

  /// Get a list of user inboxes
  Future<List<fb.Inbox>> inboxes() async {
    final Map<String, Object?> map = (await dio.get(
      '$_path/inboxes',
    ))
        .data;

    var inboxesMap = map['inboxes'] as Iterable<dynamic>;
    return inboxesMap.map((m) => fb.Inbox.fromJson(m)).toList();
  }
}
