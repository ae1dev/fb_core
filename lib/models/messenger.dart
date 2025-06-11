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

    /// Inbox type
    @JsonKey(name: 'type', required: true) required String type,
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

    /// A new message in the conversation that has not been read
    @JsonKey(name: 'read', required: true) required bool read,

    /// When there was last activity
    @JsonKey(name: 'lastActivityAt', required: true)
    required DateTime lastActivityAt,

    /// Conversation source
    @JsonKey(name: 'source', required: true) required ConversationSource source,

    /// The last part in the conversation
    ///
    /// Only returned when getting conversations list
    @JsonKey(name: 'lastRenderablePart')
    required ConversationPart? lastRenderablePart,

    /// The full conversation
    ///
    /// Only returned when getting one conversation
    @JsonKey(name: 'conversationParts')
    required List<ConversationPart>? conversationParts,

    /// The conversation participants
    @JsonKey(name: 'participants', required: true)
    required List<ConversationParticipant> participants,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, Object?> json) =>
      _$ConversationFromJson(json);
}

@freezed
class ConversationPart with _$ConversationPart {
  const factory ConversationPart({
    /// Part Id
    @JsonKey(name: 'id', required: true) required String id,

    /// Part type
    ///
    /// Known types: admin_note, email_msg
    @JsonKey(name: 'partType', required: true) required String partType,

    /// Full body
    @JsonKey(name: 'body', required: true) required String body,

    /// Body converted to text
    ///
    /// Only returned when in lastRenderablePart
    @JsonKey(name: 'bodyText') String? bodyText,

    /// Conversation channel
    ///
    /// Only returned when in lastRenderablePart
    @JsonKey(name: 'channel') String? channel,

    /// When the part was created
    @JsonKey(name: 'createdAt', required: true) required DateTime createdAt,

    /// Who the author of the part is
    ///
    /// If no author part is not a message
    @JsonKey(name: 'author') required ConversationParticipant? author,
  }) = _ConversationPart;

  factory ConversationPart.fromJson(Map<String, Object?> json) =>
      _$ConversationPartFromJson(json);
}

@freezed
class ConversationParticipant with _$ConversationParticipant {
  const factory ConversationParticipant({
    /// Participant Id
    @JsonKey(name: 'id', required: true) required String id,

    /// Participant type
    @JsonKey(name: 'type', required: true) required String type,

    /// Participant name
    ///
    /// Can be null for the bot
    @JsonKey(name: 'name') String? name,

    /// Participant picture
    ///
    /// Can be null for the bot
    @JsonKey(name: 'picture') String? picture,

    /// Participant email
    @JsonKey(name: 'email') String? email,
  }) = _ConversationParticipant;

  factory ConversationParticipant.fromJson(Map<String, Object?> json) =>
      _$ConversationParticipantFromJson(json);
}

@freezed
class ConversationSource with _$ConversationSource {
  const factory ConversationSource({
    /// Channel
    @JsonKey(name: 'channel', required: true) required String channel,

    /// Conversation subject
    @JsonKey(name: 'subject') required String? subject,

    /// Conversation body
    @JsonKey(name: 'body', required: true) required String body,

    /// Source author
    @JsonKey(name: 'author', required: true)
    required ConversationParticipant author,
  }) = _ConversationSource;

  factory ConversationSource.fromJson(Map<String, Object?> json) =>
      _$ConversationSourceFromJson(json);
}

@freezed
class FormattedLocation with _$FormattedLocation {
  const factory FormattedLocation({
    /// Location latitude
    @JsonKey(name: 'latitude', required: true) required double latitude,

    /// Location longitude
    @JsonKey(name: 'longitude', required: true) required double longitude,

    /// Location name
    @JsonKey(name: 'location') String? location,
  }) = _FormattedLocation;

  factory FormattedLocation.fromJson(Map<String, Object?> json) =>
      _$FormattedLocationFromJson(json);
}
