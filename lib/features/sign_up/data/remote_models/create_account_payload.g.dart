// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountPayload _$CreateAccountPayloadFromJson(
        Map<String, dynamic> json) =>
    CreateAccountPayload(
      email: json['email'] as String,
      password: json['password'] as String,
      accountType: $enumDecode(_$AccountTypeEnumMap, json['accountType']),
    );

Map<String, dynamic> _$CreateAccountPayloadToJson(
        CreateAccountPayload instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'accountType': _$AccountTypeEnumMap[instance.accountType]!,
    };

const _$AccountTypeEnumMap = {
  AccountType.coach: 'coach',
  AccountType.client: 'client',
};
