part of featurebase.models;

@freezed
class UserSimple with _$UserSimple {
  const factory UserSimple({
    /// The id of the user
    @JsonKey(name: '_id', required: true) required String id,

    /// The type of the user
    @JsonKey(name: 'type', required: true) required String type,

    /// The name of the user
    @JsonKey(name: 'name', required: true) required String name,

    /// The users picture
    @JsonKey(name: 'picture') String? picture,
  }) = _UserSimple;

  factory UserSimple.fromJson(Map<String, Object?> json) =>
      _$UserSimpleFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    /// The featurebase id for the user
    @JsonKey(name: 'id', required: true) required String id,

    /// The platforms user id
    @JsonKey(name: 'userId') String? userId,

    /// The name of the user
    @JsonKey(name: 'name', required: true) required String name,

    /// The users picture
    @JsonKey(name: 'profilePicture') String? picture,

    /// The amount of comments the user has created
    @JsonKey(name: 'commentsCreated') @Default(0) int commentsCreated,

    /// The amount of posts the user has created
    @JsonKey(name: 'postsCreated') @Default(0) int postsCreated,

    /// The type of the user
    @JsonKey(name: 'type', required: true) required String type,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

@freezed
class UserWithAuth with _$UserWithAuth {
  const factory UserWithAuth({
    /// The featurebase id for the user
    @JsonKey(name: 'id', required: true) required String id,

    /// The name of the user
    @JsonKey(name: 'name', required: true) required String name,

    /// The users email
    @JsonKey(name: 'email', required: true) required String email,

    /// The users picture
    @JsonKey(name: 'profilePicture') String? picture,

    /// The type of the user
    @JsonKey(name: 'type', required: true) required String type,

    /// The user access tken
    @JsonKey(name: 'accessToken', required: true) required String accessToken,
  }) = _UserWithAuth;

  factory UserWithAuth.fromJson(Map<String, Object?> json) =>
      _$UserWithAuthFromJson(json);
}
