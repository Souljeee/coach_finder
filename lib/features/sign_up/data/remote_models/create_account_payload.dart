import 'package:coach_finder/common/data/account_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_account_payload.g.dart';

@JsonSerializable()
class CreateAccountPayload{
  final String email;
  final String password;
  final AccountType accountType;

  const CreateAccountPayload({
    required this.email,
    required this.password,
    required this.accountType,
  });

  factory CreateAccountPayload.fromJson(Map<String, dynamic> json) => _$CreateAccountPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountPayloadToJson(this);
}