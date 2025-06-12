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

  /// Get a conversation
  Future<fb.Conversation> conversation(String id) async {
    final Map<String, Object?> map = (await dio.get(
      '$_path/conversations/$id',
    ))
        .data;

    return fb.Conversation.fromJson(
        map['conversation'] as Map<String, dynamic>);
  }

  /// Create a reply
  ///
  /// Returns updated conversation
  Future<fb.Conversation> reply(String id, String bodyHTML) async {
    final Map<String, Object?> map =
        (await dio.post('$_path/conversations/$id/reply', data: {
      "body": bodyHTML,
      "channel": "desktop",
    }))
            .data;

    return fb.Conversation.fromJson(
        map['conversation'] as Map<String, dynamic>);
  }

  /// Create a internal note
  ///
  /// Returns updated conversation
  Future<fb.Conversation> note(String id, String bodyHTML) async {
    //Send post
    await dio.post('$_path/conversations/$id/note', data: {
      "body": bodyHTML,
      "channel": "desktop",
    });

    //Get updated conversation
    final Map<String, Object?> map = (await dio.get(
      '$_path/conversations/$id',
    ))
        .data;

    return fb.Conversation.fromJson(
        map['conversation'] as Map<String, dynamic>);
  }
}
