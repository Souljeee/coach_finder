import 'package:coach_finder/common/data/account_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_payload.g.dart';

@JsonSerializable()
class LoginPayload{
  final String email;
  final String password;
  final AccountType accountType;
  const LoginPayload({
    required this.email,
    required this.password,
    required this.accountType,
  });

  factory LoginPayload.fromJson(Map<String, dynamic> json) => _$LoginPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$LoginPayloadToJson(this);
}