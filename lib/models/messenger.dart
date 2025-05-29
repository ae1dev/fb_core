part of featurebase.models;

@freezed
class Inbox with _$Inbox {
  const factory Inbox({
    /// Inbox item count
    @JsonKey(name: 'count', required: true) required int count,

    /// Inbox name
    @JsonKey(name: 'name', required: true) required String name,

    /// Inbox Id
    @JsonKey(name: 'id', required: true) required String id,
  }) = _Inbox;

  factory Inbox.fromJson(Map<String, Object?> json) => _$InboxFromJson(json);
}

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    /// Conversation Id
    @JsonKey(name: 'id', required: true) required String id,

    /// Conversation type
    @JsonKey(name: 'type', required: true) required String type,

    /// If the conversation is open
    @JsonKey(name: 'open', required: true) required bool open,

    /// When there was last activity
    @JsonKey(name: 'lastActivityAt', required: true)
    required DateTime lastActivityAt,

    /// The conversation participants
    @JsonKey(name: 'participants', required: true)
    required List<ConversationParticipant> participants,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, Object?> json) =>
      _$ConversationFromJson(json);
}

@freezed
class ConversationParticipant with _$ConversationParticipant {
  const factory ConversationParticipant({
    /// Participant Id
    @JsonKey(name: 'id', required: true) required String id,

    /// Participant type
    @JsonKey(name: 'type', required: true) required String type,

    /// Participant name
    @JsonKey(name: 'name', required: true) required String name,

    /// Participant picture
    @JsonKey(name: 'picture', required: true) required String picture,

    /// Participant email
    @JsonKey(name: 'email', required: true) required String email,
  }) = _ConversationParticipant;

  factory ConversationParticipant.fromJson(Map<String, Object?> json) =>
      _$ConversationParticipantFromJson(json);
}
