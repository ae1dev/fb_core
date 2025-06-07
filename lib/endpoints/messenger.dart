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

  /// Get a list of conversations
  Future<fb.ResultsPagination<fb.Conversation>> conversationsList({
    String state = 'open',
    String inboxType = 'all',
    String sortBy = 'lastActivityAt:desc',
    String? inboxId,
    int page = 1,
  }) async {
    Map<String, dynamic>? queryParameters = {
      "state": state,
      "inboxType": inboxType,
      "sortBy": sortBy,
      "page": page,
    };

    //If inbox is set
    if (inboxId != null && inboxId != 'all' && inboxId != 'unassigned') {
      queryParameters.addAll({
        "inboxId": inboxId,
      });
    }

    final Map<String, Object?> map = (await dio.get("$_path/conversations/list",
            queryParameters: queryParameters))
        .data;
    return fb.ResultsPagination<fb.Conversation>.fromJson(
      map,
      (json) => fb.Conversation.fromJson(json as Map<String, dynamic>),
    );
  }
}
