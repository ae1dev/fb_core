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
