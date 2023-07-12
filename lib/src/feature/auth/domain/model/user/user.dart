import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$User {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
  }) = _User;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
