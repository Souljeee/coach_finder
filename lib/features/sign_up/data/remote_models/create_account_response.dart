import 'package:json_annotation/json_annotation.dart';

part 'create_account_response.g.dart';

@JsonSerializable()
class CreateAccountResponse{
  final bool accessAllowed;
  final String message;
  const CreateAccountResponse({
    required this.accessAllowed,
    required this.message,
  });

  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) => _$CreateAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountResponseToJson(this);
}