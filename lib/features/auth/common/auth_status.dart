import 'package:json_annotation/json_annotation.dart';

enum AuthStatus {
  @JsonValue('SUCCESS')
  success,
  @JsonValue('NONEXISTENT_USER')
  nonexistent_user,
  @JsonValue('WRONG_PASSWORD')
  wrong_password;
}
