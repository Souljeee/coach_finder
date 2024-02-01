import 'package:coach_finder/features/auth/common/auth_state_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse{
  final AuthStatus authStatus;
  final String? token;
  const LoginResponse({
    required this.authStatus,
    this.token,
});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}