// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginPayload _$LoginPayloadFromJson(Map<String, dynamic> json) => LoginPayload(
      email: json['email'] as String,
      password: json['password'] as String,
      accountType: $enumDecode(_$AccountTypeEnumMap, json['accountType']),
    );

Map<String, dynamic> _$LoginPayloadToJson(LoginPayload instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'accountType': _$AccountTypeEnumMap[instance.accountType]!,
    };

const _$AccountTypeEnumMap = {
  AccountType.coach: 'coach',
  AccountType.client: 'client',
};
